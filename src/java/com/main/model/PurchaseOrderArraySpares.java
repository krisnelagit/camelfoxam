/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.model;

import java.util.ArrayList;

/**
 *
 * @author user
 */
public class PurchaseOrderArraySpares {
    ArrayList<String> partid,branchid,vendorid,manufacturerid,branddetailid,costprice,sellingprice,partQuantity,itemtotal;

    public PurchaseOrderArraySpares() {
    }
    
    

    public PurchaseOrderArraySpares(ArrayList<String> partid, ArrayList<String> branchid, ArrayList<String> vendorid, ArrayList<String> manufacturerid, ArrayList<String> branddetailid, ArrayList<String> costprice, ArrayList<String> sellingprice, ArrayList<String> partQuantity, ArrayList<String> itemtotal) {
        this.partid = partid;
        this.branchid = branchid;
        this.vendorid = vendorid;
        this.manufacturerid = manufacturerid;
        this.branddetailid = branddetailid;
        this.costprice = costprice;
        this.sellingprice = sellingprice;
        this.partQuantity = partQuantity;
        this.itemtotal = itemtotal;
    }

    public ArrayList<String> getPartid() {
        return partid;
    }

    public void setPartid(ArrayList<String> partid) {
        this.partid = partid;
    }

    public ArrayList<String> getBranchid() {
        return branchid;
    }

    public void setBranchid(ArrayList<String> branchid) {
        this.branchid = branchid;
    }

    public ArrayList<String> getVendorid() {
        return vendorid;
    }

    public void setVendorid(ArrayList<String> vendorid) {
        this.vendorid = vendorid;
    }

    public ArrayList<String> getManufacturerid() {
        return manufacturerid;
    }

    public void setManufacturerid(ArrayList<String> manufacturerid) {
        this.manufacturerid = manufacturerid;
    }

    public ArrayList<String> getBranddetailid() {
        return branddetailid;
    }

    public void setBranddetailid(ArrayList<String> branddetailid) {
        this.branddetailid = branddetailid;
    }

    public ArrayList<String> getCostprice() {
        return costprice;
    }

    public void setCostprice(ArrayList<String> costprice) {
        this.costprice = costprice;
    }

    public ArrayList<String> getSellingprice() {
        return sellingprice;
    }

    public void setSellingprice(ArrayList<String> sellingprice) {
        this.sellingprice = sellingprice;
    }

    public ArrayList<String> getPartQuantity() {
        return partQuantity;
    }

    public void setPartQuantity(ArrayList<String> partQuantity) {
        this.partQuantity = partQuantity;
    }

    public ArrayList<String> getItemtotal() {
        return itemtotal;
    }

    public void setItemtotal(ArrayList<String> itemtotal) {
        this.itemtotal = itemtotal;
    }
    
    
}
