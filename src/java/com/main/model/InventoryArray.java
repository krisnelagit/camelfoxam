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
public class InventoryArray {

    private String[] serviceid,serviceAction, companyinsuranceservice, servicetotal, custinsuranceservice, partid, itemtotal, manufacturerid, partQuantity, insurancepercent, insurancecompanyamount, insurancecustomeramount, servicename,carparts, description, labourcharges, serviceinsurancepercent, insuranceservicecustomeramount, insuranceservicecompanyamount, oldinvid, oldlabourinvid,invoicedetailid;
    private float[] sellingprice;

    public InventoryArray() {
    }

    public InventoryArray(String[] serviceid, String[] serviceAction, String[] companyinsuranceservice, String[] servicetotal, String[] custinsuranceservice, String[] partid, String[] itemtotal, String[] manufacturerid, String[] partQuantity, String[] insurancepercent, String[] insurancecompanyamount, String[] insurancecustomeramount, String[] servicename, String[] carparts, String[] description, String[] labourcharges, String[] serviceinsurancepercent, String[] insuranceservicecustomeramount, String[] insuranceservicecompanyamount, String[] oldinvid, String[] oldlabourinvid, String[] invoicedetailid, float[] sellingprice) {
        this.serviceid = serviceid;
        this.serviceAction = serviceAction;
        this.companyinsuranceservice = companyinsuranceservice;
        this.servicetotal = servicetotal;
        this.custinsuranceservice = custinsuranceservice;
        this.partid = partid;
        this.itemtotal = itemtotal;
        this.manufacturerid = manufacturerid;
        this.partQuantity = partQuantity;
        this.insurancepercent = insurancepercent;
        this.insurancecompanyamount = insurancecompanyamount;
        this.insurancecustomeramount = insurancecustomeramount;
        this.servicename = servicename;
        this.carparts = carparts;
        this.description = description;
        this.labourcharges = labourcharges;
        this.serviceinsurancepercent = serviceinsurancepercent;
        this.insuranceservicecustomeramount = insuranceservicecustomeramount;
        this.insuranceservicecompanyamount = insuranceservicecompanyamount;
        this.oldinvid = oldinvid;
        this.oldlabourinvid = oldlabourinvid;
        this.invoicedetailid = invoicedetailid;
        this.sellingprice = sellingprice;
    }

    public String[] getInvoicedetailid() {
        return invoicedetailid;
    }

    public void setInvoicedetailid(String[] invoicedetailid) {
        this.invoicedetailid = invoicedetailid;
    }

    

    public String[] getCarparts() {
        return carparts;
    }

    public void setCarparts(String[] carparts) {
        this.carparts = carparts;
    }

    
    public float[] getSellingprice() {
        return sellingprice;
    }

    public void setSellingprice(float[] sellingprice) {
        this.sellingprice = sellingprice;
    }
        
    public String[] getServiceAction() {
        return serviceAction;
    }

    public void setServiceAction(String[] serviceAction) {
        this.serviceAction = serviceAction;
    }
    
    public InventoryArray(String[] oldinvid, String[] oldlabourinvid) {
        this.oldinvid = oldinvid;
        this.oldlabourinvid = oldlabourinvid;
    }

    public String[] getPartid() {
        return partid;
    }

    public void setPartid(String[] partid) {
        this.partid = partid;
    }

    public String[] getManufacturerid() {
        return manufacturerid;
    }

    public void setManufacturerid(String[] manufacturerid) {
        this.manufacturerid = manufacturerid;
    }

    public String[] getPartQuantity() {
        return partQuantity;
    }

    public void setPartQuantity(String[] partQuantity) {
        this.partQuantity = partQuantity;
    }

    public String[] getInsurancepercent() {
        return insurancepercent;
    }

    public void setInsurancepercent(String[] insurancepercent) {
        this.insurancepercent = insurancepercent;
    }

    public String[] getInsurancecompanyamount() {
        return insurancecompanyamount;
    }

    public void setInsurancecompanyamount(String[] insurancecompanyamount) {
        this.insurancecompanyamount = insurancecompanyamount;
    }

    public String[] getInsurancecustomeramount() {
        return insurancecustomeramount;
    }

    public void setInsurancecustomeramount(String[] insurancecustomeramount) {
        this.insurancecustomeramount = insurancecustomeramount;
    }

    public String[] getServicename() {
        return servicename;
    }

    public void setServicename(String[] servicename) {
        this.servicename = servicename;
    }

    public String[] getDescription() {
        return description;
    }

    public void setDescription(String[] description) {
        this.description = description;
    }

    public String[] getLabourcharges() {
        return labourcharges;
    }

    public void setLabourcharges(String[] labourcharges) {
        this.labourcharges = labourcharges;
    }

    public String[] getServiceinsurancepercent() {
        return serviceinsurancepercent;
    }

    public void setServiceinsurancepercent(String[] serviceinsurancepercent) {
        this.serviceinsurancepercent = serviceinsurancepercent;
    }

    public String[] getInsuranceservicecustomeramount() {
        return insuranceservicecustomeramount;
    }

    public void setInsuranceservicecustomeramount(String[] insuranceservicecustomeramount) {
        this.insuranceservicecustomeramount = insuranceservicecustomeramount;
    }

    public String[] getInsuranceservicecompanyamount() {
        return insuranceservicecompanyamount;
    }

    public void setInsuranceservicecompanyamount(String[] insuranceservicecompanyamount) {
        this.insuranceservicecompanyamount = insuranceservicecompanyamount;
    }

    public String[] getItemtotal() {
        return itemtotal;
    }

    public void setItemtotal(String[] itemtotal) {
        this.itemtotal = itemtotal;
    }

    public String[] getServiceid() {
        return serviceid;
    }

    public void setServiceid(String[] serviceid) {
        this.serviceid = serviceid;
    }

    public String[] getCompanyinsuranceservice() {
        return companyinsuranceservice;
    }

    public void setCompanyinsuranceservice(String[] companyinsuranceservice) {
        this.companyinsuranceservice = companyinsuranceservice;
    }

    public String[] getServicetotal() {
        return servicetotal;
    }

    public void setServicetotal(String[] servicetotal) {
        this.servicetotal = servicetotal;
    }

    public String[] getCustinsuranceservice() {
        return custinsuranceservice;
    }

    public void setCustinsuranceservice(String[] custinsuranceservice) {
        this.custinsuranceservice = custinsuranceservice;
    }

    public String[] getOldinvid() {
        return oldinvid;
    }

    public void setOldinvid(String[] oldinvid) {
        this.oldinvid = oldinvid;
    }

    public String[] getOldlabourinvid() {
        return oldlabourinvid;
    }

    public void setOldlabourinvid(String[] oldlabourinvid) {
        this.oldlabourinvid = oldlabourinvid;
    }

}
