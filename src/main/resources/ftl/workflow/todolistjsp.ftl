<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/web/include/head.jsp"%>
<%@ include file="/WEB-INF/web/include/jctree.jsp"%>

<section class="scrollable padder jcGOA-section" id="scrollable">
	<header class="con-header pull-in" id="header_1">
		<div class="con-heading fl" id="navigationMenu">
			<div class="crumbs"></div>
		</div>
	</header>
	<!--start 查询条件-->
	<section class="panel clearfix search-box search-shrinkage">
		<div class="search-line hide">
			<form class="table-wrap form-table" id="searchForm">
				<table class="table table-td-striped">
					<tbody>
						<#list queryRowList as queryRowItem><tr>
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
					</tbody>
				</table>
				<section class="form-btn m-b-lg">
					<button class="btn dark query-jump" type="button" id="queryBtn">查 询</button>
					<button class="btn" type="reset" id="resetBtn">重 置</button>
				</section>
			</form>
		</div>
		<%@include file= "/WEB-INF/web/include/searchConditionHide.jsp"%>
	</section>
	<section class="panel clearfix" id="sendPassTransact-list">
		<div class="table-wrap">
			<table class="table table-striped tab_height" id="gridTable">
			</table>
		</div>
		<section class="clearfix" id="footer_height">
			<section class="form-btn fl m-l">
			</section>
		</section>
	</section>
</section>

<script src='<#noparse>${sysPath}</#noparse>/js/${basePath}/${className2}_todoList.js'></script>
<%@ include file="/WEB-INF/web/include/foot.jsp"%>