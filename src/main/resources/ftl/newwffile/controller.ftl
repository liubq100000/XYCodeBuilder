package ${packageName};


import cn.stylefeng.roses.core.base.controller.BaseController;
import cn.stylefeng.roses.kernel.model.response.ResponseData;
import com.yx.base.pojo.page.LayuiPageInfo;

import ${basePackage}.entity.${className};
import ${basePackage}.model.${className}Bean;
import ${basePackage}.model.${className}Bean;
import ${basePackage}.service.I${className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
* 控制器
*
* @author
* @Date 2020-09-07 10:25:00
*/
@Controller
@RequestMapping("/${className2}")
public class ${className}Controller extends BaseController {


	@Autowired
	private I${className}Service ${className2}Service;

	@Autowired
	IInstanceService instanceService;

	protected void fillPageInfo(Model model, HttpServletRequest request) {
		model.addAttribute("iPage", request.getParameter("iPage"));
		model.addAttribute("sortSetting", request.getParameter("sortSetting"));
		model.addAttribute("queryData", request.getParameter("queryData"));
		model.addAttribute("otherWorkflowData", request.getParameter("otherWorkflowData"));
	}
	@RequestMapping(value="startWorkflow.action")
	public String startWorkflow(${className}Bean busiBean, Model model, HttpServletRequest request) throws Exception{
		Map<String,Object> workflowBean = instanceService.getStartNodeInfo(busiBean.getWorkflowBean());
		model.addAttribute("openType", "start");
		model.addAttribute("workflowBean",workflowBean);
		request.setAttribute("workflowBean",workflowBean);
		LoginUser loginUser = LoginContextHolder.getContext().getUser();
		model.addAttribute("loginUser",loginUser);
		model.addAttribute("openType", "create");
		return urlPrefix + "/${className2}_form.html";
	}

	@RequestMapping(value="loadWorkflow.action")
	public String loadWorkflow(${className}Bean busiBean,Model model,HttpServletRequest request) throws Exception{
		QueryWrapper<${className}> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("pi_id", busiBean.getWorkflowBean().getBusiness_Key_());
		${className} busiData = ${className2}Service.getOne(queryWrapper);
		fillPageInfo(model, request);
		Map<String,Object> workflowBean = instanceService.getDefaultNodeInfo(busiBean.getWorkflowBean());
		model.addAttribute("businessJson", JSON.toJSONString(busiData) );
		model.addAttribute("workflowBean",workflowBean);
		request.setAttribute("workflowBean",workflowBean);
		model.addAttribute("openType", "load");
		return urlPrefix + "/${className2}_form.html";
	}

	/**
	 * 新增接口
	 *
	 * @author
	 * @Date 2020-09-07
	 */
	@RequestMapping("/addItem")
	@ResponseBody
	public ResponseData addItem(${className}Bean param) {
		try {
			this.${className2}Service.add(param);
			return ResponseData.success();
		} catch (Exception ex) {
			ex.printStackTrace();
			return ResponseData.error(ex.getMessage());
		}
	}

	/**
	 * 编辑接口
	 *
	 * @author
	 * @Date 2020-09-07
	 */
	@RequestMapping("/editItem")
	@ResponseBody
	public ResponseData editItem(${className}Bean param) {
		try {
			this.${className2}Service.update(param);
			return ResponseData.success();
		} catch (Exception ex) {
			ex.printStackTrace();
			return ResponseData.error(ex.getMessage());
		}
	}
}

