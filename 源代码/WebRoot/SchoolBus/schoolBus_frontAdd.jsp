<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>校车车辆添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>SchoolBus/frontlist">校车车辆管理</a></li>
  			<li class="active">添加校车车辆</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="schoolBusAddForm" id="schoolBusAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="schoolBus_busNo" class="col-md-2 text-right">车牌号:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="schoolBus_busNo" name="schoolBus.busNo" class="form-control" placeholder="请输入车牌号">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="schoolBus_busPhoto" class="col-md-2 text-right">校车图片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="schoolBus_busPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="schoolBus_busPhoto" name="schoolBus.busPhoto"/>
					    <input id="busPhotoFile" name="busPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="schoolBus_busModel" class="col-md-2 text-right">车辆型号:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="schoolBus_busModel" name="schoolBus.busModel" class="form-control" placeholder="请输入车辆型号">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="schoolBus_buyDateDiv" class="col-md-2 text-right">购买日期:</label>
				  	 <div class="col-md-8">
		                <div id="schoolBus_buyDateDiv" class="input-group date schoolBus_buyDate col-md-12" data-link-field="schoolBus_buyDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="schoolBus_buyDate" name="schoolBus.buyDate" size="16" type="text" value="" placeholder="请选择购买日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="schoolBus_recentRepairTimeDiv" class="col-md-2 text-right">最近一次维修时间:</label>
				  	 <div class="col-md-8">
		                <div id="schoolBus_recentRepairTimeDiv" class="input-group date schoolBus_recentRepairTime col-md-12" data-link-field="schoolBus_recentRepairTime" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="schoolBus_recentRepairTime" name="schoolBus.recentRepairTime" size="16" type="text" value="" placeholder="请选择最近一次维修时间" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="schoolBus_busDesc" class="col-md-2 text-right">车辆详情:</label>
				  	 <div class="col-md-8">
							    <textarea name="schoolBus.busDesc" id="schoolBus_busDesc" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxSchoolBusAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#schoolBusAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var schoolBus_busDesc_editor = UE.getEditor('schoolBus_busDesc'); //车辆详情编辑器
var basePath = "<%=basePath%>";
	//提交添加校车车辆信息
	function ajaxSchoolBusAdd() { 
		//提交之前先验证表单
		$("#schoolBusAddForm").data('bootstrapValidator').validate();
		if(!$("#schoolBusAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(schoolBus_busDesc_editor.getContent() == "") {
			alert('车辆详情不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "SchoolBus/add",
			dataType : "json" , 
			data: new FormData($("#schoolBusAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#schoolBusAddForm").find("input").val("");
					$("#schoolBusAddForm").find("textarea").val("");
					schoolBus_busDesc_editor.setContent("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证校车车辆添加表单字段
	$('#schoolBusAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"schoolBus.busNo": {
				validators: {
					notEmpty: {
						message: "车牌号不能为空",
					}
				}
			},
			"schoolBus.busModel": {
				validators: {
					notEmpty: {
						message: "车辆型号不能为空",
					}
				}
			},
			"schoolBus.buyDate": {
				validators: {
					notEmpty: {
						message: "购买日期不能为空",
					}
				}
			},
			"schoolBus.recentRepairTime": {
				validators: {
					notEmpty: {
						message: "最近一次维修时间不能为空",
					}
				}
			},
		}
	}); 
	//购买日期组件
	$('#schoolBus_buyDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#schoolBusAddForm').data('bootstrapValidator').updateStatus('schoolBus.buyDate', 'NOT_VALIDATED',null).validateField('schoolBus.buyDate');
	});
	//最近一次维修时间组件
	$('#schoolBus_recentRepairTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#schoolBusAddForm').data('bootstrapValidator').updateStatus('schoolBus.recentRepairTime', 'NOT_VALIDATED',null).validateField('schoolBus.recentRepairTime');
	});
})
</script>
</body>
</html>
