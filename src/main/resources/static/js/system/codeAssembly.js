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
                codeAssemblyFun.initSort();
            } else {
                codeAssemblyFun.initSuccess = false;
                alert(data.message)
            }
        }
    });
}
codeAssemblyFun.initSort = function () {
    var trObj1 = Sortable.create(document.getElementById('queryTableXX'), {
        animation: 150,
        store: {//缓存到localStorage
            get: function (sortable) {

            },
            set: function (sortable) {

            }
        }
    });
    var trObj2 = Sortable.create(document.getElementById('listTableXX'), {
        animation: 150,
        store: {//缓存到localStorage
            get: function (sortable) {

            },
            set: function (sortable) {

            }
        }
    });
    var trObj3 = Sortable.create(document.getElementById('formTableXX'), {
        animation: 150,
        store: {//缓存到localStorage
            get: function (sortable) {

            },
            set: function (sortable) {

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
    h += "<thead>";
    h += "<tr>";
    h += "<td style='width:150px;' align='center'>名称</td>";
    h += "<td style='width:150px;' align='center'>类型</td>";
    h += "<td style='width:150px;' align='center'><span style='color:#F00;font-weight: bold'>查询显示</span></td>";
    h += "<td style='width:150px;' align='center'>模糊</td>";
    h += "<td align='center'>排序</td>";
    h += "</tr>";
    h += "</thead>";
    h += "<tbody  id='queryTableXX'>";
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
        h += "<input type='hidden' id='query_sort_" + item.camelName + "'  name='query_sort_" + item.camelName + "' value='" + sort + "'>";
        h += "</td>";
        h += "</tr>";
    }
    h += "</tbody>";
    h += "</table>";
    $("#listQueryDefDiv").html(h);
}

//列表区域选择
codeAssemblyFun.initListPage = function () {
    $("#listDefDiv").html("");
    var h = "<table style='width:100%;' border='1px'>";
    h += "<thead>";
    h += "<tr>";
    h += "<td style='width:150px;' align='center'>名称</td>";
    h += "<td style='width:150px;' align='center'>类型</td>";
    h += "<td style='width:150px;' align='center'><span style='color:#F00;font-weight: bold'>列表显示</span></td>";
    h += "<td align='center'>排序</td>";
    h += "</tr>";
    h += "</thead>";
    h += "<tbody  id='listTableXX'>";
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
        h += "<input type='hidden'  id='list_sort_" + item.camelName + "' name='list_sort_" + item.camelName + "' value='" + sort + "'>";
        h += "</td>";
        h += "</tr>";
    }
    h += "</tbody>";
    h += "</table>";
    $("#listDefDiv").html(h);
}

//表单区域选择
codeAssemblyFun.initFormPage = function () {
    $("#formDefDiv").html("");
    var h = "<table style='width:100%;' border='1px'>";
    h += "<thead>";
    h += "<tr>";
    h += "<td style='width:150px;' align='center'>名称</td>";
    h += "<td style='width:150px;' align='center'>类型</td>";
    h += "<td style='width:150px;' align='center'><span style='color:#F00;font-weight: bold'>表单显示</span></td>";
    // h += "<td style='width:150px;' align='center'>列宽</td>";
    // h += "<td style='width:150px;' align='center'>列高</td>";
    h += "<td style='width:150px;' align='center'>显示类型</td>";
    h += "<td style='width:150px;' align='center'>字典编码</td>";
    h += "<td style='width:150px;' align='center'>父字典编码</td>";
    h += "<td align='center'>排序</td>";
    h += "</tr>";
    h += "</thead>";
    h += "<tbody  id='formTableXX'>";
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
        // h += "<td>";
        // h += "<select id='form_width_" + item.camelName + "' name='form_width_" + item.camelName + "' style='width:100%;'>";
        // h += "<option value='1'>1</option>";
        // h += "<option value='2'>2</option>";
        // h += "</select>";
        // h += "</td>";
        // h += "<td>";
        // h += "<input type='text' id='form_height_" + item.camelName + "' name='form_height_" + item.camelName + "'>";
        // h += "</td>";
        if (item.type == 'String') {
            h += "<td>";
            h += "<select id='form_disType_" + item.camelName + "'  name='form_disType_" + item.camelName + "'  style='width:100%;'>";
            h += "<option value=''>普通</option>";
            h += "<option value='Dic'>字典</option>";
            h += "<option value='DeptSelect'>部门选择</option>";
            h += "<option value='UserSelect'>人员选择</option>";
            h += "</select>";
            h += "</td>";
            h += "</td>";
            h += "<td>";
            h += "<input type='text' id='form_dicCode_" + item.camelName + "'  name='form_dicCode_" + item.camelName + "'>";
            h += "</td>";
            h += "<td>";
            h += "<input type='text' id='form_dicParentCode_" + item.camelName + "'  name='form_dicParentCode_" + item.camelName + "'>";
            h += "</td>";
        } else {
            h += "<td>";
            h += '普通';
            h += "</td>";
            h += "<td>";
            h += "</td>";
            h += "<td>";
            h += "</td>";
        }
        h += "<td>";
        h += "<input type='hidden' id='form_code_" + item.camelName + "' name='form_code_" + item.camelName + "' value='" + item.camelName + "'>";
        h += "<input type='hidden' id='form_type_" + item.camelName + "'  name='form_type_" + item.camelName + "' value='" + item.type + "'>";
        h += "<input type='hidden' id='form_label_" + item.camelName + "'  name='form_label_" + item.camelName + "' value='" + item.label + "'>";
        var sort = index;
        if (item.sort) {
            sort = item.sort;
        }
        h += "<input type='hidden' id='form_sort_" + item.camelName + "' name='form_sort_" + item.camelName + "'  value='" + sort + "'>";
        h += "</td>";
        h += "</tr>";
    }
    h += "</tbody>";
    h += "</table>";
    $("#formDefDiv").html(h);
}
codeAssemblyFun.save = function () {
    var formData = [];
    var sortNow = 0;
    var isDicOk = true;
    $("[name^='form_code_']").each(function (itemIndex, itemObj) {
        var camelName = $(itemObj).val();
        var displayValue = $("#form_display_" + camelName).val();
        var widthValue = 1;//$("#form_width_" + camelName).val();
        var heightValue = 1;//$("#form_height_" + camelName).val();
        var typeValue = $("#form_type_" + camelName).val();
        var labelValue = $("#form_label_" + camelName).val();
        var disTypeValue = $("#form_disType_" + camelName).val();
        var dicCodeValue = $("#form_dicCode_" + camelName).val();
        var dicParentCodeValue = $("#form_dicParentCode_" + camelName).val();
        if (disTypeValue == 'Dic') {
            if (!(dicCodeValue && dicCodeValue != '' && dicParentCodeValue && dicParentCodeValue != '')) {
                isDicOk = false;
                return;
            }
        }
        var itemData = {
            "name": codeAssemblyFun.nvl(camelName),
            "display": codeAssemblyFun.nvl(displayValue),
            "width": codeAssemblyFun.nvl(widthValue),
            "height": codeAssemblyFun.nvl(heightValue),
            "type": codeAssemblyFun.nvl(typeValue),
            "label": codeAssemblyFun.nvl(labelValue),
            "disType": codeAssemblyFun.nvl(disTypeValue),
            "dicCode": codeAssemblyFun.nvl(dicCodeValue),
            "dicParentCode": codeAssemblyFun.nvl(dicParentCodeValue),
            "sort": sortNow++
        };
        formData[formData.length] = itemData;
    })
    if(!isDicOk){
        layer.alert("请在表单输入字典编码信息");
        return;
    }
    //console.log(formData)

    var listData = [];
    sortNow = 0;
    $("[name^='list_code_']").each(function (itemIndex, itemObj) {
        var camelName = $(itemObj).val();
        var displayValue = $("#list_display_" + camelName).val();
        var typeValue = $("#list_type_" + camelName).val();
        var labelValue = $("#list_label_" + camelName).val();
        var itemData = {
            "name": codeAssemblyFun.nvl(camelName),
            "display": codeAssemblyFun.nvl(displayValue),
            "type": codeAssemblyFun.nvl(typeValue),
            "label": codeAssemblyFun.nvl(labelValue),
            "sort": sortNow++
        };
        listData[listData.length] = itemData;
    })
    //console.log(listData)

    var queryData = [];
    sortNow = 0;

    $("[name^='query_code_']").each(function (itemIndex, itemObj) {

        var camelName = $(itemObj).val();
        var displayValue = $("#query_display_" + camelName).val();
        var queryValue = $("#query_search_" + camelName).val();
        var typeValue = $("#query_type_" + camelName).val();
        var labelValue = $("#query_label_" + camelName).val();
        var itemData = {
            "name": codeAssemblyFun.nvl(camelName),
            "display": codeAssemblyFun.nvl(displayValue),
            "query": codeAssemblyFun.nvl(queryValue),
            "type": codeAssemblyFun.nvl(typeValue),
            "label": codeAssemblyFun.nvl(labelValue),
            "sort": sortNow++
        };
        queryData[queryData.length] = itemData;
    })
    //console.log(queryData)
    var selectTableNow = $("#selectTableNow").val();
    var selectMode = $("#selectMode").val();
    var selectProjectName = $("#selectProjectName").val();
    var selectTableBaseDir = $("#selectTableBaseDir").val();
    var selectId = $("#selectId").val();
    if (selectProjectName == null) {
        layer.alert("请输入项目名称");
        return;
    }
    if (selectTableBaseDir == null) {
        layer.alert("请输入项目存储地址");
        return;
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

            layer.confirm('生成成功,是否下载', function(){
                window.location.href = "/code/down";
            });
        }
    });


}


$(function () {
    codeAssemblyFun.init();
});