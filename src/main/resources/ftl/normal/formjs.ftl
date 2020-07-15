var ${className2}JsForm = {};

/**
 * 初始化
 * @param config {
 *     title： 标题
 *     operator： 操作 add/modify
 *     id: 修改时的主键id
 * }
 */
${className2}JsForm.init = function(config) {
    <#noparse>$('#entityFormTitle').html(config.title)</#noparse>;
    <#noparse>$("#entityForm #id").val('');</#noparse>
    if (config.operator == 'add') {
        ${className2}JsForm.operatorModal('show');
    } else if (config.operator == 'modify') {
        $.ajax({
            type : "GET", data : {id: config.id}, dataType : "json",
            url : getRootPath() + "/${modulePath}/${minPath}/get.action",
            success : function(data) {
                if (data) {
                    hideErrorMessage();
                    <#noparse>$("#entityForm").fill(data);</#noparse>
                    var companyType = ',' + data.companyType + ',';
                    $("[name='companyTypeCheckbox']").each(function () {
                        if (companyType.indexOf(',' + $(this).val() + ',') > -1) {
                            this.checked = true;
                        }
                    });
                    ${className2}JsForm.operatorModal('show');
                }
            }
        });
    }
};

/**
 * 验证表单
 * @returns {boolean}
 */
${className2}JsForm.formValidate = function() {
    <#noparse>if (!$("#entityForm").valid()) {
        return false;
    }</#noparse> 
    return true;
};

/**
 * 保存或修改方法
 */
${className2}JsForm.saveOrModify = function () {
	if (${className2}JsForm.subState) {
	    return;
    }
	${className2}JsForm.subState = true;
	if (!${className2}JsForm.formValidate()) {
	    ${className2}JsForm.subState = false;
	    return;
    }
	var url = getRootPath() + "/${modulePath}/${minPath}/" + <#noparse> ($("#id").val() != '' ? 'update' : 'save') + '.action';</#noparse> 
    jQuery.ajax({
        url : url, type : 'POST', cache: false, data : <#noparse> $("#entityForm").serializeArray(),</#noparse> 
        success : function(data) {
            ${className2}JsForm.subState = false;
            <#noparse> $("#token").val(data.token);</#noparse> 
            if(data.success == "true"){
                msgBox.tip({ type: "success", content: data.successMessage });
                ${className2}JsForm.operatorModal('hide');
                ${className2}JsList.renderTable();
            } else {
                if (data.labelErrorMessage) {
                    showErrors("entityForm", data.labelErrorMessage);
                } else{
                    msgBox.info({ type:"fail", content: data.errorMessage });
                }
            }
        },
        error : function() {
            ${className2}JsForm.subState = false;
            msgBox.tip({ type:"fail", content: $.i18n.prop("JC_SYS_002") });
        }
    });
};

/**
 * 操作窗口开关
 * @param operator
 */
${className2}JsForm.operatorModal = function (operator) {
    <#noparse> $('#form-modal').modal(operator);</#noparse> 
};

$(document).ready(function(){
    ie8StylePatch();
	$(".datepicker-input").each(function(){$(this).datepicker();});
    <#noparse> $('#saveBtn')</#noparse> .click(function () { ${className2}JsForm.saveOrModify(); });
    <#noparse> $('#closeBtn')</#noparse> .click(function () { ${className2}JsForm.operatorModal('hide'); });
});

/**
 * jquery.validate
 */
<#noparse> $("#entityForm").validate({</#noparse> 
	ignore:'ignore',
	rules: {
	<#list attrs as attr>
	<#if (attr.busiItemType>0)>
		${attr.camelName}: { required: false, maxlength:${attr.size?c} },
	</#if>
	</#list>
    }
});