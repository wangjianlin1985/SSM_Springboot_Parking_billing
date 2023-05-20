package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.SchoolBus;

import com.chengxusheji.mapper.SchoolBusMapper;
@Service
public class SchoolBusService {

	@Resource SchoolBusMapper schoolBusMapper;
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

    /*添加校车车辆记录*/
    public void addSchoolBus(SchoolBus schoolBus) throws Exception {
    	schoolBusMapper.addSchoolBus(schoolBus);
    }

    /*按照查询条件分页查询校车车辆记录*/
    public ArrayList<SchoolBus> querySchoolBus(String busNo,String busModel,String buyDate,String recentRepairTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!busNo.equals("")) where = where + " and t_schoolBus.busNo like '%" + busNo + "%'";
    	if(!busModel.equals("")) where = where + " and t_schoolBus.busModel like '%" + busModel + "%'";
    	if(!buyDate.equals("")) where = where + " and t_schoolBus.buyDate like '%" + buyDate + "%'";
    	if(!recentRepairTime.equals("")) where = where + " and t_schoolBus.recentRepairTime like '%" + recentRepairTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return schoolBusMapper.querySchoolBus(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<SchoolBus> querySchoolBus(String busNo,String busModel,String buyDate,String recentRepairTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!busNo.equals("")) where = where + " and t_schoolBus.busNo like '%" + busNo + "%'";
    	if(!busModel.equals("")) where = where + " and t_schoolBus.busModel like '%" + busModel + "%'";
    	if(!buyDate.equals("")) where = where + " and t_schoolBus.buyDate like '%" + buyDate + "%'";
    	if(!recentRepairTime.equals("")) where = where + " and t_schoolBus.recentRepairTime like '%" + recentRepairTime + "%'";
    	return schoolBusMapper.querySchoolBusList(where);
    }

    /*查询所有校车车辆记录*/
    public ArrayList<SchoolBus> queryAllSchoolBus()  throws Exception {
        return schoolBusMapper.querySchoolBusList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String busNo,String busModel,String buyDate,String recentRepairTime) throws Exception {
     	String where = "where 1=1";
    	if(!busNo.equals("")) where = where + " and t_schoolBus.busNo like '%" + busNo + "%'";
    	if(!busModel.equals("")) where = where + " and t_schoolBus.busModel like '%" + busModel + "%'";
    	if(!buyDate.equals("")) where = where + " and t_schoolBus.buyDate like '%" + buyDate + "%'";
    	if(!recentRepairTime.equals("")) where = where + " and t_schoolBus.recentRepairTime like '%" + recentRepairTime + "%'";
        recordNumber = schoolBusMapper.querySchoolBusCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取校车车辆记录*/
    public SchoolBus getSchoolBus(int busId) throws Exception  {
        SchoolBus schoolBus = schoolBusMapper.getSchoolBus(busId);
        return schoolBus;
    }

    /*更新校车车辆记录*/
    public void updateSchoolBus(SchoolBus schoolBus) throws Exception {
        schoolBusMapper.updateSchoolBus(schoolBus);
    }

    /*删除一条校车车辆记录*/
    public void deleteSchoolBus (int busId) throws Exception {
        schoolBusMapper.deleteSchoolBus(busId);
    }

    /*删除多条校车车辆信息*/
    public int deleteSchoolBuss (String busIds) throws Exception {
    	String _busIds[] = busIds.split(",");
    	for(String _busId: _busIds) {
    		schoolBusMapper.deleteSchoolBus(Integer.parseInt(_busId));
    	}
    	return _busIds.length;
    }
}
