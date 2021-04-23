layui.use(['form', 'admin', 'ax', 'laydate', 'func', 'yx'], function () {
    var $ = layui.jquery;
    var $ax = layui.ax;
    var form = layui.form;
    var admin = layui.admin;
    var yx = layui.yx;
    var func = layui.func;
    var laydate = layui.laydate;
    //管理
    var ${className}Module = {
        formId: "${className2}Form"
    };
    //新增 0， 编辑 1，其它 2
    InvoiceInfoModule.openFlag = 0;
    //获取详情信息，填充表单
    var editId = Feng.getUrlParam("id");
    var openMode = Feng.getUrlParam("openMode");
    if(editId){
        InvoiceInfoModule.openFlag = 1;
        var ajax = new $ax(Feng.ctxPath + "/${className2}/detail?id=" + editId);
        var result = ajax.start();
        form.val(${className}Module.formId, result.data);
        if(openMode == 'view' || openMode == 'look'){
            InvoiceInfoModule.openFlag = 2;
            xyForm.readOnly(layui,${className}Module.formId);
        }
    }

    //表单提交事件
    form.on('submit(btnSubmit)', function (data) {
        var url = Feng.ctxPath + "/${className2}/addItem";
        if(InvoiceInfoModule.openFlag > 0){
            url = Feng.ctxPath + "/${className2}/editItem";
        }
        var ajax = new $ax(url, function (data) {
            if(data.success){
                Feng.success("保存成功！");
                //传给上个页面，刷新table用
                admin.putTempData('formOk', true);
                //关掉对话框
                admin.closeThisDialog();
            } else {
                Feng.alert(data.message)
            }
        }, function (data) {
            Feng.error("保存失败！" + data.responseJSON.message)
        });
        ajax.set(data.field);
        ajax.start();
        return false;
    });

});