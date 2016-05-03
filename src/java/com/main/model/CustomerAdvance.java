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
@Entity(name = "customer_advance")
@Table(name = "customer_advance")
public class CustomerAdvance {
    @Id
    private String id;
    private String customerid,brandid,branddetailid,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
    private float advance_amount;

    public CustomerAdvance(String id, String customerid, String brandid, String branddetailid, float advance_amount) {
        this.id = id;
        this.customerid = customerid;
        this.brandid = brandid;
        this.branddetailid = branddetailid;
        this.advance_amount = advance_amount;
    }

    public float getAdvance_amount() {
        return advance_amount;
    }

    public void setAdvance_amount(float advance_amount) {
        this.advance_amount = advance_amount;
    }
    
    public CustomerAdvance() {
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
