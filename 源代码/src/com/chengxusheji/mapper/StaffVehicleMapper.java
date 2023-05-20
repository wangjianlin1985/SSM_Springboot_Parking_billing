package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.StaffVehicle;

public interface StaffVehicleMapper {
	/*添加职工车辆信息*/
	public void addStaffVehicle(StaffVehicle staffVehicle) throws Exception;

	/*按照查询条件分页查询职工车辆记录*/
	public ArrayList<StaffVehicle> queryStaffVehicle(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有职工车辆记录*/
	public ArrayList<StaffVehicle> queryStaffVehicleList(@Param("where") String where) throws Exception;

	/*按照查询条件的职工车辆记录数*/
	public int queryStaffVehicleCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条职工车辆记录*/
	public StaffVehicle getStaffVehicle(int carId) throws Exception;

	/*更新职工车辆记录*/
	public void updateStaffVehicle(StaffVehicle staffVehicle) throws Exception;

	/*删除职工车辆记录*/
	public void deleteStaffVehicle(int carId) throws Exception;

}
