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
@Entity(name = "ledger")
@Table(name = "ledger")
public class Ledger {
    @Id
    private String id;
    private String accountname,ledgergroupid,ledger_type,customerid,isdelete="No",modifydate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public Ledger(String id, String accountname, String ledgergroupid, String ledger_type, String customerid) {
        this.id = id;
        this.accountname = accountname;
        this.ledgergroupid = ledgergroupid;
        this.ledger_type = ledger_type;
        this.customerid = customerid;
    }

    public String getCustomerid() {
        return customerid;
    }

    public void setCustomerid(String customerid) {
        this.customerid = customerid;
    }
    
    public String getLedger_type() {
        return ledger_type;
    }

    public void setLedger_type(String ledger_type) {
        this.ledger_type = ledger_type;
    }
       
    public String getAccountname() {
        return accountname;
    }

    public void setAccountname(String accountname) {
        this.accountname = accountname;
    }
   
    public String getLedgergroupid() {
        return ledgergroupid;
    }

    public void setLedgergroupid(String ledgergroupid) {
        this.ledgergroupid = ledgergroupid;
    }   

    public Ledger() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
