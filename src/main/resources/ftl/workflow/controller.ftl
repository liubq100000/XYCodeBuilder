package ${packageName};

import ${basePackage}.domain.${className};
import ${basePackage}.domain.validator.${className}Validator;
import ${basePackage}.service.I${className}Service;
import com.jc.foundation.domain.PageManager;
import com.jc.foundation.util.*;
import com.jc.foundation.web.BaseController;
import com.jc.system.util.menuUtil;
import com.jc.system.applog.ActionLog;
import com.jc.foundation.util.GlobalContext;
import com.jc.foundation.exception.CustomException;
import com.jc.system.security.SystemSecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.jc.workflow.instance.service.IInstanceService;
import com.jc.workflow.util.WorkflowContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

/**
 * @Version 1.0
 */
@Controller
@RequestMapping(value="/${modulePath}/${minPath}/")
public class ${className}Controller extends BaseController{

	@Autowired
	IInstanceService instanceService;

	@Autowired
	private I${className}Service ${className2}Service;

	@org.springframework.web.bind.annotation.InitBinder("${className2}")
	public void initBinder(WebDataBinder binder) {
		binder.setValidator(new ${className}Validator());
	}

	public ${className}Controller() {
	}

		/**
	 * @description 保存方法 
	 * @param BindingResult result 校验结果
	 * @return success 是否成功， errorMessage错误信息
	 * @throws Exception
	 * @author
	 * @version  2020-07-09
	 */
	@RequestMapping(value = "saveWorkflow.action",method=RequestMethod.POST)
	@ResponseBody
	@ActionLog(operateModelNm="管理",operateFuncNm="save",operateDescribe="新增操作")
	public Map<String,Object> saveWorkflow(@Valid ${className} cond,BindingResult result,
			HttpServletRequest request) throws Exception{
		
		Map<String, Object> resultMap = validateBean(result);
		if (resultMap.size() > 0) {
			return resultMap;
		}
		// 验证token
		resultMap = validateToken(request);
		if (resultMap.size() > 0) {
			return resultMap;
		}
		
		if(!"false".equals(resultMap.get("success"))){
			resultMap.put(GlobalContext.SESSION_TOKEN, getToken(request));
			Integer flag = ${className2}Service.saveWorkflow(cond);
			if (flag == 1) {
				resultMap.put(GlobalContext.RESULT_SUCCESS, "true");
				resultMap.put(GlobalContext.RESULT_SUCCESSMESSAGE, MessageUtils.getMessage("JC_WORKFLOW_001"));
			} else {
				String workflowMessage = WorkflowContext.getErrMsg(flag);
				if(StringUtil.isEmpty(workflowMessage)){
					resultMap.put(GlobalContext.RESULT_SUCCESS, "false");
					resultMap.put(GlobalContext.RESULT_ERRORMESSAGE, MessageUtils.getMessage("JC_WORKFLOW_002"));
				}else{
					resultMap.put(GlobalContext.RESULT_SUCCESS, "false");
					resultMap.put(GlobalContext.RESULT_ERRORMESSAGE, workflowMessage);
				}
			}
		}
		return resultMap;
	}

	/**
	* workflowParamTemp修改方法
	* @param cond 实体类
	* @param result 校验结果
	* @return Integer 更新的数目
	* @author
	* @version  2020-07-09 
	*/
	@RequestMapping(value="updateWorkflow.action",method=RequestMethod.POST)
	@ResponseBody
	@ActionLog(operateModelNm="管理",operateFuncNm="update",operateDescribe="更新操作")
	public Map<String, Object> updateWorkflow(${className} cond, BindingResult result,
			HttpServletRequest request) throws Exception{
		Map<String, Object> resultMap = validateBean(result);
		if (resultMap.size() > 0) {
			return resultMap;
		}
		String token = getToken(request);
		resultMap.put(GlobalContext.SESSION_TOKEN, token);
		Integer flag = ${className2}Service.updateWorkflow(cond);
		
		if (flag == 1) {
			resultMap.put(GlobalContext.RESULT_SUCCESS, "true");
			resultMap.put(GlobalContext.RESULT_SUCCESSMESSAGE, MessageUtils.getMessage("JC_WORKFLOW_001"));
		} else {
			String workflowMessage = WorkflowContext.getErrMsg(flag);
			if(StringUtil.isEmpty(workflowMessage)){
				resultMap.put(GlobalContext.RESULT_SUCCESS, "false");
				resultMap.put(GlobalContext.RESULT_ERRORMESSAGE, MessageUtils.getMessage("JC_WORKFLOW_002"));
			}else{
				resultMap.put(GlobalContext.RESULT_SUCCESS, "false");
				resultMap.put(GlobalContext.RESULT_ERRORMESSAGE, workflowMessage);
			}
		}
		
		return resultMap;
	}

	/**
	 * @description 发起流程进入的方法
	 * @param workflowParamTemp 实体类
	 * @return String 表单所在地址
	 * @throws Exception
	 */
	@RequestMapping(value="startWorkflow.action",method=RequestMethod.GET)
	public String startWorkflow(${className} cond,Model model,HttpServletRequest request) throws Exception{
		Map<String,Object> workflowBean = instanceService.getStartNodeInfo(cond.getWorkflowBean());
		model.addAttribute("workflowBean",workflowBean);
		menuUtil.saveMenuID("/${modulePath}/${minPath}/startWorkflow.action",request);
		String token = getToken(request);
		model.addAttribute(GlobalContext.SESSION_TOKEN, token);
		return "/${modulePath}/${minPath}/${className2}_form";
	}
	/**
	 * @description 打开流程进入的方法
	 * @param workflowParamTemp 实体类
	 * @return String 表单所在地址
	 * @throws Exception
	 */
	@RequestMapping(value="loadWorkflow.action",method=RequestMethod.GET)
	public String loadWorkflow(${className} cond,Model model,HttpServletRequest request) throws Exception{
		
		${className} cond_temp = new ${className}();
		cond_temp.setPiId(cond.getWorkflowBean().getBusiness_Key_());
		cond_temp = ${className2}Service.get(cond_temp);
		fillPageInfo(model, request);
		Map<String,Object> workflowBean = instanceService.getDefaultNodeInfo(cond.getWorkflowBean());
		model.addAttribute("cond",cond_temp);
		model.addAttribute("businessJson",JsonUtil.java2Json(cond_temp));
		model.addAttribute("workflowBean",workflowBean);
		String token = getToken(request);
		model.addAttribute(GlobalContext.SESSION_TOKEN, token);
		return "/${modulePath}/${minPath}/${className2}_form";
	}
	/**
	* @description 跳转方法
	* @return String 跳转的路径
	* @throws Exception
	* @author
	* @version  2020-07-09 
	*/
	@RequestMapping(value="manage.action",method=RequestMethod.GET)
	@ActionLog(operateModelNm="项目",operateFuncNm="manage",operateDescribe="跳转")
	public String manage(Model model,HttpServletRequest request) throws Exception{
		menuUtil.saveMenuID("/${modulePath}/${minPath}/manage.action",request);
		fillPageInfo(model, request);
		return "/${modulePath}/${minPath}/${className2}_queryList";
	}

	/**
	 * @description 待办/已办查询数据方法
	 * @param cond 实体类
	 * @param PageManager page 分页实体类
	 * @return PagingBean 查询结果
	 * @throws Exception
	 * @author
	 * @version  2020-07-09 
	 */
	@RequestMapping(value="manageWorkflowList.action",method=RequestMethod.GET)
	@ResponseBody
	public PageManager manageWorkflowList(${className} cond,PageManager page){
		//默认排序
		if(StringUtil.isEmpty(cond.getOrderBy())) {
			cond.addOrderByFieldDesc("t.CREATE_DATE");
		}
		PageManager page_ = ${className2}Service.workFlowInstanceQueryByPage(cond, page);
		return page_; 
	}

	/**
	* @description 待办列表
	* @return String 跳转的路径
	* @throws Exception
	* @author
	* @version  2020-07-09 
	*/
	@RequestMapping(value="todoList.action",method=RequestMethod.GET)
	@ActionLog(operateModelNm="管理",operateFuncNm="manageForApplyList",operateDescribe="跳转工作")
	public String todoList(Model model,HttpServletRequest request) throws Exception{
		menuUtil.saveMenuID("/${modulePath}/${minPath}/todoList.action",request);
		fillPageInfo(model, request);
		return "/${modulePath}/${minPath}/${className2}_todoList";
	}

	/**
	 * @description 待办数据
	 * @param cond 实体类
	 * @param PageManager page 分页实体类
	 * @return PagingBean 查询结果
	 * @throws Exception
	 * @author
	 * @version  2020-07-09 
	 */
	@RequestMapping(value="manageTodoList.action",method=RequestMethod.GET)
	@ResponseBody
	public PageManager manageTodoList(${className} cond,PageManager page){
		//默认排序
		if(StringUtil.isEmpty(cond.getOrderBy())) {
			cond.addOrderByFieldDesc("t.CREATE_DATE");
		}
		PageManager page_ = null;
		cond.setCurUserId(SystemSecurityUtils.getUser().getId()+"");
		try {
			page_ = ${className2}Service.workFlowTodoQueryByPage(cond,page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page_;
	}

	/**
	* @description 已办列表
	* @return String 跳转的路径
	* @throws Exception
	* @author
	* @version  2020-07-09 
	*/
	@RequestMapping(value="doneList.action",method=RequestMethod.GET)
	@ActionLog(operateModelNm="管理",operateFuncNm="condSearch",operateDescribe="跳转工作")
	public String doneList(Model model,HttpServletRequest request) throws Exception{
		menuUtil.saveMenuID("/${modulePath}/${minPath}/doneList.action",request);
		fillPageInfo(model, request);
		return "/${modulePath}/${minPath}/${className2}_doneList";
	}

	/**
	 * @description 已办数据
	 * @param cond 实体类
	 * @param PageManager page 分页实体类
	 * @return PagingBean 查询结果
	 * @throws Exception
	 * @author
	 * @version  2020-07-09 
	 */
	@RequestMapping(value="manageDoneList.action",method=RequestMethod.GET)
	@ResponseBody
	public PageManager manageDoneList(${className} cond,PageManager page, HttpServletRequest request) throws CustomException{
		//默认排序
		if(StringUtil.isEmpty(cond.getOrderBy())) {
			cond.addOrderByFieldDesc("t.CREATE_DATE");
		}
		PageManager page_ = null;
		cond.setCurUserId(SystemSecurityUtils.getUser().getId()+"");
		try {
			page_ = ${className2}Service.workFlowDoneQueryByPage(cond,page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page_;
	}

	/**
	* @description 个人列表
	* @return String 跳转的路径
	* @throws Exception
	* @author
	* @version  2020-07-09 
	*/
	@RequestMapping(value="myList.action",method=RequestMethod.GET)
	@ActionLog(operateModelNm="管理",operateFuncNm="condMyList",operateDescribe="跳转工作")
	public String myList(Model model,HttpServletRequest request) throws Exception{
		menuUtil.saveMenuID("/${modulePath}/${minPath}/myList.action",request);
		fillPageInfo(model, request);
		return "/${modulePath}/${minPath}/${className2}_myList";
	}

	/**
	 * @description 个人列表数据
	 * @param cond 实体类
	 * @return PagingBean 查询结果
	 * @throws Exception
	 * @author
	 * @version  2020-07-09 
	 */
	@RequestMapping(value="manageMyList.action",method=RequestMethod.GET)
	@ResponseBody
	public PageManager manageMyList(${className} cond,PageManager page, HttpServletRequest request) throws CustomException{
		//默认排序
		if(StringUtil.isEmpty(cond.getOrderBy())) {
			cond.addOrderByFieldDesc("t.CREATE_DATE");
		}
		PageManager page_ = null;
		cond.setCreateUser(SystemSecurityUtils.getUser().getId());
		try {
			page_ = ${className2}Service.workFlowInstanceQueryByPage(cond,page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page_;
	}
}

