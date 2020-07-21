var codeAssemblyFun = {};
codeAssemblyFun.resMap;
codeAssemblyFun.initSuccess = true;
//空值处理
codeAssemblyFun.nvl = function (data) {
    if (data) {
        return data;
    }
    return "";
}
//初始化
codeAssemblyFun.init = function () {
    var selectTableNow = $("#selectTableNow").val();
    var selectId = $("#selectId").val();
    $.ajax({
        type: "GET",
        url: "/code/columnInfo?selectTableNow=" + selectTableNow + "&selectId=" + selectId + "&n_" + (new Date().getTime()),
        success: function (data) {
            if (data.code == '000000') {
                codeAssemblyFun.resMap = data;
                codeAssemblyFun.initPage();
            } else {
                codeAssemblyFun.initSuccess = false;
                alert(data.message)
            }
        }
    });
}
//初始化页面
codeAssemblyFun.initPage = function () {
    codeAssemblyFun.initQueryPage();
    codeAssemblyFun.initListPage();
    codeAssemblyFun.initFormPage();
}
//查询区域选择
codeAssemblyFun.initQueryPage = function () {
    $("#listQueryDefDiv").html("");
    var h = "<table style='width:100%;' border='1px'>";
    h += "<tr>";
    h += "<td style='width:150px;' align='center'>名称</td>";
    h += "<td style='width:150px;' align='center'>类型</td>";
    h += "<td style='width:150px;' align='center'>查询显示</td>";
    h += "<td style='width:150px;' align='center'>模糊</td>";
    h += "<td align='center'>排序</td>";
    h += "</tr>";
    var attList = codeAssemblyFun.resMap.attList;
    var item;
    for (var index = 0; index < attList.length; index++) {
        item = attList[index];
        h += "<tr>";
        h += "<td>";
        h += item.label;
        h += "</td>";
        h += "<td>";
        h += item.type;
        h += "</td>";
        h += "<td>";
        h += "<select id='query_display_" + item.camelName + "' name='query_display_" + item.camelName + "'  style='width:100%;'>";
        h += "<option value='N'>否</option>";
        h += "<option value='Y'>是</option>";
        h += "</select>";
        h += "</td>";
        if (item.type == 'String') {
            h += "<td>";
            h += "<select id='query_search_" + item.camelName + "'  name='query_search_" + item.camelName + "'  style='width:100%;'>";
            h += "<option value='N'>否</option>";
            h += "<option value='Y'>是</option>";
            h += "</select>";
            h += "</td>";
        } else {
            h += "<td>";
            h += '否';
            h += "</td>";
        }
        h += "<td>";
        h += "<input type='hidden' id='query_code_" + item.camelName + "'  name='query_code_" + item.camelName + "' value='" + item.camelName + "'>";
        h += "<input type='hidden' id='query_type_" + item.camelName + "'  name='query_type_" + item.camelName + "' value='" + item.type + "'>";
        h += "<input type='hidden' id='query_label_" + item.camelName + "'  name='query_label_" + item.camelName + "' value='" + item.label + "'>";
        var sort = index;
        if (item.sort) {
            sort = item.sort;
        }
        h += "<input type='text' id='query_sort_" + item.camelName + "'  name='query_sort_" + item.camelName + "' value='" + sort + "'>";
        h += "</td>";
        h += "</tr>";
    }
    h += "</table>";
    $("#listQueryDefDiv").html(h);
}

//列表区域选择
codeAssemblyFun.initListPage = function () {
    $("#listDefDiv").html("");
    var h = "<table style='width:100%;' border='1px'>";
    h += "<tr>";
    h += "<td style='width:150px;' align='center'>名称</td>";
    h += "<td style='width:150px;' align='center'>类型</td>";
    h += "<td style='width:150px;' align='center'>列表显示</td>";
    h += "<td align='center'>排序</td>";
    h += "</tr>";
    var attList = codeAssemblyFun.resMap.attList;
    var item;
    for (var index = 0; index < attList.length; index++) {
        item = attList[index];
        h += "<tr>";
        h += "<td>";
        h += item.label;
        h += "</td>";
        h += "<td>";
        h += item.type;
        h += "</td>";
        h += "<td>";
        if (item.camelName.indexOf("id") >= 0
            || item.camelName.indexOf("ext") >= 0
            || item.camelName.indexOf("create") >= 0
            || item.camelName.indexOf("modify") >= 0
            || item.camelName.indexOf("delete") >= 0) {
            h += "<select id='list_display_" + item.camelName + "' name='list_display_" + item.camelName + "' style='width:100%;'>";
            h += "<option value='N'>否</option>";
            h += "<option value='Y'>是</option>";
            h += "</select>";
        } else {
            h += "<select id='list_display_" + item.camelName + "' name='list_display_" + item.camelName + "' style='width:100%;'>";
            h += "<option value='Y'>是</option>";
            h += "<option value='N'>否</option>";
            h += "</select>";
        }
        h += "</td>";
        h += "<td>";
        h += "<input type='hidden' id='list_code_" + item.camelName + "' name='list_code_" + item.camelName + "' value='" + item.camelName + "'>";
        h += "<input type='hidden' id='list_type_" + item.camelName + "'  name='list_type_" + item.camelName + "' value='" + item.type + "'>";
        h += "<input type='hidden' id='list_label_" + item.camelName + "'  name='list_label_" + item.camelName + "' value='" + item.label + "'>";
        var sort = index;
        if (item.sort) {
            sort = item.sort;
        }
        h += "<input type='text'  id='list_sort_" + item.camelName + "' name='list_sort_" + item.camelName + "' value='" + sort + "'>";
        h += "</td>";
        h += "</tr>";
    }
    h += "</table>";
    $("#listDefDiv").html(h);
}

//表单区域选择
codeAssemblyFun.initFormPage = function () {
    $("#formDefDiv").html("");
    var h = "<table style='width:100%;' border='1px'>";
    h += "<tr>";
    h += "<td style='width:150px;' align='center'>名称</td>";
    h += "<td style='width:150px;' align='center'>类型</td>";
    h += "<td style='width:150px;' align='center'>表单显示</td>";
    h += "<td style='width:150px;' align='center'>列宽</td>";
    h += "<td style='width:150px;' align='center'>列高</td>";
    h += "<td align='center'>排序</td>";
    h += "</tr>";
    var attList = codeAssemblyFun.resMap.attList;
    var item;
    for (var index = 0; index < attList.length; index++) {
        item = attList[index];
        h += "<tr>";
        h += "<td>";
        h += item.label;
        h += "</td>";
        h += "<td>";
        h += item.type;
        h += "</td>";
        h += "<td>";
        if (item.camelName.indexOf("id") >= 0
            || item.camelName.indexOf("ext") >= 0
            || item.camelName.indexOf("create") >= 0
            || item.camelName.indexOf("modify") >= 0
            || item.camelName.indexOf("delete") >= 0) {
            h += "<select id='form_display_" + item.camelName + "' name='form_display_" + item.camelName + "' style='width:100%;'>";
            h += "<option value='N'>否</option>";
            h += "<option value='Y'>是</option>";
            h += "</select>";
        } else {
            h += "<select id='form_display_" + item.camelName + "' name='form_display_" + item.camelName + "' style='width:100%;'>";
            h += "<option value='Y'>是</option>";
            h += "<option value='N'>否</option>";
            h += "</select>";
        }
        h += "</td>";
        h += "<td>";
        h += "<select id='form_width_" + item.camelName + "' name='form_width_" + item.camelName + "' style='width:100%;'>";
        h += "<option value='1'>1</option>";
        h += "<option value='2'>2</option>";
        h += "</select>";
        h += "</td>";
        h += "<td>";
        h += "<input type='text' id='form_height_" + item.camelName + "' name='form_height_" + item.camelName + "'>";
        h += "</td>";
        h += "<td>";
        h += "<input type='hidden' id='form_code_" + item.camelName + "' name='form_code_" + item.camelName + "' value='" + item.camelName + "'>";
        h += "<input type='hidden' id='form_type_" + item.camelName + "'  name='form_type_" + item.camelName + "' value='" + item.type + "'>";
        h += "<input type='hidden' id='form_label_" + item.camelName + "'  name='form_label_" + item.camelName + "' value='" + item.label + "'>";
        var sort = index;
        if (item.sort) {
            sort = item.sort;
        }
        h += "<input type='text' id='form_sort_" + item.camelName + "' name='form_sort_" + item.camelName + "'  value='" + sort + "'>";
        h += "</td>";
        h += "</tr>";
    }
    h += "</table>";
    $("#formDefDiv").html(h);
}
codeAssemblyFun.save = function () {
    var formData = [];
    $("[name^='form_code_']").each(function (itemIndex, itemObj) {
        var camelName = $(itemObj).val();
        var displayValue = $("#form_display_" + camelName).val();
        var widthValue = $("#form_width_" + camelName).val();
        var heightValue = $("#form_height_" + camelName).val();
        var typeValue = $("#form_type_" + camelName).val();
        var labelValue = $("#form_label_" + camelName).val();
        var sortValue = $("#form_sort_" + camelName).val();
        var itemData = {
            "name": codeAssemblyFun.nvl(camelName),
            "display": codeAssemblyFun.nvl(displayValue),
            "width": codeAssemblyFun.nvl(widthValue),
            "height": codeAssemblyFun.nvl(heightValue),
            "type": codeAssemblyFun.nvl(typeValue),
            "label": codeAssemblyFun.nvl(labelValue),
            "sort": codeAssemblyFun.nvl(sortValue)
        };
        formData[formData.length] = itemData;
    })
    console.log(formData)

    var listData = [];
    $("[name^='list_code_']").each(function (itemIndex, itemObj) {
        var camelName = $(itemObj).val();
        var displayValue = $("#list_display_" + camelName).val();
        var typeValue = $("#list_type_" + camelName).val();
        var labelValue = $("#list_label_" + camelName).val();
        var sortValue = $("#list_sort_" + camelName).val();
        var itemData = {
            "name": codeAssemblyFun.nvl(camelName),
            "display": codeAssemblyFun.nvl(displayValue),
            "type": codeAssemblyFun.nvl(typeValue),
            "label": codeAssemblyFun.nvl(labelValue),
            "sort": codeAssemblyFun.nvl(sortValue)
        };
        listData[listData.length] = itemData;
    })
    console.log(listData)

    var queryData = [];
    $("[name^='query_code_']").each(function (itemIndex, itemObj) {
        var camelName = $(itemObj).val();
        var displayValue = $("#query_display_" + camelName).val();
        var queryValue = $("#query_search_" + camelName).val();
        var typeValue = $("#query_type_" + camelName).val();
        var labelValue = $("#query_label_" + camelName).val();
        var sortValue = $("#query_sort_" + camelName).val();
        var itemData = {
            "name": codeAssemblyFun.nvl(camelName),
            "display": codeAssemblyFun.nvl(displayValue),
            "query": codeAssemblyFun.nvl(queryValue),
            "type": codeAssemblyFun.nvl(typeValue),
            "label": codeAssemblyFun.nvl(labelValue),
            "sort": codeAssemblyFun.nvl(sortValue)
        };
        queryData[queryData.length] = itemData;
    })
    console.log(queryData)
    var selectTableNow = $("#selectTableNow").val();
    var selectMode = $("#selectMode").val();
    var selectProjectName = $("#selectProjectName").val();
    var selectTableBaseDir = $("#selectTableBaseDir").val();
    var selectId = $("#selectId").val();
    if(selectProjectName == null){
        layer.alert("请输入项目名称");
        return ;
    }
    if(selectTableBaseDir == null){
        layer.alert("请输入项目存储地址");
        return ;
    }
    $.ajax({
        type: "POST",
        data: {
            "selectId": selectId,
            "selectTableNow": selectTableNow,
            "selectProjectName": selectProjectName,
            "selectTableBaseDir": selectTableBaseDir,
            "selectMode": selectMode,
            "formData": JSON.stringify(formData),
            "listData": JSON.stringify(listData),
            "queryData": JSON.stringify(queryData)
        },
        url: "/code/build?n_=" + (new Date().getTime()),
        success: function (data) {
            window.location.href = "/code/down";
            layer.alert("生成成功");
        }
    });


}


$(function () {
    codeAssemblyFun.init();
});