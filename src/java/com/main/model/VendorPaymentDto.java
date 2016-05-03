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
public class VendorPaymentDto {
    String id,mode,narration,bankname,chequenumber,chequedate,transactionnumber,transactiondate;

    public VendorPaymentDto(String id, String mode, String narration, String bankname, String chequenumber, String chequedate, String transactionnumber, String transactiondate) {
        this.id = id;
        this.mode = mode;
        this.narration = narration;
        this.bankname = bankname;
        this.chequenumber = chequenumber;
        this.chequedate = chequedate;
        this.transactionnumber = transactionnumber;
        this.transactiondate = transactiondate;
    }

    public VendorPaymentDto() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public String getNarration() {
        return narration;
    }

    public void setNarration(String narration) {
        this.narration = narration;
    }

    public String getBankname() {
        return bankname;
    }

    public void setBankname(String bankname) {
        this.bankname = bankname;
    }

    public String getChequenumber() {
        return chequenumber;
    }

    public void setChequenumber(String chequenumber) {
        this.chequenumber = chequenumber;
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
    
    
    
}
