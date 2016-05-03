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
@Entity(name = "purchaseorder")
@Table(name = "purchaseorder")
public class PurchaseOrder {
    @Id
    private String id;
    private String date,vendorid,taxamount,taxid,tax,paymentterms,finaltotal,branchid,status,balance,isreceived="Not received",comment,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
    private float sparepartsfinal;

    public PurchaseOrder(String id, String date, String vendorid, String taxamount, String taxid, String tax, String paymentterms, String finaltotal, String branchid, String status, String balance, String comment, float sparepartsfinal) {
        this.id = id;
        this.date = date;
        this.vendorid = vendorid;
        this.taxamount = taxamount;
        this.taxid = taxid;
        this.tax = tax;
        this.paymentterms = paymentterms;
        this.finaltotal = finaltotal;
        this.branchid = branchid;
        this.status = status;
        this.balance = balance;
        this.comment = comment;
        this.sparepartsfinal = sparepartsfinal;
    }

    public String getTax() {
        return tax;
    }

    public void setTax(String tax) {
        this.tax = tax;
    }
    
    public float getSparepartsfinal() {
        return sparepartsfinal;
    }

    public void setSparepartsfinal(float sparepartsfinal) {
        this.sparepartsfinal = sparepartsfinal;
    }       
        
    public String getIsreceived() {
        return isreceived;
    }

    public void setIsreceived(String isreceived) {
        this.isreceived = isreceived;
    }
    
    public String getBranchid() {
        return branchid;
    }

    public void setBranchid(String branchid) {
        this.branchid = branchid;
    }    

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }    

    public String getBalance() {
        return balance;
    }

    public void setBalance(String balance) {
        this.balance = balance;
    }    

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }    

    public String getPaymentterms() {
        return paymentterms;
    }

    public void setPaymentterms(String paymentterms) {
        this.paymentterms = paymentterms;
    }
    
    public String getTaxid() {
        return taxid;
    }

    public void setTaxid(String taxid) {
        this.taxid = taxid;
    }
        
    public PurchaseOrder() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getVendorid() {
        return vendorid;
    }

    public void setVendorid(String vendorid) {
        this.vendorid = vendorid;
    }

    public String getTaxamount() {
        return taxamount;
    }

    public void setTaxamount(String taxamount) {
        this.taxamount = taxamount;
    }

    public String getFinaltotal() {
        return finaltotal;
    }

    public void setFinaltotal(String finaltotal) {
        this.finaltotal = finaltotal;
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
