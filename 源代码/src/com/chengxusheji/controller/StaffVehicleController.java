package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.StaffVehicleService;
import com.chengxusheji.po.StaffVehicle;

//StaffVehicle管理控制层
@Controller
@RequestMapping("/StaffVehicle")
public class StaffVehicleController extends BaseController {

    /*业务层对象*/
    @Resource StaffVehicleService staffVehicleService;

	@InitBinder("staffVehicle")
	public void initBinderStaffVehicle(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("staffVehicle.");
	}
	/*跳转到添加StaffVehicle视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new StaffVehicle());
		return "StaffVehicle_add";
	}

	
	/*客户端ajax方式提交添加职工车辆信息*/
	@RequestMapping(value = "/getCostFlag", method = RequestMethod.POST)
	public void getCostFlag(String carNo,Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		ArrayList<StaffVehicle> vehicleList = staffVehicleService.queryStaffVehicle("", carNo);
		if(vehicleList.size() > 0) {
			float days = vehicleList.get(0).getLeftDays();
			message = "剩余停车天数: " + days + "天";
		} else {
			message = "是";
			success = true;
		} 
        
        writeJsonResponse(response, success, message);
	}
	
	
	
	
	/*客户端ajax方式提交添加职工车辆信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated StaffVehicle staffVehicle, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			staffVehicle.setVehiclePhoto(this.handlePhotoUpload(request, "vehiclePhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        staffVehicleService.addStaffVehicle(staffVehicle);
        message = "职工车辆添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询职工车辆信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String teacherName,String carNo,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (teacherName == null) teacherName = "";
		if (carNo == null) carNo = "";
		if(rows != 0)staffVehicleService.setRows(rows);
		List<StaffVehicle> staffVehicleList = staffVehicleService.queryStaffVehicle(teacherName, carNo, page);
	    /*计算总的页数和总的记录数*/
	    staffVehicleService.queryTotalPageAndRecordNumber(teacherName, carNo);
	    /*获取到总的页码数目*/
	    int totalPage = staffVehicleService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = staffVehicleService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(StaffVehicle staffVehicle:staffVehicleList) {
			JSONObject jsonStaffVehicle = staffVehicle.getJsonObject();
			jsonArray.put(jsonStaffVehicle);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询职工车辆信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<StaffVehicle> staffVehicleList = staffVehicleService.queryAllStaffVehicle();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(StaffVehicle staffVehicle:staffVehicleList) {
			JSONObject jsonStaffVehicle = new JSONObject();
			jsonStaffVehicle.accumulate("carId", staffVehicle.getCarId());
			jsonStaffVehicle.accumulate("carNo", staffVehicle.getCarNo());
			jsonArray.put(jsonStaffVehicle);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询职工车辆信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String teacherName,String carNo,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (teacherName == null) teacherName = "";
		if (carNo == null) carNo = "";
		List<StaffVehicle> staffVehicleList = staffVehicleService.queryStaffVehicle(teacherName, carNo, currentPage);
	    /*计算总的页数和总的记录数*/
	    staffVehicleService.queryTotalPageAndRecordNumber(teacherName, carNo);
	    /*获取到总的页码数目*/
	    int totalPage = staffVehicleService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = staffVehicleService.getRecordNumber();
	    request.setAttribute("staffVehicleList",  staffVehicleList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("teacherName", teacherName);
	    request.setAttribute("carNo", carNo);
		return "StaffVehicle/staffVehicle_frontquery_result"; 
	}

     /*前台查询StaffVehicle信息*/
	@RequestMapping(value="/{carId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer carId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键carId获取StaffVehicle对象*/
        StaffVehicle staffVehicle = staffVehicleService.getStaffVehicle(carId);

        request.setAttribute("staffVehicle",  staffVehicle);
        return "StaffVehicle/staffVehicle_frontshow";
	}

	/*ajax方式显示职工车辆修改jsp视图页*/
	@RequestMapping(value="/{carId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer carId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键carId获取StaffVehicle对象*/
        StaffVehicle staffVehicle = staffVehicleService.getStaffVehicle(carId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonStaffVehicle = staffVehicle.getJsonObject();
		out.println(jsonStaffVehicle.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新职工车辆信息*/
	@RequestMapping(value = "/{carId}/update", method = RequestMethod.POST)
	public void update(@Validated StaffVehicle staffVehicle, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String vehiclePhotoFileName = this.handlePhotoUpload(request, "vehiclePhotoFile");
		if(!vehiclePhotoFileName.equals("upload/NoImage.jpg"))staffVehicle.setVehiclePhoto(vehiclePhotoFileName); 


		try {
			staffVehicleService.updateStaffVehicle(staffVehicle);
			message = "职工车辆更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "职工车辆更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除职工车辆信息*/
	@RequestMapping(value="/{carId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer carId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  staffVehicleService.deleteStaffVehicle(carId);
	            request.setAttribute("message", "职工车辆删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "职工车辆删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条职工车辆记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String carIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = staffVehicleService.deleteStaffVehicles(carIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出职工车辆信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String teacherName,String carNo, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(teacherName == null) teacherName = "";
        if(carNo == null) carNo = "";
        List<StaffVehicle> staffVehicleList = staffVehicleService.queryStaffVehicle(teacherName,carNo);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "StaffVehicle信息记录"; 
        String[] headers = { "教职工姓名","教职工车牌","车辆图片","剩余停车天数"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<staffVehicleList.size();i++) {
        	StaffVehicle staffVehicle = staffVehicleList.get(i); 
        	dataset.add(new String[]{staffVehicle.getTeacherName(),staffVehicle.getCarNo(),staffVehicle.getVehiclePhoto(),staffVehicle.getLeftDays() + ""});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"StaffVehicle.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
