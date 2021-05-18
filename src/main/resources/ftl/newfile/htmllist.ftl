@layout("/common/_containerEx.html",{js:["/assets/${modulePath}/${minPath}/${className2}.js"]}){

<div class="layui-body-header">
	<span class="layui-body-header-title">基本信息</span>
</div>

<div class="layui-fluid">
	<div class="layui-row layui-col-space15">
		<div class="layui-col-sm12 layui-col-md12 layui-col-lg12">
			<div class="layui-card">
				<div class="layui-card-body">
					<div class="layui-form toolbar">
						<div class="layui-form-item">
							<form id="searchForm">
							<div class="layui-inline">
								<input id="query_name" class="layui-input" type="text" placeholder="名称"/>
							</div>
							<div class="layui-inline">
								<input type="button" id="btnSearch" class="layui-btn icon-btn" value="搜索" />
								<input type="button" id="btnReset" class="layui-btn icon-btn" value="重置" />
								<input type="button" id="btnAdd" class="layui-btn icon-btn" value="添加" />
							</div>
							</form>
						</div>
					</div>
					<table class="layui-table" id="${className2}Table" lay-filter="${className2}Table"></table>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/html" id="tableBar">
	<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="view">查看</a>
	<a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
</script>
@}