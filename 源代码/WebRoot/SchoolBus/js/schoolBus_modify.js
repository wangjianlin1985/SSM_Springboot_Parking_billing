$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('schoolBus_busDesc_edit');
	var schoolBus_busDesc_edit = UE.getEditor('schoolBus_busDesc_edit'); //车辆详情编辑器
	schoolBus_busDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "SchoolBus/" + $("#schoolBus_busId_edit").val() + "/update",
		type : "get",
		data : {
			//busId : $("#schoolBus_busId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (schoolBus, response, status) {
			$.messager.progress("close");
			if (schoolBus) { 
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
				schoolBus_busDesc_edit.setContent(schoolBus.busDesc);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#schoolBusModifyButton").click(function(){ 
		if ($("#schoolBusEditForm").form("validate")) {
			$("#schoolBusEditForm").form({
			    url:"SchoolBus/" +  $("#schoolBus_busId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#schoolBusEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
