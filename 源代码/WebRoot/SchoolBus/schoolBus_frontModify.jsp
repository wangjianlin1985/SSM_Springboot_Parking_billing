<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SchoolBus" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    SchoolBus schoolBus = (SchoolBus)request.getAttribute("schoolBus");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改校车车辆信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">校车车辆信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="schoolBusEditForm" id="schoolBusEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="schoolBus_busId_edit" class="col-md-3 text-right">记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="schoolBus_busId_edit" name="schoolBus.busId" class="form-control" placeholder="请输入记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="schoolBus_busNo_edit" class="col-md-3 text-right">车牌号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="schoolBus_busNo_edit" name="schoolBus.busNo" class="form-control" placeholder="请输入车牌号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="schoolBus_busPhoto_edit" class="col-md-3 text-right">校车图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="schoolBus_busPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="schoolBus_busPhoto" name="schoolBus.busPhoto"/>
			    <input id="busPhotoFile" name="busPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="schoolBus_busModel_edit" class="col-md-3 text-right">车辆型号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="schoolBus_busModel_edit" name="schoolBus.busModel" class="form-control" placeholder="请输入车辆型号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="schoolBus_buyDate_edit" class="col-md-3 text-right">购买日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date schoolBus_buyDate_edit col-md-12" data-link-field="schoolBus_buyDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="schoolBus_buyDate_edit" name="schoolBus.buyDate" size="16" type="text" value="" placeholder="请选择购买日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="schoolBus_recentRepairTime_edit" class="col-md-3 text-right">最近一次维修时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date schoolBus_recentRepairTime_edit col-md-12" data-link-field="schoolBus_recentRepairTime_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="schoolBus_recentRepairTime_edit" name="schoolBus.recentRepairTime" size="16" type="text" value="" placeholder="请选择最近一次维修时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="schoolBus_busDesc_edit" class="col-md-3 text-right">车辆详情:</label>
		  	 <div class="col-md-9">
			    <script name="schoolBus.busDesc" id="schoolBus_busDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSchoolBusModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#schoolBusEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var schoolBus_busDesc_editor = UE.getEditor('schoolBus_busDesc_edit'); //车辆详情编辑框
var basePath = "<%=basePath%>";
/*弹出修改校车车辆界面并初始化数据*/
function schoolBusEdit(busId) {
  schoolBus_busDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(busId);
  });
}
 function ajaxModifyQuery(busId) {
	$.ajax({
		url :  basePath + "SchoolBus/" + busId + "/update",
		type : "get",
		dataType: "json",
		success : function (schoolBus, response, status) {
			if (schoolBus) {
				$("#schoolBus_busId_edit").val(schoolBus.busId);
				$("#schoolBus_busNo_edit").val(schoolBus.busNo);
				$("#schoolBus_busPhoto").val(schoolBus.busPhoto);
				$("#schoolBus_busPhotoImg").attr("src", basePath +　schoolBus.busPhoto);
				$("#schoolBus_busModel_edit").val(schoolBus.busModel);
				$("#schoolBus_buyDate_edit").val(schoolBus.buyDate);
				$("#schoolBus_recentRepairTime_edit").val(schoolBus.recentRepairTime);
				schoolBus_busDesc_editor.setContent(schoolBus.busDesc, false);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交校车车辆信息表单给服务器端修改*/
function ajaxSchoolBusModify() {
	$.ajax({
		url :  basePath + "SchoolBus/" + $("#schoolBus_busId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#schoolBusEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#schoolBusQueryForm").submit();
            }else{
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
    /*购买日期组件*/
    $('.schoolBus_buyDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*最近一次维修时间组件*/
    $('.schoolBus_recentRepairTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    schoolBusEdit("<%=request.getParameter("busId")%>");
 })
 </script> 
</body>
</html>

