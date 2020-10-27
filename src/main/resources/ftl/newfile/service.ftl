package ${packageName};

import ${basePackage}.entity.${className};
import ${basePackage}.model.${className}Param;
import ${basePackage}.model.${className}Result;
import com.yx.base.pojo.page.LayuiPageInfo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * @Version 1.0
 */
public interface I${className}Service extends IService<${className}>{

	void add(${className}Param param)throws Exception;

	void update(${className}Param param)throws Exception;

	void delete(${className}Param param)throws Exception;

	${className}Result findBySpec(${className}Param param);

	List<${className}Result> findListBySpec(${className}Param param);

	LayuiPageInfo findPageBySpec(${className}Param param);

	<#if hasHeadId=="Y">
	${className}Result queryByHeadIds(String headId);
	</#if>
}
