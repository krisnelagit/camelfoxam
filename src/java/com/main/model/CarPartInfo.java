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
@Entity(name = "carpartinfo")
@Table(name = "carpartinfo")
public class CarPartInfo {
    @Id
    private String id;
    private String branddetailid,balancequantity,vaultid, isdelete = "No", modifydate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public CarPartInfo(String id, String branddetailid, String balancequantity, String vaultid) {
        this.id = id;
        this.branddetailid = branddetailid;
        this.balancequantity = balancequantity;
        this.vaultid = vaultid;
    }
    
    public CarPartInfo() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBranddetailid() {
        return branddetailid;
    }

    public void setBranddetailid(String branddetailid) {
        this.branddetailid = branddetailid;
    }

    public String getVaultid() {
        return vaultid;
    }

    public void setVaultid(String vaultid) {
        this.vaultid = vaultid;
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

    public String getBalancequantity() {
        return balancequantity;
    }

    public void setBalancequantity(String balancequantity) {
        this.balancequantity = balancequantity;
    }
    
}
