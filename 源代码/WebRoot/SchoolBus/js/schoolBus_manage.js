var schoolBus_manage_tool = null; 
$(function () { 
	initSchoolBusManageTool(); //建立SchoolBus管理对象
	schoolBus_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#schoolBus_manage").datagrid({
		url : 'SchoolBus/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "busId",
		sortOrder : "desc",
		toolbar : "#schoolBus_manage_tool",
		columns : [[
			{
				field : "busNo",
				title : "车牌号",
				width : 140,
			},
			{
				field : "busPhoto",
				title : "校车图片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "busModel",
				title : "车辆型号",
				width : 140,
			},
			{
				field : "buyDate",
				title : "购买日期",
				width : 140,
			},
			{
				field : "recentRepairTime",
				title : "最近一次维修时间",
				width : 140,
			},
		]],
	});

	$("#schoolBusEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#schoolBusEditForm").form("validate")) {
					//验证表单 
					if(!$("#schoolBusEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#schoolBusEditForm").form({
						    url:"SchoolBus/" + $("#schoolBus_busId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#schoolBusEditForm").form("validate"))  {
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
			                        $("#schoolBusEditDiv").dialog("close");
			                        schoolBus_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#schoolBusEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#schoolBusEditDiv").dialog("close");
				$("#schoolBusEditForm").form("reset"); 
			},
		}],
	});
});

function initSchoolBusManageTool() {
	schoolBus_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#schoolBus_manage").datagrid("reload");
		},
		redo : function () {
			$("#schoolBus_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#schoolBus_manage").datagrid("options").queryParams;
			queryParams["busNo"] = $("#busNo").val();
			queryParams["busModel"] = $("#busModel").val();
			queryParams["buyDate"] = $("#buyDate").datebox("getValue"); 
			queryParams["recentRepairTime"] = $("#recentRepairTime").datebox("getValue"); 
			$("#schoolBus_manage").datagrid("options").queryParams=queryParams; 
			$("#schoolBus_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#schoolBusQueryForm").form({
			    url:"SchoolBus/OutToExcel",
			});
			//提交表单
			$("#schoolBusQueryForm").submit();
		},
		remove : function () {
			var rows = $("#schoolBus_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var busIds = [];
						for (var i = 0; i < rows.length; i ++) {
							busIds.push(rows[i].busId);
						}
						$.ajax({
							type : "POST",
							url : "SchoolBus/deletes",
							data : {
								busIds : busIds.join(","),
							},
							beforeSend : function () {
								$("#schoolBus_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#schoolBus_manage").datagrid("loaded");
									$("#schoolBus_manage").datagrid("load");
									$("#schoolBus_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#schoolBus_manage").datagrid("loaded");
									$("#schoolBus_manage").datagrid("load");
									$("#schoolBus_manage").datagrid("unselectAll");
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
			var rows = $("#schoolBus_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "SchoolBus/" + rows[0].busId +  "/update",
					type : "get",
					data : {
						//busId : rows[0].busId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (schoolBus, response, status) {
						$.messager.progress("close");
						if (schoolBus) { 
							$("#schoolBusEditDiv").dialog("open");
							$("#schoolBus_busId_edit").val(schoolBus.busId);
							$("#schoolBus_busId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录id",
								editable: false
							});
							$("#schoolBus_busNo_edit").val(schoolBus.busNo);
							$("#schoolBus_busNo_edit").validatebox({
								required : true,
								missingMessage : "请输入车牌号",
							});
							$("#schoolBus_busPhoto").val(schoolBus.busPhoto);
							$("#schoolBus_busPhotoImg").attr("src", schoolBus.busPhoto);
							$("#schoolBus_busModel_edit").val(schoolBus.busModel);
							$("#schoolBus_busModel_edit").validatebox({
								required : true,
								missingMessage : "请输入车辆型号",
							});
							$("#schoolBus_buyDate_edit").datebox({
								value: schoolBus.buyDate,
							    required: true,
							    showSeconds: true,
							});
							$("#schoolBus_recentRepairTime_edit").datebox({
								value: schoolBus.recentRepairTime,
							    required: true,
							    showSeconds: true,
							});
							schoolBus_busDesc_editor.setContent(schoolBus.busDesc, false);
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
