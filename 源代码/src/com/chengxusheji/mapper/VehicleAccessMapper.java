package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.VehicleAccess;

public interface VehicleAccessMapper {
	/*添加车辆进出信息*/
	public void addVehicleAccess(VehicleAccess vehicleAccess) throws Exception;

	/*按照查询条件分页查询车辆进出记录*/
	public ArrayList<VehicleAccess> queryVehicleAccess(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有车辆进出记录*/
	public ArrayList<VehicleAccess> queryVehicleAccessList(@Param("where") String where) throws Exception;

	/*按照查询条件的车辆进出记录数*/
	public int queryVehicleAccessCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条车辆进出记录*/
	public VehicleAccess getVehicleAccess(int accessId) throws Exception;

	/*更新车辆进出记录*/
	public void updateVehicleAccess(VehicleAccess vehicleAccess) throws Exception;

	/*删除车辆进出记录*/
	public void deleteVehicleAccess(int accessId) throws Exception;

}
