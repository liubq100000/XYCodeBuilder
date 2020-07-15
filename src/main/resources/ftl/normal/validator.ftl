package ${packageName};

import ${basePackage}.domain.${className};
import com.jc.foundation.util.MessageUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * @Version 1.0
 */
public class ${className}Validator implements Validator{
	private static final String JC_SYS_010 = "JC_SYS_010";
	private static final String JC_SYS_011 = "JC_SYS_011";
	private static final int FIFTY = 50;
	private static final int TWO_HUNDRED = 200;

	/**
	 * @description 检验类能够校验的类
	 * @param arg0  校验的类型
	 * @return 是否支持校验
	 * @Author 常鹏
	 * @version 1.0
	 */
	@Override
	public boolean supports(Class<?> arg0) {
		return ${className}.class.equals(arg0);
	}

	/**
	 * @version 1.0
	 */
	@Override
	public void validate(Object arg0, Errors arg1) {
		${className} v = (${className}) arg0;
		<#list attrs as attr>
		<#if attr.typeName?contains("String")>
		if (v.get${attr.pascalName}() != null && v.get${attr.pascalName}().length() > ${attr.size?c}) {
			arg1.reject("${attr.camelName}", MessageUtils.getMessage(JC_SYS_011, new Object[]{"${attr.size?c}"}));
		}
		</#if>				    
		</#list>		
	}
}
