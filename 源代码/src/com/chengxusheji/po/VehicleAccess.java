package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class VehicleAccess {
    /*记录id*/
    private Integer accessId;
    public Integer getAccessId(){
        return accessId;
    }
    public void setAccessId(Integer accessId){
        this.accessId = accessId;
    }

    /*车牌号*/
    @NotEmpty(message="车牌号不能为空")
    private String carNo;
    public String getCarNo() {
        return carNo;
    }
    public void setCarNo(String carNo) {
        this.carNo = carNo;
    }

    /*进入时间*/
    @NotEmpty(message="进入时间不能为空")
    private String inTime;
    public String getInTime() {
        return inTime;
    }
    public void setInTime(String inTime) {
        this.inTime = inTime;
    }

    /*进入校门*/
    @NotEmpty(message="进入校门不能为空")
    private String inDoor;
    public String getInDoor() {
        return inDoor;
    }
    public void setInDoor(String inDoor) {
        this.inDoor = inDoor;
    }

    /*离开时间*/
    @NotEmpty(message="离开时间不能为空")
    private String outTime;
    public String getOutTime() {
        return outTime;
    }
    public void setOutTime(String outTime) {
        this.outTime = outTime;
    }

    /*离开校门*/
    @NotEmpty(message="离开校门不能为空")
    private String outDoor;
    public String getOutDoor() {
        return outDoor;
    }
    public void setOutDoor(String outDoor) {
        this.outDoor = outDoor;
    }

    /*停车时长*/
    @NotEmpty(message="停车时长不能为空")
    private String stopTime;
    public String getStopTime() {
        return stopTime;
    }
    public void setStopTime(String stopTime) {
        this.stopTime = stopTime;
    }

    /*是否收费*/
    @NotEmpty(message="是否收费不能为空")
    private String costFlag;
    public String getCostFlag() {
        return costFlag;
    }
    public void setCostFlag(String costFlag) {
        this.costFlag = costFlag;
    }

    /*收费金额*/
    @NotNull(message="必须输入收费金额")
    private Float costMoney;
    public Float getCostMoney() {
        return costMoney;
    }
    public void setCostMoney(Float costMoney) {
        this.costMoney = costMoney;
    }

    /*备注信息*/
    private String memo;
    public String getMemo() {
        return memo;
    }
    public void setMemo(String memo) {
        this.memo = memo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonVehicleAccess=new JSONObject(); 
		jsonVehicleAccess.accumulate("accessId", this.getAccessId());
		jsonVehicleAccess.accumulate("carNo", this.getCarNo());
		jsonVehicleAccess.accumulate("inTime", this.getInTime().length()>19?this.getInTime().substring(0,19):this.getInTime());
		jsonVehicleAccess.accumulate("inDoor", this.getInDoor());
		jsonVehicleAccess.accumulate("outTime", this.getOutTime().length()>19?this.getOutTime().substring(0,19):this.getOutTime());
		jsonVehicleAccess.accumulate("outDoor", this.getOutDoor());
		jsonVehicleAccess.accumulate("stopTime", this.getStopTime());
		jsonVehicleAccess.accumulate("costFlag", this.getCostFlag());
		jsonVehicleAccess.accumulate("costMoney", this.getCostMoney());
		jsonVehicleAccess.accumulate("memo", this.getMemo());
		return jsonVehicleAccess;
    }}