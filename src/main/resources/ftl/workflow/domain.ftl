package ${packageName};

import com.jc.foundation.domain.BaseBean;
import java.util.List;
import java.util.Map;
import java.util.Date;
import java.math.BigDecimal;
import com.jc.foundation.util.DateUtils;
import com.jc.foundation.util.SpringContextHolder;
import com.jc.system.security.SystemSecurityUtils;
import com.jc.system.dic.IDicManager;
import com.jc.system.dic.domain.Dic;
import com.jc.workflow.external.WorkflowBean;
/**
 * @author lc 
 * @version 2020-03-10
 */
public class ${className} extends BaseBean {

	private static final long serialVersionUID = 1L;
	public ${className}() {
	}
	<#-- 循环类型及属性 -->
	<#list attrs as attr>
	<#if (attr.busiItemType>0)>
	<#if attr.typeName?contains("Date")>
	private ${attr.type} ${attr.camelName};
	private ${attr.type} ${attr.camelName}Begin;
	private ${attr.type} ${attr.camelName}End;
	<#else>
	private ${attr.type} ${attr.camelName};
	</#if>
	</#if>
	</#list>

	//待办人查询
	private String curUserId;
	
	private WorkflowBean workflowBean = new WorkflowBean();

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
		this.${attr.camelName}End = DateUtils.fillTime(${attr.camelName}End);
	}
	public ${attr.type} get${attr.pascalName}End() {
		return ${attr.camelName}End;
	}
	public void set${attr.pascalName}(${attr.type} ${attr.camelName}) {
		this.${attr.camelName} = ${attr.camelName};
	}
	public ${attr.type} get${attr.pascalName}() {
		return ${attr.camelName};
	}
	<#elseif attr.disType?contains("Dic")>
	public void set${attr.pascalName}(${attr.type} ${attr.camelName}) {
		this.${attr.camelName} = ${attr.camelName};
	}
	public ${attr.type} get${attr.pascalName}() {
		return ${attr.camelName};
	}
	public ${attr.type} get${attr.pascalName}Value() {
		if(${attr.camelName} == null){
			return null;
		}
		IDicManager dicManager = SpringContextHolder.getBean(IDicManager.class);
		Dic dic = dicManager.getDic("${attr.dicCode}","${attr.dicParentCode}", this.${attr.camelName});
		return dic == null ? "" : dic.getValue();
	}
	<#elseif attr.disType?contains("DeptSelect")>
	public void set${attr.pascalName}(${attr.type} ${attr.camelName}) {
		this.${attr.camelName} = ${attr.camelName};
	}
	public ${attr.type} get${attr.pascalName}() {
		return ${attr.camelName};
	}
	public List<Map<String, String>> get${attr.pascalName}Value() {
		if(${attr.camelName} == null){
			return null;
		}
		return SystemSecurityUtils.getDeptByDeptIdsToSelectControl(${attr.camelName});
	}
	<#elseif attr.disType?contains("UserSelect")>
	public void set${attr.pascalName}(${attr.type} ${attr.camelName}) {
		this.${attr.camelName} = ${attr.camelName};
	}
	public ${attr.type} get${attr.pascalName}() {
		return ${attr.camelName};
	}
	public List<Map<String, String>> get${attr.pascalName}Value() {
		if(${attr.camelName} == null){
			return null;
		}
		return SystemSecurityUtils.getUsersByUserIdsToSelectControl(${attr.camelName});
	}
	<#else>
	public void set${attr.pascalName}(${attr.type} ${attr.camelName}) {
		this.${attr.camelName} = ${attr.camelName};
	}
	public ${attr.type} get${attr.pascalName}() {
		return ${attr.camelName};
	}
	</#if>
	</#if>
	</#list>
	public WorkflowBean getWorkflowBean() {
		return workflowBean;
	}

	public void setWorkflowBean(WorkflowBean workflowBean) {
		this.workflowBean = workflowBean;
	}

	public String getCurUserId() {
		return curUserId;
	}

	public void setCurUserId(String curUserId) {
		this.curUserId = curUserId;
	}

}