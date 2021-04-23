layui.use(['table', 'admin', 'ax', 'func'], function () {
    var $ = layui.$;
    var table = layui.table;
    var $ax = layui.ax;
    var admin = layui.admin;
    var func = layui.func;

    //管理
    var ${className} = {
        tableId: "${className2}Table"
    };

    //初始化表格的列
    ${className}.initColumn = function () {
        return [[
            {type: 'checkbox'},
            <#list listItemList as listItem>
            {field: '${listItem.name}', sort: false, title: '${listItem.label}'},
            </#list>
            {align: 'center', toolbar: '#tableBar', title: '操作'}
        ]];
    };

    //点击查询按钮
    ${className}.queryParams = function () {
        var queryData = {};
        var condObj = $("#query_name").val();
        if(condObj){
            queryData['name'] = condObj;
        }
        return queryData;
    };

    //点击查询按钮
    ${className}.search = function () {
        table.reload(${className}.tableId, {page: {curr: 1}});
    };

    //弹出添加对话框
    ${className}.openAddDlg = function () {
        func.open({
            title: '添加',
            height: '420',
            content: Feng.ctxPath + '/${className2}/add',
            tableId: ${className}.tableId
        });
    };

    //点击编辑
    ${className}.openEditDlg = function (data) {
        func.openEx({
            title: '修改',
            height: '420',
            content: Feng.ctxPath + '/${className2}/edit?id=' + data.id,
            tableId: ${className}.tableId
        });
    };

    //点击查看
    ${className}.openViewDlg = function (data) {
        func.openEx({
            title: '查看',
            height: '420',
            content: Feng.ctxPath + '/${className2}/edit?openMode=look&id=' + data.id,
            tableId: ${className}.tableId
        });
    };

    //点击删除
    ${className}.onDeleteItem = function (data) {
        var operation = function () {
        var ajax = new $ax(Feng.ctxPath + "/${className2}/delete", function (data) {
                Feng.success("删除成功!");
                table.reload(${className}.tableId);
            }, function (data) {
                Feng.error("删除失败!" + data.responseJSON.message + "!");
            });
            ajax.set("id", data.id);
            ajax.start();
        };
        Feng.confirm("是否删除?", operation);
    };

    // 渲染表格
    var tableResult = table.render({
        elem: '#' + ${className}.tableId,
        url: Feng.ctxPath + '/${className2}/list',
        toolbar: '#toolbarDemo', //开启头部工具栏，并为其绑定左侧模板
        defaultToolbar: ['filter', {title: '导出', layEvent: 'EXPORT', icon: 'layui-icon-export'}, 'print'],
        queryParams: ${className}.queryParams(),
        page: true,
        limit:20,
        height: "full-98",
        cellMinWidth: 100,
        cols: ${className}.initColumn()
    });
    // 导出
    table.on('toolbar(' + VehicleInformation.tableId + ')', function (obj) {
        if (obj.event === 'EXPORT') {
            xyexport.do(layui, tableResult, "信息");
        }
    });
    // 搜索按钮点击事件
    $('#btnSearch').click(function () {
        ${className}.search();
    });
    // 重置按钮点击事件
    $("#btnReset").click(function () {
        $('#searchForm')[0].reset();
    });
    // 添加按钮点击事件
    $('#btnAdd').click(function () {
        ${className}.openAddDlg();
    });
    // 工具条点击事件
    table.on('tool(' + ${className}.tableId + ')', function (obj) {
        var data = obj.data;
        var layEvent = obj.event;

        if (layEvent === 'edit') {
            ${className}.openEditDlg(data);
        } else if (layEvent === 'view') {
            ${className}.openEditDlg(data);
        } else if (layEvent === 'delete') {
            ${className}.onDeleteItem(data);
        }
    });
});