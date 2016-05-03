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
public class ConsumableDtoArray {
    private String [] jobsheetid, partid, type, sellingprice, quantity, manufacturerid, total, partname;

    public ConsumableDtoArray() {
    }

    public ConsumableDtoArray(String[] jobsheetid, String[] partid, String[] type, String[] sellingprice, String[] quantity, String[] manufacturerid, String[] total, String[] partname) {
        this.jobsheetid = jobsheetid;
        this.partid = partid;
        this.type = type;
        this.sellingprice = sellingprice;
        this.quantity = quantity;
        this.manufacturerid = manufacturerid;
        this.total = total;
        this.partname = partname;
    }

    public String[] getJobsheetid() {
        return jobsheetid;
    }

    public void setJobsheetid(String[] jobsheetid) {
        this.jobsheetid = jobsheetid;
    }

    public String[] getPartid() {
        return partid;
    }

    public void setPartid(String[] partid) {
        this.partid = partid;
    }

    public String[] getType() {
        return type;
    }

    public void setType(String[] type) {
        this.type = type;
    }

    public String[] getSellingprice() {
        return sellingprice;
    }

    public void setSellingprice(String[] sellingprice) {
        this.sellingprice = sellingprice;
    }

    public String[] getQuantity() {
        return quantity;
    }

    public void setQuantity(String[] quantity) {
        this.quantity = quantity;
    }

    public String[] getManufacturerid() {
        return manufacturerid;
    }

    public void setManufacturerid(String[] manufacturerid) {
        this.manufacturerid = manufacturerid;
    }

    public String[] getTotal() {
        return total;
    }

    public void setTotal(String[] total) {
        this.total = total;
    }

    public String[] getPartname() {
        return partname;
    }

    public void setPartname(String[] partname) {
        this.partname = partname;
    }
    
    
    
}
