<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/schoolBus.css" />
<div id="schoolBus_editDiv">
	<form id="schoolBusEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schoolBus_busId_edit" name="schoolBus.busId" value="<%=request.getParameter("busId") %>" style="width:200px" />
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
				<script id="schoolBus_busDesc_edit" name="schoolBus.busDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div class="operation">
			<a id="schoolBusModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/SchoolBus/js/schoolBus_modify.js"></script> 
