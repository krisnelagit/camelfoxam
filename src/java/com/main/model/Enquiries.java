/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.model;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author user
 */
@Entity(name = "enquiries")
@Table(name = "enquiries")
public class Enquiries {

    @Id
    private String id;
    @Column(insertable = false, updatable = false)
    private String savedate;
    private String name, date, email, leadsource, location, mobile,brandid,branddetailid, leadowner, status, requirement,iscustomer="No",policyno,insurancecompany,type,expirydate,idv,yearofmanufacturer,enginecc, isdelete = "No", modifydate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public Enquiries(String id, String savedate, String name, String date, String email, String leadsource, String location, String mobile, String brandid, String branddetailid, String leadowner, String status, String requirement, String policyno, String insurancecompany, String type, String expirydate, String idv, String yearofmanufacturer, String enginecc) {
        this.id = id;
        this.savedate = savedate;
        this.name = name;
        this.date = date;
        this.email = email;
        this.leadsource = leadsource;
        this.location = location;
        this.mobile = mobile;
        this.brandid = brandid;
        this.branddetailid = branddetailid;
        this.leadowner = leadowner;
        this.status = status;
        this.requirement = requirement;
        this.policyno = policyno;
        this.insurancecompany = insurancecompany;
        this.type = type;
        this.expirydate = expirydate;
        this.idv = idv;
        this.yearofmanufacturer = yearofmanufacturer;
        this.enginecc = enginecc;
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
    
    public String getSavedate() {
        return savedate;
    }

    public void setSavedate(String savedate) {
        this.savedate = savedate;
    }
    
    public String getIscustomer() {
        return iscustomer;
    }

    public void setIscustomer(String iscustomer) {
        this.iscustomer = iscustomer;
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

    public Enquiries() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLeadsource() {
        return leadsource;
    }

    public void setLeadsource(String leadsource) {
        this.leadsource = leadsource;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getLeadowner() {
        return leadowner;
    }

    public void setLeadowner(String leadowner) {
        this.leadowner = leadowner;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRequirement() {
        return requirement;
    }

    public void setRequirement(String requirement) {
        this.requirement = requirement;
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
