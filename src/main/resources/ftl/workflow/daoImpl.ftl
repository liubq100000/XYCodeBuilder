package ${packageName};

import org.springframework.stereotype.Repository;

import ${basePackage}.dao.I${className}Dao;
import ${basePackage}.domain.${className};
import com.jc.foundation.dao.impl.BaseClientDaoImpl;
import com.jc.foundation.exception.ConcurrentException;
import com.jc.foundation.exception.DBException;
import com.jc.foundation.domain.PageManager;
/**
 * @title   
 * @version
 */
@Repository
public class ${className}DaoImpl extends BaseClientDaoImpl<${className}> implements I${className}Dao{

	public ${className}DaoImpl(){}

    @Override
    public PageManager workFlowTodoQueryByPage(${className} cond, PageManager page) {
        return queryByPage(cond,page,"workflowTodoQueryCount","workflowTodoQuery");
    }


    @Override
    public PageManager workFlowDoneQueryByPage(${className} cond, PageManager page) {
        return queryByPage(cond,page,"workflowDoneQueryCount","workflowDoneQuery");
    }


    @Override
    public PageManager workFlowInstanceQueryByPage(${className} cond, PageManager page) {
        return queryByPage(cond,page,"workflowInstanceQueryCount","workflowInstanceQuery");
    }


}