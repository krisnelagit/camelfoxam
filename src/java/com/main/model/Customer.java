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
@Entity(name = "customer")
@Table(name = "customer")
public class Customer {
    @Id
    private String id;
    @Column(insertable = false,updatable = false)
    private String savedate;
    private String name,mobilenumber,email,address,password,isdelete = "No", modifydate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
    private float advance_amount;

    public Customer() {
    }

    public Customer(String id, String savedate, String name, String mobilenumber, String email, String address, String password, float advance_amount) {
        this.id = id;
        this.savedate = savedate;
        this.name = name;
        this.mobilenumber = mobilenumber;
        this.email = email;
        this.address = address;
        this.password = password;
        this.advance_amount = advance_amount;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public float getAdvance_amount() {
        return advance_amount;
    }

    public void setAdvance_amount(float advance_amount) {
        this.advance_amount = advance_amount;
    }
    
    public String getSavedate() {
        return savedate;
    }

    public void setSavedate(String savedate) {
        this.savedate = savedate;
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

    public String getMobilenumber() {
        return mobilenumber;
    }

    public void setMobilenumber(String mobilenumber) {
        this.mobilenumber = mobilenumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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
