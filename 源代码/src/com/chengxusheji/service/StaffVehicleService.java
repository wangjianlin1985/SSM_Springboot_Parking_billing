package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.StaffVehicle;

import com.chengxusheji.mapper.StaffVehicleMapper;
@Service
public class StaffVehicleService {

	@Resource StaffVehicleMapper staffVehicleMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加职工车辆记录*/
    public void addStaffVehicle(StaffVehicle staffVehicle) throws Exception {
    	staffVehicleMapper.addStaffVehicle(staffVehicle);
    }

    /*按照查询条件分页查询职工车辆记录*/
    public ArrayList<StaffVehicle> queryStaffVehicle(String teacherName,String carNo,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!teacherName.equals("")) where = where + " and t_staffVehicle.teacherName like '%" + teacherName + "%'";
    	if(!carNo.equals("")) where = where + " and t_staffVehicle.carNo like '%" + carNo + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return staffVehicleMapper.queryStaffVehicle(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<StaffVehicle> queryStaffVehicle(String teacherName,String carNo) throws Exception  { 
     	String where = "where 1=1";
    	if(!teacherName.equals("")) where = where + " and t_staffVehicle.teacherName like '%" + teacherName + "%'";
    	if(!carNo.equals("")) where = where + " and t_staffVehicle.carNo like '%" + carNo + "%'";
    	return staffVehicleMapper.queryStaffVehicleList(where);
    }

    /*查询所有职工车辆记录*/
    public ArrayList<StaffVehicle> queryAllStaffVehicle()  throws Exception {
        return staffVehicleMapper.queryStaffVehicleList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String teacherName,String carNo) throws Exception {
     	String where = "where 1=1";
    	if(!teacherName.equals("")) where = where + " and t_staffVehicle.teacherName like '%" + teacherName + "%'";
    	if(!carNo.equals("")) where = where + " and t_staffVehicle.carNo like '%" + carNo + "%'";
        recordNumber = staffVehicleMapper.queryStaffVehicleCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取职工车辆记录*/
    public StaffVehicle getStaffVehicle(int carId) throws Exception  {
        StaffVehicle staffVehicle = staffVehicleMapper.getStaffVehicle(carId);
        return staffVehicle;
    }

    /*更新职工车辆记录*/
    public void updateStaffVehicle(StaffVehicle staffVehicle) throws Exception {
        staffVehicleMapper.updateStaffVehicle(staffVehicle);
    }

    /*删除一条职工车辆记录*/
    public void deleteStaffVehicle (int carId) throws Exception {
        staffVehicleMapper.deleteStaffVehicle(carId);
    }

    /*删除多条职工车辆信息*/
    public int deleteStaffVehicles (String carIds) throws Exception {
    	String _carIds[] = carIds.split(",");
    	for(String _carId: _carIds) {
    		staffVehicleMapper.deleteStaffVehicle(Integer.parseInt(_carId));
    	}
    	return _carIds.length;
    }
}
