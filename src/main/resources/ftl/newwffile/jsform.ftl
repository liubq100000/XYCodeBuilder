var ${className2}Fun = {
    subState: false,
    saveOrUpdate: 'save'
};

function validateForm() {
    return form.flowValidateFlag_;
}

function validateFormFail(result) {
    Feng.alert(result);
}

function insert(type, layerIdex) {
    if (${className2}Fun.subState) return;
    ${className2}Fun.subState = true;
    var url = Feng.ctxPath + "/${className2}/saveWorkflow.action";
    var formData = $("#${className2}Form").serializeArray();
    jQuery.ajax({
        url: url,
        type: 'POST',
        cache: false,
        data: formData,
        success: function (data) {
            ${className2}Fun.subState = false;
            Feng.closeLoading();
            if (data.success == "true") {
                Feng.successCallback(data.successMessage, function () {
                    Feng.closeModalByIndex(layerIdex);
                    top.layui.index.refreshTab({title: '我的待办', url: "/workflowExt/todoList.action"});
                })
            } else {
                Feng.error(data.errorMessage)
            }
        },
        error: function () {
            ${className2}Fun.subState = false;
            Feng.closeLoading();
            Feng.error("提交失败")
        }
    });
}

function update(type, layerIdex) {
    if (${className2}Fun.subState) return;
    ${className2}Fun.subState = true;
    var url = Feng.ctxPath + "/${className2}/updateWorkflow.action";
    var formData = $("#${className2}Form").serializeArray();

    jQuery.ajax({
        url: url,
        cache: false,
        async: false,
        type: 'POST',
        data: formData,
        success: function (data) {
            ${className2}Fun.subState = false;
            Feng.closeLoading();
            if (data.success == "true") {
            Feng.closeModalByIndex(layerIdex);
            Feng.successCallback(data.successMessage, function () {
                Feng.closeModalByIndex(layerIdex);
                top.layui.index.refreshTab({title: '我的待办', url: "/workflowExt/todoList.action"});
            })
            } else {
            Feng.error(data.errorMessage)
            }
        },
        error: function () {
            ${className2}Fun.subState = false;
            Feng.closeLoading();
            Feng.error("提交失败")
        }
    });
}


layui.use(['layer', 'ax', 'form', 'admin', 'table', 'util', 'upload', 'laydate', 'func', 'index'], function () {
    var $ = layui.jquery;
    var $ax = layui.ax;
    var layer = layui.layer;
    var form = layui.form;
    var admin = layui.admin;
    var table = layui.table;
    var util = layui.util;
    var laydate = layui.laydate;
    var func = layui.func;
    var index = layui.index;
    var upload = layui.upload;



    var businessJson = $("#businessJson").val();
    if (businessJson.length > 0) {
        ${className2}Fun.saveOrUpdate = 'update';
        var businessObj = eval("(" + businessJson + ")");
        form.val('${className2}Form', businessObj);
    }
    formPriv.doForm();

});