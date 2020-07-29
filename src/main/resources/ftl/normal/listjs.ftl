var ${className2}JsList = {};
${className2}JsList.oTable = null;

<#list queryRowList as queryRowItem>
<#list queryRowItem.rowList as queryItem>
<#if (queryItem.flag > 0)>
<#if queryItem.disType?contains("DeptSelect")>
${queryItem.name}SearchTree = JCTree.init({
    container: "${queryItem.name}SearchDiv",
    controlId: "${queryItem.name}SearchDiv-${queryItem.name}",
    isCheckOrRadio:false,
    isPersonOrOrg:false
});
<#elseif queryItem.disType?contains("UserSelect")>
${queryItem.name}SearchTree = JCTree.init({
    container: "${queryItem.name}SearchDiv",
    controlId: "${queryItem.name}SearchDiv-${queryItem.name}",
    isCheckOrRadio:false,
    isPersonOrOrg:true
});
</#if>
</#if>
</#list>
</#list>

${className2}JsList.oTableFnServerParams = function(aoData){
    getTableParameters(${className2}JsList.oTable, aoData);
    <#list queryRowList as queryRowItem>
    <#list queryRowItem.rowList as queryItem>
    <#if (queryItem.flag > 0)>
    <#if queryItem.type?contains("Date")>
    var ${queryItem.name}CondObjBegin  <#noparse>= $('#searchForm #</#noparse>query_${queryItem.name}Begin').val();
    if (${queryItem.name}CondObjBegin && ${queryItem.name}CondObjBegin.length > 0) { aoData.push({"name": "${queryItem.name}Begin", "value": ${queryItem.name}CondObjBegin}); }
    var ${queryItem.name}CondObjEnd  <#noparse>= $('#searchForm #</#noparse>query_${queryItem.name}End').val();
    if (${queryItem.name}CondObjEnd && ${queryItem.name}CondObjEnd.length > 0) { aoData.push({"name": "${queryItem.name}End", "value": ${queryItem.name}CondObjEnd}); }
    <#elseif queryItem.disType?contains("DeptSelect")>
    var ${queryItem.name}CondObj  <#noparse>= $('#searchForm #</#noparse>${queryItem.name}SearchDiv-${queryItem.name}').val();
    if (${queryItem.name}CondObj && ${queryItem.name}CondObj.length > 0) { aoData.push({"name": "${queryItem.name}", "value": ${queryItem.name}CondObj}); }
    <#elseif queryItem.disType?contains("UserSelect")>
    var ${queryItem.name}CondObj  <#noparse>= $('#searchForm #</#noparse>${queryItem.name}SearchDiv-${queryItem.name}').val();
    if (${queryItem.name}CondObj && ${queryItem.name}CondObj.length > 0) { aoData.push({"name": "${queryItem.name}", "value": ${queryItem.name}CondObj}); }
    <#else>
    var ${queryItem.name}CondObj  <#noparse>= $('#searchForm #</#noparse>query_${queryItem.name}').val();
    if (${queryItem.name}CondObj && ${queryItem.name}CondObj.length > 0) { aoData.push({"name": "${queryItem.name}", "value": ${queryItem.name}CondObj}); }
    </#if>
    </#if>
    </#list>
    </#list>
};

${className2}JsList.oTableAoColumns = [
    <#list listItemList as listItem>
    {mData: '${listItem.name}', sTitle: '${listItem.label}', bSortable: false},
    </#list>
	{mData: function(source) {
		var edit = "<a class=\"a-icon i-edit m-r-xs\" <#noparse> href=\"#myModal-edit\" </#noparse> onclick=\"${className2}JsList.loadModuleForUpdate('"+ source.id+ "')\" role=\"button\">" + finalParamEditText + "</a>";
		var del = "<a class=\"a-icon i-remove\" <#noparse> href=\"#\" </#noparse> onclick=\"${className2}JsList.delete('"+ source.id+ "')\">" + finalParamDeleteText + "</a>";
		return edit + del;
	}, sTitle: '操作', bSortable: false, sWidth: 170}
];

${className2}JsList.renderTable = function () {
    if (${className2}JsList.oTable == null) {
        ${className2}JsList.oTable = <#noparse> $('#gridTable')</#noparse>.dataTable( {
            "iDisplayLength": ${className2}JsList.pageCount,
            "sAjaxSource": getRootPath() + "/${modulePath}/${minPath}/manageList.action",
            "fnServerData": oTableRetrieveData,
            "aoColumns": ${className2}JsList.oTableAoColumns,
            "fnServerParams": function ( aoData ) {
                ${className2}JsList.oTableFnServerParams(aoData);
            },
            aaSorting:[],
            aoColumnDefs: []
        });
    } else {
        ${className2}JsList.oTable.fnDraw();
    }
};

${className2}JsList.delete = function (id) {
    var ids = String(id);
    if (id == 0) {
        var idsArr = [];
	<#noparse>
        $("[name='ids']:checked").each(function() {
            idsArr.push($(this).val());
        });
	</#noparse>
        ids = idsArr.join(",");
    }
    if (ids.length == 0) {
        <#noparse>msgBox.info({ content: $.i18n.prop("JC_SYS_061") });</#noparse>
        return;
    }
    msgBox.confirm({
        <#noparse>content: $.i18n.prop("JC_SYS_034"),</#noparse>
        success: function(){
            ${className2}JsList.deleteCallBack(ids);
        }
    });
};

${className2}JsList.deleteCallBack = function(ids) {
    $.ajax({
        type: "POST", url: getRootPath() + "/${modulePath}/${minPath}/deleteByIds.action", data: {"ids": ids}, dataType: "json",
        success : function(data) {
            if (data.success == "true") {
                msgBox.tip({ type:"success", content: data.successMessage });
            } else {
                msgBox.info({ content: data.errorMessage });
            }
            ${className2}JsList.renderTable();
        }
    });
};

${className2}JsList.queryReset = function(){
    <#noparse>$('#searchForm')</#noparse>[0].reset();
    <#list queryRowList as queryRowItem>
    <#list queryRowItem.rowList as queryItem>
    <#if queryItem.disType?contains("DeptSelect")>
    ${queryItem.name}SearchTree.clearValue();
    <#elseif queryItem.disType?contains("UserSelect")>
    ${queryItem.name}SearchTree.clearValue();
    </#if>
    </#list>
    </#list>
};

${className2}JsList.loadModuleForAdd = function (){
    <#noparse>$("#formModule")</#noparse>.load(getRootPath() + "/${modulePath}/${minPath}/loadForm.action", null, function() {
        ${className2}JsForm.init({title: '新增', operator: 'add'});
    });
};

${className2}JsList.loadModuleForUpdate = function (id){
    <#noparse>$("#formModule")</#noparse>.load(getRootPath() + "/${modulePath}/${minPath}/loadForm.action", null, function() {
        ${className2}JsForm.init({title: '修改', operator: 'modify', id: id});
    });
};

$(document).ready(function(){
    ${className2}JsList.pageCount = TabNub > 0 ? TabNub : 10;
    ${className2}JsList.renderTable();
    <#noparse>$('#queryBtn')</#noparse>.click(${className2}JsList.renderTable);
    <#noparse>$('#resetBtn')</#noparse>.click(${className2}JsList.queryReset);
    <#noparse>$("#addBtn")</#noparse>.click(${className2}JsList.loadModuleForAdd);
});