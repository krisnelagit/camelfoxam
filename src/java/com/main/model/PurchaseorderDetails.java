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
@Entity(name = "purchaseorderdetails")
@Table(name = "purchaseorderdetails")
public class PurchaseorderDetails {
    @Id
    private String id;
    private String partid,manufacturerid,branddetailid,costprice,sellingprice,isreceived="No",billnumber="",expense_billnumber,bill_date,partQuantity,itemtotal,purchaseorderid,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public PurchaseorderDetails(String id, String partid, String manufacturerid, String branddetailid, String costprice, String sellingprice, String expense_billnumber, String bill_date, String partQuantity, String itemtotal, String purchaseorderid) {
        this.id = id;
        this.partid = partid;
        this.manufacturerid = manufacturerid;
        this.branddetailid = branddetailid;
        this.costprice = costprice;
        this.sellingprice = sellingprice;
        this.expense_billnumber = expense_billnumber;
        this.bill_date = bill_date;
        this.partQuantity = partQuantity;
        this.itemtotal = itemtotal;
        this.purchaseorderid = purchaseorderid;
    }

    public String getExpense_billnumber() {
        return expense_billnumber;
    }

    public void setExpense_billnumber(String expense_billnumber) {
        this.expense_billnumber = expense_billnumber;
    }

    public String getBill_date() {
        return bill_date;
    }

    public void setBill_date(String bill_date) {
        this.bill_date = bill_date;
    }
     
    public String getBillnumber() {
        return billnumber;
    }

    public void setBillnumber(String billnumber) {
        this.billnumber = billnumber;
    }
    
    public String getIsreceived() {
        return isreceived;
    }

    public void setIsreceived(String isreceived) {
        this.isreceived = isreceived;
    }        
       
    public String getCostprice() {
        return costprice;
    }

    public void setCostprice(String costprice) {
        this.costprice = costprice;
    }
    
    public String getSellingprice() {
        return sellingprice;
    }

    public void setSellingprice(String sellingprice) {
        this.sellingprice = sellingprice;
    }
    
    public String getBranddetailid() {
        return branddetailid;
    }

    public void setBranddetailid(String branddetailid) {
        this.branddetailid = branddetailid;
    }
    
    public PurchaseorderDetails() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPartid() {
        return partid;
    }

    public void setPartid(String partid) {
        this.partid = partid;
    }

    public String getManufacturerid() {
        return manufacturerid;
    }

    public void setManufacturerid(String manufacturerid) {
        this.manufacturerid = manufacturerid;
    }

    public String getPartQuantity() {
        return partQuantity;
    }

    public void setPartQuantity(String partQuantity) {
        this.partQuantity = partQuantity;
    }

    public String getItemtotal() {
        return itemtotal;
    }

    public void setItemtotal(String itemtotal) {
        this.itemtotal = itemtotal;
    }

    public String getPurchaseorderid() {
        return purchaseorderid;
    }

    public void setPurchaseorderid(String purchaseorderid) {
        this.purchaseorderid = purchaseorderid;
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
