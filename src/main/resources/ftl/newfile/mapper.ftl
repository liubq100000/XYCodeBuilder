package ${packageName};

import ${basePackage}.entity.${className};
import ${basePackage}.model.params.${className}Param;
import ${basePackage}.model.result.${className}Result;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 * @title  
 * @version  
 */
public interface ${className}Mapper extends BaseMapper<${className}> {

   List<${className}Result> customList(@Param("paramCondition") ${className}Param paramCondition);


   List<Map<String, Object>> customMapList(@Param("paramCondition") ${className}Param paramCondition);


   Page<${className}Result> customPageList(@Param("page") Page page, @Param("paramCondition") ${className}Param paramCondition);


   Page<Map<String, Object>> customPageMapList(@Param("page") Page page, @Param("paramCondition") ${className}Param paramCondition);

}
