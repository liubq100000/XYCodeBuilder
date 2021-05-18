package ${packageName};

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.alibaba.fastjson.annotation.JSONField;
import java.util.Date;
import lombok.Data;
import java.io.Serializable;
import java.math.BigDecimal;
/**
 * 属性
 * @author liubq
 * @version 2020-07-10
 */
@TableName("${tableName}")
@Data
public class ${className} implements Serializable {

	private static final long serialVersionUID = 1L;

	<#-- 循环类型及属性 -->
	<#list attrs as attr>
	<#if (attr.camelName!"xxx") == "id">
    //${attr.label}
	@TableId(value = "${attr.columnName}", type = IdType.ASSIGN_ID)
	private ${attr.type} ${attr.camelName};
	<#else>
	//${attr.label}
	<#if attr.typeName?contains("Date")>
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	</#if>
	@TableField("${attr.columnName}")
	private ${attr.type} ${attr.camelName};
	</#if>
	</#list>
}