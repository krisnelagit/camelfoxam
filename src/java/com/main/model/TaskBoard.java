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
@Entity(name = "taskboard")
@Table(name = "taskboard")
public class TaskBoard {
    @Id
    private String id;
    private String jobsheetid,workmanid,starttime,endtime,estimatetime,elapsed,timeconsumed,status,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public TaskBoard() {
    }

    public TaskBoard(String id, String jobsheetid, String workmanid, String starttime, String endtime, String estimatetime, String elapsed, String timeconsumed, String status) {
        this.id = id;
        this.jobsheetid = jobsheetid;
        this.workmanid = workmanid;
        this.starttime = starttime;
        this.endtime = endtime;
        this.estimatetime = estimatetime;
        this.elapsed = elapsed;
        this.timeconsumed = timeconsumed;
        this.status = status;
    }          

    public String getTimeconsumed() {
        return timeconsumed;
    }

    public void setTimeconsumed(String timeconsumed) {
        this.timeconsumed = timeconsumed;
    }   

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getJobsheetid() {
        return jobsheetid;
    }

    public void setJobsheetid(String jobsheetid) {
        this.jobsheetid = jobsheetid;
    }

    public String getWorkmanid() {
        return workmanid;
    }

    public void setWorkmanid(String workmanid) {
        this.workmanid = workmanid;
    }

    public String getStarttime() {
        return starttime;
    }

    public void setStarttime(String starttime) {
        this.starttime = starttime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    public String getEstimatetime() {
        return estimatetime;
    }

    public void setEstimatetime(String estimatetime) {
        this.estimatetime = estimatetime;
    }

    public String getElapsed() {
        return elapsed;
    }

    public void setElapsed(String elapsed) {
        this.elapsed = elapsed;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
