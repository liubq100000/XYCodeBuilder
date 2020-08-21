package ${packageName};

import ${basePackage}.domain.${className};
import com.jc.foundation.dao.IBaseDao;
import com.jc.foundation.domain.PageManager;


/**
 * @title  
 * @version  
 */
public interface I${className}Dao extends IBaseDao<${className}>{

 public PageManager workFlowTodoQueryByPage(${className} cond, PageManager page) ;

 public PageManager workFlowDoneQueryByPage(${className} cond, PageManager page) ;

 public PageManager workFlowInstanceQueryByPage(${className} cond, PageManager page) ;
}
