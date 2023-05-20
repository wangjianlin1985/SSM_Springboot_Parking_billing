<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/schoolBus.css" /> 

<div id="schoolBus_manage"></div>
<div id="schoolBus_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="schoolBus_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="schoolBus_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="schoolBus_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="schoolBus_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="schoolBus_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="schoolBusQueryForm" method="post">
			车牌号：<input type="text" class="textbox" id="busNo" name="busNo" style="width:110px" />
			车辆型号：<input type="text" class="textbox" id="busModel" name="busModel" style="width:110px" />
			购买日期：<input type="text" id="buyDate" name="buyDate" class="easyui-datebox" editable="false" style="width:100px">
			最近一次维修时间：<input type="text" id="recentRepairTime" name="recentRepairTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="schoolBus_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="schoolBusEditDiv">
	<form id="schoolBusEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schoolBus_busId_edit" name="schoolBus.busId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">车牌号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schoolBus_busNo_edit" name="schoolBus.busNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">校车图片:</span>
			<span class="inputControl">
				<img id="schoolBus_busPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="schoolBus_busPhoto" name="schoolBus.busPhoto"/>
				<input id="busPhotoFile" name="busPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">车辆型号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schoolBus_busModel_edit" name="schoolBus.busModel" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">购买日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schoolBus_buyDate_edit" name="schoolBus.buyDate" />

			</span>

		</div>
		<div>
			<span class="label">最近一次维修时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schoolBus_recentRepairTime_edit" name="schoolBus.recentRepairTime" />

			</span>

		</div>
		<div>
			<span class="label">车辆详情:</span>
			<span class="inputControl">
				<script name="schoolBus.busDesc" id="schoolBus_busDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var schoolBus_busDesc_editor = UE.getEditor('schoolBus_busDesc_edit'); //车辆详情编辑器
</script>
<script type="text/javascript" src="SchoolBus/js/schoolBus_manage.js"></script> 
