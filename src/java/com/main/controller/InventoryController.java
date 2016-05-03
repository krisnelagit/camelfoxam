/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.main.model.Inventory;
import com.main.model.InventoryVendor;
import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author manish
 */
@Controller
@PropertySource("classpath:keyidconfig.properties")
public class InventoryController {

    @Autowired
    AllUpdateService updateService;

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    Environment env;

    //inserts to inventory
    @RequestMapping(value = "insertinventory", method = RequestMethod.POST)
    public String insertinventory(@ModelAttribute Inventory inventory, @RequestParam(value = "branddetailid") String branddetailid) {
        String pre = env.getProperty("inventory");
        String id = pre + insertService.getmaxcount("inventory", "id", 4);
        inventory.setId(id);
        inventory.setSold("No");
        inventory.setSell_qty(inventory.getQuantity());
        insertService.insert(inventory);
        List<Map<String, Object>> qty = viewService.getanyjdbcdatalist("Select balancequantity from carpartinfo where id='" + inventory.getPartid() + "' and isdelete='No'");
        int a, temp;
        temp = Integer.parseInt(qty.get(0).get("balancequantity").toString());
        a = temp + Integer.parseInt(inventory.getQuantity());
        updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + a + "',modifydate=now() where id='" + inventory.getPartid() + "'");
        //codefor NA parts begins! here
        List<Inventory> outwardNaList = viewService.getanyhqldatalist("from inventory where isdelete='No' and partid='" + inventory.getPartid() + "' and manufacturerid='" + inventory.getManufacturerid() + "' and vendor='NA' and type='outward'");
        if (outwardNaList.size() > 0) {
            for (int i = 0; i < outwardNaList.size(); i++) {
                //code for inventory outward
                Inventory inventory2 = new Inventory();
                inventory2.setPartid(inventory.getPartid());
                inventory2.setInvoiceid(outwardNaList.get(i).getInvoiceid());
                inventory2.setType("outward");
                inventory2.setSellingprice(outwardNaList.get(i).getSellingprice());
                inventory2.setPartname(outwardNaList.get(i).getPartname());
                inventory2.setManufacturerid(outwardNaList.get(i).getManufacturerid());
                //if required then code for invsurance 
                inventory2.setTotal(outwardNaList.get(i).getTotal());
                List<Map<String, Object>> inwardSum = viewService.getanyjdbcdatalist("select sum(sell_qty) qtycount from inventory \n"
                        + "where isdelete='No' and partid='" + inventory.getPartid() + "' and manufacturerid='" + inventory.getManufacturerid() + "' and `type`='inward' and sold='No'");
                double inventorycount;
                if (inwardSum.get(0).get("qtycount") != null) {
                    inventorycount = Double.parseDouble(inwardSum.get(0).get("qtycount").toString());
                } else {
                    inventorycount = 0.0;
                }
                double invoicecount = Double.parseDouble(outwardNaList.get(i).getQuantity());
                double dummypartqty = invoicecount;
                if (invoicecount <= inventorycount) {
                    //all vendor list
                    List<Map<String, Object>> vendorList = viewService.getanyjdbcdatalist("select * from inventory \n"
                            + "where isdelete='No' and partid='" + inventory.getPartid() + "' and manufacturerid='" + inventory.getManufacturerid() + "' and `type`='inward' and sold='No'");

                    for (int j = 0; j < vendorList.size(); j++) {
                        //check if the invoice qty is less or greater than the inward qty.
                        String vendorid = vendorList.get(j).get("vendor").toString();
                        String inventoryids = vendorList.get(j).get("id").toString();
                        double usablequantity = Double.parseDouble(vendorList.get(j).get("sell_qty").toString());
                        //code for invoicedetails here
                        List<InventoryVendor> inventoryVendorList = viewService.getanyhqldatalist("from inventoryvendor where to_inventoryid='" + outwardNaList.get(i).getId() + "' and isdelete='No'");
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
                            iv.setInvoiceid(outwardNaList.get(i).getInvoiceid());
                            iv.setQuantity(String.valueOf(dummypartqty));
                            iv.setVendorid(vendorid);
                            iv.setInvoicedetailid(inventoryVendorList.get(0).getInvoicedetailid());
                            iv.setPartid(inventory.getPartid());
                            iv.setMfgid(inventory.getManufacturerid());
                            insertService.insert(iv);
                            inventory2.setQuantity(String.valueOf(dummypartqty));
                            dummypartqty = usablequantity - dummypartqty;
                            //updating inventory qty here
                            if (dummypartqty == 0) {
                                updateService.updateanyhqlquery("update inventory set sell_qty='" + dummypartqty + "', sold='Yes' where id='" + inventoryids + "'");
                            } else {
                                updateService.updateanyhqlquery("update inventory set sell_qty='" + dummypartqty + "', sold='No' where id='" + inventoryids + "'");
                            }
                            inventory2.setVendor(vendorid);
                            inventory2.setId(inventoryid);
                            insertService.insert(inventory2);
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
                            iv.setInvoiceid(outwardNaList.get(i).getInvoiceid());
                            iv.setQuantity(String.valueOf(usablequantity));
                            iv.setVendorid(vendorid);
                            iv.setInvoicedetailid(inventoryVendorList.get(0).getInvoicedetailid());
                            iv.setPartid(inventory.getPartid());
                            iv.setMfgid(inventory.getManufacturerid());
                            insertService.insert(iv);
                            inventory2.setQuantity(String.valueOf(usablequantity));
                            inventory2.setVendor(vendorid);
                            dummypartqty = dummypartqty - usablequantity;
                            updateService.updateanyhqlquery("update inventory set sell_qty='0.0', sold='Yes' where id='" + inventoryids + "'");
                            inventory2.setId(inventoryid);
                            insertService.insert(inventory2);
                        }
                        //code to delete entry 
                    }
                    //code to delete entry from inventory and inventoryvendor the N A entries
                    updateService.updateanyhqlquery("update inventoryvendor set isdelete='Yes',modifydate=now() where to_inventoryid='" + outwardNaList.get(i).getId() + "'");
                    updateService.updateanyhqlquery("update inventory set isdelete='Yes',modifydate=now() where id='" + outwardNaList.get(i).getId() + "'");
                }

            }
        }

        //codefor NA parts ends! here        
        return "redirect:inventoryqty?id=" + inventory.getPartid() + "&carmodel=" + branddetailid;
    }

}
