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
public class PurchaseOrderArray {
    private String[] sellingprice,costprice,partid,manufacturerid,partQuantity,itemtotal,purchaseorderid,branddetailid,oldpartid,oldbranddetailid,oldmanufacturerid,oldpartQuantity,oldsellingprice,oldcostprice,olditemtotal,oldpodsid;

    public PurchaseOrderArray() {
    }

    public PurchaseOrderArray(String[] sellingprice, String[] costprice, String[] partid, String[] manufacturerid, String[] partQuantity, String[] itemtotal, String[] purchaseorderid, String[] branddetailid, String[] oldpartid, String[] oldbranddetailid, String[] oldmanufacturerid, String[] oldpartQuantity, String[] oldsellingprice, String[] oldcostprice, String[] olditemtotal, String[] oldpodsid) {
        this.sellingprice = sellingprice;
        this.costprice = costprice;
        this.partid = partid;
        this.manufacturerid = manufacturerid;
        this.partQuantity = partQuantity;
        this.itemtotal = itemtotal;
        this.purchaseorderid = purchaseorderid;
        this.branddetailid = branddetailid;
        this.oldpartid = oldpartid;
        this.oldbranddetailid = oldbranddetailid;
        this.oldmanufacturerid = oldmanufacturerid;
        this.oldpartQuantity = oldpartQuantity;
        this.oldsellingprice = oldsellingprice;
        this.oldcostprice = oldcostprice;
        this.olditemtotal = olditemtotal;
        this.oldpodsid = oldpodsid;
    }

    public String[] getOldcostprice() {
        return oldcostprice;
    }

    public void setOldcostprice(String[] oldcostprice) {
        this.oldcostprice = oldcostprice;
    }
            
    public String[] getCostprice() {
        return costprice;
    }

    public void setCostprice(String[] costprice) {
        this.costprice = costprice;
    }
    
    public String[] getSellingprice() {
        return sellingprice;
    }

    public void setSellingprice(String[] sellingprice) {
        this.sellingprice = sellingprice;
    }
    
    public String[] getOldpodsid() {
        return oldpodsid;
    }

    public void setOldpodsid(String[] oldpodsid) {
        this.oldpodsid = oldpodsid;
    }
    
    public String[] getOldpartid() {
        return oldpartid;
    }

    public void setOldpartid(String[] oldpartid) {
        this.oldpartid = oldpartid;
    }

    public String[] getOldbranddetailid() {
        return oldbranddetailid;
    }

    public void setOldbranddetailid(String[] oldbranddetailid) {
        this.oldbranddetailid = oldbranddetailid;
    }

    public String[] getOldmanufacturerid() {
        return oldmanufacturerid;
    }

    public void setOldmanufacturerid(String[] oldmanufacturerid) {
        this.oldmanufacturerid = oldmanufacturerid;
    }

    public String[] getOldpartQuantity() {
        return oldpartQuantity;
    }

    public void setOldpartQuantity(String[] oldpartQuantity) {
        this.oldpartQuantity = oldpartQuantity;
    }

    public String[] getOldsellingprice() {
        return oldsellingprice;
    }

    public void setOldsellingprice(String[] oldsellingprice) {
        this.oldsellingprice = oldsellingprice;
    }

    public String[] getOlditemtotal() {
        return olditemtotal;
    }

    public void setOlditemtotal(String[] olditemtotal) {
        this.olditemtotal = olditemtotal;
    }
    
    public String[] getBranddetailid() {
        return branddetailid;
    }

    public void setBranddetailid(String[] branddetailid) {
        this.branddetailid = branddetailid;
    }
    
    public String[] getPartid() {
        return partid;
    }

    public void setPartid(String[] partid) {
        this.partid = partid;
    }

    public String[] getManufacturerid() {
        return manufacturerid;
    }

    public void setManufacturerid(String[] manufacturerid) {
        this.manufacturerid = manufacturerid;
    }

    public String[] getPartQuantity() {
        return partQuantity;
    }

    public void setPartQuantity(String[] partQuantity) {
        this.partQuantity = partQuantity;
    }

    public String[] getItemtotal() {
        return itemtotal;
    }

    public void setItemtotal(String[] itemtotal) {
        this.itemtotal = itemtotal;
    }

    public String[] getPurchaseorderid() {
        return purchaseorderid;
    }

    public void setPurchaseorderid(String[] purchaseorderid) {
        this.purchaseorderid = purchaseorderid;
    }
    
    
}
