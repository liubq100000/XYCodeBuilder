package ${packageName};

import cn.stylefeng.roses.kernel.model.validator.BaseValidatingParam;
import java.io.Serializable;
import java.util.Date;
/**
 * @author liubq
 * @version 2020-07-10
 */
public class ${className}Param implements Serializable, BaseValidatingParam {

	private static final long serialVersionUID = 1L;

	<#-- 循环类型及属性 -->
	<#list attrs as attr>
    //${attr.label}
	private ${attr.type} ${attr.camelName};
	</#list>

	<#-- 循环生成set get方法 -->
	<#list attrs as attr>
	public void set${attr.pascalName}(${attr.type} ${attr.camelName}) {
		this.${attr.camelName} = ${attr.camelName};
	}
	public ${attr.type} get${attr.pascalName}() {
		return ${attr.camelName};
	}
	</#list>
}