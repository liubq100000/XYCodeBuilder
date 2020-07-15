/**
 * 用户管理
 */
var pageCurr;
var form;
$(function () {
    layui.use('table', function () {
        var table = layui.table;
        form = layui.form;

        tableIns = table.render({
            elem: '#dataSourceList',
            url: '/dataSource/findList',
            method: 'post', //默认：get请求
            cellMinWidth: 80,
            page: true,
            limit: 20,
            request: {
                pageName: 'pageNum', //页码的参数名称，默认：pageNum
                limitName: 'pageSize' //每页数据量的参数名，默认：pageSize
            },
            response: {
                statusName: 'code', //数据状态的字段名称，默认：code
                statusCode: 200, //成功的状态码，默认：0
                countName: 'totalSize', //数据总数的字段名称，默认：count
                dataName: 'list' //数据列表的字段名称，默认：data
            },
            cols: [[
                {type: 'numbers', title: '序号', width: 80}
                , {field: 'txt', title: '名称', align: 'center', width: 150}
                , {field: 'dbType', title: '类型', align: 'center', width: 100}
                , {field: 'dbName', title: '数据库', align: 'center', width: 100}
                , {field: 'url', title: '地址', align: 'center'}
                , {field: 'username', title: '用户', align: 'center', width: 100}
                , {field: 'password', title: '密码', align: 'center', width: 100}
                , {title: '操作', align: 'center', toolbar: '#optBar', width: 200}
            ]],
            done: function (res, curr, count) {
                pageCurr = curr;
            }
        });

        //监听工具条
        table.on('tool(dataSourceTable)', function (obj) {
            var data = obj.data;
            if (obj.event === 'del') {
                //删除
                deleteDataSource(data, data.id);
            } else if (obj.event === 'edit') {
                editDataSource(data);
            } else if (obj.event === 'createTableCode') {
                createTableCodeFun(data, data.id);
            }
        });

        //监听提交
        form.on('submit(dataSourceSubmit)', function (data) {
            // TODO 校验
            formSubmit(data);
            return false;
        });

        //生成代码
        form.on('submit(selectTableSubmit)', function (data) {
            // TODO 校验
            selectTableSubmit(data);
            return false;
        });
    });
});

//提交表单
function formSubmit(inData) {
    $.ajax({
        type: "POST",
        data: $("#dataSourceForm").serialize(),
        url: "/dataSource/saveDataSource",
        success: function (data) {
            if (data.code == 1) {
                layer.alert("保存成功", function () {
                    layer.closeAll();
                    load(null);
                });
            } else {
                layer.alert(data.msg);
            }
        },
        error: function () {
            layer.alert("操作请求错误，请您稍后再试", function () {
                layer.closeAll();
                //加载load方法
                load(inData);//自定义
            });
        }
    });
}

//生成
function selectTableSubmit(obj) {
    var selectTableNow = $("#selectTableForm #selectTableNow").val();
    var selectId = $("#selectTableForm #selectId").val();
    var url = '/code/codebuild?selectId=' + selectId + "&selectTableNow=" + selectTableNow + "&_=" + (new Date().getTime());
    window.open(url);
}

//新增数据源
function addDataSource() {
    $("#id").val("");
    var pageNum = $(".layui-laypage-skip").find("input").val();
    $("#pageNum").val(pageNum);
    layer.open({
        type: 1,
        title: "新增数据源",
        fixed: false,
        resize: false,
        shadeClose: true,
        area: ['950px'],
        content: $('#saveDataSource'),
        end: function () {
            cleanDataSource();
        }
    });
}

//编辑数据源
function editDataSource(data) {
    var pageNum = $(".layui-laypage-skip").find("input").val();
    $("#pageNum").val(pageNum);
    $("#id").val(data.id);
    $("#txt").val(data.txt);
    $("#dbType").val(data.dbType);
    $("#dbName").val(data.dbName);
    $("#url").val(data.url);
    $("#username").val(data.username);
    $("#password").val(data.password);
    layer.open({
        type: 1,
        title: "编辑数据源",
        fixed: false,
        resize: false,
        shadeClose: true,
        area: ['950px'],
        content: $('#saveDataSource'),
        end: function () {
            cleanDataSource();
        }
    });
}


function deleteDataSource(obj, id) {
    layer.confirm('您确定要删除吗？', {
        btn: ['确认', '返回'] //按钮
    }, function () {
        $.post("/dataSource/deleteDataSource", {"id": id}, function (data) {
            if (data.code == 1) {
                layer.alert("删除成功", function () {
                    layer.closeAll();
                    load(obj);
                });
            } else {
                layer.alert(data.msg);
            }
        });
    }, function () {
        layer.closeAll();
    });
}

function createTableCodeFun(obj, id) {
    var roleId = null;
    $("#selectId").val(id);
    $.ajax({
        url: '/code/tableInfo?id=' + id + "&_=" + (new Date().getTime()),
        dataType: 'json',
        async: true,
        success: function (data) {
            $('#selectTableNow').html("");
            $.each(data, function (index, item) {
                var option = new Option(item, item);
                $('#selectTableNow').append(option);//往下拉菜单里添加元素
                form.render('select'); //这个很重要
            })
        }
    });
    layer.open({
        type: 1,
        title: "选择",
        fixed: false,
        resize: false,
        shadeClose: true,
        area: ['950px'],
        content: $('#selectTable'),
        end: function () {
        }
    });
}


function load(obj) {
    var whereCond = {};
    if (obj && obj.field) {
        whereCond = obj.field;
    }
    //重新加载table
    tableIns.reload({
        where: whereCond
        , page: {
            curr: pageCurr //从当前页码开始
        }
    });
}

function cleanDataSource() {
}
