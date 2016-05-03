/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.model;

/**
 *
 * @author user
 */
public class EstimateLabourArray {
    public String[] serviceid,servicename,servicetotal,labourdescription,newserviceid,newservicename,newservicetotal,newlabourdescription,serviceestdetailids;

    public EstimateLabourArray(String[] serviceid, String[] servicename, String[] servicetotal, String[] labourdescription, String[] newserviceid, String[] newservicename, String[] newservicetotal, String[] newlabourdescription, String[] serviceestdetailids) {
        this.serviceid = serviceid;
        this.servicename = servicename;
        this.servicetotal = servicetotal;
        this.labourdescription = labourdescription;
        this.newserviceid = newserviceid;
        this.newservicename = newservicename;
        this.newservicetotal = newservicetotal;
        this.newlabourdescription = newlabourdescription;
        this.serviceestdetailids = serviceestdetailids;
    }

    public String[] getNewservicename() {
        return newservicename;
    }

    public void setNewservicename(String[] newservicename) {
        this.newservicename = newservicename;
    }
    
    public String[] getServicename() {
        return servicename;
    }

    public void setServicename(String[] servicename) {
        this.servicename = servicename;
    }
    
    public String[] getServiceestdetailids() {
        return serviceestdetailids;
    }

    public void setServiceestdetailids(String[] serviceestdetailids) {
        this.serviceestdetailids = serviceestdetailids;
    }
    
    public String[] getNewserviceid() {
        return newserviceid;
    }

    public void setNewserviceid(String[] newserviceid) {
        this.newserviceid = newserviceid;
    }

    public String[] getNewservicetotal() {
        return newservicetotal;
    }

    public void setNewservicetotal(String[] newservicetotal) {
        this.newservicetotal = newservicetotal;
    }

    public String[] getNewlabourdescription() {
        return newlabourdescription;
    }

    public void setNewlabourdescription(String[] newlabourdescription) {
        this.newlabourdescription = newlabourdescription;
    }
    
    public EstimateLabourArray() {
    }

    public String[] getServiceid() {
        return serviceid;
    }

    public void setServiceid(String[] serviceid) {
        this.serviceid = serviceid;
    }

    public String[] getServicetotal() {
        return servicetotal;
    }

    public void setServicetotal(String[] servicetotal) {
        this.servicetotal = servicetotal;
    }

    public String[] getLabourdescription() {
        return labourdescription;
    }

    public void setLabourdescription(String[] labourdescription) {
        this.labourdescription = labourdescription;
    }
    
    
    
}
