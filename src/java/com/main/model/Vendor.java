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
@Entity(name = "vendor")
@Table(name = "vendor")
public class Vendor {
    @Id
    private String id;
    private String name,address,contactperson,mobilenumber,email,paymentterms,vat_number,tin_number,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());  

    public Vendor() {
    }

    public Vendor(String id, String name, String address, String contactperson, String mobilenumber, String email, String paymentterms, String vat_number, String tin_number) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.contactperson = contactperson;
        this.mobilenumber = mobilenumber;
        this.email = email;
        this.paymentterms = paymentterms;
        this.vat_number = vat_number;
        this.tin_number = tin_number;
    }

    public String getVat_number() {
        return vat_number;
    }

    public void setVat_number(String vat_number) {
        this.vat_number = vat_number;
    }

    public String getTin_number() {
        return tin_number;
    }

    public void setTin_number(String tin_number) {
        this.tin_number = tin_number;
    }
    
    public String getPaymentterms() {
        return paymentterms;
    }

    public void setPaymentterms(String paymentterms) {
        this.paymentterms = paymentterms;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContactperson() {
        return contactperson;
    }

    public void setContactperson(String contactperson) {
        this.contactperson = contactperson;
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
