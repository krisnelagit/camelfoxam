/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
12:41 24/04/2015
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
@Entity(name = "pointchecklist")
@Table(name = "pointchecklist")
public class PointChecklist {
    @Id
    private String id;
    private String date,customervehiclesid,servicechecklistid,isestimate="No",isdelete="No",ishidden="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public PointChecklist() {
    }

    public PointChecklist(String id, String date, String customervehiclesid, String servicechecklistid) {
        this.id = id;
        this.date = date;
        this.customervehiclesid = customervehiclesid;
        this.servicechecklistid = servicechecklistid;
    }

    public String getIshidden() {
        return ishidden;
    }

    public void setIshidden(String ishidden) {
        this.ishidden = ishidden;
    }
        
    public String getIsestimate() {
        return isestimate;
    }

    public void setIsestimate(String isestimate) {
        this.isestimate = isestimate;
    }     

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }    

    public String getServicechecklistid() {
        return servicechecklistid;
    }

    public void setServicechecklistid(String servicechecklistid) {
        this.servicechecklistid = servicechecklistid;
    }    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCustomervehiclesid() {
        return customervehiclesid;
    }

    public void setCustomervehiclesid(String customervehiclesid) {
        this.customervehiclesid = customervehiclesid;
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
 