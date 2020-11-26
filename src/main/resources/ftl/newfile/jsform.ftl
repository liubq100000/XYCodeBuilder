layui.use(['form', 'admin', 'ax'], function () {
    var $ = layui.jquery;
    var $ax = layui.ax;
    var form = layui.form;
    var admin = layui.admin;


    //获取详情信息，填充表单
    var editId = Feng.getUrlParam("id");
    if(editId){
        var ajax = new $ax(Feng.ctxPath + "/${className2}/detail?id=" + editId);
        var result = ajax.start();
        form.val('${className2}Form', result.data);
    }

    //表单提交事件
    form.on('submit(btnSubmit)', function (data) {
        var url = Feng.ctxPath + "/${className2}/addItem";
        if(editId){
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