var vehicleAccess_manage_tool = null; 
$(function () { 
	initVehicleAccessManageTool(); //建立VehicleAccess管理对象
	vehicleAccess_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#vehicleAccess_manage").datagrid({
		url : 'VehicleAccess/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "accessId",
		sortOrder : "desc",
		toolbar : "#vehicleAccess_manage_tool",
		columns : [[
			{
				field : "carNo",
				title : "车牌号",
				width : 140,
			},
			{
				field : "inTime",
				title : "进入时间",
				width : 140,
			},
			{
				field : "inDoor",
				title : "进入校门",
				width : 140,
			},
			{
				field : "outTime",
				title : "离开时间",
				width : 140,
			},
			{
				field : "outDoor",
				title : "离开校门",
				width : 140,
			},
			{
				field : "stopTime",
				title : "停车时长",
				width : 140,
			},
			{
				field : "costFlag",
				title : "是否收费",
				width : 140,
			},
			{
				field : "costMoney",
				title : "收费金额",
				width : 70,
			},
			{
				field : "memo",
				title : "备注信息",
				width : 140,
			},
		]],
	});

	$("#vehicleAccessEditDiv").dialog({
		title : "驶出结算",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "结算收费",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#vehicleAccessEditForm").form("validate")) {
					//验证表单 
					if(!$("#vehicleAccessEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#vehicleAccessEditForm").form({
						    url:"VehicleAccess/" + $("#vehicleAccess_accessId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#vehicleAccessEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#vehicleAccessEditDiv").dialog("close");
			                        vehicleAccess_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#vehicleAccessEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#vehicleAccessEditDiv").dialog("close");
				$("#vehicleAccessEditForm").form("reset"); 
			},
		}],
	});
});

function initVehicleAccessManageTool() {
	vehicleAccess_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#vehicleAccess_manage").datagrid("reload");
		},
		redo : function () {
			$("#vehicleAccess_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#vehicleAccess_manage").datagrid("options").queryParams;
			queryParams["inTime"] = $("#inTime").datebox("getValue"); 
			queryParams["inDoor"] = $("#inDoor").val();
			queryParams["outTime"] = $("#outTime").datebox("getValue"); 
			queryParams["outDoor"] = $("#outDoor").val();
			$("#vehicleAccess_manage").datagrid("options").queryParams=queryParams; 
			$("#vehicleAccess_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#vehicleAccessQueryForm").form({
			    url:"VehicleAccess/OutToExcel",
			});
			//提交表单
			$("#vehicleAccessQueryForm").submit();
		},
		remove : function () {
			var rows = $("#vehicleAccess_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var accessIds = [];
						for (var i = 0; i < rows.length; i ++) {
							accessIds.push(rows[i].accessId);
						}
						$.ajax({
							type : "POST",
							url : "VehicleAccess/deletes",
							data : {
								accessIds : accessIds.join(","),
							},
							beforeSend : function () {
								$("#vehicleAccess_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#vehicleAccess_manage").datagrid("loaded");
									$("#vehicleAccess_manage").datagrid("load");
									$("#vehicleAccess_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#vehicleAccess_manage").datagrid("loaded");
									$("#vehicleAccess_manage").datagrid("load");
									$("#vehicleAccess_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#vehicleAccess_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				if(rows[0].outTime != "--") {
					$.messager.alert("警告操作！", "已经结算过了！", "warning");
					return;
				}
				
				$.ajax({
					url : "VehicleAccess/" + rows[0].accessId +  "/update",
					type : "get",
					data : {
						//accessId : rows[0].accessId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (vehicleAccess, response, status) {
						$.messager.progress("close");
						if (vehicleAccess) { 
							$("#vehicleAccessEditDiv").dialog("open");
							$("#vehicleAccess_accessId_edit").val(vehicleAccess.accessId);
							$("#vehicleAccess_accessId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录id",
								editable: false
							});
							$("#vehicleAccess_carNo_edit").val(vehicleAccess.carNo);
							$("#vehicleAccess_carNo_edit").validatebox({
								required : true,
								missingMessage : "请输入车牌号",
							});
							$("#vehicleAccess_inTime_edit").datetimebox({
								value: vehicleAccess.inTime,
							    required: true,
							    showSeconds: true,
							});
							$("#vehicleAccess_inDoor_edit").val(vehicleAccess.inDoor);
							$("#vehicleAccess_inDoor_edit").validatebox({
								required : true,
								missingMessage : "请输入进入校门",
							});
							$("#vehicleAccess_outTime_edit").datetimebox({
								value: vehicleAccess.outTime,
							    required: true,
							    showSeconds: true,
							});
							$("#vehicleAccess_outDoor_edit").val(vehicleAccess.outDoor);
							$("#vehicleAccess_outDoor_edit").validatebox({
								required : true,
								missingMessage : "请输入离开校门",
							});
							$("#vehicleAccess_stopTime_edit").val(vehicleAccess.stopTime);
							$("#vehicleAccess_stopTime_edit").validatebox({
								required : true,
								missingMessage : "请输入停车时长",
							});
							$("#vehicleAccess_costFlag_edit").val(vehicleAccess.costFlag);
							$("#vehicleAccess_costFlag_edit").validatebox({
								required : true,
								missingMessage : "请输入是否收费",
							});
							$("#vehicleAccess_costMoney_edit").val(vehicleAccess.costMoney);
							$("#vehicleAccess_costMoney_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入收费金额",
								invalidMessage : "收费金额输入不对",
							});
							$("#vehicleAccess_memo_edit").val(vehicleAccess.memo);
							
							var inTime = $("#vehicleAccess_inTime_edit").val();
							var outTime = $("#vehicleAccess_outTime_edit").val();
							
							var d1 = new Date(inTime);
							var d2 = new Date(outTime);
							
							var stopTime = parseFloat((d2 - d1) / 1000 / 3600).toFixed(1);
							
							$("#vehicleAccess_stopTime_edit").val(stopTime + "小时");
							
							if($("#vehicleAccess_costFlag_edit").val() == "是") {
								var costMoney = stopTime * 10; //定义10元1个小时
								$("#vehicleAccess_costMoney_edit").val(costMoney)
							}
								
							 
							
							
							
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
