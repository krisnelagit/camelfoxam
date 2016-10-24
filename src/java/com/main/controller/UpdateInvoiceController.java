/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.main.model.CarPartInfo;
import com.main.model.Feedback;
import com.main.model.Inventory;
import com.main.model.InventoryArray;
import com.main.model.InventoryVendor;
import com.main.model.Invoice;
import com.main.model.InvoiceEdit;
import com.main.model.Invoicedetails;
import com.main.model.LabourInventory;
import com.main.model.ReminderCustomer;
import com.main.model.UpdateInventoryArray;
import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author manish
 */
@Controller
@PropertySource("classpath:keyidconfig.properties")
public class UpdateInvoiceController {

    @Autowired
    AllUpdateService updateService;

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    Environment env;

    //insert to invoice/labourinventory/inventory
    @RequestMapping(value = "updateInvoice")
    public String updateInvoice(@ModelAttribute Invoice invoice,
            @RequestParam(value = "loopvalue", required = false) int loopvalue,
            @RequestParam(value = "isapplicable", required = false) String isapplicable,
            @ModelAttribute InvoiceEdit editdto,
            @ModelAttribute InventoryArray inventoryArray,
            @ModelAttribute UpdateInventoryArray updateInventoryArray) {

        invoice.setBalanceamount(invoice.getAmountTotal());
        //1.code to set insurance details when no it is. begins here
        if (invoice.getIsinsurance().equals("No")) {
            invoice.setInsurancetype("");
            invoice.setCustomertotal("0");
            invoice.setCustomerinsuranceliability("0");
        }
        //code to set insurance details when no it is. ends! here

        //code to update balance amount if atleast one payment is made begin here
        List<Map<String, Object>> paidlist = viewService.getanyjdbcdatalist("SELECT sum(total) as alreadypaid FROM generalincome where invoiceid='" + invoice.getId() + "'");
        if (paidlist.get(0).get("alreadypaid") != null && paidlist.size() > 0) {
            double invoicetotal = Double.parseDouble(invoice.getAmountTotal());
            double paidamt = Double.parseDouble(paidlist.get(0).get("alreadypaid").toString());
            double balance;
            if (invoicetotal > paidamt) {
                balance = invoicetotal - paidamt;
                invoice.setBalanceamount(Double.toString(balance));
            }

            if (invoicetotal < paidamt) {
                invoice.setBalanceamount("0");
                balance = paidamt - invoicetotal;
                invoice.setSundry_debitors(Double.toString(balance));
                invoice.setIspaid("Yes");
            }
        } else {
            invoice.setBalanceamount(invoice.getAmountTotal());
        }
        //code to update balance amount if atleast one payment is made ends! here

        if (isapplicable.equals("Yes")) {
            invoice.setIstax("Yes");
            updateService.update(invoice);
        } else {
            double spare = Double.parseDouble(invoice.getSparepartsfinal());
            double service = Double.parseDouble(invoice.getLabourfinal());
            double result = spare + service;
            invoice.setTaxAmount1("0");
            invoice.setTaxAmount2("0");
            invoice.setAmountTotal("" + result);
            invoice.setCustomertotal("" + result);
            if (invoice.getInsurancetype().equals("Depreciation")) {
                invoice.setCustomerinsuranceliability("" + result);

            } else {
                invoice.setCustomerinsuranceliability("0");
            }
            invoice.setIstax("No");
            updateService.update(invoice);
        }

        //2.code to insert invoice edit begins here
        String prefix = env.getProperty("invoice_edit");
        String id = insertService.getmaxcount("invoice_edit", "id", 5);
        String maxCount = prefix + id;
        editdto.setId(maxCount);
        editdto.setInvoiceid(invoice.getId());
        insertService.insert(editdto);
        //code to insert invoice edit ends! here

        //3.code to first maintain quantity of carpartino begin here
        List<Invoicedetails> inventoryidsarray = viewService.getanyhqldatalist("from invoicedetails where invoiceid='" + invoice.getId() + "'");
        for (int i = 0; inventoryidsarray.size() > 0 && i < inventoryidsarray.size(); i++) {
//            Inventory inv = (Inventory) viewService.getspecifichqldata(Inventory.class, inventoryidsarray.get(i).getId());
            int qty = Integer.parseInt(inventoryidsarray.get(i).getQuantity());
            String partid = inventoryidsarray.get(i).getPartid();

            CarPartInfo c = (CarPartInfo) viewService.getspecifichqldata(CarPartInfo.class, partid);
            int avail = Integer.parseInt(c.getBalancequantity());

            int result = avail + qty;

            updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + result + "',modifydate=now() where id='" + partid + "'");
//            updateService.updateanyhqlquery("update  invoicedetails  set isdelete='yes',modifydate=now() where id='" + inventoryidsarray[i] + "'");
        }
        //code to first maintain quantity of carpartino ends! here

        double vattax = Double.parseDouble(invoice.getTaxpercent1());
        double servicetax = Double.parseDouble(invoice.getTaxpercent2());
        //4.this code updates old invoice part details as it is 
        for (int i = 0; inventoryArray.getPartid() != null && i < inventoryArray.getPartid().length; i++) {
            //code to update invoice details goes here
            Invoicedetails invoicedetails = new Invoicedetails();
            invoicedetails.setId(inventoryArray.getInvoicedetailid()[i]);
            invoicedetails.setPartid(inventoryArray.getPartid()[i]);
            invoicedetails.setInvoiceid(invoice.getId());
            invoicedetails.setType("outward");
            invoicedetails.setSellingprice(inventoryArray.getSellingprice()[i]);
            invoicedetails.setQuantity(inventoryArray.getPartQuantity()[i]);
            invoicedetails.setManufacturerid(inventoryArray.getManufacturerid()[i]);
            invoicedetails.setPartname(inventoryArray.getCarparts()[i]);
            if (invoice.getIsinsurance().equals("Yes")) {
                invoicedetails.setInsurancepercent(inventoryArray.getInsurancepercent()[i]);
                invoicedetails.setInsurancecustomeramount(inventoryArray.getInsurancecustomeramount()[i]);
                invoicedetails.setInsurancecompanyamount(inventoryArray.getInsurancecompanyamount()[i]);
                double amount = Double.parseDouble(inventoryArray.getInsurancecompanyamount()[i].toString());
                double taxes = amount * vattax / 100;
                double total = amount + taxes;
                invoicedetails.setBalance("" + total);
                invoicedetails.setPaidamount("0");
            }
            invoicedetails.setTotal(inventoryArray.getItemtotal()[i]);
            updateService.update(invoicedetails);

            //code to insert/update in inventory begins here
            //update into inventory
            Inventory inventory = new Inventory();
//            inventory.setId(inventoryArray.getOldinvid()[i]);
            inventory.setPartid(inventoryArray.getPartid()[i]);
            inventory.setType("outward");
            inventory.setInvoiceid(invoice.getId());
            inventory.setSellingprice(inventoryArray.getSellingprice()[i]);
//            inventory.setQuantity(inventoryArray.getPartQuantity()[i]);
            inventory.setPartname(inventoryArray.getCarparts()[i]);

            //code to revert part balance begins here
            int partqty = Integer.parseInt(inventoryArray.getPartQuantity()[i]);
            CarPartInfo c = (CarPartInfo) viewService.getspecifichqldata(CarPartInfo.class, inventoryArray.getPartid()[i]);
            int availableqty = Integer.parseInt(c.getBalancequantity());
            int result = availableqty - partqty;
            updateService.updateanyhqlquery("update carpartinfo  set balancequantity='" + result + "',modifydate=now() where id='" + inventoryArray.getPartid()[i] + "'");
            //code to revert part balance ends! here

            //code for insurance 
            inventory.setManufacturerid(inventoryArray.getManufacturerid()[i]);
            if (invoice.getIsinsurance().equals("Yes")) {
                inventory.setInsurancepercent(inventoryArray.getInsurancepercent()[i]);
                inventory.setInsurancecompanyamount(inventoryArray.getInsurancecompanyamount()[i]);
                inventory.setInsurancecustomeramount(inventoryArray.getInsurancecustomeramount()[i]);
            }
            inventory.setTotal(inventoryArray.getItemtotal()[i]);
            //code to update old part with quantity changes begins here  

            List<Map<String, Object>> inventoryVendorList = viewService.getanyjdbcdatalist("SELECT sum(quantity) qtycount FROM inventoryvendor \n"
                    + "where invoicedetailid='" + inventoryArray.getInvoicedetailid()[i] + "' and isdelete='No'");
            double oldvendorqty;
            if (inventoryVendorList.get(0).get("qtycount") != null) {
                oldvendorqty = Double.parseDouble(inventoryVendorList.get(0).get("qtycount").toString());
            } else {
                oldvendorqty = 0.0;
            }
            double newpartqty = Double.parseDouble(inventoryArray.getPartQuantity()[i]);
            if (newpartqty <= oldvendorqty) {
                //if decreased here
                List<InventoryVendor> oldvendorList = viewService.getanyhqldatalist("from inventoryvendor where invoicedetailid='" + inventoryArray.getInvoicedetailid()[i] + "' and isdelete='No' order by savedate desc");
                double revertQty = oldvendorqty - newpartqty;

                for (int j = 0; j < oldvendorList.size(); j++) {
                    if (revertQty == 0) {
                        break;
                    }
                    //kitna revert karna hai ? calculated here
                    if (revertQty <= Double.parseDouble(oldvendorList.get(j).getQuantity())) {
                        updateService.updateanyhqlquery("update  inventoryvendor set quantity=quantity-'" + revertQty + "',modifydate=now() where id='" + oldvendorList.get(j).getId() + "'");
                        updateService.updateanyhqlquery("update  inventory set sell_qty=sell_qty+'" + revertQty + "',sold='No',modifydate=now() where id='" + oldvendorList.get(j).getFrom_inventoryid() + "'");
                        double updateqty = Double.parseDouble(oldvendorList.get(j).getQuantity()) - revertQty;
                        if (updateqty == 0) {
                            updateService.updateanyhqlquery("update  inventory set isdelete='Yes',modifydate=now() where id='" + oldvendorList.get(j).getTo_inventoryid() + "'");
                        } else {
                            updateService.updateanyhqlquery("update  inventory set quantity='" + updateqty + "',modifydate=now() where id='" + oldvendorList.get(j).getTo_inventoryid() + "'");
                        }
                        break;
                    } else {
                        revertQty = revertQty - Double.parseDouble(oldvendorList.get(j).getQuantity());
                        updateService.updateanyhqlquery("update  inventory set sell_qty=sell_qty+'" + Double.parseDouble(oldvendorList.get(j).getQuantity()) + "',sold='No',modifydate=now() where id='" + oldvendorList.get(j).getFrom_inventoryid() + "'");
                        if (revertQty == 0) {
                            updateService.updateanyhqlquery("update  inventory set quantity=quantity-'" + Double.parseDouble(oldvendorList.get(j).getQuantity()) + "',isdelete='Yes',modifydate=now() where id='" + oldvendorList.get(j).getTo_inventoryid() + "'");
                            updateService.updateanyhqlquery("update  inventoryvendor set quantity=quantity-'" + Double.parseDouble(oldvendorList.get(j).getQuantity()) + "',isdelete='Yes',modifydate=now() where id='" + oldvendorList.get(j).getTo_inventoryid() + "'");
                        } else {
                            updateService.updateanyhqlquery("update  inventory set quantity=quantity-'" + Double.parseDouble(oldvendorList.get(j).getQuantity()) + "',modifydate=now() where id='" + oldvendorList.get(j).getTo_inventoryid() + "'");
                            updateService.updateanyhqlquery("update  inventoryvendor set quantity=quantity-'" + Double.parseDouble(oldvendorList.get(j).getQuantity()) + "',modifydate=now() where id='" + oldvendorList.get(j).getTo_inventoryid() + "'");
                        }
                    }
                }
            } else if (newpartqty > oldvendorqty) {
                //it is increased
                //delete set isdelete yes for inventoryvendro table
                List<InventoryVendor> deleteinVendorList = viewService.getanyhqldatalist("from inventoryvendor where invoicedetailid='" + inventoryArray.getInvoicedetailid()[i] + "' and isdelete='No'");
                for (int j = 0; j < deleteinVendorList.size(); j++) {
                    //delete from inventoryvendor
                    updateService.updateanyhqlquery("update inventoryvendor set isdelete='Yes',modifydate=now() where id='" + deleteinVendorList.get(j).getId() + "'");
                    //update quantity revertback
                    //check if na qty increased?
                    if (!deleteinVendorList.get(j).getFrom_inventoryid().equals("NA")) {
                        Inventory inventory2 = (Inventory) viewService.getspecifichqldata(Inventory.class, deleteinVendorList.get(j).getFrom_inventoryid());
                        double available = Double.parseDouble(inventory2.getSell_qty());
                        double totalqty = available + Double.parseDouble(deleteinVendorList.get(j).getQuantity());
                        updateService.updateanyhqlquery("update inventory set sold='No',sell_qty='" + totalqty + "',modifydate=now() where id='" + deleteinVendorList.get(j).getFrom_inventoryid() + "'");
                    } 
                    //Delete the entry form inventory table outward.
                    updateService.updateanyhqlquery("update inventory set isdelete='Yes',modifydate=now() where id='" + deleteinVendorList.get(j).getTo_inventoryid() + "'");
                }
                //delete code ends here
                List<Map<String, Object>> invqtyList = viewService.getanyjdbcdatalist("SELECT sum(sell_qty) qtycount FROM inventory where partid='" + inventoryArray.getPartid()[i] + "' and manufacturerid='" + inventoryArray.getManufacturerid()[i] + "' and `type`='inward' and sold='No'  \n"
                        + "order by savedate ");
                double inventorycount;
                if (invqtyList.get(0).get("qtycount") != null) {
                    inventorycount = Double.parseDouble(invqtyList.get(0).get("qtycount").toString());
                } else {
                    inventorycount = 0.0;
                }

                double invoicecount = Double.parseDouble(inventoryArray.getPartQuantity()[i]);
                double dummypartqty = invoicecount;

                if (invoicecount <= inventorycount) {
                    //all vendor list
                    List<Map<String, Object>> vendorList = viewService.getanyjdbcdatalist("SELECT * from inventory where partid='" + inventoryArray.getPartid()[i] + "' and manufacturerid='" + inventoryArray.getManufacturerid()[i] + "' and `type`='inward' and sold='No'  \n"
                            + "order by savedate ");
                    for (int j = 0; j < vendorList.size(); j++) {
                        //check if the invoice qty is less or greater than the inward qty.
                        String vendorid = vendorList.get(j).get("vendor").toString();
                        String inventoryids = vendorList.get(j).get("id").toString();
                        double usablequantity = Double.parseDouble(vendorList.get(j).get("sell_qty").toString());
                        //check if variable is less than available qty    
                        if (dummypartqty <= usablequantity) {
                            //insert into inventory vendor table for edit invoice use only
                            String prefix2 = env.getProperty("inventory");
                            String inventoryid = prefix2 + insertService.getmaxcount("inventory", "id", 4);
                            InventoryVendor iv = new InventoryVendor();
                            String invvendorId = env.getProperty("inventoryvendor");
                            String prefixInvvendorId = invvendorId + insertService.getmaxcount("inventoryvendor", "id", 5);
                            iv.setId(prefixInvvendorId);
                            iv.setFrom_inventoryid(vendorList.get(j).get("id").toString());
                            iv.setTo_inventoryid(inventoryid);
                            iv.setInvoiceid(invoice.getId());
                            iv.setQuantity(String.valueOf(dummypartqty));
                            iv.setVendorid(vendorid);
                            iv.setInvoicedetailid(inventoryArray.getInvoicedetailid()[i]);
                            iv.setPartid(inventoryArray.getPartid()[i]);
                            iv.setMfgid(inventoryArray.getManufacturerid()[i]);
                            insertService.insert(iv);
                            inventory.setQuantity(String.valueOf(dummypartqty));
                            dummypartqty = usablequantity - dummypartqty;
                            //updating inventory qty here
                            if (dummypartqty == 0) {
                                updateService.updateanyhqlquery("update inventory set sell_qty='" + dummypartqty + "', sold='Yes',modifydate=now() where id='" + inventoryids + "'");
                            } else {
                                updateService.updateanyhqlquery("update inventory set sell_qty='" + dummypartqty + "', sold='No',modifydate=now() where id='" + inventoryids + "'");
                            }
                            inventory.setVendor(vendorid);
                            inventory.setId(inventoryid);

                            updateService.update(inventory);
                            break;
                        } else {
                            //insert into inventory vendor table for edit invoice use only
                            String prefix2 = env.getProperty("inventory");
                            String inventoryid = prefix2 + insertService.getmaxcount("inventory", "id", 4);
                            InventoryVendor iv = new InventoryVendor();
                            String invvendorId = env.getProperty("inventoryvendor");
                            String prefixInvvendorId = invvendorId + insertService.getmaxcount("inventoryvendor", "id", 5);
                            iv.setId(prefixInvvendorId);
                            iv.setFrom_inventoryid(vendorList.get(j).get("id").toString());
                            iv.setTo_inventoryid(inventoryid);
                            iv.setInvoiceid(invoice.getId());
                            iv.setQuantity(String.valueOf(usablequantity));
                            iv.setVendorid(vendorid);
                            iv.setInvoicedetailid(inventoryArray.getInvoicedetailid()[i]);
                            iv.setPartid(inventoryArray.getPartid()[i]);
                            iv.setMfgid(inventoryArray.getManufacturerid()[i]);
                            insertService.insert(iv);
                            inventory.setQuantity(String.valueOf(usablequantity));
                            inventory.setVendor(vendorid);
                            dummypartqty = dummypartqty - usablequantity;
                            updateService.updateanyhqlquery("update inventory set sell_qty='0.0', sold='Yes',modifydate=now() where id='" + inventoryids + "'");

                            inventory.setId(inventoryid);
                            updateService.update(inventory);
                        }
                    }
                } else {
                    inventory.setQuantity(inventoryArray.getPartQuantity()[i]);
                    String prefix2 = env.getProperty("inventory");
                    String inventoryid = prefix2 + insertService.getmaxcount("inventory", "id", 4);
                    inventory.setId(inventoryid);
                    inventory.setQuantity(inventoryArray.getPartQuantity()[i]);
                    inventory.setVendor("NA");
                    updateService.update(inventory);
                }
            }
            //code to update old part with quantity changes ends! here
            //code to insert/update in inventory ends! here
            //Nitz
        }

        //5.code beelow updates old service 
        for (int i = 0; i < loopvalue; i++) {
            //update into labour inventory
            LabourInventory labourInventory = new LabourInventory();
            labourInventory.setId(inventoryArray.getOldlabourinvid()[i]);
            labourInventory.setInvoiceid(invoice.getId());
            labourInventory.setServicename(inventoryArray.getServicename()[i]);
            if (inventoryArray.getServiceid().length != 0 || inventoryArray.getServiceid().length > 0) {
                labourInventory.setServiceid(inventoryArray.getServiceid()[i]);
            }
            if (inventoryArray.getDescription().length > 0 || inventoryArray.getDescription().length != 0) {
                labourInventory.setDescription(inventoryArray.getDescription()[i]);
            }

            if (invoice.getIsinsurance().equals("Yes")) {
                labourInventory.setServiceinsurancepercent(inventoryArray.getServiceinsurancepercent()[i]);
                labourInventory.setCompanyinsurance(inventoryArray.getCompanyinsuranceservice()[i]);
                labourInventory.setCustomerinsurance(inventoryArray.getCustinsuranceservice()[i]);
                double amount = Double.parseDouble(inventoryArray.getCompanyinsuranceservice()[i].toString());
                double taxes = amount * servicetax / 100;
                double total = amount + taxes;
                labourInventory.setBalance("" + total);
                labourInventory.setPaidamount("0");
            }
            labourInventory.setTotal(inventoryArray.getServicetotal()[i]);
            updateService.update(labourInventory);
        }

        //6.code beelow adds new service insert
        if (updateInventoryArray.getNewserviceid() != null) {
            for (int i = 0; i < updateInventoryArray.getNewserviceid().length; i++) {
                //inserts into labour inventory
                LabourInventory labourInventory = new LabourInventory();
                String prefix2 = env.getProperty("labourinventory");
                String labourInventoryid = prefix2 + insertService.getmaxcount("labourinventory", "id", 5);
                labourInventory.setId(labourInventoryid);
                labourInventory.setInvoiceid(invoice.getId());
                labourInventory.setServiceid(updateInventoryArray.getNewserviceid()[i]);
                labourInventory.setServicename(updateInventoryArray.getNewservicename()[i]);
                labourInventory.setDescription(updateInventoryArray.getNewdescription()[i]);
                if (invoice.getIsinsurance().equals("Yes")) {
                    labourInventory.setServiceinsurancepercent(updateInventoryArray.getNewserviceinsurancepercent()[i]);
                    labourInventory.setCompanyinsurance(updateInventoryArray.getNewcompanyinsuranceservice()[i]);
                    labourInventory.setCustomerinsurance(updateInventoryArray.getNewcustinsuranceservice()[i]);
                    double amount = Double.parseDouble(updateInventoryArray.getNewcustinsuranceservice()[i].toString());
                    double taxes = amount * servicetax / 100;
                    double total = amount + taxes;
                    labourInventory.setBalance("" + total);
                    labourInventory.setPaidamount("0");
                }
                labourInventory.setTotal(updateInventoryArray.getNewservicetotal()[i]);
                insertService.insert(labourInventory);
            }
        }

        //7.this code updates old invoice with new part details as it is 
        if (updateInventoryArray.getNewpartid() != null) {
            for (int i = 0; i < updateInventoryArray.getNewpartid().length; i++) {
                //insert in invoice details goes here begins!
                Invoicedetails invoicedetails = new Invoicedetails();
                String prefix3 = env.getProperty("invoicedetails");
                String invoicedetailid = prefix3 + insertService.getmaxcount("invoicedetails", "id", 5);
                invoicedetails.setId(invoicedetailid);
                invoicedetails.setPartid(updateInventoryArray.getNewpartid()[i]);
                invoicedetails.setInvoiceid(invoice.getInvoiceid());
                invoicedetails.setType("outward");
                invoicedetails.setSellingprice(Float.parseFloat(updateInventoryArray.getNewsellingprice()[i]));
                invoicedetails.setQuantity(updateInventoryArray.getNewpartQuantity()[i]);
                invoicedetails.setManufacturerid(updateInventoryArray.getNewmanufacturerid()[i]);
                invoicedetails.setPartname(updateInventoryArray.getNewcarparts()[i]);
                if (invoice.getIsinsurance().equals("Yes")) {
                    invoicedetails.setInsurancepercent(updateInventoryArray.getNewinsurancepercent()[i]);
                    invoicedetails.setInsurancecustomeramount(updateInventoryArray.getNewinsurancecustomeramount()[i]);
                    invoicedetails.setInsurancecompanyamount(updateInventoryArray.getNewinsurancecompanyamount()[i]);
                    double amount = Double.parseDouble(updateInventoryArray.getNewinsurancecompanyamount()[i].toString());
                    double taxes = amount * vattax / 100;
                    double total = amount + taxes;
                    invoicedetails.setBalance("" + total);
                    invoicedetails.setPaidamount("0");
                }
                invoicedetails.setTotal(updateInventoryArray.getNewitemtotal()[i]);
                insertService.insert(invoicedetails);
                //insert in invoice details goes here ends!
                //inserts into inventory
                Inventory inventory = new Inventory();
                inventory.setPartid(updateInventoryArray.getNewpartid()[i]);
                inventory.setInvoiceid(invoice.getId());
                inventory.setType("outward");
                inventory.setSellingprice(Float.parseFloat(updateInventoryArray.getNewsellingprice()[i]));
                inventory.setPartname(updateInventoryArray.getNewcarparts()[i]);
//                String prefix2 = env.getProperty("inventory");
//                String inventoryid = prefix2 + insertService.getmaxcount("inventory", "id", 4);
//                inventory.setId(inventoryid);

//                inventory.setQuantity(updateInventoryArray.getNewpartQuantity()[i]);
                int partqty = Integer.parseInt(updateInventoryArray.getNewpartQuantity()[i]);
                CarPartInfo c = (CarPartInfo) viewService.getspecifichqldata(CarPartInfo.class, updateInventoryArray.getNewpartid()[i]);
                int availableqty = Integer.parseInt(c.getBalancequantity());
                int result = availableqty - partqty;
                updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + result + "',modifydate=now() where id='" + updateInventoryArray.getNewpartid()[i] + "'");
                inventory.setManufacturerid(updateInventoryArray.getNewmanufacturerid()[i]);
                if (invoice.getIsinsurance().equals("Yes")) {
                    inventory.setInsurancepercent(updateInventoryArray.getNewinsurancepercent()[i]);
                    inventory.setInsurancecompanyamount(updateInventoryArray.getNewinsurancecompanyamount()[i]);
                    inventory.setInsurancecustomeramount(updateInventoryArray.getNewinsurancecustomeramount()[i]);
                }
                inventory.setTotal(updateInventoryArray.getNewitemtotal()[i]);
                //code to find the vendor for this outward begins here
                List<Map<String, Object>> invqtyList = viewService.getanyjdbcdatalist("SELECT sum(sell_qty) qtycount FROM inventory where partid='" + updateInventoryArray.getNewpartid()[i] + "' and manufacturerid='" + updateInventoryArray.getNewmanufacturerid()[i] + "' and `type`='inward' and sold='No'  \n"
                        + "order by savedate ");
                double inventorycount;
                if (invqtyList.get(0).get("qtycount") != null) {
                    inventorycount = Double.parseDouble(invqtyList.get(0).get("qtycount").toString());
                } else {
                    inventorycount = 0.0;
                }
                double invoicecount = Double.parseDouble(updateInventoryArray.getNewpartQuantity()[i]);
                double dummypartqty = invoicecount;
                if (invoicecount <= inventorycount) {
                    //all vendor list
                    List<Map<String, Object>> vendorList = viewService.getanyjdbcdatalist("SELECT * from inventory where partid='" + updateInventoryArray.getNewpartid()[i] + "' and manufacturerid='" + updateInventoryArray.getNewmanufacturerid()[i] + "' and `type`='inward' and sold='No'  \n"
                            + "order by savedate ");
                    for (int j = 0; j < vendorList.size(); j++) {
                        //check if the invoice qty is less or greater than the inward qty.
                        String vendorid = vendorList.get(j).get("vendor").toString();
                        String inventoryids = vendorList.get(j).get("id").toString();
                        double usablequantity = Double.parseDouble(vendorList.get(j).get("sell_qty").toString());
                        //check if variable is less than available qty
                        if (dummypartqty <= usablequantity) {
                            //insert into inventory vendor table for edit invoice use only
                            String prefix2 = env.getProperty("inventory");
                            String inventoryid = prefix2 + insertService.getmaxcount("inventory", "id", 4);
                            InventoryVendor iv = new InventoryVendor();
                            String invvendorId = env.getProperty("inventoryvendor");
                            String prefixInvvendorId = invvendorId + insertService.getmaxcount("inventoryvendor", "id", 5);
                            iv.setId(prefixInvvendorId);
                            iv.setFrom_inventoryid(vendorList.get(j).get("id").toString());
                            iv.setTo_inventoryid(inventoryid);
                            iv.setInvoiceid(invoice.getId());
                            iv.setQuantity(String.valueOf(dummypartqty));
                            iv.setVendorid(vendorid);
                            iv.setInvoicedetailid(invoicedetailid);
                            iv.setPartid(updateInventoryArray.getNewpartid()[i]);
                            iv.setMfgid(updateInventoryArray.getNewmanufacturerid()[i]);
                            insertService.insert(iv);
                            inventory.setQuantity(String.valueOf(dummypartqty));
                            dummypartqty = usablequantity - dummypartqty;
                            //updating inventory qty here
                            if (dummypartqty == 0) {
                                updateService.updateanyhqlquery("update inventory set sell_qty='" + dummypartqty + "', sold='Yes' where id='" + inventoryids + "'");
                            } else {
                                updateService.updateanyhqlquery("update inventory set sell_qty='" + dummypartqty + "', sold='No' where id='" + inventoryids + "'");
                            }
                            inventory.setVendor(vendorid);
                            inventory.setId(inventoryid);
                            insertService.insert(inventory);
                            break;
                        } else {
                            //insert into inventory vendor table for edit invoice use only
                            String prefix2 = env.getProperty("inventory");
                            String inventoryid = prefix2 + insertService.getmaxcount("inventory", "id", 4);
                            InventoryVendor iv = new InventoryVendor();
                            String invvendorId = env.getProperty("inventoryvendor");
                            String prefixInvvendorId = invvendorId + insertService.getmaxcount("inventoryvendor", "id", 5);
                            iv.setId(prefixInvvendorId);
                            iv.setFrom_inventoryid(vendorList.get(j).get("id").toString());
                            iv.setTo_inventoryid(inventoryid);
                            iv.setInvoiceid(invoice.getId());
                            iv.setQuantity(String.valueOf(usablequantity));
                            iv.setVendorid(vendorid);
                            iv.setInvoicedetailid(invoicedetailid);
                            iv.setPartid(updateInventoryArray.getNewpartid()[i]);
                            iv.setMfgid(updateInventoryArray.getNewmanufacturerid()[i]);
                            insertService.insert(iv);
                            inventory.setQuantity(String.valueOf(usablequantity));
                            inventory.setVendor(vendorid);
                            dummypartqty = dummypartqty - usablequantity;
                            updateService.updateanyhqlquery("update inventory set sell_qty='0.0', sold='Yes' where id='" + inventoryids + "'");
                            inventory.setId(inventoryid);
                            insertService.insert(inventory);
                        }
                    }
                } else {
                    inventory.setQuantity(updateInventoryArray.getNewpartQuantity()[i]);
                    String prefix2 = env.getProperty("inventory");
                    String inventoryid = prefix2 + insertService.getmaxcount("inventory", "id", 4);
                    //also necessary to insert in inventory vendor table ?

                    inventory.setId(inventoryid);
                    inventory.setVendor("NA");
                    insertService.insert(inventory);
                    InventoryVendor iv = new InventoryVendor();
                    String invvendorId = env.getProperty("inventoryvendor");
                    String prefixInvvendorId = invvendorId + insertService.getmaxcount("inventoryvendor", "id", 5);
                    iv.setId(prefixInvvendorId);
                    iv.setFrom_inventoryid("NA");
                    iv.setTo_inventoryid(inventoryid);
                    iv.setInvoiceid(invoice.getId());
                    iv.setQuantity(updateInventoryArray.getNewpartQuantity()[i]);
                    iv.setVendorid("NA");
                    iv.setInvoicedetailid(invoicedetailid);
                    iv.setPartid(updateInventoryArray.getNewpartid()[i]);
                    iv.setMfgid(updateInventoryArray.getNewmanufacturerid()[i]);
                    insertService.insert(iv);
                }
                //code to find the vendor for this outward ends! here
            }
        }
        return "redirect:invoiceMasterLink";
    }

}
