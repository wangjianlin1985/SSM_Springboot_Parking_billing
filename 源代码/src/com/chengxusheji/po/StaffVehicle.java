package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class StaffVehicle {
    /*记录id*/
    private Integer carId;
    public Integer getCarId(){
        return carId;
    }
    public void setCarId(Integer carId){
        this.carId = carId;
    }

    /*教职工姓名*/
    @NotEmpty(message="教职工姓名不能为空")
    private String teacherName;
    public String getTeacherName() {
        return teacherName;
    }
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    /*教职工车牌*/
    @NotEmpty(message="教职工车牌不能为空")
    private String carNo;
    public String getCarNo() {
        return carNo;
    }
    public void setCarNo(String carNo) {
        this.carNo = carNo;
    }

    /*车辆图片*/
    private String vehiclePhoto;
    public String getVehiclePhoto() {
        return vehiclePhoto;
    }
    public void setVehiclePhoto(String vehiclePhoto) {
        this.vehiclePhoto = vehiclePhoto;
    }

    /*剩余停车天数*/
    @NotNull(message="必须输入剩余停车天数")
    private Float leftDays;
    public Float getLeftDays() {
        return leftDays;
    }
    public void setLeftDays(Float leftDays) {
        this.leftDays = leftDays;
    }

    /*车辆描述*/
    private String carDesc;
    public String getCarDesc() {
        return carDesc;
    }
    public void setCarDesc(String carDesc) {
        this.carDesc = carDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonStaffVehicle=new JSONObject(); 
		jsonStaffVehicle.accumulate("carId", this.getCarId());
		jsonStaffVehicle.accumulate("teacherName", this.getTeacherName());
		jsonStaffVehicle.accumulate("carNo", this.getCarNo());
		jsonStaffVehicle.accumulate("vehiclePhoto", this.getVehiclePhoto());
		jsonStaffVehicle.accumulate("leftDays", this.getLeftDays());
		jsonStaffVehicle.accumulate("carDesc", this.getCarDesc());
		return jsonStaffVehicle;
    }}