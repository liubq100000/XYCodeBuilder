package ${packageName};

import com.jc.foundation.domain.BaseBean;
import java.util.Date;
import java.math.BigDecimal;
import com.jc.foundation.util.DateUtils;
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