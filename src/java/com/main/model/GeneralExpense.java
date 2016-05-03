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
@Entity(name = "generalexpense")
@Table(name = "generalexpense")
public class GeneralExpense {
    @Id
    private String id;
    private String ledgerid,towards,tax,taxid,bank_accountid,expense_billnumber,bill_date,tax_applicable,subadminapproval,acceptance,narration,expense_date,vat_tax="0",service_tax="0",vat_service_tax="0",status,amount,vouchernumber,total,mode,chequenumber="",bankname="",chequedate="",transactionnumber="",transactiondate="",carddetails="",purchaseorderid="",isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public GeneralExpense(String id, String ledgerid, String towards, String tax, String taxid, String bank_accountid, String expense_billnumber, String bill_date, String tax_applicable, String subadminapproval, String acceptance, String narration, String expense_date, String status, String amount, String vouchernumber, String total, String mode) {
        this.id = id;
        this.ledgerid = ledgerid;
        this.towards = towards;
        this.tax = tax;
        this.taxid = taxid;
        this.bank_accountid = bank_accountid;
        this.expense_billnumber = expense_billnumber;
        this.bill_date = bill_date;
        this.tax_applicable = tax_applicable;
        this.subadminapproval = subadminapproval;
        this.acceptance = acceptance;
        this.narration = narration;
        this.expense_date = expense_date;
        this.status = status;
        this.amount = amount;
        this.vouchernumber = vouchernumber;
        this.total = total;
        this.mode = mode;
    }

    public String getCarddetails() {
        return carddetails;
    }

    public void setCarddetails(String carddetails) {
        this.carddetails = carddetails;
    }
    
    public String getExpense_billnumber() {
        return expense_billnumber;
    }

    public void setExpense_billnumber(String expense_billnumber) {
        this.expense_billnumber = expense_billnumber;
    }

    public String getBill_date() {
        return bill_date;
    }

    public void setBill_date(String bill_date) {
        this.bill_date = bill_date;
    }
    
    public String getAcceptance() {
        return acceptance;
    }

    public void setAcceptance(String acceptance) {
        this.acceptance = acceptance;
    }
    
    public String getSubadminapproval() {
        return subadminapproval;
    }

    public void setSubadminapproval(String subadminapproval) {
        this.subadminapproval = subadminapproval;
    }    

    public String getNarration() {
        return narration;
    }

    public void setNarration(String narration) {
        this.narration = narration;
    }
    
    public String getVat_tax() {
        return vat_tax;
    }

    public void setVat_tax(String vat_tax) {
        this.vat_tax = vat_tax;
    }

    public String getService_tax() {
        return service_tax;
    }

    public void setService_tax(String service_tax) {
        this.service_tax = service_tax;
    }

    public String getVat_service_tax() {
        return vat_service_tax;
    }

    public void setVat_service_tax(String vat_service_tax) {
        this.vat_service_tax = vat_service_tax;
    }        

    public String getTax_applicable() {
        return tax_applicable;
    }

    public void setTax_applicable(String tax_applicable) {
        this.tax_applicable = tax_applicable;
    }

    

    public String getBank_accountid() {
        return bank_accountid;
    }

    public void setBank_accountid(String bank_accountid) {
        this.bank_accountid = bank_accountid;
    }

    

    public String getExpense_date() {
        return expense_date;
    }

    public void setExpense_date(String expense_date) {
        this.expense_date = expense_date;
    }    

    public String getTaxid() {
        return taxid;
    }

    public void setTaxid(String taxid) {
        this.taxid = taxid;
    }   

    public String getVouchernumber() {
        return vouchernumber;
    }

    public void setVouchernumber(String vouchernumber) {
        this.vouchernumber = vouchernumber;
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

    public String getPurchaseorderid() {
        return purchaseorderid;
    }

    public void setPurchaseorderid(String purchaseorderid) {
        this.purchaseorderid = purchaseorderid;
    }
    
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }    

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }
        
    public String getTowards() {
        return towards;
    }

    public void setTowards(String towards) {
        this.towards = towards;
    } 

    public GeneralExpense() {
    }
        
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLedgerid() {
        return ledgerid;
    }

    public void setLedgerid(String ledgerid) {
        this.ledgerid = ledgerid;
    }

    public String getTax() {
        return tax;
    }

    public void setTax(String tax) {
        this.tax = tax;
    }    

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
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
