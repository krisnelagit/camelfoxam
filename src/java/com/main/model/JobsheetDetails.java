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
@Entity(name = "jobsheetdetails")
@Table(name = "jobsheetdetails")
public class JobsheetDetails {

    @Id
    private String id;
    private float estimatetime;
    private String estimatedetailid, jobsheetid, mfgid, itemtype, partstatus, verified = "No", workmanid, isdelete = "No", modifydate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public JobsheetDetails() {
    }

    public JobsheetDetails(String id, float estimatetime, String estimatedetailid, String jobsheetid, String mfgid, String itemtype, String partstatus, String workmanid) {
        this.id = id;
        this.estimatetime = estimatetime;
        this.estimatedetailid = estimatedetailid;
        this.jobsheetid = jobsheetid;
        this.mfgid = mfgid;
        this.itemtype = itemtype;
        this.partstatus = partstatus;
        this.workmanid = workmanid;
    }

    public String getPartstatus() {
        return partstatus;
    }

    public void setPartstatus(String partstatus) {
        this.partstatus = partstatus;
    }
    
    public String getItemtype() {
        return itemtype;
    }

    public void setItemtype(String itemtype) {
        this.itemtype = itemtype;
    }
    
    public float getEstimatetime() {
        return estimatetime;
    }

    public void setEstimatetime(float estimatetime) {
        this.estimatetime = estimatetime;
    }

    public String getMfgid() {
        return mfgid;
    }

    public void setMfgid(String mfgid) {
        this.mfgid = mfgid;
    }

    public String getVerified() {
        return verified;
    }

    public void setVerified(String verified) {
        this.verified = verified;
    }

    public String getWorkmanid() {
        return workmanid;
    }

    public void setWorkmanid(String workmanid) {
        this.workmanid = workmanid;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEstimatedetailid() {
        return estimatedetailid;
    }

    public void setEstimatedetailid(String estimatedetailid) {
        this.estimatedetailid = estimatedetailid;
    }

    public String getJobsheetid() {
        return jobsheetid;
    }

    public void setJobsheetid(String jobsheetid) {
        this.jobsheetid = jobsheetid;
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
