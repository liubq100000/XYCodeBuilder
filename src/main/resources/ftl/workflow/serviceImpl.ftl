package ${packageName};

import ${basePackage}.domain.${className};
import ${basePackage}.dao.I${className}Dao;
import ${basePackage}.domain.${className};
import ${basePackage}.service.I${className}Service;
import com.jc.foundation.exception.CustomException;
import com.jc.foundation.exception.DBException;
import com.jc.foundation.domain.PageManager;
import com.jc.foundation.service.impl.BaseServiceImpl;
import com.jc.foundation.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.jc.workflow.instance.service.IInstanceService;
import com.jc.workflow.task.service.ITaskService;
import java.util.Map;
/** 
 * @Version 1.0
 */
@Service
public class ${className}ServiceImpl extends BaseServiceImpl<${className}> implements I${className}Service {

	@Autowired
	IInstanceService instanceService;

	@Autowired
	ITaskService taskService;

	private I${className}Dao ${className2}Dao;

	public ${className}ServiceImpl(){}

	@Autowired
	public ${className}ServiceImpl(I${className}Dao ${className2}Dao){
		super(${className2}Dao);
		this.${className2}Dao = ${className2}Dao;
	}

	@Override
	@Transactional(rollbackFor=Exception.class,propagation=Propagation.REQUIRED)
	public Integer deleteByIds(${className} entity) throws CustomException{
		Integer result = -1;
		try{
			propertyService.fillProperties(entity,true);
			result = ${className2}Dao.delete(entity);
		}catch(Exception e){
			CustomException ce = new CustomException(e);
			ce.setBean(entity);
			throw ce;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor=Exception.class,propagation=Propagation.REQUIRED)
	public Result saveEntity(${className} entity) throws CustomException {
		if (!StringUtil.isEmpty(entity.getId())) {
			return Result.failure(ResultCode.PARAM_IS_INVALID);
		}
		try {
			this.save(entity);
			return Result.success(MessageUtils.getMessage("JC_SYS_001"));
		} catch (Exception e) {
			CustomException ce = new CustomException(e);
			ce.setBean(entity);
			throw ce;
		}
	}

	@Override
	@Transactional(rollbackFor=Exception.class,propagation=Propagation.REQUIRED)
	public Result updateEntity(${className} entity) throws CustomException {
		if (StringUtil.isEmpty(entity.getId())) {
			return Result.failure(ResultCode.PARAM_IS_INVALID);
		}
		try {
			Integer flag = this.update(entity);
			if (flag == 1) {
				return Result.success(MessageUtils.getMessage("JC_SYS_003"));
			} else {
				return Result.failure(1, MessageUtils.getMessage("JC_SYS_004"));
			}
		} catch (Exception e) {
			CustomException ce = new CustomException(e);
			ce.setBean(entity);
			throw ce;
		}
	}

	/**
	* @description 发起流程方法
	* @return Integer 增加的记录数
	* @author
	* @version  2020-07-09
	*/
	@Override
	@Transactional(rollbackFor=Exception.class,propagation=Propagation.REQUIRED)
	public Integer saveWorkflow(${className} cond)  throws CustomException {

		propertyService.fillProperties(cond,false);
		cond.setPiId(cond.getWorkflowBean().getBusiness_Key_());
		Integer result = ${className2}Dao.save(cond);
		Map<String,Object> resultMap = instanceService.startProcess(cond.getWorkflowBean());
		if(resultMap.get("code") != null && !resultMap.get("code").toString().equals("0")){
			return Integer.parseInt(resultMap.get("code").toString());
		}
		return result;

	}

	/**
	* @description 修改方法
	* @return Integer 修改的记录数量
	* @author
	* @version  2020-07-09
	*/
	@Override
	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public Integer updateWorkflow(${className} cond) throws  CustomException {
		propertyService.fillProperties(cond,true);
		Integer result = ${className2}Dao.update(cond);
		cond.getWorkflowBean().setBusiness_Key_(cond.getPiId());
		Map<String,Object> resultMap = taskService.excute(cond.getWorkflowBean());
		if(resultMap.get("code") != null && !resultMap.get("code").toString().equals("0")){
			return Integer.parseInt(resultMap.get("code").toString());
		}
		return result;
	}


	@Override
	public PageManager workFlowTodoQueryByPage(${className} cond, PageManager page) {
	return ${className2}Dao.workFlowTodoQueryByPage(cond, page);
	}


	@Override
	public PageManager workFlowDoneQueryByPage(${className} cond, PageManager page) {
	return ${className2}Dao.workFlowDoneQueryByPage(cond, page);
	}


	@Override
	public PageManager workFlowInstanceQueryByPage(${className} cond, PageManager page) {
	return ${className2}Dao.workFlowInstanceQueryByPage(cond, page);
	}

}

