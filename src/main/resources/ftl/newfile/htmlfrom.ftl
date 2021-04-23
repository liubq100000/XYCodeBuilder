@layout("/common/_containerEx.html",{js:["/assets/${modulePath}/${minPath}/${className2}Form.js"]}){

<form class="layui-form layui-form-pane" id="${className2}Form" lay-filter="${className2}Form">
	<input type="hidden" id="id" name="id"  />
	<div class="layui-fluid" style="padding-bottom: 15px;">
		<div class="layui-card">
			<div class="layui-card-body">
				<div class="layui-form-item layui-row">
					<#list formRowList as formRowItem>
					<#list formRowItem.rowList as formItem>
					<div class="layui-inline layui-col-md6">
						<label class="layui-form-label layui-form-required">${formItem.label}</label>
						<div class="layui-input-block">
							<#if formItem.type?contains("Date")>
							<input id="${formItem.name}" name="${formItem.name}" placeholder="请输入" type="text" class="layui-input date-icon" lay-verify="required" required xyFlowForm="textinput"/>
							<#else>
							<input id="${formItem.name}" name="${formItem.name}" placeholder="请输入" type="text" class="layui-input" lay-verify="required" required xyFlowForm="textinput"/>
							</#if>
						</div>
					</div>
					</#list>
					</#list>
				</div>
			</div>
		</div>
	</div>
	<div class="form-group-bottom text-center">
		<button class="layui-btn" lay-filter="btnSubmit" lay-submit xyFlowForm="button">保存</button>
		<button type="reset" class="layui-btn layui-btn-primary" ew-event="closeDialog" xyFlowForm="closeBtn">取消</button>
	</div>
</form>
@}