package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.VehicleAccess;

import com.chengxusheji.mapper.VehicleAccessMapper;
@Service
public class VehicleAccessService {

	@Resource VehicleAccessMapper vehicleAccessMapper;
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

    /*添加车辆进出记录*/
    public void addVehicleAccess(VehicleAccess vehicleAccess) throws Exception {
    	vehicleAccessMapper.addVehicleAccess(vehicleAccess);
    }

    /*按照查询条件分页查询车辆进出记录*/
    public ArrayList<VehicleAccess> queryVehicleAccess(String inTime,String inDoor,String outTime,String outDoor,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!inTime.equals("")) where = where + " and t_vehicleAccess.inTime like '%" + inTime + "%'";
    	if(!inDoor.equals("")) where = where + " and t_vehicleAccess.inDoor like '%" + inDoor + "%'";
    	if(!outTime.equals("")) where = where + " and t_vehicleAccess.outTime like '%" + outTime + "%'";
    	if(!outDoor.equals("")) where = where + " and t_vehicleAccess.outDoor like '%" + outDoor + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return vehicleAccessMapper.queryVehicleAccess(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<VehicleAccess> queryVehicleAccess(String inTime,String inDoor,String outTime,String outDoor) throws Exception  { 
     	String where = "where 1=1";
    	if(!inTime.equals("")) where = where + " and t_vehicleAccess.inTime like '%" + inTime + "%'";
    	if(!inDoor.equals("")) where = where + " and t_vehicleAccess.inDoor like '%" + inDoor + "%'";
    	if(!outTime.equals("")) where = where + " and t_vehicleAccess.outTime like '%" + outTime + "%'";
    	if(!outDoor.equals("")) where = where + " and t_vehicleAccess.outDoor like '%" + outDoor + "%'";
    	return vehicleAccessMapper.queryVehicleAccessList(where);
    }

    /*查询所有车辆进出记录*/
    public ArrayList<VehicleAccess> queryAllVehicleAccess()  throws Exception {
        return vehicleAccessMapper.queryVehicleAccessList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String inTime,String inDoor,String outTime,String outDoor) throws Exception {
     	String where = "where 1=1";
    	if(!inTime.equals("")) where = where + " and t_vehicleAccess.inTime like '%" + inTime + "%'";
    	if(!inDoor.equals("")) where = where + " and t_vehicleAccess.inDoor like '%" + inDoor + "%'";
    	if(!outTime.equals("")) where = where + " and t_vehicleAccess.outTime like '%" + outTime + "%'";
    	if(!outDoor.equals("")) where = where + " and t_vehicleAccess.outDoor like '%" + outDoor + "%'";
        recordNumber = vehicleAccessMapper.queryVehicleAccessCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取车辆进出记录*/
    public VehicleAccess getVehicleAccess(int accessId) throws Exception  {
        VehicleAccess vehicleAccess = vehicleAccessMapper.getVehicleAccess(accessId);
        return vehicleAccess;
    }

    /*更新车辆进出记录*/
    public void updateVehicleAccess(VehicleAccess vehicleAccess) throws Exception {
        vehicleAccessMapper.updateVehicleAccess(vehicleAccess);
    }

    /*删除一条车辆进出记录*/
    public void deleteVehicleAccess (int accessId) throws Exception {
        vehicleAccessMapper.deleteVehicleAccess(accessId);
    }

    /*删除多条车辆进出信息*/
    public int deleteVehicleAccesss (String accessIds) throws Exception {
    	String _accessIds[] = accessIds.split(",");
    	for(String _accessId: _accessIds) {
    		vehicleAccessMapper.deleteVehicleAccess(Integer.parseInt(_accessId));
    	}
    	return _accessIds.length;
    }
}
