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
@Entity(name = "followups")
@Table(name = "followups")
public class Followups {    
    @Id
    private String id;
    private String enquirieid="",feedbackid="",followedby,lastfollowup,nextfollowup,title,type,fpdescription,fpstatus,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
    
    public Followups() {
    }

    public Followups(String id, String followedby, String lastfollowup, String nextfollowup, String title, String type, String fpdescription, String fpstatus) {
        this.id = id;
        this.followedby = followedby;
        this.lastfollowup = lastfollowup;
        this.nextfollowup = nextfollowup;
        this.title = title;
        this.type = type;
        this.fpdescription = fpdescription;
        this.fpstatus = fpstatus;
    }

    public String getFeedbackid() {
        return feedbackid;
    }

    public void setFeedbackid(String feedbackid) {
        this.feedbackid = feedbackid;
    }
    
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }    

    public String getFpstatus() {
        return fpstatus;
    }

    public void setFpstatus(String fpstatus) {
        this.fpstatus = fpstatus;
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

    public String getFollowedby() {
        return followedby;
    }

    public void setFollowedby(String followedby) {
        this.followedby = followedby;
    }

    public String getLastfollowup() {
        return lastfollowup;
    }

    public void setLastfollowup(String lastfollowup) {
        this.lastfollowup = lastfollowup;
    }

    public String getNextfollowup() {
        return nextfollowup;
    }

    public void setNextfollowup(String nextfollowup) {
        this.nextfollowup = nextfollowup;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFpdescription() {
        return fpdescription;
    }

    public void setFpdescription(String fpdescription) {
        this.fpdescription = fpdescription;
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
