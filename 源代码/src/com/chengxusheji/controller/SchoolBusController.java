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
import com.chengxusheji.service.SchoolBusService;
import com.chengxusheji.po.SchoolBus;

//SchoolBus管理控制层
@Controller
@RequestMapping("/SchoolBus")
public class SchoolBusController extends BaseController {

    /*业务层对象*/
    @Resource SchoolBusService schoolBusService;

	@InitBinder("schoolBus")
	public void initBinderSchoolBus(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("schoolBus.");
	}
	/*跳转到添加SchoolBus视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new SchoolBus());
		return "SchoolBus_add";
	}

	/*客户端ajax方式提交添加校车车辆信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated SchoolBus schoolBus, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			schoolBus.setBusPhoto(this.handlePhotoUpload(request, "busPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        schoolBusService.addSchoolBus(schoolBus);
        message = "校车车辆添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询校车车辆信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String busNo,String busModel,String buyDate,String recentRepairTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (busNo == null) busNo = "";
		if (busModel == null) busModel = "";
		if (buyDate == null) buyDate = "";
		if (recentRepairTime == null) recentRepairTime = "";
		if(rows != 0)schoolBusService.setRows(rows);
		List<SchoolBus> schoolBusList = schoolBusService.querySchoolBus(busNo, busModel, buyDate, recentRepairTime, page);
	    /*计算总的页数和总的记录数*/
	    schoolBusService.queryTotalPageAndRecordNumber(busNo, busModel, buyDate, recentRepairTime);
	    /*获取到总的页码数目*/
	    int totalPage = schoolBusService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = schoolBusService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(SchoolBus schoolBus:schoolBusList) {
			JSONObject jsonSchoolBus = schoolBus.getJsonObject();
			jsonArray.put(jsonSchoolBus);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询校车车辆信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<SchoolBus> schoolBusList = schoolBusService.queryAllSchoolBus();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(SchoolBus schoolBus:schoolBusList) {
			JSONObject jsonSchoolBus = new JSONObject();
			jsonSchoolBus.accumulate("busId", schoolBus.getBusId());
			jsonSchoolBus.accumulate("busNo", schoolBus.getBusNo());
			jsonArray.put(jsonSchoolBus);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询校车车辆信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String busNo,String busModel,String buyDate,String recentRepairTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (busNo == null) busNo = "";
		if (busModel == null) busModel = "";
		if (buyDate == null) buyDate = "";
		if (recentRepairTime == null) recentRepairTime = "";
		List<SchoolBus> schoolBusList = schoolBusService.querySchoolBus(busNo, busModel, buyDate, recentRepairTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    schoolBusService.queryTotalPageAndRecordNumber(busNo, busModel, buyDate, recentRepairTime);
	    /*获取到总的页码数目*/
	    int totalPage = schoolBusService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = schoolBusService.getRecordNumber();
	    request.setAttribute("schoolBusList",  schoolBusList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("busNo", busNo);
	    request.setAttribute("busModel", busModel);
	    request.setAttribute("buyDate", buyDate);
	    request.setAttribute("recentRepairTime", recentRepairTime);
		return "SchoolBus/schoolBus_frontquery_result"; 
	}

     /*前台查询SchoolBus信息*/
	@RequestMapping(value="/{busId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer busId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键busId获取SchoolBus对象*/
        SchoolBus schoolBus = schoolBusService.getSchoolBus(busId);

        request.setAttribute("schoolBus",  schoolBus);
        return "SchoolBus/schoolBus_frontshow";
	}

	/*ajax方式显示校车车辆修改jsp视图页*/
	@RequestMapping(value="/{busId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer busId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键busId获取SchoolBus对象*/
        SchoolBus schoolBus = schoolBusService.getSchoolBus(busId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSchoolBus = schoolBus.getJsonObject();
		out.println(jsonSchoolBus.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新校车车辆信息*/
	@RequestMapping(value = "/{busId}/update", method = RequestMethod.POST)
	public void update(@Validated SchoolBus schoolBus, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String busPhotoFileName = this.handlePhotoUpload(request, "busPhotoFile");
		if(!busPhotoFileName.equals("upload/NoImage.jpg"))schoolBus.setBusPhoto(busPhotoFileName); 


		try {
			schoolBusService.updateSchoolBus(schoolBus);
			message = "校车车辆更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "校车车辆更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除校车车辆信息*/
	@RequestMapping(value="/{busId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer busId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  schoolBusService.deleteSchoolBus(busId);
	            request.setAttribute("message", "校车车辆删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "校车车辆删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条校车车辆记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String busIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = schoolBusService.deleteSchoolBuss(busIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出校车车辆信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String busNo,String busModel,String buyDate,String recentRepairTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(busNo == null) busNo = "";
        if(busModel == null) busModel = "";
        if(buyDate == null) buyDate = "";
        if(recentRepairTime == null) recentRepairTime = "";
        List<SchoolBus> schoolBusList = schoolBusService.querySchoolBus(busNo,busModel,buyDate,recentRepairTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "SchoolBus信息记录"; 
        String[] headers = { "车牌号","校车图片","车辆型号","购买日期","最近一次维修时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<schoolBusList.size();i++) {
        	SchoolBus schoolBus = schoolBusList.get(i); 
        	dataset.add(new String[]{schoolBus.getBusNo(),schoolBus.getBusPhoto(),schoolBus.getBusModel(),schoolBus.getBuyDate(),schoolBus.getRecentRepairTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"SchoolBus.xls");//filename是下载的xls的名，建议最好用英文 
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
