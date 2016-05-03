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
 * @author manish
 */
@Entity(name = "inventoryvendor")
@Table(name = "inventoryvendor")
public class InventoryVendor {
    @Id
    private String id;
    private String invoiceid,vendorid,quantity,invoicedetailid,from_inventoryid,to_inventoryid,partid,mfgid,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());  

    public InventoryVendor(String id, String invoiceid, String vendorid, String quantity, String invoicedetailid, String from_inventoryid, String to_inventoryid, String partid, String mfgid) {
        this.id = id;
        this.invoiceid = invoiceid;
        this.vendorid = vendorid;
        this.quantity = quantity;
        this.invoicedetailid = invoicedetailid;
        this.from_inventoryid = from_inventoryid;
        this.to_inventoryid = to_inventoryid;
        this.partid = partid;
        this.mfgid = mfgid;
    }

    public String getPartid() {
        return partid;
    }

    public void setPartid(String partid) {
        this.partid = partid;
    }

    public String getMfgid() {
        return mfgid;
    }

    public void setMfgid(String mfgid) {
        this.mfgid = mfgid;
    }
    
    public String getFrom_inventoryid() {
        return from_inventoryid;
    }

    public void setFrom_inventoryid(String from_inventoryid) {
        this.from_inventoryid = from_inventoryid;
    }

    public String getTo_inventoryid() {
        return to_inventoryid;
    }

    public void setTo_inventoryid(String to_inventoryid) {
        this.to_inventoryid = to_inventoryid;
    }
    
    public String getInvoicedetailid() {
        return invoicedetailid;
    }

    public void setInvoicedetailid(String invoicedetailid) {
        this.invoicedetailid = invoicedetailid;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getInvoiceid() {
        return invoiceid;
    }

    public void setInvoiceid(String invoiceid) {
        this.invoiceid = invoiceid;
    }

    public String getVendorid() {
        return vendorid;
    }

    public void setVendorid(String vendorid) {
        this.vendorid = vendorid;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
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

    public InventoryVendor() {
    }   
    
}
