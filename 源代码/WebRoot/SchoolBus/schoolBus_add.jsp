<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/schoolBus.css" />
<div id="schoolBusAddDiv">
	<form id="schoolBusAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">车牌号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schoolBus_busNo" name="schoolBus.busNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">校车图片:</span>
			<span class="inputControl">
				<input id="busPhotoFile" name="busPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">车辆型号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schoolBus_busModel" name="schoolBus.busModel" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">购买日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schoolBus_buyDate" name="schoolBus.buyDate" />

			</span>

		</div>
		<div>
			<span class="label">最近一次维修时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="schoolBus_recentRepairTime" name="schoolBus.recentRepairTime" />

			</span>

		</div>
		<div>
			<span class="label">车辆详情:</span>
			<span class="inputControl">
				<script name="schoolBus.busDesc" id="schoolBus_busDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div class="operation">
			<a id="schoolBusAddButton" class="easyui-linkbutton">添加</a>
			<a id="schoolBusClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/SchoolBus/js/schoolBus_add.js"></script> 
