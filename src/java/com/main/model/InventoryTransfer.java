/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.model;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author user
 */
@Entity(name = "inventory_transfer")
@Table(name = "inventory_transfer")
public class InventoryTransfer {
    @Id
    private String id;
    @Column(insertable = false,updatable = false)
    private String savedate;
    private String total,type,manufacturerid,vendor,costprice,partid,quantity,branddetailid,to_branch,from_branch,is_transferred,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());  
    private float sellingprice;

    public InventoryTransfer(String id, String savedate, String total, String type, String manufacturerid, String vendor, String costprice, String partid, String quantity, String branddetailid, String to_branch, String from_branch, String is_transferred, float sellingprice) {
        this.id = id;
        this.savedate = savedate;
        this.total = total;
        this.type = type;
        this.manufacturerid = manufacturerid;
        this.vendor = vendor;
        this.costprice = costprice;
        this.partid = partid;
        this.quantity = quantity;
        this.branddetailid = branddetailid;
        this.to_branch = to_branch;
        this.from_branch = from_branch;
        this.is_transferred = is_transferred;
        this.sellingprice = sellingprice;
    }

    public String getBranddetailid() {
        return branddetailid;
    }

    public void setBranddetailid(String branddetailid) {
        this.branddetailid = branddetailid;
    }
    
    public InventoryTransfer() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSavedate() {
        return savedate;
    }

    public void setSavedate(String savedate) {
        this.savedate = savedate;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getManufacturerid() {
        return manufacturerid;
    }

    public void setManufacturerid(String manufacturerid) {
        this.manufacturerid = manufacturerid;
    }

    public String getVendor() {
        return vendor;
    }

    public void setVendor(String vendor) {
        this.vendor = vendor;
    }

    public String getCostprice() {
        return costprice;
    }

    public void setCostprice(String costprice) {
        this.costprice = costprice;
    }

    public String getPartid() {
        return partid;
    }

    public void setPartid(String partid) {
        this.partid = partid;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getTo_branch() {
        return to_branch;
    }

    public void setTo_branch(String to_branch) {
        this.to_branch = to_branch;
    }

    public String getFrom_branch() {
        return from_branch;
    }

    public void setFrom_branch(String from_branch) {
        this.from_branch = from_branch;
    }

    public String getIs_transferred() {
        return is_transferred;
    }

    public void setIs_transferred(String is_transferred) {
        this.is_transferred = is_transferred;
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

    public float getSellingprice() {
        return sellingprice;
    }

    public void setSellingprice(float sellingprice) {
        this.sellingprice = sellingprice;
    }
           
}
