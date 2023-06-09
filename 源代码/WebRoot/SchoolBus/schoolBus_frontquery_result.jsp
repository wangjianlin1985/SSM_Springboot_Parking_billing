<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SchoolBus" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<SchoolBus> schoolBusList = (List<SchoolBus>)request.getAttribute("schoolBusList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String busNo = (String)request.getAttribute("busNo"); //车牌号查询关键字
    String busModel = (String)request.getAttribute("busModel"); //车辆型号查询关键字
    String buyDate = (String)request.getAttribute("buyDate"); //购买日期查询关键字
    String recentRepairTime = (String)request.getAttribute("recentRepairTime"); //最近一次维修时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>校车车辆查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>SchoolBus/frontlist">校车车辆信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>SchoolBus/schoolBus_frontAdd.jsp" style="display:none;">添加校车车辆</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<schoolBusList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		SchoolBus schoolBus = schoolBusList.get(i); //获取到校车车辆对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>SchoolBus/<%=schoolBus.getBusId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=schoolBus.getBusPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		车牌号:<%=schoolBus.getBusNo() %>
			     	</div>
			     	<div class="field">
	            		车辆型号:<%=schoolBus.getBusModel() %>
			     	</div>
			     	<div class="field">
	            		购买日期:<%=schoolBus.getBuyDate() %>
			     	</div>
			     	<div class="field">
	            		最近维修时间:<%=schoolBus.getRecentRepairTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>SchoolBus/<%=schoolBus.getBusId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="schoolBusEdit('<%=schoolBus.getBusId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="schoolBusDelete('<%=schoolBus.getBusId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>校车车辆查询</h1>
		</div>
		<form name="schoolBusQueryForm" id="schoolBusQueryForm" action="<%=basePath %>SchoolBus/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="busNo">车牌号:</label>
				<input type="text" id="busNo" name="busNo" value="<%=busNo %>" class="form-control" placeholder="请输入车牌号">
			</div>
			<div class="form-group">
				<label for="busModel">车辆型号:</label>
				<input type="text" id="busModel" name="busModel" value="<%=busModel %>" class="form-control" placeholder="请输入车辆型号">
			</div>
			<div class="form-group">
				<label for="buyDate">购买日期:</label>
				<input type="text" id="buyDate" name="buyDate" class="form-control"  placeholder="请选择购买日期" value="<%=buyDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="recentRepairTime">最近一次维修时间:</label>
				<input type="text" id="recentRepairTime" name="recentRepairTime" class="form-control"  placeholder="请选择最近一次维修时间" value="<%=recentRepairTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="schoolBusEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;校车车辆信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="schoolBus.busDesc" id="schoolBus_busDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#schoolBusEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSchoolBusModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
//实例化编辑器
var schoolBus_busDesc_edit = UE.getEditor('schoolBus_busDesc_edit'); //车辆详情编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.schoolBusQueryForm.currentPage.value = currentPage;
    document.schoolBusQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.schoolBusQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.schoolBusQueryForm.currentPage.value = pageValue;
    documentschoolBusQueryForm.submit();
}

/*弹出修改校车车辆界面并初始化数据*/
function schoolBusEdit(busId) {
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
				schoolBus_busDesc_edit.setContent(schoolBus.busDesc, false);
				$('#schoolBusEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除校车车辆信息*/
function schoolBusDelete(busId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "SchoolBus/deletes",
			data : {
				busIds : busId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#schoolBusQueryForm").submit();
					//location.href= basePath + "SchoolBus/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

