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
@Entity(name = "jobsheet")
@Table(name = "jobsheet")
public class Jobsheet {
    @Id
    private String id;
    private String estimateid,cvid,verified,cleaning,car_washing,car_vacuuming,tyre_polish,dashboard_polish,engine_cleaning,underchasis_cleaning,trunk_cleaning,km_out,isinvoiceconverted="No",isrequisitionready="No",istaskcompleted="No",isdelete="No",enableDelete="Yes",ishidden="No",jobsheetcomments,spcomments,jvcomments,finalcomments,deliverydate,modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public Jobsheet() {
    }

    public Jobsheet(String id, String estimateid, String cvid, String verified, String cleaning, String car_washing, String car_vacuuming, String tyre_polish, String dashboard_polish, String engine_cleaning, String underchasis_cleaning, String trunk_cleaning, String km_out, String jobsheetcomments, String spcomments, String jvcomments, String finalcomments, String deliverydate) {
        this.id = id;
        this.estimateid = estimateid;
        this.cvid = cvid;
        this.verified = verified;
        this.cleaning = cleaning;
        this.car_washing = car_washing;
        this.car_vacuuming = car_vacuuming;
        this.tyre_polish = tyre_polish;
        this.dashboard_polish = dashboard_polish;
        this.engine_cleaning = engine_cleaning;
        this.underchasis_cleaning = underchasis_cleaning;
        this.trunk_cleaning = trunk_cleaning;
        this.km_out = km_out;
        this.jobsheetcomments = jobsheetcomments;
        this.spcomments = spcomments;
        this.jvcomments = jvcomments;
        this.finalcomments = finalcomments;
        this.deliverydate = deliverydate;
    }

    

    public String getEnableDelete() {
        return enableDelete;
    }

    public void setEnableDelete(String enableDelete) {
        this.enableDelete = enableDelete;
    }

    public String getJobsheetcomments() {
        return jobsheetcomments;
    }

    public void setJobsheetcomments(String jobsheetcomments) {
        this.jobsheetcomments = jobsheetcomments;
    }

    public String getSpcomments() {
        return spcomments;
    }

    public void setSpcomments(String spcomments) {
        this.spcomments = spcomments;
    }

    public String getJvcomments() {
        return jvcomments;
    }

    public void setJvcomments(String jvcomments) {
        this.jvcomments = jvcomments;
    }

    public String getFinalcomments() {
        return finalcomments;
    }

    public void setFinalcomments(String finalcomments) {
        this.finalcomments = finalcomments;
    }

    public String getDeliverydate() {
        return deliverydate;
    }

    public void setDeliverydate(String deliverydate) {
        this.deliverydate = deliverydate;
    }
    
    public String getIshidden() {
        return ishidden;
    }

    public void setIshidden(String ishidden) {
        this.ishidden = ishidden;
    }
        
    public String getKm_out() {
        return km_out;
    }

    public void setKm_out(String km_out) {
        this.km_out = km_out;
    }
    
    public String getIstaskcompleted() {
        return istaskcompleted;
    }

    public void setIstaskcompleted(String istaskcompleted) {
        this.istaskcompleted = istaskcompleted;
    }

    public String getCar_washing() {
        return car_washing;
    }

    public void setCar_washing(String car_washing) {
        this.car_washing = car_washing;
    }

    public String getCar_vacuuming() {
        return car_vacuuming;
    }

    public void setCar_vacuuming(String car_vacuuming) {
        this.car_vacuuming = car_vacuuming;
    }

    public String getTyre_polish() {
        return tyre_polish;
    }

    public void setTyre_polish(String tyre_polish) {
        this.tyre_polish = tyre_polish;
    }

    public String getDashboard_polish() {
        return dashboard_polish;
    }

    public void setDashboard_polish(String dashboard_polish) {
        this.dashboard_polish = dashboard_polish;
    }

    public String getEngine_cleaning() {
        return engine_cleaning;
    }

    public void setEngine_cleaning(String engine_cleaning) {
        this.engine_cleaning = engine_cleaning;
    }

    public String getUnderchasis_cleaning() {
        return underchasis_cleaning;
    }

    public void setUnderchasis_cleaning(String underchasis_cleaning) {
        this.underchasis_cleaning = underchasis_cleaning;
    }

    public String getTrunk_cleaning() {
        return trunk_cleaning;
    }

    public void setTrunk_cleaning(String trunk_cleaning) {
        this.trunk_cleaning = trunk_cleaning;
    }
    
    public String getIsrequisitionready() {
        return isrequisitionready;
    }

    public void setIsrequisitionready(String isrequisitionready) {
        this.isrequisitionready = isrequisitionready;
    }

    public String getIsinvoiceconverted() {
        return isinvoiceconverted;
    }

    public void setIsinvoiceconverted(String isinvoiceconverted) {
        this.isinvoiceconverted = isinvoiceconverted;
    }

    public String getVerified() {
        return verified;
    }

    public void setVerified(String verified) {
        this.verified = verified;
    }

    public String getCleaning() {
        return cleaning;
    }

    public void setCleaning(String cleaning) {
        this.cleaning = cleaning;
    }
    
    public String getCvid() {
        return cvid;
    }

    public void setCvid(String cvid) {
        this.cvid = cvid;
    }    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEstimateid() {
        return estimateid;
    }

    public void setEstimateid(String estimateid) {
        this.estimateid = estimateid;
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
