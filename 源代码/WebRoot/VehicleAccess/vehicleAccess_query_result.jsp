<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vehicleAccess.css" /> 

<div id="vehicleAccess_manage"></div>
<div id="vehicleAccess_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="vehicleAccess_manage_tool.edit();">驶出结算</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="vehicleAccess_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="vehicleAccess_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="vehicleAccess_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="vehicleAccess_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="vehicleAccessQueryForm" method="post">
			进入时间：<input type="text" id="inTime" name="inTime" class="easyui-datebox" editable="false" style="width:100px">
			进入校门：<input type="text" class="textbox" id="inDoor" name="inDoor" style="width:110px" />
			离开时间：<input type="text" id="outTime" name="outTime" class="easyui-datebox" editable="false" style="width:100px">
			离开校门：<input type="text" class="textbox" id="outDoor" name="outDoor" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="vehicleAccess_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="vehicleAccessEditDiv">
	<form id="vehicleAccessEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="vehicleAccess_accessId_edit" name="vehicleAccess.accessId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">车牌号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="vehicleAccess_carNo_edit" name="vehicleAccess.carNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">进入时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="vehicleAccess_inTime_edit" name="vehicleAccess.inTime" />

			</span>

		</div>
		<div>
			<span class="label">进入校门:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="vehicleAccess_inDoor_edit" name="vehicleAccess.inDoor" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">离开时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="vehicleAccess_outTime_edit" name="vehicleAccess.outTime" />

			</span>

		</div>
		<div>
			<span class="label">离开校门:</span>
			<span class="inputControl">
				<select id="vehicleAccess_outDoor_edit" name="vehicleAccess.outDoor">
					<option value="东校门">东校门</option>
					<option value="南校门">南校门</option>
					<option value="西校门">西校门</option>
					<option value="北校门">北校门</option>
				</select>
			</span>

		</div>
		<div>
			<span class="label">停车时长:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="vehicleAccess_stopTime_edit" name="vehicleAccess.stopTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">是否收费:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="vehicleAccess_costFlag_edit" name="vehicleAccess.costFlag" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收费金额(10元/小时):</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="vehicleAccess_costMoney_edit" name="vehicleAccess.costMoney" style="width:80px" />
				元
			</span>

		</div>
		<div>
			<span class="label">备注信息:</span>
			<span class="inputControl">
				<textarea id="vehicleAccess_memo_edit" name="vehicleAccess.memo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="VehicleAccess/js/vehicleAccess_manage.js"></script> 
