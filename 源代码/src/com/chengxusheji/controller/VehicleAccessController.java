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
import com.chengxusheji.service.VehicleAccessService;
import com.chengxusheji.po.VehicleAccess;

//VehicleAccess管理控制层
@Controller
@RequestMapping("/VehicleAccess")
public class VehicleAccessController extends BaseController {

    /*业务层对象*/
    @Resource VehicleAccessService vehicleAccessService;

	@InitBinder("vehicleAccess")
	public void initBinderVehicleAccess(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("vehicleAccess.");
	}
	/*跳转到添加VehicleAccess视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new VehicleAccess());
		return "VehicleAccess_add";
	}

	/*客户端ajax方式提交添加车辆进出信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated VehicleAccess vehicleAccess, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        vehicleAccessService.addVehicleAccess(vehicleAccess);
        message = "车辆进出添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询车辆进出信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String inTime,String inDoor,String outTime,String outDoor,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (inTime == null) inTime = "";
		if (inDoor == null) inDoor = "";
		if (outTime == null) outTime = "";
		if (outDoor == null) outDoor = "";
		if(rows != 0)vehicleAccessService.setRows(rows);
		List<VehicleAccess> vehicleAccessList = vehicleAccessService.queryVehicleAccess(inTime, inDoor, outTime, outDoor, page);
	    /*计算总的页数和总的记录数*/
	    vehicleAccessService.queryTotalPageAndRecordNumber(inTime, inDoor, outTime, outDoor);
	    /*获取到总的页码数目*/
	    int totalPage = vehicleAccessService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = vehicleAccessService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(VehicleAccess vehicleAccess:vehicleAccessList) {
			JSONObject jsonVehicleAccess = vehicleAccess.getJsonObject();
			jsonArray.put(jsonVehicleAccess);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询车辆进出信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<VehicleAccess> vehicleAccessList = vehicleAccessService.queryAllVehicleAccess();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(VehicleAccess vehicleAccess:vehicleAccessList) {
			JSONObject jsonVehicleAccess = new JSONObject();
			jsonVehicleAccess.accumulate("accessId", vehicleAccess.getAccessId());
			jsonVehicleAccess.accumulate("carNo", vehicleAccess.getCarNo());
			jsonArray.put(jsonVehicleAccess);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询车辆进出信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String inTime,String inDoor,String outTime,String outDoor,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (inTime == null) inTime = "";
		if (inDoor == null) inDoor = "";
		if (outTime == null) outTime = "";
		if (outDoor == null) outDoor = "";
		List<VehicleAccess> vehicleAccessList = vehicleAccessService.queryVehicleAccess(inTime, inDoor, outTime, outDoor, currentPage);
	    /*计算总的页数和总的记录数*/
	    vehicleAccessService.queryTotalPageAndRecordNumber(inTime, inDoor, outTime, outDoor);
	    /*获取到总的页码数目*/
	    int totalPage = vehicleAccessService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = vehicleAccessService.getRecordNumber();
	    request.setAttribute("vehicleAccessList",  vehicleAccessList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("inTime", inTime);
	    request.setAttribute("inDoor", inDoor);
	    request.setAttribute("outTime", outTime);
	    request.setAttribute("outDoor", outDoor);
		return "VehicleAccess/vehicleAccess_frontquery_result"; 
	}

     /*前台查询VehicleAccess信息*/
	@RequestMapping(value="/{accessId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer accessId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键accessId获取VehicleAccess对象*/
        VehicleAccess vehicleAccess = vehicleAccessService.getVehicleAccess(accessId);

        request.setAttribute("vehicleAccess",  vehicleAccess);
        return "VehicleAccess/vehicleAccess_frontshow";
	}

	/*ajax方式显示车辆进出修改jsp视图页*/
	@RequestMapping(value="/{accessId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer accessId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键accessId获取VehicleAccess对象*/
        VehicleAccess vehicleAccess = vehicleAccessService.getVehicleAccess(accessId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonVehicleAccess = vehicleAccess.getJsonObject();
		out.println(jsonVehicleAccess.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新车辆进出信息*/
	@RequestMapping(value = "/{accessId}/update", method = RequestMethod.POST)
	public void update(@Validated VehicleAccess vehicleAccess, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			vehicleAccessService.updateVehicleAccess(vehicleAccess);
			message = "车辆进出更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "车辆进出更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除车辆进出信息*/
	@RequestMapping(value="/{accessId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer accessId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  vehicleAccessService.deleteVehicleAccess(accessId);
	            request.setAttribute("message", "车辆进出删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "车辆进出删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条车辆进出记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String accessIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = vehicleAccessService.deleteVehicleAccesss(accessIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出车辆进出信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String inTime,String inDoor,String outTime,String outDoor, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(inTime == null) inTime = "";
        if(inDoor == null) inDoor = "";
        if(outTime == null) outTime = "";
        if(outDoor == null) outDoor = "";
        List<VehicleAccess> vehicleAccessList = vehicleAccessService.queryVehicleAccess(inTime,inDoor,outTime,outDoor);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "VehicleAccess信息记录"; 
        String[] headers = { "车牌号","进入时间","进入校门","离开时间","离开校门","停车时长","是否收费","收费金额","备注信息"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<vehicleAccessList.size();i++) {
        	VehicleAccess vehicleAccess = vehicleAccessList.get(i); 
        	dataset.add(new String[]{vehicleAccess.getCarNo(),vehicleAccess.getInTime(),vehicleAccess.getInDoor(),vehicleAccess.getOutTime(),vehicleAccess.getOutDoor(),vehicleAccess.getStopTime(),vehicleAccess.getCostFlag(),vehicleAccess.getCostMoney() + "",vehicleAccess.getMemo()});
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
			response.setHeader("Content-disposition","attachment; filename="+"VehicleAccess.xls");//filename是下载的xls的名，建议最好用英文 
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
