@layout("/common/_container.html",{js:["/assets/${modulePath}/${minPath}/${className2}Form.js"]}){

<form class="layui-form layui-form-pane" id="${className2}Form" lay-filter="${className2}Form">
	<input type="hidden" id="id" name="id"  />
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
							<input id="${formItem.name}" name="${formItem.name}" placeholder="请输入" type="text" class="layui-input" lay-verify="required" required/>
						</div>
					</div>
					</#list>
					</#list>
				</div>
			</div>
		</div>
	</div>
	<div class="form-group-bottom text-center">
		<button class="layui-btn" lay-filter="btnSubmit" lay-submit>保存</button>
		<button type="reset" class="layui-btn layui-btn-primary" ew-event="closeDialog">取消</button>
	</div>
</form>
@}