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
@Entity(name = "pointchecklistdetails")
@Table(name = "pointchecklistdetails")
public class PointChecklistDetails {
    @Id
    private String id;
    private String partlistid,pointchecklistid,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public PointChecklistDetails() {
    }

    public PointChecklistDetails(String id, String partlistid, String pointchecklistid) {
        this.id = id;
        this.partlistid = partlistid;
        this.pointchecklistid = pointchecklistid;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPartlistid() {
        return partlistid;
    }

    public void setPartlistid(String partlistid) {
        this.partlistid = partlistid;
    }

    public String getPointchecklistid() {
        return pointchecklistid;
    }

    public void setPointchecklistid(String pointchecklistid) {
        this.pointchecklistid = pointchecklistid;
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
 