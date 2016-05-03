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
@Entity(name = "appointment")
@Table(name = "appointment")
public class Appointment {
    @Id
    private String id;
    private String enquirieid,datetime,subject,address,apdescription,appointmentowner,pickup="No",isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public Appointment(String id, String enquirieid, String datetime, String subject, String address, String apdescription, String appointmentowner) {
        this.id = id;
        this.enquirieid = enquirieid;
        this.datetime = datetime;
        this.subject = subject;
        this.address = address;
        this.apdescription = apdescription;
        this.appointmentowner = appointmentowner;
    }

    public String getPickup() {
        return pickup;
    }

    public void setPickup(String pickup) {
        this.pickup = pickup;
    }   
    
    public Appointment() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEnquirieid() {
        return enquirieid;
    }

    public void setEnquirieid(String enquirieid) {
        this.enquirieid = enquirieid;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getApdescription() {
        return apdescription;
    }

    public void setApdescription(String apdescription) {
        this.apdescription = apdescription;
    } 

    public String getAppointmentowner() {
        return appointmentowner;
    }

    public void setAppointmentowner(String appointmentowner) {
        this.appointmentowner = appointmentowner;
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
