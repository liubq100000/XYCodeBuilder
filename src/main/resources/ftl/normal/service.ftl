package ${packageName};

import ${basePackage}.domain.${className};
import com.jc.foundation.exception.CustomException;
import com.jc.foundation.service.IBaseService;
import com.jc.foundation.util.Result;

/**
 * @Version 1.0
 */
public interface I${className}Service extends IBaseService<${className}>{

	/**
	 * 根据主键删除多条记录方法
	 * @param entity
	 * @return
	 * @throws CustomException
	 */
	Integer deleteByIds(${className} entity) throws CustomException;

	/**
	 * 保存方法
	 * @param entity
	 * @return
	 * @throws CustomException
	 */
	Result saveEntity(${className} entity) throws CustomException;

	/**
	 * 修改方法
	 * @param entity
	 * @return
	 * @throws CustomException
	 */
	Result updateEntity(${className} entity) throws CustomException;
}
