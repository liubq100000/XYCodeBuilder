@layout("/common/_workflow_container.html",{plugins:["workflow"],js:["/assets/common/xyDateUtil.js","/assets/common/yxWorkflow_var.js","/assets/hrNew/annualLeave/annualLeave_workflow_form.js?q=2"]}){
@include("/workflow/common/workflowHide.html"){}
<div class="page-loading">
	<div class="ball-loader">
		<span></span><span></span><span></span><span></span>
	</div>
</div>
<input type="hidden" id="businessJson"	value='${businessJson!}'/>
<form class="layui-form layui-form-pane" id="${className2}Form" lay-filter="${className2}Form">
	<input type="hidden" id="id" name="id"  />
	<input type="hidden" id="piId" name="piId" value='${piId!}'/>
	<input id="openType" name="openType" type="hidden" value='${openType!}'/>
	<div class="layui-fluid" style="padding-bottom: 15px;">
		<div class="layui-card">
			<div class="layui-card-header">基本信息</div>
			<div class="layui-card-body">
				<div class="layui-form-item layui-row">
					<#list formRowList as formRowItem>
					<#list formRowItem.rowList as formItem>
					<div class="layui-inline layui-col-md12">
						<label class="layui-form-label layui-form-required">${formItem.label}</label>
						<div class="layui-input-block">
							<input id="${formItem.name}" name="${formItem.name}" placeholder="请输入" type="text" class="layui-input" lay-verify="required" required workFlowForm='textinput' itemName="${formItem.name}"/>
						</div>
					</div>
					</#list>
					</#list>
				</div>
			</div>

			<div class="layui-card" id="approvalOpinions">
				<div class="layui-card-header">审批意见</div>
				<div class="layui-card-body">

					<div class="layui-form-item layui-row">
						<div class="layui-inline layui-col-md12">
							<div class="layui-inline layui-col-md12">
								<div style='z-index:1' class='layui-form-text'>
									<tag:suggest itemId="workflowStandardSuggest" showLast="false" showTitle="审批意见" order="createTime" classStr="" showWritePannel="false" style=""/>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	<div id="workflowFormButton" class="form-group-bottom text-center">
	</div>

</form>
@include("/workflow/common/workflowLayer.html"){}
@}