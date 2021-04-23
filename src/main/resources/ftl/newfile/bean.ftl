package ${packageName};

import ${basePackage}.entity.${className};
import com.yx.core.util.YxDateUtil;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;
/**
 * @author liubq
 * @version 2020-07-10
 */
@Data
public class ${className}Bean extends ${className} implements Serializable {

	private static final long serialVersionUID = 1L;
    <#-- 循环类型及属性 -->
    <#list attrs as attr>
    <#if (attr.busiItemType>0)>
    <#if attr.typeName?contains("Date")>
    //${attr.label}开始
    private ${attr.type} ${attr.camelName}Begin;
    //${attr.label}结束
    private ${attr.type} ${attr.camelName}End;
    </#if>
    </#if>
    </#list>
    <#if hasHeadId=="Y">
    //表头ID
    private Long[] headIdList;
    </#if>
    <#if hasUserId=="Y">
    //用户ID
    private Long[] userIdList;
    </#if>


    <#-- 循环生成set get方法 -->
    <#list attrs as attr>
    <#if (attr.busiItemType>0)>
    <#if attr.typeName?contains("Date")>
    public void set${attr.pascalName}Begin(${attr.type} ${attr.camelName}Begin) {
        this.${attr.camelName}Begin = ${attr.camelName}Begin;
    }
    public void set${attr.pascalName}End(${attr.type} ${attr.camelName}End) {
        if(${attr.camelName}End == null){
            return;
        }
        this.${attr.camelName}End = YxDateUtil.fillTime(${attr.camelName}End);
    }
    </#if>
    </#if>
    </#list>
}