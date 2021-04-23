package ${packageName};

import ${basePackage}.entity.${className}; 
import ${basePackage}.model.${className}Bean;
import com.yx.base.pojo.page.LayuiPageInfo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * @Version 1.0
 */
public interface I${className}Service extends IService<${className}>{

	void add(${className}Bean param)throws Exception;

	void update(${className}Bean param)throws Exception;

	void delete(${className}Bean param)throws Exception;

	${className}Bean findBySpec(${className}Bean param);

	List<${className}Bean> findListBySpec(${className}Bean param);

	LayuiPageInfo findPageBySpec(${className}Bean param);

	<#if hasHeadId=="Y">
	void deleteByHeadId(Long headId);

	void deleteByHeadIds(String headId);

	List<${className}Bean> queryByHeadIds(String headId);
	</#if>
}
