$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('schoolBus_busDesc');
	var schoolBus_busDesc_editor = UE.getEditor('schoolBus_busDesc'); //车辆详情编辑框
	$("#schoolBus_busNo").validatebox({
		required : true, 
		missingMessage : '请输入车牌号',
	});

	$("#schoolBus_busModel").validatebox({
		required : true, 
		missingMessage : '请输入车辆型号',
	});

	$("#schoolBus_buyDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#schoolBus_recentRepairTime").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#schoolBusAddButton").click(function () {
		if(schoolBus_busDesc_editor.getContent() == "") {
			alert("请输入车辆详情");
			return;
		}
		//验证表单 
		if(!$("#schoolBusAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#schoolBusAddForm").form({
			    url:"SchoolBus/add",
			    onSubmit: function(){
					if($("#schoolBusAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#schoolBusAddForm").form("clear");
                        schoolBus_busDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#schoolBusAddForm").submit();
		}
	});

	//单击清空按钮
	$("#schoolBusClearButton").click(function () { 
		$("#schoolBusAddForm").form("clear"); 
	});
});
