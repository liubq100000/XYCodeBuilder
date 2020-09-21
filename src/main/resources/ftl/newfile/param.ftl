package ${packageName};

import cn.stylefeng.roses.kernel.model.validator.BaseValidatingParam;
import com.yx.core.util.YxDateUtil;
import java.io.Serializable;
import java.util.Date;
/**
 * @author liubq
 * @version 2020-07-10
 */
public class ${className}Param extends ${className}Bean implements Serializable, BaseValidatingParam {

	private static final long serialVersionUID = 1L;
    <#-- 循环类型及属性 -->
    <#list attrs as attr>
    <#if (attr.busiItemType>0)>
    <#if attr.typeName?contains("Date")>
    //${attr.label}
    private ${attr.type} ${attr.camelName}Begin;
    //${attr.label}
    private ${attr.type} ${attr.camelName}End;
    </#if>
    </#if>
    </#list>
    <#-- 循环生成set get方法 -->
    <#list attrs as attr>
    <#if (attr.busiItemType>0)>
    <#if attr.typeName?contains("Date")>
    public void set${attr.pascalName}Begin(${attr.type} ${attr.camelName}Begin) {
        this.${attr.camelName}Begin = ${attr.camelName}Begin;
    }
    public ${attr.type} get${attr.pascalName}Begin() {
        return ${attr.camelName}Begin;
    }
    public void set${attr.pascalName}End(${attr.type} ${attr.camelName}End) {
        if(${attr.camelName}End == null){
            return;
        }
        this.${attr.camelName}End = YxDateUtil.fillTime(${attr.camelName}End);
    }
    public ${attr.type} get${attr.pascalName}End() {
        return ${attr.camelName}End;
    }
    </#if>
    </#if>
    </#list>

}