
function checkCostFlag() {
	var carNo = null;
	carNo = $("#vehicleAccess_carNo").val();
	$.ajax({
		url : basePath + "/StaffVehicle/getCostFlag",
		type : "post",
		dataType: "json",
		data: {
			"carNo": carNo
		},
		success : function (data, response, status) {
			//var obj = jQuery.parseJSON(data);
			if(data.success){
				$("#vehicleAccess_costFlag").val("是");
				$("#costFlagTest").html(data.message);
			}else{
				$("#vehicleAccess_costFlag").val("否");
				$("#costFlagTest").html(data.message);
			}
		}
	});
}


$(function () {
	 
	

	
	$("#vehicleAccess_carNo").validatebox({
		required : true, 
		missingMessage : '请输入车牌号',
	});

	$("#vehicleAccess_inTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#vehicleAccess_inDoor").validatebox({
		required : true, 
		missingMessage : '请输入进入校门',
	});

	 

	$("#vehicleAccess_outDoor").validatebox({
		required : true, 
		missingMessage : '请输入离开校门',
	});

	$("#vehicleAccess_stopTime").validatebox({
		required : true, 
		missingMessage : '请输入停车时长',
	});

	$("#vehicleAccess_costFlag").validatebox({
		required : true, 
		missingMessage : '请输入是否收费',
	});

	$("#vehicleAccess_costMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入收费金额',
		invalidMessage : '收费金额输入不对',
	});

	//单击添加按钮
	$("#vehicleAccessAddButton").click(function () {
		//验证表单 
		if(!$("#vehicleAccessAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#vehicleAccessAddForm").form({
			    url:"VehicleAccess/add",
			    onSubmit: function(){
					if($("#vehicleAccessAddForm").form("validate"))  { 
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
                        $("#vehicleAccessAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#vehicleAccessAddForm").submit();
		}
	});

	//单击清空按钮
	$("#vehicleAccessClearButton").click(function () { 
		$("#vehicleAccessAddForm").form("clear"); 
	});
});
