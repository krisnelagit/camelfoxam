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
@Entity(name = "branch")
@Table(name = "branch")
public class Branch {

    @Id
    private String id;
    private String name, phonenumber, email, address, purchase_ord_prefix,purchase_ord_detail_prefix, isdelete = "No", modifydate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public Branch(String id, String name, String phonenumber, String email, String address, String purchase_ord_prefix, String purchase_ord_detail_prefix) {
        this.id = id;
        this.name = name;
        this.phonenumber = phonenumber;
        this.email = email;
        this.address = address;
        this.purchase_ord_prefix = purchase_ord_prefix;
        this.purchase_ord_detail_prefix = purchase_ord_detail_prefix;
    }

    public String getPurchase_ord_detail_prefix() {
        return purchase_ord_detail_prefix;
    }

    public void setPurchase_ord_detail_prefix(String purchase_ord_detail_prefix) {
        this.purchase_ord_detail_prefix = purchase_ord_detail_prefix;
    }

    public String getPurchase_ord_prefix() {
        return purchase_ord_prefix;
    }

    public void setPurchase_ord_prefix(String purchase_ord_prefix) {
        this.purchase_ord_prefix = purchase_ord_prefix;
    }
    
    public Branch() {
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

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
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
