<%@ page language="java" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/include/head.jsp"%>
<%@ include file="/WEB-INF/web/include/taglib.jsp"%>
<%@ include file="/WEB-INF/web/include/jctree.jsp"%>
<%@ include file="/WEB-INF/web/include/webupload.jsp"%>
<%@ include file="/WEB-INF/web/include/workflowHide.jsp"%>

<script src="<#noparse>${sysPath}</#noparse>/js/com/jc/workflow/form.all.js" type="text/javascript"></script>

<section class="scrollable padder jcGOA-section" id="scrollable">
	<header class="con-header pull-in" id="header_1">
		<div class="con-heading fl" id="navigationMenu">
			<div class="crumbs"></div>
		</div>
	</header>
	<!--start 表格-->
	<section class="panel m-t-md clearfix">
		<form class="table-wrap w900 m-20-auto" id="entityForm">
			<h3 class="tc"></h3>
			<#noparse><input type="hidden" id="businessJson"	value='${businessJson}'/></#noparse>
			<#noparse><input type="hidden" id="token" name="token" value="${token}"/></#noparse>
			<#noparse><input type="hidden" id="id" name="id" value="0"/></#noparse>
			<#noparse><input type="hidden" id="piId" name="piId" value='${piId}'/></#noparse>
			<#noparse><input type="hidden" id="modifyDate" name="modifyDate"/></#noparse>
			<!-- 归档文书档案开关隐藏域  -->

			<table class="table table-td-striped">
				<tbody>
				<#list formRowList as formRowItem>
					<tr>
						<#list formRowItem.rowList as formItem>
							<td><span class='required'>*</span>${formItem.label}</td>
							<#if (formItem.colspanSize > 1)>
							<td colspan="${formItem.colspanSize}">
								<#if formItem.type?contains("Date")>
								<input class="datepicker-input" type="text" id="${formItem.name}" name="${formItem.name}" workFlowForm='textinput' data-pick-time="false" data-date-format="yyyy-MM-dd">
								<#else>
								<input type="text" id="${formItem.name}" name="${formItem.name}" workFlowForm='textinput'/>
								</#if>
							</td>
							<#else>
							<td>
								<#if formItem.type?contains("Date")>
								<input class="datepicker-input" type="text" id="${formItem.name}" name="${formItem.name}" workFlowForm='textinput' data-pick-time="false" data-date-format="yyyy-MM-dd">
								<#else>
								<input type="text" id="${formItem.name}" name="${formItem.name}" workFlowForm='textinput'/>
								</#if>
							</td>
							</#if>
						</#list>
					</tr>
				</#list>
				</tbody>
			</table>
		</form>
	</section>
	<div id="formFoorDiv" class="m-l-md">
		<section id="workflowFormButton" class=" form-btn statistics-box">

		</section>
	</div>
	<!--end 表格-->
</section>

<%@ include file="/WEB-INF/web/include/workflowLayer.jsp"%>
<script src='<#noparse>${sysPath}</#noparse>/js/${basePath}/${className2}_form.js' type="text/javascript"></script>
<script src='<#noparse>${sysPath}</#noparse>/js/${basePath}/${className2}.validate.js' type="text/javascript"></script>
<%@ include file="/WEB-INF/web/include/foot.jsp"%>