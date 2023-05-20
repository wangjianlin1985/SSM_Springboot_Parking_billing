package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class SchoolBus {
    /*记录id*/
    private Integer busId;
    public Integer getBusId(){
        return busId;
    }
    public void setBusId(Integer busId){
        this.busId = busId;
    }

    /*车牌号*/
    @NotEmpty(message="车牌号不能为空")
    private String busNo;
    public String getBusNo() {
        return busNo;
    }
    public void setBusNo(String busNo) {
        this.busNo = busNo;
    }

    /*校车图片*/
    private String busPhoto;
    public String getBusPhoto() {
        return busPhoto;
    }
    public void setBusPhoto(String busPhoto) {
        this.busPhoto = busPhoto;
    }

    /*车辆型号*/
    @NotEmpty(message="车辆型号不能为空")
    private String busModel;
    public String getBusModel() {
        return busModel;
    }
    public void setBusModel(String busModel) {
        this.busModel = busModel;
    }

    /*购买日期*/
    @NotEmpty(message="购买日期不能为空")
    private String buyDate;
    public String getBuyDate() {
        return buyDate;
    }
    public void setBuyDate(String buyDate) {
        this.buyDate = buyDate;
    }

    /*最近一次维修时间*/
    @NotEmpty(message="最近一次维修时间不能为空")
    private String recentRepairTime;
    public String getRecentRepairTime() {
        return recentRepairTime;
    }
    public void setRecentRepairTime(String recentRepairTime) {
        this.recentRepairTime = recentRepairTime;
    }

    /*车辆详情*/
    @NotEmpty(message="车辆详情不能为空")
    private String busDesc;
    public String getBusDesc() {
        return busDesc;
    }
    public void setBusDesc(String busDesc) {
        this.busDesc = busDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSchoolBus=new JSONObject(); 
		jsonSchoolBus.accumulate("busId", this.getBusId());
		jsonSchoolBus.accumulate("busNo", this.getBusNo());
		jsonSchoolBus.accumulate("busPhoto", this.getBusPhoto());
		jsonSchoolBus.accumulate("busModel", this.getBusModel());
		jsonSchoolBus.accumulate("buyDate", this.getBuyDate().length()>19?this.getBuyDate().substring(0,19):this.getBuyDate());
		jsonSchoolBus.accumulate("recentRepairTime", this.getRecentRepairTime().length()>19?this.getRecentRepairTime().substring(0,19):this.getRecentRepairTime());
		jsonSchoolBus.accumulate("busDesc", this.getBusDesc());
		return jsonSchoolBus;
    }}