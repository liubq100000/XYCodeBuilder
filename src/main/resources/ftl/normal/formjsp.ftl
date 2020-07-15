<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/include/taglib.jsp"%>
<div class="modal fade panel" id="form-modal" aria-hidden="false">
	<div class="modal-dialog w900">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h4 class="modal-title" id="entityFormTitle"></h4>
			</div>
			<div class="modal-body">
				<form class="table-wrap form-table" id="entityForm">
					<input type="hidden" id="id" name="id" />
					<#noparse><input type="hidden" id="token" name="token" value="${data.token}"></#noparse>
					<input type="hidden" id="modifyDate" name="modifyDate" />
					<table class="table table-td-striped">
						<tbody>
						<#list formRowList as formRowItem>
						<tr>
						<#list formRowItem.rowList as formItem>
							<td><span class='required'>*</span>${formItem.label}</td>
							<#if (formItem.colspanSize > 1)>
							<td colspan="${formItem.colspanSize}">
								<#if formItem.type?contains("Date")>
								<input class="datepicker-input" type="text" id="${formItem.name}" name="${formItem.name}" data-pick-time="false" data-date-format="yyyy-MM-dd">
								<#else>
								<input type="text" id="${formItem.name}" name="${formItem.name}"/>
								</#if>
							</td>
							<#else>
							<td>
								<#if formItem.type?contains("Date")>
								<input class="datepicker-input" type="text" id="${formItem.name}" name="${formItem.name}" data-pick-time="false" data-date-format="yyyy-MM-dd">
								<#else>
								<input type="text" id="${formItem.name}" name="${formItem.name}"/>
								</#if>
							</td>
							</#if>
						</#list>
						</tr>
						</#list>
						</tbody>
					</table>
				</form>
			</div>
			<div class="modal-footer form-btn" style="text-align: center; width: 100%;">
				<button class="btn dark" type="button" id="saveBtn">保 存</button>
				<button class="btn" type="button" id="closeBtn">关 闭</button>
			</div>
		</div>
	</div>
</div>
<script src='<#noparse>${sysPath}</#noparse>/js/${basePath}/${className2}Form.js'></script>