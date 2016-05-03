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
@Entity(name = "labourinventory")
@Table(name = "labourinventory")
public class LabourInventory {

    @Id
    private String id;
    private String serviceid, servicename, invoiceid, serviceinsurancepercent, companyinsurance, customerinsurance, description, total, isdelete = "No", modifydate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());

    public LabourInventory() {
    }

    public LabourInventory(String id, String serviceid, String servicename, String invoiceid, String serviceinsurancepercent, String companyinsurance, String customerinsurance, String description, String total) {
        this.id = id;
        this.serviceid = serviceid;
        this.servicename = servicename;
        this.invoiceid = invoiceid;
        this.serviceinsurancepercent = serviceinsurancepercent;
        this.companyinsurance = companyinsurance;
        this.customerinsurance = customerinsurance;
        this.description = description;
        this.total = total;
    }

    public String getServicename() {
        return servicename;
    }

    public void setServicename(String servicename) {
        this.servicename = servicename;
    }
        
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getServiceid() {
        return serviceid;
    }

    public void setServiceid(String serviceid) {
        this.serviceid = serviceid;
    }

    public String getInvoiceid() {
        return invoiceid;
    }

    public void setInvoiceid(String invoiceid) {
        this.invoiceid = invoiceid;
    }

    public String getServiceinsurancepercent() {
        return serviceinsurancepercent;
    }

    public void setServiceinsurancepercent(String serviceinsurancepercent) {
        this.serviceinsurancepercent = serviceinsurancepercent;
    }

    public String getCompanyinsurance() {
        return companyinsurance;
    }

    public void setCompanyinsurance(String companyinsurance) {
        this.companyinsurance = companyinsurance;
    }

    public String getCustomerinsurance() {
        return customerinsurance;
    }

    public void setCustomerinsurance(String customerinsurance) {
        this.customerinsurance = customerinsurance;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
