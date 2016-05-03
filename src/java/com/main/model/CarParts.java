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
 * @author pc2
 */
@Entity(name = "carparts")
@Table(name = "carparts")
public class CarParts {

    @Id
    private String id;
    private String itemname,balanceqty, category,  model, brand, vehicle, isdelete = "No", modifydate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public CarParts() {
    }

    public CarParts(String id, String itemname, String balanceqty, String category,  String model, String brand, String vehicle) {
        this.id = id;
        this.itemname = itemname;
        this.balanceqty = balanceqty;
        this.category = category;
        this.model = model;
        this.brand = brand;
        this.vehicle = vehicle;
    }

    public String getBalanceqty() {
        return balanceqty;
    }

    public void setBalanceqty(String balanceqty) {
        this.balanceqty = balanceqty;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getItemname() {
        return itemname;
    }

    public void setItemname(String itemname) {
        this.itemname = itemname;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getVehicle() {
        return vehicle;
    }

    public void setVehicle(String vehicle) {
        this.vehicle = vehicle;
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
