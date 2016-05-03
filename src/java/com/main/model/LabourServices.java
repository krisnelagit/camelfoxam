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
@Entity(name = "labourservices")
@Table(name = "labourservices")
public class LabourServices {

    @Id
    private String id;
    private String name, rate_a, rate_b, rate_c, rate_d, description, isdelete = "No", modifydate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public LabourServices(String id, String name, String rate_a, String rate_b, String rate_c, String rate_d, String description) {
        this.id = id;
        this.name = name;
        this.rate_a = rate_a;
        this.rate_b = rate_b;
        this.rate_c = rate_c;
        this.rate_d = rate_d;
        this.description = description;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRate_a() {
        return rate_a;
    }

    public void setRate_a(String rate_a) {
        this.rate_a = rate_a;
    }

    public String getRate_b() {
        return rate_b;
    }

    public void setRate_b(String rate_b) {
        this.rate_b = rate_b;
    }

    public String getRate_c() {
        return rate_c;
    }

    public void setRate_c(String rate_c) {
        this.rate_c = rate_c;
    }

    public String getRate_d() {
        return rate_d;
    }

    public void setRate_d(String rate_d) {
        this.rate_d = rate_d;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public LabourServices() {
    }

}
