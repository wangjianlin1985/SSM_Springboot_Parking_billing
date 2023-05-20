package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.SchoolBus;

public interface SchoolBusMapper {
	/*添加校车车辆信息*/
	public void addSchoolBus(SchoolBus schoolBus) throws Exception;

	/*按照查询条件分页查询校车车辆记录*/
	public ArrayList<SchoolBus> querySchoolBus(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有校车车辆记录*/
	public ArrayList<SchoolBus> querySchoolBusList(@Param("where") String where) throws Exception;

	/*按照查询条件的校车车辆记录数*/
	public int querySchoolBusCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条校车车辆记录*/
	public SchoolBus getSchoolBus(int busId) throws Exception;

	/*更新校车车辆记录*/
	public void updateSchoolBus(SchoolBus schoolBus) throws Exception;

	/*删除校车车辆记录*/
	public void deleteSchoolBus(int busId) throws Exception;

}
