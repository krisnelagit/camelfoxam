/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.model;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author pc2
 */
@Entity(name = "branddetails")
@Table(name = "branddetails")
public class BrandDetails {
    @Id
    private String id;
    private String brandid,vehiclename,labourChargeType,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public BrandDetails() {
    }

    public BrandDetails(String id, String brandid, String vehiclename, String labourChargeType) {
        this.id = id;
        this.brandid = brandid;
        this.vehiclename = vehiclename;
        this.labourChargeType = labourChargeType;
    }

    public String getLabourChargeType() {
        return labourChargeType;
    }

    public void setLabourChargeType(String labourChargeType) {
        this.labourChargeType = labourChargeType;
    }
        
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBrandid() {
        return brandid;
    }

    public void setBrandid(String brandid) {
        this.brandid = brandid;
    }

    public String getVehiclename() {
        return vehiclename;
    }

    public void setVehiclename(String vehiclename) {
        this.vehiclename = vehiclename;
    }

    public String getIsdelete() {
        return isdelete;
    }

    public void setIsdelete(String isdelete) {
        this.isdelete = isdelete;
    }

    public String getModifydate() {
        return modifydate;
    }

    public void setModifydate(String modifydate) {
        this.modifydate = modifydate;
    }
    
    
}
