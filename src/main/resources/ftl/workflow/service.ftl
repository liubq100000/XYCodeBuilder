package ${packageName};

import ${basePackage}.domain.${className};
import com.jc.foundation.exception.CustomException;
import com.jc.foundation.domain.PageManager;
import com.jc.foundation.service.IBaseService;
import com.jc.foundation.util.Result;

/**
 * @Version 1.0
 */
public interface I${className}Service extends IBaseService<${className}>{

	Integer deleteByIds(${className} entity) throws CustomException;

	Result saveEntity(${className} entity) throws CustomException;

	Result updateEntity(${className} entity) throws CustomException;
	
	Integer saveWorkflow(${className} projectPlan)  throws CustomException ;
	
	Integer updateWorkflow(${className} cond) throws  CustomException ;

	PageManager workFlowTodoQueryByPage(${className} cond, PageManager page) ;

	PageManager workFlowDoneQueryByPage(${className} cond, PageManager page) ;

	PageManager workFlowInstanceQueryByPage(${className} cond, PageManager page) ;
}
