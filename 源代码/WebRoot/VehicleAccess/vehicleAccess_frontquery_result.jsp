<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.VehicleAccess" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<VehicleAccess> vehicleAccessList = (List<VehicleAccess>)request.getAttribute("vehicleAccessList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String inTime = (String)request.getAttribute("inTime"); //进入时间查询关键字
    String inDoor = (String)request.getAttribute("inDoor"); //进入校门查询关键字
    String outTime = (String)request.getAttribute("outTime"); //离开时间查询关键字
    String outDoor = (String)request.getAttribute("outDoor"); //离开校门查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>车辆进出查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#vehicleAccessListPanel" aria-controls="vehicleAccessListPanel" role="tab" data-toggle="tab">车辆进出列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>VehicleAccess/vehicleAccess_frontAdd.jsp" style="display:none;">添加车辆进出</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="vehicleAccessListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>车牌号</td><td>进入时间</td><td>进入校门</td><td>离开时间</td><td>离开校门</td><td>停车时长</td><td>是否收费</td><td>收费金额</td><td>备注信息</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<vehicleAccessList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		VehicleAccess vehicleAccess = vehicleAccessList.get(i); //获取到车辆进出对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=vehicleAccess.getCarNo() %></td>
 											<td><%=vehicleAccess.getInTime() %></td>
 											<td><%=vehicleAccess.getInDoor() %></td>
 											<td><%=vehicleAccess.getOutTime() %></td>
 											<td><%=vehicleAccess.getOutDoor() %></td>
 											<td><%=vehicleAccess.getStopTime() %></td>
 											<td><%=vehicleAccess.getCostFlag() %></td>
 											<td><%=vehicleAccess.getCostMoney() %></td>
 											<td><%=vehicleAccess.getMemo() %></td>
 											<td style="display:none;">
 												<a href="<%=basePath  %>VehicleAccess/<%=vehicleAccess.getAccessId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="vehicleAccessEdit('<%=vehicleAccess.getAccessId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="vehicleAccessDelete('<%=vehicleAccess.getAccessId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>车辆进出查询</h1>
		</div>
		<form name="vehicleAccessQueryForm" id="vehicleAccessQueryForm" action="<%=basePath %>VehicleAccess/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="inTime">进入时间:</label>
				<input type="text" id="inTime" name="inTime" class="form-control"  placeholder="请选择进入时间" value="<%=inTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="inDoor">进入校门:</label>
				<input type="text" id="inDoor" name="inDoor" value="<%=inDoor %>" class="form-control" placeholder="请输入进入校门">
			</div>






			<div class="form-group">
				<label for="outTime">离开时间:</label>
				<input type="text" id="outTime" name="outTime" class="form-control"  placeholder="请选择离开时间" value="<%=outTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="outDoor">离开校门:</label>
				<input type="text" id="outDoor" name="outDoor" value="<%=outDoor %>" class="form-control" placeholder="请输入离开校门">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="vehicleAccessEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;车辆进出信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="vehicleAccessEditForm" id="vehicleAccessEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="vehicleAccess_accessId_edit" class="col-md-3 text-right">记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="vehicleAccess_accessId_edit" name="vehicleAccess.accessId" class="form-control" placeholder="请输入记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="vehicleAccess_carNo_edit" class="col-md-3 text-right">车牌号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="vehicleAccess_carNo_edit" name="vehicleAccess.carNo" class="form-control" placeholder="请输入车牌号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="vehicleAccess_inTime_edit" class="col-md-3 text-right">进入时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date vehicleAccess_inTime_edit col-md-12" data-link-field="vehicleAccess_inTime_edit">
                    <input class="form-control" id="vehicleAccess_inTime_edit" name="vehicleAccess.inTime" size="16" type="text" value="" placeholder="请选择进入时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="vehicleAccess_inDoor_edit" class="col-md-3 text-right">进入校门:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="vehicleAccess_inDoor_edit" name="vehicleAccess.inDoor" class="form-control" placeholder="请输入进入校门">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="vehicleAccess_outTime_edit" class="col-md-3 text-right">离开时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date vehicleAccess_outTime_edit col-md-12" data-link-field="vehicleAccess_outTime_edit">
                    <input class="form-control" id="vehicleAccess_outTime_edit" name="vehicleAccess.outTime" size="16" type="text" value="" placeholder="请选择离开时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="vehicleAccess_outDoor_edit" class="col-md-3 text-right">离开校门:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="vehicleAccess_outDoor_edit" name="vehicleAccess.outDoor" class="form-control" placeholder="请输入离开校门">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="vehicleAccess_stopTime_edit" class="col-md-3 text-right">停车时长:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="vehicleAccess_stopTime_edit" name="vehicleAccess.stopTime" class="form-control" placeholder="请输入停车时长">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="vehicleAccess_costFlag_edit" class="col-md-3 text-right">是否收费:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="vehicleAccess_costFlag_edit" name="vehicleAccess.costFlag" class="form-control" placeholder="请输入是否收费">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="vehicleAccess_costMoney_edit" class="col-md-3 text-right">收费金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="vehicleAccess_costMoney_edit" name="vehicleAccess.costMoney" class="form-control" placeholder="请输入收费金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="vehicleAccess_memo_edit" class="col-md-3 text-right">备注信息:</label>
		  	 <div class="col-md-9">
			    <textarea id="vehicleAccess_memo_edit" name="vehicleAccess.memo" rows="8" class="form-control" placeholder="请输入备注信息"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#vehicleAccessEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxVehicleAccessModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.vehicleAccessQueryForm.currentPage.value = currentPage;
    document.vehicleAccessQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.vehicleAccessQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.vehicleAccessQueryForm.currentPage.value = pageValue;
    documentvehicleAccessQueryForm.submit();
}

/*弹出修改车辆进出界面并初始化数据*/
function vehicleAccessEdit(accessId) {
	$.ajax({
		url :  basePath + "VehicleAccess/" + accessId + "/update",
		type : "get",
		dataType: "json",
		success : function (vehicleAccess, response, status) {
			if (vehicleAccess) {
				$("#vehicleAccess_accessId_edit").val(vehicleAccess.accessId);
				$("#vehicleAccess_carNo_edit").val(vehicleAccess.carNo);
				$("#vehicleAccess_inTime_edit").val(vehicleAccess.inTime);
				$("#vehicleAccess_inDoor_edit").val(vehicleAccess.inDoor);
				$("#vehicleAccess_outTime_edit").val(vehicleAccess.outTime);
				$("#vehicleAccess_outDoor_edit").val(vehicleAccess.outDoor);
				$("#vehicleAccess_stopTime_edit").val(vehicleAccess.stopTime);
				$("#vehicleAccess_costFlag_edit").val(vehicleAccess.costFlag);
				$("#vehicleAccess_costMoney_edit").val(vehicleAccess.costMoney);
				$("#vehicleAccess_memo_edit").val(vehicleAccess.memo);
				$('#vehicleAccessEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除车辆进出信息*/
function vehicleAccessDelete(accessId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "VehicleAccess/deletes",
			data : {
				accessIds : accessId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#vehicleAccessQueryForm").submit();
					//location.href= basePath + "VehicleAccess/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交车辆进出信息表单给服务器端修改*/
function ajaxVehicleAccessModify() {
	$.ajax({
		url :  basePath + "VehicleAccess/" + $("#vehicleAccess_accessId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#vehicleAccessEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#vehicleAccessQueryForm").submit();
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

    /*进入时间组件*/
    $('.vehicleAccess_inTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*离开时间组件*/
    $('.vehicleAccess_outTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
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

