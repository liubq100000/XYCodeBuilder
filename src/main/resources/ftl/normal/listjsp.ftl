<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/include/head.jsp"%>
<%@ include file="/WEB-INF/web/include/taglib.jsp"%>
<%@ include file="/WEB-INF/web/include/jctree.jsp"%>
<section class="scrollable padder jcGOA-section" id="scrollable">
	<header class="con-header pull-in" id="navigationMenu">
		<h1></h1><div class="crumbs"></div>
	</header>
	<section class="panel clearfix search-box search-shrinkage">
		<div class="search-line">
			<form class="table-wrap form-table" id="searchForm">
				<table class="table table-td-striped">
					<tbody>
						<#list queryRowList as queryRowItem>
						<tr>
							<#list queryRowItem.rowList as queryItem>
							<#if (queryItem.flag > 0)>
							<td class="w140">${queryItem.label}</td>
							<td>
								<#if queryItem.type?contains("Date")>
								<div class="input-group w-p100">
								<input class="datepicker-input" type="text" id="query_${queryItem.name}Begin" name="query_${queryItem.name}Begin" data-pick-time="false" data-date-format="yyyy-MM-dd" data-ref-obj="<#noparse>#</#noparse>query_${queryItem.name}End lt">
								<div class="input-group-btn w30">-</div>
								<input class="datepicker-input" type="text" id="query_${queryItem.name}End" name="query_${queryItem.name}End" data-pick-time="false" data-date-format="yyyy-MM-dd" data-ref-obj="<#noparse>#</#noparse>query_${queryItem.name}Begin gt">
								</div>
								<#elseif queryItem.disType?contains("Dic")>
								<dic:select  id="query_${queryItem.name}"  name="query_${queryItem.name}" dictName="${queryItem.dicCode}" parentCode="${queryItem.dicParentCode}" defaultValue=""  headName="-全部-" headValue=""/>
								<#elseif queryItem.disType?contains("DeptSelect")>
								<div id="${queryItem.name}SearchDiv">
								<#elseif queryItem.disType?contains("UserSelect")>
								<div id="${queryItem.name}SearchDiv">
								<#else>
								<input type="text" id="query_${queryItem.name}" name="query_${queryItem.name}"/>
								</#if>
							</td>
							<#else>
							<td colspan="2"></td>
							</#if>
							</#list>
						</tr>
						</#list>
						<tr>
							<td style="text-align: center; background: #FFFFFF;" colspan="4">
								<button class="btn" type="button" id="queryBtn">查 询</button>
								<button class="btn" type="button" id="resetBtn">重 置</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</section>
	<section class="panel ">
		<h2 class="panel-heading clearfix">查询结果</h2>
		<div class="table-wrap"><table class="table table-striped tab_height" id="gridTable"></table></div>
		<section class="clearfix" id="footer_height">
			<section class="form-btn fl m-l">
				<a class="btn dark" role="button" id="addBtn">新 增</a>
			</section>
		</section>
	</section>
	<div id="formModule"></div>
</section>
<script src='<#noparse>${sysPath}</#noparse>/js/${basePath}/${className2}List.js'></script>
<%@ include file="/WEB-INF/web/include/foot.jsp"%>