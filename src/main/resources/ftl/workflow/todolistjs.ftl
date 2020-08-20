var ${className2}JsTodoList = {};
${className2}JsTodoList.pageRows = null;
//重复提交标识
${className2}JsTodoList.subState = false;
//分页对象
${className2}JsTodoList.oTable = null;

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

${className2}JsTodoList.oTableFnServerParams = function(aoData){
    getTableParameters(${className2}JsTodoList.oTable, aoData);

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

${className2}JsTodoList.oTableAoColumns = [
    <#list listItemList as listItem>
    {mData: '${listItem.name}', sTitle: '${listItem.label}', bSortable: false},
    </#list>
	{mData: function(source) {
        var buttonStr = "<a class='a-icon i-new m-r-xs' onclick=${className2}JsTodoList<#noparse>.openForm('/instance/toOpenForm.action?definitionId_="+source.workflowBean.definitionId_+"&business_Key_="+source.workflowBean.business_Key_+"&curNodeId_="+source.workflowBean.curNodeId_+"&taskId_="+source.workflowBean.taskId_+"&instanceId_="+source.workflowBean.instanceId_+"&openType_=TODO') href='javascript:void(0)' >办理</a>";</#noparse>
        <#noparse> buttonStr += "<a class='a-icon i-new m-r-xs' target='_blank' href='"+getRootPath()+"/workflowHistory/showHistory.action?instanceId="+source.workflowBean.instanceId_+"&definitionId="+source.workflowBean.definitionId_+"' >流程历史</a>";</#noparse>
        return buttonStr;
	}, sTitle: '操作', bSortable: false, sWidth: 170}
];

${className2}JsTodoList.openForm = function(url){
    JCFF.loadPage({url:url});
}

${className2}JsTodoList.renderTable = function () {
    $.ajaxSetup ({
        cache: false //设置成false将不会从浏览器缓存读取信息
    });
    if (${className2}JsTodoList.oTable == null) {
        ${className2}JsTodoList.oTable = <#noparse> $('#gridTable')</#noparse>.dataTable( {
            "iDisplayLength": ${className2}JsTodoList.pageCount,
            "sAjaxSource": getRootPath() + "/${modulePath}/${minPath}/manageTodoList.action",
            "fnServerData": oTableRetrieveData,
            "aoColumns": ${className2}JsTodoList.oTableAoColumns,
            "fnServerParams": function ( aoData ) {
                ${className2}JsTodoList.oTableFnServerParams(aoData);
            },
            aaSorting:[],
            aoColumnDefs: []
        });
    } else {
        ${className2}JsTodoList.oTable.fnDraw();
    }
};


${className2}JsTodoList.queryReset = function(){
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


$(document).ready(function(){
    ${className2}JsTodoList.pageCount = TabNub > 0 ? TabNub : 10;
    ${className2}JsTodoList.renderTable();
    <#noparse>$('#queryBtn')</#noparse>.click(${className2}JsTodoList.renderTable);
    <#noparse>$('#queryReset')</#noparse>.click(${className2}JsTodoList.queryReset);
});