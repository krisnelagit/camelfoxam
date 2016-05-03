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
@Entity(name = "generalincome")
@Table(name = "generalincome")
public class GeneralIncome {
    @Id
    private String id;
    private String ledgerid,towards,carddetails="",tax,taxid,income_date,narration,tax_applicable,vat_tax,service_tax,vat_service_tax,invoiceid="",bank_accountid,status,amount,vouchernumber,total,mode,chequenumber="",bankname="",chequedate="",transactionnumber="",transactiondate="",isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public GeneralIncome(String id, String ledgerid, String towards, String tax, String taxid, String income_date, String narration, String tax_applicable, String vat_tax, String service_tax, String vat_service_tax, String bank_accountid, String status, String amount, String vouchernumber, String total, String mode) {
        this.id = id;
        this.ledgerid = ledgerid;
        this.towards = towards;
        this.tax = tax;
        this.taxid = taxid;
        this.income_date = income_date;
        this.narration = narration;
        this.tax_applicable = tax_applicable;
        this.vat_tax = vat_tax;
        this.service_tax = service_tax;
        this.vat_service_tax = vat_service_tax;
        this.bank_accountid = bank_accountid;
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

    public String getIncome_date() {
        return income_date;
    }

    public void setIncome_date(String income_date) {
        this.income_date = income_date;
    }

    public String getInvoiceid() {
        return invoiceid;
    }

    public void setInvoiceid(String invoiceid) {
        this.invoiceid = invoiceid;
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

    public GeneralIncome() {
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
