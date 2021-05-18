package ${packageName};

import ${basePackage}.entity.${className};
import ${basePackage}.model.${className}Bean;
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

   List<${className}Bean> queryList(@Param("paramCondition") ${className}Bean paramCondition);

   Page<${className}Bean> queryPageList(@Param("page") Page page, @Param("paramCondition") ${className}Bean paramCondition);

}
