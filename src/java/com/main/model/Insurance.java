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
 * @author user
 */
@Entity(name = "insurance")
@Table(name = "insurance")
public class Insurance {
    @Id
    private String id;
    private String customerid,policyno,insurancecompany,type,expirydate,idv,brandid,branddetailid,yearofmanufacturer,enginecc,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public Insurance() {
    }

    public Insurance(String id, String customerid, String policyno, String insurancecompany, String type, String expirydate, String idv, String brandid, String branddetailid, String yearofmanufacturer, String enginecc) {
        this.id = id;
        this.customerid = customerid;
        this.policyno = policyno;
        this.insurancecompany = insurancecompany;
        this.type = type;
        this.expirydate = expirydate;
        this.idv = idv;
        this.brandid = brandid;
        this.branddetailid = branddetailid;
        this.yearofmanufacturer = yearofmanufacturer;
        this.enginecc = enginecc;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCustomerid() {
        return customerid;
    }

    public void setCustomerid(String customerid) {
        this.customerid = customerid;
    }

    public String getPolicyno() {
        return policyno;
    }

    public void setPolicyno(String policyno) {
        this.policyno = policyno;
    }

    public String getInsurancecompany() {
        return insurancecompany;
    }

    public void setInsurancecompany(String insurancecompany) {
        this.insurancecompany = insurancecompany;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getExpirydate() {
        return expirydate;
    }

    public void setExpirydate(String expirydate) {
        this.expirydate = expirydate;
    }

    public String getIdv() {
        return idv;
    }

    public void setIdv(String idv) {
        this.idv = idv;
    }

    public String getBrandid() {
        return brandid;
    }

    public void setBrandid(String brandid) {
        this.brandid = brandid;
    }

    public String getBranddetailid() {
        return branddetailid;
    }

    public void setBranddetailid(String branddetailid) {
        this.branddetailid = branddetailid;
    }

    public String getYearofmanufacturer() {
        return yearofmanufacturer;
    }

    public void setYearofmanufacturer(String yearofmanufacturer) {
        this.yearofmanufacturer = yearofmanufacturer;
    }

    public String getEnginecc() {
        return enginecc;
    }

    public void setEnginecc(String enginecc) {
        this.enginecc = enginecc;
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
