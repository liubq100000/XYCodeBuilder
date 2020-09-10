package ${packageName};

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.util.Date;
import java.io.Serializable;

/**
 * @author liubq
 * @version 2020-07-10
 */
@TableName("${tableName}")
public class ${className} implements Serializable {

	private static final long serialVersionUID = 1L;

	<#-- 循环类型及属性 -->
	<#list attrs as attr>
	<#if (attr.camelName!"xxx") == "id">
    //${attr.label}
	@TableId(value = "${attr.columnName}", type = IdType.ASSIGN_ID)
	private ${attr.type} ${attr.camelName};
	<#else>
	@TableField("${attr.columnName}")
	private ${attr.type} ${attr.camelName};
	</#if>
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