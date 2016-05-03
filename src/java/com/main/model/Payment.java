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
@Entity(name = "payment")
@Table(name = "payment")
public class Payment {
    @Id
    private String id;
    private String invoiceid,customerid,amount,mode="",chequenumber="",bankname="",chequedate="",transactionnumber="",transactiondate="",isdelete="No",paymentby,modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public Payment() {
    }

    public Payment(String id, String invoiceid, String customerid, String amount, String paymentby) {
        this.id = id;
        this.invoiceid = invoiceid;
        this.customerid = customerid;
        this.amount = amount;
        this.paymentby = paymentby;
    }

    public String getPaymentby() {
        return paymentby;
    }

    public void setPaymentby(String paymentby) {
        this.paymentby = paymentby;
    }
    
    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    

    public String getChequenumber() {
        return chequenumber;
    }

    public void setChequenumber(String chequenumber) {
        this.chequenumber = chequenumber;
    }

    public String getBankname() {
        return bankname;
    }

    public void setBankname(String bankname) {
        this.bankname = bankname;
    }

    public String getChequedate() {
        return chequedate;
    }

    public void setChequedate(String chequedate) {
        this.chequedate = chequedate;
    }

    public String getTransactionnumber() {
        return transactionnumber;
    }

    public void setTransactionnumber(String transactionnumber) {
        this.transactionnumber = transactionnumber;
    }

    public String getTransactiondate() {
        return transactiondate;
    }

    public void setTransactiondate(String transactiondate) {
        this.transactiondate = transactiondate;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getInvoiceid() {
        return invoiceid;
    }

    public void setInvoiceid(String invoiceid) {
        this.invoiceid = invoiceid;
    }

    public String getCustomerid() {
        return customerid;
    }

    public void setCustomerid(String customerid) {
        this.customerid = customerid;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
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
