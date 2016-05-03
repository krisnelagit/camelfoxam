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
 * @author pc2
 */
@Entity(name = "customervehicles")
@Table(name = "customervehicles")
public class CustomerVehicles {

    @Id
    private String id;
    @Column(insertable = false, updatable = false)
    private String savedate;
    private String custid, licensenumber="", carbrand, carmodel,drivername,drivernumber, vehiclenumber, km_in,is180ready = "No",ishidden="No", vinnumber, date, brandid, branddetailid, isdelete = "No", modifydate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public CustomerVehicles() {
    }

    public CustomerVehicles(String id, String savedate, String custid, String carbrand, String carmodel, String drivername, String drivernumber, String vehiclenumber, String km_in, String vinnumber, String date, String brandid, String branddetailid) {
        this.id = id;
        this.savedate = savedate;
        this.custid = custid;
        this.carbrand = carbrand;
        this.carmodel = carmodel;
        this.drivername = drivername;
        this.drivernumber = drivernumber;
        this.vehiclenumber = vehiclenumber;
        this.km_in = km_in;
        this.vinnumber = vinnumber;
        this.date = date;
        this.brandid = brandid;
        this.branddetailid = branddetailid;
    }

    public String getIshidden() {
        return ishidden;
    }

    public void setIshidden(String ishidden) {
        this.ishidden = ishidden;
    }
        
    public String getDrivername() {
        return drivername;
    }

    public void setDrivername(String drivername) {
        this.drivername = drivername;
    }

    public String getDrivernumber() {
        return drivernumber;
    }

    public void setDrivernumber(String drivernumber) {
        this.drivernumber = drivernumber;
    }

    public String getKm_in() {
        return km_in;
    }

    public void setKm_in(String km_in) {
        this.km_in = km_in;
    }
    
    public String getIs180ready() {
        return is180ready;
    }

    public void setIs180ready(String is180ready) {
        this.is180ready = is180ready;
    }    

    public String getSavedate() {
        return savedate;
    }

    public void setSavedate(String savedate) {
        this.savedate = savedate;
    }

    public CustomerVehicles(String brandid, String branddetailid) {
        this.brandid = brandid;
        this.branddetailid = branddetailid;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCustid() {
        return custid;
    }

    public void setCustid(String custid) {
        this.custid = custid;
    }

    public String getLicensenumber() {
        return licensenumber;
    }

    public void setLicensenumber(String licensenumber) {
        this.licensenumber = licensenumber;
    }

    public String getCarbrand() {
        return carbrand;
    }

    public void setCarbrand(String carbrand) {
        this.carbrand = carbrand;
    }

    public String getCarmodel() {
        return carmodel;
    }

    public void setCarmodel(String carmodel) {
        this.carmodel = carmodel;
    }

    public String getVehiclenumber() {
        return vehiclenumber;
    }

    public void setVehiclenumber(String vehiclenumber) {
        this.vehiclenumber = vehiclenumber;
    }

    public String getVinnumber() {
        return vinnumber;
    }

    public void setVinnumber(String vinnumber) {
        this.vinnumber = vinnumber;
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
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

}
