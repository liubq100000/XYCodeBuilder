//初始化方法
var ${className2}JsForm = {};

//重复提交标识
${className2}JsForm.subState = false;

function insert(type,jumpFun) {
    if(${className2}JsForm.subState)  return;
        ${className2}JsForm.subState = true;
    var url = getRootPath()+"/${modulePath}/${minPath}/saveWorkflow.action";
    var formData = $("#entityForm").serializeArray();
    jQuery.ajax({
        url : url,
        type : 'POST',
        cache: false,
        data : formData,
        success : function(data) {
            ${className2}JsForm.subState = false;
            if(data.success == "true"){
                msgBox.tip({
                    type: "success",
                    content: data.successMessage,
                    callback: ${className2}JsForm.gotoTodo
                });
                $("#token").val(data.token);
            } else {
                if(data.labelErrorMessage){
                    showErrors("entityForm", data.labelErrorMessage);
                } else{
                    msgBox.info({
                        type:"fail",
                        content: data.errorMessage
                    });
                }
                $("#token").val(data.token);
            }
        },
        error : function() {
            ${className2}JsForm.subState = false;
            msgBox.tip({
                type:"fail",
                content: $.i18n.prop("JC_SYS_002")
            });
        }
    });
}

function update(type, jumpFun) {
    if(${className2}JsForm.subState)  return;
        ${className2}JsForm.subState = true;
    var url = getRootPath()+"/${modulePath}/${minPath}/updateWorkflow.action";
    var formData = $("#entityForm").serializeArray();
    jQuery.ajax({
        url : url,
        async : false,
        type : 'POST',
        data : formData,
        success : function(data) {
            ${className2}JsForm.subState = false;
            if(data.success == "true"){
                msgBox.tip({
                    type: "success",
                    content: data.successMessage,
                    callback: ${className2}JsForm.gotoTodo
                });
                $("#token").val(data.token);
            } else {
                if(data.labelErrorMessage){
                    showErrors("entityForm", data.labelErrorMessage);
                } else{
                    msgBox.info({
                        type: "fail",
                        content: data.errorMessage
                    });
                }
            }
        },
        error : function() {
            ${className2}JsForm.subState = false;
            msgBox.tip({
                type:"fail",
                content: $.i18n.prop("JC_SYS_002")
            });
        }
    });
}

function validateForm(){
    return $("#entityForm").valid();
}

//校验失败调用的方法
function validateFormFail(){
    ${className2}JsForm.subState = false;
    msgBox.info({
        content : $.i18n.prop("JC_SYS_067"),
    });
}

${className2}JsForm.gotoTodo = function(){
    JCFF.loadPage({url:"/${modulePath}/${minPath}/todoList.action"});
}

<#list formRowList as formRowItem>
<#list formRowItem.rowList as formItem>
<#if formItem.disType?contains("DeptSelect")>
${formItem.name}FormTree = JCTree.init({
    container: "${formItem.name}FormDiv",
    controlId: "${formItem.name}FormDiv-${formItem.name}",
    isCheckOrRadio:false,
    isPersonOrOrg:false
});
<#elseif formItem.disType?contains("UserSelect")>
${formItem.name}FormTree = JCTree.init({
    container: "${formItem.name}FormDiv",
    controlId: "${formItem.name}FormDiv-${formItem.name}",
    isCheckOrRadio:false,
    isPersonOrOrg:true
});
</#if>
</#list>
</#list>

$(document).ready(function(){
    ie8StylePatch();
    $(".datepicker-input").each(function(){$(this).datepicker();});
    $("#saveAndClose").click(function(){${className2}JsForm.saveOrModify(true);});
    $("#saveOrModify").click(function(){${className2}JsForm.saveOrModify(false);});
    $("#formDivClose").click(function(){$('#myModal-edit').modal('hide');});

    var businessJson = $("#businessJson").val();
    if(businessJson.length>0){
        var businessObj = eval("("+businessJson+")");
        $("#entityForm").fill(businessObj);
        <#list formRowList as formRowItem>
        <#list formRowItem.rowList as formItem>
        <#if formItem.disType?contains("DeptSelect")>
        if (businessObj.${formItem.name} && businessObj.${formItem.name}Value) {
            ${formItem.name}FormTree.setData(businessObj.${formItem.name}Value[0]);
        }
        <#elseif formItem.disType?contains("UserSelect")>
        if (businessObj.${formItem.name} && businessObj.${formItem.name}Value) {
            ${formItem.name}FormTree.setData(businessObj.${formItem.name}Value[0]);
        }
        </#if>
        </#list>
        </#list>
    }
    formPriv.doForm();
});
