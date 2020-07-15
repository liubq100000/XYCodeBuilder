package ${packageName};

import org.springframework.stereotype.Repository;

import ${basePackage}.dao.I${className}Dao;
import ${basePackage}.domain.${className};
import com.jc.foundation.dao.impl.BaseClientDaoImpl;
import com.jc.foundation.exception.ConcurrentException;
import com.jc.foundation.exception.DBException;

/**
 * @title   
 * @version
 */
@Repository
public class ${className}DaoImpl extends BaseClientDaoImpl<${className}> implements I${className}Dao{

	public ${className}DaoImpl(){}

}