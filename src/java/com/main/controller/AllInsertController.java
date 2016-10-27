/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.main.mailer.EmailSessionBean;
import com.main.mailer.UploadPdf;
import com.main.model.AllArrayPojo;
import com.main.model.Appointment;
import com.main.model.ApprovalLimit;
import com.main.model.BankAccount;
import com.main.model.Branch;
import com.main.model.Brand;
import com.main.model.BrandDetails;
import com.main.model.CarPartInfo;
import com.main.model.CarPartVault;
import com.main.model.CarParts;
import com.main.model.Category;
import com.main.model.ConsumableDetails;
import com.main.model.ConsumableDtoArray;
import com.main.model.Customer;
import com.main.model.CustomerAdvance;
import com.main.model.CustomerVehicles;
import com.main.model.CustomerVehiclesDeatils;
import com.main.model.Enquiries;
import com.main.model.Estimate;
import com.main.model.EstimateDetails;
import com.main.model.EstimateLabourArray;
import com.main.model.Feedback;
import com.main.model.Followups;
import com.main.model.GeneralExpense;
import com.main.model.GeneralIncome;
import com.main.model.Insurance;
import com.main.model.InsuranceCompany;
import com.main.model.Inventory;
import com.main.model.InventoryArray;
import com.main.model.InventoryTransfer;
import com.main.model.InventoryVendor;
import com.main.model.Invoice;
import com.main.model.Invoicedetails;
import com.main.model.Jobsheet;
import com.main.model.JobsheetDetails;
import com.main.model.LabourInventory;
import com.main.model.Manufacturer;
import com.main.model.LabourServices;
import com.main.model.Ledger;
import com.main.model.LedgerGroup;
import com.main.model.Payment;
import com.main.model.PointChecklist;
import com.main.model.PointChecklistDetails;
import com.main.model.PurchaseOrder;
import com.main.model.PurchaseOrderArray;
import com.main.model.PurchaseOrderArraySpares;
import com.main.model.PurchaseOrderReceived;
import com.main.model.PurchaseorderDetails;
import com.main.model.ReminderCustomer;
import com.main.model.TaskBoard;
import com.main.model.Taxes;
import com.main.model.Vendor;
import com.main.model.Workman;
import com.main.service.AllInsertService;
import com.main.service.AllUpdateService;
import com.main.service.AllViewService;
import java.io.File;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.Scope;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author krisnela
 */
//@propertys
@Controller
@PropertySource("classpath:keyidconfig.properties")
public class AllInsertController {

    @Autowired
    AllInsertService insertService;

    @Autowired
    AllViewService viewService;

    @Autowired
    AllUpdateService updateService;

    @Autowired
    Environment env;

//    String prefixcarpartvault = env.getProperty("carpartvault");
//    String prefixcarpartinfo = env.getProperty("carpartinfo");
//     String prefixcustomer = env.getProperty("customer");
//    String prefixcarpartvault=env.getProperty("carpartvault");
//    String prefixcarpartvault=env.getProperty("carpartvault");
    //insert to car parts
    @RequestMapping(value = "insertcarparts", method = RequestMethod.POST)
    public String insertcarparts(@ModelAttribute CarPartVault carPartVault) {
        String pre = env.getProperty("carpartvault");
        String id = pre + insertService.getmaxcount("carpartvault", "id", 5);
        carPartVault.setId(id);

        insertService.insert(carPartVault);

        //adds to brand for the new Car Part inserted
        List<BrandDetails> brandDetailsList = viewService.getanyhqldatalist("from branddetails where isdelete='No' and id not in ('" + env.getProperty("generic_brand_detailid") + "','" + env.getProperty("consumable_brand_detailid") + "')");
        for (int i = 0; i < brandDetailsList.size(); i++) {
            if (!brandDetailsList.get(i).getId().equals(env.getProperty("generic_brand_detailid"))) {
                CarPartInfo carPartInfo = new CarPartInfo();
                carPartInfo.setBranddetailid(brandDetailsList.get(i).getId());
                carPartInfo.setVaultid(id);
                String pre2 = env.getProperty("carpartinfo");
                String carPartInfoid = insertService.getmaxcount("carpartinfo", "id", 5);
                String maxCountCarPartInfoid = pre2 + carPartInfoid;
                carPartInfo.setId(maxCountCarPartInfoid);
                carPartInfo.setBalancequantity("0");
                insertService.insert(carPartInfo);
            }
        }

        return "redirect:viewVehicleList";
    }

    //insert to generic car parts
    @RequestMapping(value = "insertgenericcarparts", method = RequestMethod.POST)
    public String insertgenericcarparts(@ModelAttribute CarPartVault carPartVault) {
        String pre = env.getProperty("carpartvault");
        String id = pre + insertService.getmaxcount("carpartvault", "id", 5);
        carPartVault.setId(id);

        insertService.insert(carPartVault);

        //adds to brand for the new Car Part inserted
        CarPartInfo carPartInfo = new CarPartInfo();
        carPartInfo.setBranddetailid(env.getProperty("generic_brand_detailid"));
        carPartInfo.setVaultid(id);
        String pre2 = env.getProperty("carpartinfo");
        String carPartInfoid = insertService.getmaxcount("carpartinfo", "id", 5);
        String maxCountCarPartInfoid = pre2 + carPartInfoid;
        carPartInfo.setId(maxCountCarPartInfoid);
        carPartInfo.setBalancequantity("0");
        insertService.insert(carPartInfo);

        return "redirect:viewGenericVehicleList";
    }

    //insert to consumable car parts
    @RequestMapping(value = "insertconsumablecarparts", method = RequestMethod.POST)
    public String insertconsumablecarparts(@ModelAttribute CarPartVault carPartVault) {
        String pre = env.getProperty("carpartvault");
        String id = pre + insertService.getmaxcount("carpartvault", "id", 5);
        carPartVault.setId(id);

        insertService.insert(carPartVault);

        //adds to brand for the new consumable Car Part inserted
        CarPartInfo carPartInfo = new CarPartInfo();
        carPartInfo.setBranddetailid(env.getProperty("consumable_brand_detailid"));
        carPartInfo.setVaultid(id);
        String pre2 = env.getProperty("carpartinfo");
        String carPartInfoid = insertService.getmaxcount("carpartinfo", "id", 5);
        String maxCountCarPartInfoid = pre2 + carPartInfoid;
        carPartInfo.setId(maxCountCarPartInfoid);
        carPartInfo.setBalancequantity("0");
        insertService.insert(carPartInfo);

        return "redirect:viewConsumableVehicleList";
    }

//    //inserts to inventory
//    @RequestMapping(value = "insertinventory", method = RequestMethod.POST)
//    public String insertinventory(@ModelAttribute Inventory inventory, @RequestParam(value = "branddetailid") String branddetailid) {
//        String pre = env.getProperty("inventory");
//        String id = pre + insertService.getmaxcount("inventory", "id", 4);
//        inventory.setId(id);
//        insertService.insert(inventory);
//        List<Map<String, Object>> qty = viewService.getanyjdbcdatalist("Select balancequantity from carpartinfo where id='" + inventory.getPartid() + "' and isdelete='No'");
//        int a, temp;
//        temp = Integer.parseInt(qty.get(0).get("balancequantity").toString());
//        a = temp + Integer.parseInt(inventory.getQuantity());
//        updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + a + "',modifydate=now() where id='" + inventory.getPartid() + "'");
//
//        return "redirect:inventoryqty?id=" + inventory.getPartid() + "&carmodel=" + branddetailid;
//    }

    //internal transfer coding begin here
    @RequestMapping(value = "addinternalTransfer")
    public String addinternalTransfer(@RequestParam(value = "inventoryid") String inventoryid,
            @RequestParam(value = "vaultid") String vaultid,
            @RequestParam(value = "branddetailid") String branddetailid,
            @RequestParam(value = "transferquantity") String transferquantity,
            @RequestParam(value = "oldpartid") String oldpartid,
            @RequestParam(value = "oldquantity") String oldquantity) {

        //code to get carpartinfo from vaultid
        List<CarPartInfo> partlist = viewService.getanyhqldatalist("FROM carpartinfo where vaultid='" + vaultid + "' and branddetailid='" + branddetailid + "'");
        //code to get partid ends here

        //code to insert in inenory begin here
        List<Inventory> inventoryList = viewService.getanyhqldatalist("from inventory where id='" + inventoryid + "'");
        Inventory inventory = new Inventory();
        String pre = env.getProperty("inventory");
        String id = pre + insertService.getmaxcount("inventory", "id", 4);
        inventory.setId(id);
        inventory.setManufacturerid(inventoryList.get(0).getManufacturerid());
        inventory.setVendor(inventoryList.get(0).getVendor());
        inventory.setQuantity(transferquantity);
        inventory.setCostprice(inventoryList.get(0).getCostprice());
        inventory.setSellingprice(inventoryList.get(0).getSellingprice());
        inventory.setPartid(partlist.get(0).getId());
        inventory.setType("inward");
        insertService.insert(inventory);
        //code to insert in inenory end! here

        //code to insert the quantity in carpartinfo table begin here
        List<Map<String, Object>> qty = viewService.getanyjdbcdatalist("Select balancequantity from carpartinfo where id='" + inventory.getPartid() + "' and isdelete='No'");
        int a, temp;
        temp = Integer.parseInt(qty.get(0).get("balancequantity").toString());
        a = temp + Integer.parseInt(inventory.getQuantity());
        updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + a + "',modifydate=now() where id='" + inventory.getPartid() + "'");
        //code to insert the quantity in carpartinfo table ends here

        //code to give affect to deduct from the inventory id transferred from begin here!
        if (transferquantity.equals(oldquantity)) {
            updateService.updateanyhqlquery("update inventory set isdelete='Yes',modifydate=now() where id='" + inventoryid + "'");
        } else {
            int inventoryqty = Integer.parseInt(oldquantity) - Integer.parseInt(transferquantity);
            updateService.updateanyhqlquery("update inventory set quantity='" + inventoryqty + "',modifydate=now() where id='" + inventoryid + "'");
        }
        List<CarPartInfo> partinfoList = viewService.getanyhqldatalist("from carpartinfo where id='" + oldpartid + "' and isdelete='No' ");
        int totalbal, finalqty;
        totalbal = Integer.parseInt(partinfoList.get(0).getBalancequantity());
        finalqty = totalbal - Integer.parseInt(transferquantity);
        updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + finalqty + "',modifydate=now() where id='" + oldpartid + "'");
        //code to give affect to deduct from the inventory id transferred from end! here.
        return "redirect:viewVehicleList";
    }

    //branch transfer coding begin here
    @RequestMapping(value = "addbranchTransfer")
    public String addbranchTransfer(@RequestParam(value = "inventoryid") String inventoryid,
            @RequestParam(value = "vaultid") String vaultid,
            @RequestParam(value = "branddetailid") String branddetailid,
            @RequestParam(value = "transferquantity") String transferquantity,
            @RequestParam(value = "oldpartid") String oldpartid,
            @RequestParam(value = "oldquantity") String oldquantity,
            @RequestParam(value = "branchid") String branchid) {

        //code to get carpartinfo from vaultid
//        List<CarPartInfo> partlist = viewService.getanyhqldatalist("FROM carpartinfo where vaultid='" + vaultid + "' and branddetailid='" + branddetailid + "'");
        //code to get partid ends here
        //code to insert in invenory transfer begin here
        List<Inventory> inventoryList = viewService.getanyhqldatalist("from inventory where id='" + inventoryid + "'");
        InventoryTransfer inventory = new InventoryTransfer();
        String pre = env.getProperty("inventory_transfer");
        String id = pre + insertService.getmaxcount("inventory_transfer", "id", 4);
        inventory.setId(id);
        inventory.setManufacturerid(inventoryList.get(0).getManufacturerid());
        inventory.setVendor(inventoryList.get(0).getVendor());
        inventory.setQuantity(transferquantity);
        inventory.setCostprice(inventoryList.get(0).getCostprice());
        inventory.setSellingprice(inventoryList.get(0).getSellingprice());
        inventory.setPartid(oldpartid);
        inventory.setType("transfer");
        inventory.setIs_transferred("No");
        inventory.setTo_branch(branchid);
        inventory.setBranddetailid(branddetailid);
        List<Branch> branchList = viewService.getanyhqldatalist("from branch where purchase_ord_prefix like '" + env.getProperty("branch_prefix") + "%'");
        inventory.setFrom_branch(branchList.get(0).getId());
        insertService.insert(inventory);
        //code to insert in invenory transfer end! here

        //code to insert the quantity in carpartinfo table begin here
//        List<Map<String, Object>> qty = viewService.getanyjdbcdatalist("Select balancequantity from carpartinfo where id='" + oldpartid + "' and isdelete='No'");
//        int a, temp;
//        temp = Integer.parseInt(qty.get(0).get("balancequantity").toString());
//        a = temp + Integer.parseInt(transferquantity);
//        updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + a + "',modifydate=now() where id='" + oldpartid + "'");
        //code to insert the quantity in carpartinfo table ends here
        //code to give affect to deduct from the inventory id transferred from begin here!
        if (transferquantity.equals(oldquantity)) {
            updateService.updateanyhqlquery("update inventory set isdelete='Yes',modifydate=now() where id='" + inventoryid + "'");
        } else {
            int inventoryqty = Integer.parseInt(oldquantity) - Integer.parseInt(transferquantity);
            updateService.updateanyhqlquery("update inventory set quantity='" + inventoryqty + "',modifydate=now() where id='" + inventoryid + "'");
        }
        List<CarPartInfo> partinfoList = viewService.getanyhqldatalist("from carpartinfo where id='" + oldpartid + "' and isdelete='No' ");
        int totalbal, finalqty;
        totalbal = Integer.parseInt(partinfoList.get(0).getBalancequantity());
        finalqty = totalbal - Integer.parseInt(transferquantity);
        updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + finalqty + "',modifydate=now() where id='" + oldpartid + "'");
        //code to give affect to deduct from the inventory id transferred from end! here.
        return "redirect:viewVehicleList";
    }

    // nitya work done
    //insert brand details
    @RequestMapping("addCar")
    public String addCar(@RequestParam(value = "brandid") String brandid, @RequestParam(value = "carname") String[] carNames, @RequestParam(value = "labourChargeTypes") String[] labourType) {
        BrandDetails brandDetails = new BrandDetails();
        for (int i = 0; i < carNames.length; i++) {
            String pre = env.getProperty("branddetails");
            String branddetailsid = insertService.getmaxcount("branddetails", "id", 4);
            brandDetails.setBrandid(brandid);
            brandDetails.setVehiclename(carNames[i]);

            String maxCountid = pre + branddetailsid;
            brandDetails.setId(maxCountid);
            brandDetails.setLabourChargeType(labourType[i]);
            insertService.insert(brandDetails);

            //adds carpart for the new car inserted
            List<Map<String, Object>> nongenericCarpartVaultList = viewService.getanyjdbcdatalist("SELECT * FROM carpartvault cpv\n"
                    + "where cpv.isdelete='No' and cpv.id NOT IN (select vaultid from carpartinfo where branddetailid='" + env.getProperty("generic_brand_detailid") + "')");

            if (nongenericCarpartVaultList != null && !nongenericCarpartVaultList.isEmpty()) {
                for (int j = 0; j < nongenericCarpartVaultList.size(); j++) {
                    CarPartInfo carPartInfo = new CarPartInfo();
                    carPartInfo.setBranddetailid(maxCountid);
                    carPartInfo.setVaultid(nongenericCarpartVaultList.get(j).get("id").toString());
                    String pre1 = env.getProperty("carpartinfo");
                    String carPartInfoid = insertService.getmaxcount("carpartinfo", "id", 5);
                    String maxCountCarPartInfoid = pre1 + carPartInfoid;
                    carPartInfo.setId(maxCountCarPartInfoid);
                    carPartInfo.setBalancequantity("0");
                    insertService.insert(carPartInfo);
                }
            }
        }
        return "redirect:brandMasterLink";
    }

    //**warning** only fo the use of krisnela for adding car part below each cars automated code runs on callin gof this huge data cost time run at your own risk
    @RequestMapping("addCarpartNitz")
    public String addCarpartNitz() {
//        BrandDetails brandDetails = new BrandDetails();
        List<BrandDetails> carList = viewService.getanyhqldatalist("from branddetails where isdelete='No'");
        for (int i = 0; i < carList.size(); i++) {

            //adds carpart for the new car inserted
            List<CarPartVault> carPartVaultList = viewService.getanyhqldatalist("from carpartvault where isdelete='No'");
            for (int j = 0; j < carPartVaultList.size(); j++) {
                CarPartInfo carPartInfo = new CarPartInfo();
                String pre = env.getProperty("carpartinfo");
                String carPartInfoid = insertService.getmaxcount("carpartinfo", "id", 5);
                String maxCountCarPartInfoid = pre + carPartInfoid;
                carPartInfo.setId(maxCountCarPartInfoid);
                carPartInfo.setBalancequantity("0");
                carPartInfo.setVaultid(carPartVaultList.get(j).getId());
                carPartInfo.setBranddetailid(carList.get(i).getId());
                insertService.insert(carPartInfo);
            }
        }
        return "redirect:viewVehicleList";
    }
    //**warning end!**

    //inserts new brand
    @RequestMapping("addBrand")
    public String addBrand(@ModelAttribute Brand brand) {
        String prefix = env.getProperty("brand");
        String id = insertService.getmaxcount("brand", "id", 3);
        String maxCount = prefix + id;
        brand.setId(maxCount);
        insertService.insert(brand);
        return "redirect:brandMasterLink";
    }

    //inserts new bank account
    @RequestMapping(value = "insertBankAccount")
    public String insertBankAccount(@ModelAttribute BankAccount bankAccount) {
        String prefix = env.getProperty("bank_account");
        String id = prefix + insertService.getmaxcount("bank_account", "id", 4);
        bankAccount.setId(id);
        insertService.insert(bankAccount);
        return "redirect:bankAccountMasterLink";
    }

    //insert new branch
    @RequestMapping(value = "addBranch")
    public String addBranch(@ModelAttribute Branch branch) {
        String prefix = env.getProperty("branch");
        String id = prefix + insertService.getmaxcount("branch", "id", 4);
        branch.setId(id);
        insertService.insert(branch);
        return "redirect:branchMasterLink";
    }

    //insert new branch
    @RequestMapping(value = "addInsuranceCompany")
    public String addInsuranceCompany(@ModelAttribute InsuranceCompany insuranceCompany) {
        String pre = env.getProperty("insurance_company");
        String id = pre + insertService.getmaxcount("insurance_company", "id", 4);
        insuranceCompany.setId(id);
        insertService.insert(insuranceCompany);
        return "redirect:insuranceCompanyMasterLink";
    }

    //inserts new vendor
    @RequestMapping("addVendor")
    public String addVendor(@ModelAttribute Vendor vendor) {
        String prefix = env.getProperty("vendor");
        String id = insertService.getmaxcount("vendor", "id", 3);
        String maxCount = prefix + id;
        vendor.setId(maxCount);
        insertService.insert(vendor);
        return "redirect:vendorMasterLink";
    }

    //insert ledger
    @RequestMapping(value = "addLedgerAccount")
    public String addLedgerAccount(@ModelAttribute Ledger ledger) {
        String prefix = env.getProperty("ledger");
        String id = prefix + insertService.getmaxcount("ledger", "id", 4);
        ledger.setId(id);
        ledger.setCustomerid("");
        insertService.insert(ledger);
        return "redirect:ledgerMasterLink";
    }

    //insert ledger group  from popup
    @RequestMapping(value = "saveLedgerGroup")
    public @ResponseBody
    String saveLedgerGroup(@ModelAttribute LedgerGroup ledgerGroup) {
        try {
            String prefix = env.getProperty("ledgergroup");
            String id = prefix + insertService.getmaxcount("ledgergroup", "id", 4);
            ledgerGroup.setId(id);
            insertService.insert(ledgerGroup);
            return "done";
        } catch (Exception e) {

        }
        return "error";
    }

    //inserts new manufacturer
    @RequestMapping("addMfg")
    public String addMfg(@ModelAttribute Manufacturer manufacturer) {
        String prefix = env.getProperty("manufacturer");
        String id = insertService.getmaxcount("manufacturer", "id", 3);
        String maxCount = prefix + id;
        manufacturer.setId(maxCount);
        insertService.insert(manufacturer);
        return "redirect:mfgMasterLink";
    }

    //inserts new category
    @RequestMapping("addCategory")
    public String addCategory(@ModelAttribute Category category) {
        String prefix = env.getProperty("category");
        String id = insertService.getmaxcount("category", "id", 4);
        String maxCount = prefix + id;
        category.setId(maxCount);
        insertService.insert(category);
        return "redirect:categoryMasterLink";
    }

    //inserts new category
    @RequestMapping("addTaxes")
    public String addTaxes(@ModelAttribute Taxes taxes) {
        String prefix = env.getProperty("taxes");
        String id = insertService.getmaxcount("taxes", "id", 4);
        String maxCount = prefix + id;
        taxes.setId(maxCount);
        insertService.insert(taxes);
        return "redirect:taxMasterLink";
    }

    //inserts new customer master
    @RequestMapping("addCustomer")
    public String addCustomer(@ModelAttribute Customer customer) {
        List<Customer> customerexist = viewService.getanyjdbcdatalist("select * from customer where mobilenumber like '" + customer.getMobilenumber() + "%' and isdelete='No'");
        if (customerexist.size() > 0) {
            return "redirect:customerMasterLink?isexist=Yes";
        } else {
            String prefixcustomer = env.getProperty("customer");
            String id = insertService.getmaxcount("customer", "id", 4);
            String maxCount = prefixcustomer + id;
            customer.setId(maxCount);
            String uuid = UUID.randomUUID().toString();
            String genpassword = new String(uuid);
            System.out.println("uuid = " + genpassword.substring(0, 4));
            String password = genpassword.substring(0, 4);
            System.out.println("uuid password = " + password);
            customer.setPassword(password);
            insertService.insert(customer);

            //create customer ledger
            Ledger ledger=new Ledger();
            String prefix = env.getProperty("ledger");
            String id2 = prefix + insertService.getmaxcount("ledger", "id", 4);
            ledger.setId(id2);
            ledger.setCustomerid(customer.getId());
            ledger.setAccountname(customer.getName());
            ledger.setLedger_type("income");
            ledger.setLedgergroupid(env.getProperty("indirect_income"));
            insertService.insert(ledger);
            return "redirect:customerMasterLink";
        }
    }

    //inserts new customer master when converted an enquiry
    @RequestMapping("addConvertCustomer")
    public String addConvertCustomer(@ModelAttribute Customer customer, @RequestParam(value = "enquiryid") String enquiryid) {
        List<Customer> customerlist = viewService.getanyhqldatalist("from customer where mobilenumber='" + customer.getMobilenumber() + "'");
        if (customerlist.size() > 0) {
            updateService.updateanyhqlquery("update enquiries set iscustomer='Yes',modifydate=now() where id='" + enquiryid + "'");
        } else {
            String prefix = env.getProperty("customer");
            String id = insertService.getmaxcount("customer", "id", 4);
            String maxCount = prefix + id;
            customer.setId(maxCount);
            insertService.insert(customer);
            updateService.updateanyhqlquery("update enquiries set iscustomer='Yes',modifydate=now() where id='" + enquiryid + "'");
        }
        return "redirect:customerMasterLink";
    }

    //inserts new customer master
    @RequestMapping("addCustomerChecklist")
    public String addCustomerChecklist(@ModelAttribute Customer customer) {
        String prefix = env.getProperty("customer");
        String id = insertService.getmaxcount("customer", "id", 4);
        String maxCount = prefix + id;
        customer.setId(maxCount);
        insertService.insert(customer);
        return "redirect:create_service_checklist";
    }

    //inserts new customer master
    @RequestMapping("addCustomerInsuranceExpiring")
    public String addCustomerInsuranceExpiring(@ModelAttribute Customer customer) {
        String prefix = env.getProperty("customer");
        String id = insertService.getmaxcount("customer", "id", 4);
        String maxCount = prefix + id;
        customer.setId(maxCount);
        insertService.insert(customer);
        return "redirect:create_Cust_Insurance";
    }

    //inserts new service
    @RequestMapping("addService")
    public String addService(@ModelAttribute LabourServices services) {
        String prefix = env.getProperty("labourservices");
        String id = insertService.getmaxcount("labourservices", "id", 4);
        String maxCount = prefix + id;
        services.setId(maxCount);
        insertService.insert(services);
        return "redirect:serviceMasterLink";
    }

    //insert to invoice/labourinventory/inventory/feedback
    @RequestMapping(value = "addInvoice")
    public String addInvoice(@ModelAttribute Invoice invoice, 
            @ModelAttribute InventoryArray inventoryArray, 
            @RequestParam(value = "date_time", required = false) String date_time, 
            @RequestParam(value = "customer_id", required = false) String customer_id, 
            @RequestParam(value = "isapplicable", required = false) String isapplicable,
            @RequestParam(value = "message", required = false) String message) {
        String prefix = env.getProperty("invoice");
        String id = insertService.getmaxcount("invoice", "id", 4);
        String maxCount = prefix + id;
        invoice.setId(maxCount);
        invoice.setInvoiceid(maxCount);
        //nitz mod 04-11-2015
        invoice.setBalanceamount(invoice.getAmountTotal());
        //code for with tax- without tax begins here
        if (isapplicable.equals("Yes")) {
            invoice.setIstax("Yes");
            insertService.insert(invoice);
        } else {
            double spare = Double.parseDouble(invoice.getSparepartsfinal());
            double service = Double.parseDouble(invoice.getLabourfinal());
            double result = spare + service;
            invoice.setTaxAmount1("0");
            invoice.setTaxAmount2("0");
            invoice.setAmountTotal("" + result);
            invoice.setCustomertotal("" + result);
            invoice.setCustomerinsuranceliability("" + result);
            invoice.setBalanceamount("" + result);
            invoice.setIstax("No");
            insertService.insert(invoice);
        }
        //code for with tax- without tax ends! here

        //insert in reminder for customer begin here 
        if (date_time != null && !date_time.isEmpty()) {
            ReminderCustomer rc = new ReminderCustomer();

            String reminder_orefix = env.getProperty("reminder_customer");
            String reminder_id = reminder_orefix + insertService.getmaxcount("reminder_customer", "id", 4);
            rc.setId(reminder_id);
            rc.setCustomerid(customer_id);
            rc.setDate_time(date_time);
            if (message == null && message.isEmpty()) {
                rc.setMessage("");
            } else {
                rc.setMessage(message);
            }
            insertService.insert(rc);
        }

        for (int i = 0; i < inventoryArray.getPartid().length; i++) {

            //insert in invoice details goes here begins!
            Invoicedetails invoicedetails = new Invoicedetails();
            String prefix3 = env.getProperty("invoicedetails");
            String invoicedetailid = prefix3 + insertService.getmaxcount("invoicedetails", "id", 5);
            invoicedetails.setId(invoicedetailid);
            invoicedetails.setPartid(inventoryArray.getPartid()[i]);
            invoicedetails.setInvoiceid(maxCount);
            invoicedetails.setType("outward");
            invoicedetails.setSellingprice(inventoryArray.getSellingprice()[i]);
            invoicedetails.setQuantity(inventoryArray.getPartQuantity()[i]);
            invoicedetails.setManufacturerid(inventoryArray.getManufacturerid()[i]);
            invoicedetails.setPartname(inventoryArray.getCarparts()[i]);
            if (invoice.getIsinsurance().equals("Yes")) {
                invoicedetails.setInsurancepercent(inventoryArray.getInsurancepercent()[i]);
                invoicedetails.setInsurancecustomeramount(inventoryArray.getInsurancecustomeramount()[i]);
                invoicedetails.setInsurancecompanyamount(inventoryArray.getInsurancecompanyamount()[i]);
            }
            invoicedetails.setTotal(inventoryArray.getItemtotal()[i]);
            insertService.insert(invoicedetails);
            //insert in invoice details goes here ends!
            
            //inserts into inventory
            Inventory inventory = new Inventory();
            
            inventory.setPartid(inventoryArray.getPartid()[i]);
            inventory.setInvoiceid(maxCount);
            inventory.setType("outward");
            inventory.setSellingprice(inventoryArray.getSellingprice()[i]);
            inventory.setPartname(inventoryArray.getCarparts()[i]);

            inventory.setQuantity(inventoryArray.getPartQuantity()[i]);
            int partqty = Integer.parseInt(inventoryArray.getPartQuantity()[i]);

            CarPartInfo c = (CarPartInfo) viewService.getspecifichqldata(CarPartInfo.class, inventoryArray.getPartid()[i]);
            int availableqty = Integer.parseInt(c.getBalancequantity());

            int result = availableqty - partqty;
            updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + result + "',modifydate=now() where id='" + inventoryArray.getPartid()[i] + "'");

            inventory.setManufacturerid(inventoryArray.getManufacturerid()[i]);
            if (invoice.getIsinsurance().equals("Yes")) {
                inventory.setInsurancepercent(inventoryArray.getInsurancepercent()[i]);
                inventory.setInsurancecompanyamount(inventoryArray.getInsurancecompanyamount()[i]);
                inventory.setInsurancecustomeramount(inventoryArray.getInsurancecustomeramount()[i]);
            }
            inventory.setTotal(inventoryArray.getItemtotal()[i]);
            

            //code to find the vendor for this outward begins here
            List<Map<String, Object>> invqtyList = new ArrayList<Map<String, Object>>();

            invqtyList = viewService.getanyjdbcdatalist("SELECT sum(sell_qty) qtycount FROM inventory where partid='" + inventoryArray.getPartid()[i] + "' and manufacturerid='" + inventoryArray.getManufacturerid()[i] + "' and `type`='inward' and sold='No'  \n"
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
                        iv.setInvoicedetailid(invoicedetailid);
                        iv.setPartid(inventoryArray.getPartid()[i]);
                        iv.setMfgid(inventoryArray.getManufacturerid()[i]);
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
                        iv.setPartid(inventoryArray.getPartid()[i]);
                        iv.setMfgid(inventoryArray.getManufacturerid()[i]);
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
                inventory.setQuantity(inventoryArray.getPartQuantity()[i]);
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
                iv.setQuantity(inventoryArray.getPartQuantity()[i]);
                iv.setVendorid("NA");
                iv.setInvoicedetailid(invoicedetailid);
                iv.setPartid(inventoryArray.getPartid()[i]);
                iv.setMfgid(inventoryArray.getManufacturerid()[i]);
                insertService.insert(iv);
            }
            //code to find the vendor for this outward ends! here
        }

        if (inventoryArray.getServiceid() != null) {
            for (int i = 0; i < inventoryArray.getServiceid().length; i++) {
                //inserts into labour inventory
                LabourInventory labourInventory = new LabourInventory();
                String prefix2 = env.getProperty("labourinventory");
                String labourInventoryid = prefix2 + insertService.getmaxcount("labourinventory", "id", 5);
                labourInventory.setId(labourInventoryid);
                labourInventory.setInvoiceid(maxCount);
                labourInventory.setServicename(inventoryArray.getServiceAction()[i]);
                labourInventory.setServiceid(inventoryArray.getServiceid()[i]);
                if (inventoryArray.getDescription().length > 0 || inventoryArray.getDescription().length != 0) {
                    labourInventory.setDescription(inventoryArray.getDescription()[i]);
                }
                if (invoice.getIsinsurance().equals("Yes")) {
                    labourInventory.setServiceinsurancepercent(inventoryArray.getServiceinsurancepercent()[i]);
                    labourInventory.setCompanyinsurance(inventoryArray.getCompanyinsuranceservice()[i]);
                    labourInventory.setCustomerinsurance(inventoryArray.getCustinsuranceservice()[i]);
                }
                labourInventory.setTotal(inventoryArray.getServicetotal()[i]);
                insertService.insert(labourInventory);
            }
        }

        //inserts into feedback
        Feedback feedback = new Feedback();
        String prefix2 = env.getProperty("feedback");
        String id2 = prefix2 + insertService.getmaxcount("feedback", "id", 4);
        feedback.setId(id2);
        feedback.setStatus("incomplete");
        feedback.setInvoiceid(invoice.getId());
        insertService.insert(feedback);
        //end of inert to feedback

        return "redirect:invoiceMasterLink";
    }

    //send email and genrate pdf
    @RequestMapping(value = "sendmailinfo")
    public @ResponseBody
    String sendCustomerMail(@RequestParam(value = "customerName") String customerName, @RequestParam(value = "emailcomments") String emailcomments, @RequestParam(value = "customerEmail") String customerEmail, @RequestParam(value = "mypdfbase") String mypdfbase) {
        try {
            System.out.println("I am called nityanand");
            //generate random name for pdf based on timestamp
            java.util.Date date = new java.util.Date();
            String one = new Timestamp(date.getTime()).toString();
            String fileName = one.replaceAll("[-+.^:, ]", "n");
            String filePath = "E:\\Krisnela\\Mail\\";
            String fileType = ".pdf";
            UploadPdf uploadPdf = new UploadPdf();
            //upload pdf class called and uploaded file to server/location
            uploadPdf.savePdf(mypdfbase, fileName, filePath, fileType);

            //now for sending mail  to customer
            String subject = "eBill";

            EmailSessionBean emailSessionBean = new EmailSessionBean();
            String attachment = filePath + fileName + fileType;
            emailSessionBean.sendEmail(customerEmail, subject, emailcomments, attachment, fileName);
            File file = new File(attachment);
            file.delete();
            System.out.println(file.getName() + " is deleted!");
            return "Yes";
        } catch (Exception e) {
            return "No";
        }

    }

    //actual mail send code for the whole project
    @RequestMapping(value = "sendmailinfod", method = RequestMethod.POST)
    public @ResponseBody
    String sendCustomerMaild(@RequestParam(value = "customerName") String customerName,
            @RequestParam(value = "name") String invoicename,
            @RequestParam(value = "emailcomments", required = false) String emailcomments,
            @RequestParam(value = "customerEmail") String customerEmail,
            @RequestParam(value = "mypdfbase") String mypdfbase) {
        try {
            EmailSessionBean emailSessionBean = new EmailSessionBean();
            if (customerEmail.contains(",")) {
                String recipient[] = customerEmail.split(",");
                for (int i = 0; i < recipient.length; i++) {
                    emailSessionBean.sendCustomerPasswordMail(emailcomments, mypdfbase, recipient[i], "Karworx", invoicename);
                }
            } else {
                emailSessionBean.sendCustomerPasswordMail(emailcomments, mypdfbase, customerEmail, "Karworx", invoicename);
            }

            return "Yes";
        } catch (Exception e) {
            return "No";
        }

    }

    //send email and genrate pdf
    @RequestMapping(value = "sendmailpoinfo", method = RequestMethod.POST)
    public @ResponseBody
    String sendmailpoinfo(@RequestParam(value = "customerName") String customerName, @RequestParam(value = "customerEmail") String customerEmail, @RequestParam(value = "mypdfbase") String mypdfbase) {
        try {
            //generate random name for pdf based on timestamp
            java.util.Date date = new java.util.Date();
            String one = new Timestamp(date.getTime()).toString();
            String fileName = one.replaceAll("[-+.^:, ]", "n");
            String filePath = "E:\\Krisnela\\Mail\\";
//            String filePath = "/home/Krisnela/Mail/";
            String fileType = ".pdf";
            UploadPdf uploadPdf = new UploadPdf();
            System.out.println(mypdfbase + "Hey pdf codde nitz");
            //upload pdf class called and uploaded file to server/location
            uploadPdf.savePdf(mypdfbase, fileName, filePath, fileType);

            //now for sending mail  to customer
            String subject = "eBill";
//            String body = "";

            EmailSessionBean emailSessionBean = new EmailSessionBean();
            String attachment = filePath + fileName + fileType;
            emailSessionBean.sendEmail(customerEmail, subject, "", attachment, fileName);
            File file = new File(attachment);
            file.delete();
            System.out.println(file.getName() + " is deleted!");
            return "Yes";
        } catch (Exception e) {
            return "No";
        }

    }

    // latest 24/04/2015
    @RequestMapping(value = "insertservicechecklist", method = RequestMethod.POST)
    public String insertservicechecklist(@ModelAttribute CustomerVehicles cv, @ModelAttribute CustomerVehiclesDeatils cvd, String vid, String existing) {
        String prefix2 = env.getProperty("customervehicles");
        cv.setId(prefix2 + insertService.getmaxcount("customervehicles", "id", 4));
        insertService.insert(cv);
        String prefix = env.getProperty("customervehiclesdetails");
        cvd.setId(prefix + insertService.getmaxcount("customervehiclesdetails", "id", 5));
        cvd.setCustvehicleid(cv.getId());
        insertService.insert(cvd);
        return "redirect:service_checklist_grid.html";
    }

    //insert into estimate
    @RequestMapping(value = "insertestimate", method = RequestMethod.POST)
    public String inserestimate(@ModelAttribute AllArrayPojo aap, @ModelAttribute Estimate estimate, @ModelAttribute EstimateLabourArray labourArray) {
        String prefix = env.getProperty("estimate");
        String id = prefix + insertService.getmaxcount("estimate", "id", 3);
        estimate.setId(id);
        insertService.insert(estimate);

        //insert into estimate details for parts begin here
        if (aap.getPartlistid().length > 0) {
            for (int i = 0; i < aap.getPartlistid().length; i++) {
                EstimateDetails e = new EstimateDetails();
                String prefix2 = env.getProperty("estimatedetails");
                e.setId(prefix2 + insertService.getmaxcount("estimatedetails", "id", 4));
                e.setEstimateid(estimate.getId());
                e.setPartlistid(aap.getPartlistid()[i]);
                e.setLabourrs(aap.getLabourrs()[i]);
                e.setPartrs(aap.getPartrs()[i]);
                e.setQuantity(aap.getQuantity()[i]);
                e.setTotalpartrs(aap.getTotalpartrs()[i]);
                e.setDescription(aap.getDescription()[i]);
                e.setItem_type("part");
                e.setPartlistname(aap.getPartname()[i]);
                insertService.insert(e);
            }
        }
        //insert into estimate details for parts ends! here

        //insert into estimate details for service begin here
        if (labourArray.getServiceid().length > 0) {
            for (int i = 0; i < labourArray.getServiceid().length; i++) {
                EstimateDetails e = new EstimateDetails();
                String prefix2 = env.getProperty("estimatedetails");
                e.setId(prefix2 + insertService.getmaxcount("estimatedetails", "id", 4));
                e.setEstimateid(estimate.getId());
                e.setPartlistid(labourArray.getServiceid()[i]);
                e.setLabourrs(labourArray.getServicetotal()[i]);
                e.setPartrs("0");
                e.setQuantity("0");
                e.setTotalpartrs(labourArray.getServicetotal()[i]);
                e.setDescription(labourArray.getLabourdescription()[i]);
                e.setItem_type("service");
                e.setPartlistname(labourArray.getServicename()[i]);
                insertService.insert(e);
            }
        }
        //insert into estimate details for service ends! here

        updateService.updateanyhqlquery("update pointchecklist set isestimate='Yes',modifydate=now() where id='" + estimate.getPclid() + "'");

        //code for inserting some new parts 
        return "redirect:estimate.html";
    }

    // latest 24/04/2015
    //nitz work done
    //insert 180 point checklist 12:41 24/04/2015 
    @RequestMapping(value = "add180pointchecklist")
    public String add180pointchecklist(@ModelAttribute PointChecklist pointChecklist, @ModelAttribute PointChecklistDetails pointChecklistDetails, @RequestParam("carpartvaultchecks") String[] carpartvaultchecks, @RequestParam(value = "cvid") String cvid) {
        if (carpartvaultchecks != null) {
            String prefix2 = env.getProperty("pointchecklist");
            String id = prefix2 + insertService.getmaxcount("pointchecklist", "id", 5);
            pointChecklist.setId(id);
            insertService.insert(pointChecklist);
            for (int i = 0; i < carpartvaultchecks.length; i++) {
                String prefix = env.getProperty("pointchecklistdetails");
                String id2 = prefix + insertService.getmaxcount("pointchecklistdetails", "id", 6);
                pointChecklistDetails.setId(id2);
                pointChecklistDetails.setPointchecklistid(pointChecklist.getId());
                pointChecklistDetails.setPartlistid(carpartvaultchecks[i]);
                insertService.insert(pointChecklistDetails);
            }
            updateService.updateanyhqlquery("update customervehicles set is180ready='Yes',modifydate=now() where id='" + cvid + "'");
        }
        return "redirect:180pointchecklistgridlink";
    }
//12:41 24/04/2015

    //add new workman master grid
    @RequestMapping(value = "addWorkman")
    public String addWorkman(@ModelAttribute Workman workman) {
        String prefix = env.getProperty("workman");
        String id = prefix + insertService.getmaxcount("workman", "id", 4);
        workman.setId(id);
        insertService.insert(workman);
        return "redirect:viewWorkmanLink";
    }

    //insert workman for the jobsheet
    @RequestMapping(value = "saveWorkman")
    public String insertJobsheet(@ModelAttribute Jobsheet jobsheet, @ModelAttribute JobsheetDetails jobsheetDetails, @RequestParam(value = "workmen") String[] workmen, @RequestParam(value = "typeofpart") String[] typeofpart, @RequestParam(value = "estimatedtime") float[] estimatedtime, @RequestParam(value = "estdid") String[] estdid, @RequestParam(value = "myestimateid") String myestimateid) {

        if (workmen.length > 0) {
            String prefix = env.getProperty("jobsheet");
            String id = prefix + insertService.getmaxcount("jobsheet", "id", 4);
            jobsheet.setId(id);
            jobsheet.setVerified("No");
            jobsheet.setCleaning("not done");
            jobsheet.setCar_washing("not done");
            jobsheet.setCar_vacuuming("not done");
            jobsheet.setTyre_polish("not done");
            jobsheet.setDashboard_polish("not done");
            jobsheet.setEngine_cleaning("not done");
            jobsheet.setUnderchasis_cleaning("not done");
            jobsheet.setTrunk_cleaning("not done");
            insertService.insert(jobsheet);

            for (int i = 0; i < workmen.length; i++) {
                String prefix2 = env.getProperty("jobsheetdetails");
                String id2 = prefix2 + insertService.getmaxcount("jobsheetdetails", "id", 5);
                jobsheetDetails.setId(id2);
                jobsheetDetails.setEstimatedetailid(estdid[i]);
                jobsheetDetails.setJobsheetid(jobsheet.getId());
                jobsheetDetails.setWorkmanid(workmen[i]);
                jobsheetDetails.setItemtype(typeofpart[i]);
                //change in hours to min has been stopped on client revision. now dire ctly enterd time is saved
//                float minutes = estimatedtime[i] * 60;
                jobsheetDetails.setEstimatetime(estimatedtime[i]);
                if (typeofpart[i].equals("service")) {
                    jobsheetDetails.setPartstatus("");
                }
                insertService.insert(jobsheetDetails);
            }
        }
        updateService.updateanyhqlquery("update estimate set isjobsheetready='Yes',modifydate=now() where id='" + myestimateid + "'");

        List<Map<String, Object>> taskrelated = viewService.getanyjdbcdatalist("SELECT jsd.id,jsd.workmanid,wm.name,sum(jsd.estimatetime) as totalestimatetime FROM jobsheetdetails jsd\n"
                + "inner join workman wm on wm.id=jsd.workmanid\n"
                + "where jsd.jobsheetid='" + jobsheet.getId() + "'\n"
                + "group by jsd.workmanid");

        TaskBoard taskBoard = new TaskBoard();

        for (int i = 0; i < taskrelated.size(); i++) {
            String prefix2 = env.getProperty("taskboard");
            String id3 = prefix2 + insertService.getmaxcount("taskboard", "id", 5);
            taskBoard.setId(id3);
            taskBoard.setJobsheetid(jobsheet.getId());
            taskBoard.setWorkmanid(taskrelated.get(i).get("workmanid").toString());
            taskBoard.setEstimatetime(taskrelated.get(i).get("totalestimatetime").toString());
            taskBoard.setTimeconsumed("0");
            insertService.insert(taskBoard);
        }

        return "redirect:viewJobsheetGridLink";
    }

    //insert to invoice/labourinventory/inventory
    @RequestMapping(value = "convertinInvoice")
    public String convertinInvoice(@ModelAttribute Invoice invoice, 
            @ModelAttribute InventoryArray inventoryArray, 
            @RequestParam(value = "loopvalue", required = false) int loopvalue, 
            @RequestParam(value = "serviceAction", required = false) String[] serviceAction, 
            @RequestParam(value = "myjsid") String myjsid, 
            @RequestParam(value = "isapplicable") String isapplicable,
            @RequestParam(value = "date_time", required = false) String date_time, 
            @RequestParam(value = "customer_id", required = false) String customer_id, 
            @RequestParam(value = "message", required = false) String message) {
        String prefix2 = env.getProperty("invoice");
        String id = insertService.getmaxcount("invoice", "id", 4);
        String maxCount = prefix2 + id;
        invoice.setId(maxCount);
        invoice.setInvoiceid(maxCount);
        //nitz mod 04-11a-2015
        invoice.setBalanceamount(invoice.getAmountTotal());
        invoice.setIsconvert("Yes");

        //code for with tax- without tax begins here
        if (isapplicable.equals("Yes")) {
            
        }
        insertService.insert(invoice);

        //insert in reminder for customer begin here 
        if (date_time != null && !date_time.isEmpty()) {
            ReminderCustomer rc = new ReminderCustomer();

            String reminder_orefix = env.getProperty("reminder_customer");
            String reminder_id = reminder_orefix + insertService.getmaxcount("reminder_customer", "id", 4);
            rc.setId(reminder_id);
            rc.setCustomerid(customer_id);
            rc.setDate_time(date_time);
            if (message == null && message.isEmpty()) {
                rc.setMessage("");
            } else {
                rc.setMessage(message);
            }
            insertService.insert(rc);
        }

        for (int i = 0; i < inventoryArray.getPartid().length; i++) {
            //inserts into inventory
            Inventory inventory = new Inventory();
            String prefix = env.getProperty("inventory");
            String inventoryid = prefix + insertService.getmaxcount("inventory", "id", 4);
            inventory.setId(inventoryid);
            inventory.setPartid(inventoryArray.getPartid()[i]);
            inventory.setInvoiceid(maxCount);
            inventory.setType("outward");
            inventory.setSellingprice(inventoryArray.getSellingprice()[i]);
            inventory.setPartname(inventoryArray.getCarparts()[i]);

            inventory.setQuantity(inventoryArray.getPartQuantity()[i]);
            int partqty = Integer.parseInt(inventoryArray.getPartQuantity()[i]);

            CarPartInfo c = (CarPartInfo) viewService.getspecifichqldata(CarPartInfo.class, inventoryArray.getPartid()[i]);
            int availableqty = Integer.parseInt(c.getBalancequantity());

//            List<Map<String, Object>> c = viewService.getanyjdbcdatalist("SELECT * FROM carpartinfo where branddetailid='" + invoice.getVehicleid() + "' and vaultid='" + inventoryArray.getPartid()[i] + "'");
//
////            CarPartInfo c = (CarPartInfo) viewService.getspecifichqldata(CarPartInfo.class, inventoryArray.getPartid()[i]);
//            int availableqty = Integer.parseInt(c.get(0).get("balancequantity").toString());
            int result = availableqty - partqty;
            updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + result + "',modifydate=now() where id='" + inventoryArray.getPartid()[i] + "'");

            inventory.setManufacturerid(inventoryArray.getManufacturerid()[i]);
            if (invoice.getIsinsurance().equals("Yes")) {
                inventory.setInsurancepercent(inventoryArray.getInsurancepercent()[i]);
                inventory.setInsurancecompanyamount(inventoryArray.getInsurancecompanyamount()[i]);
                inventory.setInsurancecustomeramount(inventoryArray.getInsurancecustomeramount()[i]);
            }
            inventory.setTotal(inventoryArray.getItemtotal()[i]);
            insertService.insert(inventory);
            inventory.setQuantity(inventoryArray.getPartQuantity()[i]);
        }

        for (int i = 0; i < loopvalue; i++) {

            //inserts into labour inventory
            LabourInventory labourInventory = new LabourInventory();
            String prefix = env.getProperty("labourinventory");
            String labourInventoryid = prefix + insertService.getmaxcount("labourinventory", "id", 5);
            labourInventory.setId(labourInventoryid);
            labourInventory.setInvoiceid(maxCount);
            labourInventory.setServicename(inventoryArray.getServiceAction()[i]);

            if (inventoryArray.getServiceid().length != 0 || inventoryArray.getServiceid().length > 0) {
                labourInventory.setServiceid(inventoryArray.getServiceid()[i]);
            }
            if (inventoryArray.getDescription().length > 0 || inventoryArray.getDescription().length != 0) {
                labourInventory.setServiceid(inventoryArray.getServiceid()[i]);
            }
            if (invoice.getIsinsurance().equals("Yes")) {
                labourInventory.setServiceinsurancepercent(inventoryArray.getServiceinsurancepercent()[i]);
                labourInventory.setCompanyinsurance(inventoryArray.getCompanyinsuranceservice()[i]);
                labourInventory.setCustomerinsurance(inventoryArray.getCustinsuranceservice()[i]);
            }
            labourInventory.setTotal(inventoryArray.getServicetotal()[i]);
            insertService.insert(labourInventory);
        }
        //insert into new create invociedetails table begin here
        List<Inventory> inventoryList = viewService.getanyhqldatalist("from inventory where invoiceid='" + maxCount + "'");
        for (int i = 0; i < inventoryList.size(); i++) {
            Invoicedetails invoicedetails = new Invoicedetails();
            String prefix3 = env.getProperty("invoicedetails");
            String invoicedetailid = prefix3 + insertService.getmaxcount("invoicedetails", "id", 5);
            invoicedetails.setId(invoicedetailid);
            invoicedetails.setInventoryid(inventoryList.get(i).getId());
            invoicedetails.setPartid(inventoryList.get(i).getPartid());
            invoicedetails.setInvoiceid(maxCount);
            invoicedetails.setType(inventoryList.get(i).getType());
            invoicedetails.setSellingprice(inventoryList.get(i).getSellingprice());
            invoicedetails.setQuantity(inventoryList.get(i).getQuantity());
            invoicedetails.setManufacturerid(inventoryList.get(i).getManufacturerid());
            invoicedetails.setPartname(inventoryList.get(i).getPartname());

            if (invoice.getIsinsurance().equals("Yes")) {
                invoicedetails.setInsurancepercent(inventoryList.get(i).getInsurancepercent());
                invoicedetails.setInsurancecustomeramount(inventoryList.get(i).getInsurancecustomeramount());
                invoicedetails.setInsurancecompanyamount(inventoryList.get(i).getInsurancecompanyamount());
            }
            invoicedetails.setTotal(inventoryList.get(i).getTotal());
            insertService.insert(invoicedetails);
        }
        //insert into new create invociedetails table ends! here

        //inserts into feedback
        Feedback feedback = new Feedback();
        String prefix = env.getProperty("feedback");
        String id2 = prefix + insertService.getmaxcount("feedback", "id", 4);
        feedback.setId(id2);
        feedback.setStatus("incomplete");
        feedback.setInvoiceid(maxCount);
        insertService.insert(feedback);

        //update jobsheet 
        updateService.updateanyhqlquery("update jobsheet set isinvoiceconverted='Yes',modifydate=now() where id='" + myjsid + "'");

        return "redirect:invoiceMasterLink";
    }

    //=====================CRM Coding Begin here===========================
    //insert new enquiry
    @RequestMapping(value = "insertLead")
    public String insertLead(@ModelAttribute Enquiries enquiries, @ModelAttribute Appointment appointment, @ModelAttribute Followups followups, @RequestParam(value = "followedby", required = false) String followedby, @RequestParam(value = "followedby", required = false) String followedby2, @RequestParam(value = "appointmentowner", required = false) String appointmentowner2) {
        String prefix = env.getProperty("enquiries");
        String id = prefix + insertService.getmaxcount("enquiries", "id", 4);
        enquiries.setId(id);
        insertService.insert(enquiries);

        if (appointmentowner2 != null && !appointmentowner2.isEmpty()) {
            String prefix2 = env.getProperty("appointment");
            String id2 = prefix2 + insertService.getmaxcount("appointment", "id", 4);
            appointment.setId(id2);
            appointment.setEnquirieid(id);
            insertService.insert(appointment);
        }

        if (followedby2 != null && !followedby2.isEmpty()) {
            String prefix2 = env.getProperty("followups");
            String id3 = prefix2 + insertService.getmaxcount("followups", "id", 4);
            followups.setId(id3);
            followups.setEnquirieid(id);
            insertService.insert(followups);
        }
        return "redirect:enquiriesgridlink";
    }

    //insert new appointment
    @RequestMapping(value = "insertAppointment")
    public String insertAppointment(@ModelAttribute Appointment appointment) {
        String prefix = env.getProperty("appointment");
        String id = prefix + insertService.getmaxcount("appointment", "id", 4);
        appointment.setId(id);
        insertService.insert(appointment);

        return "redirect:viewEnquiriyDetailPage?enquiryid=" + appointment.getEnquirieid();
    }

    //insert new appointment on calendar page
    @RequestMapping(value = "insertAppointmentCal")
    public String insertAppointmentCal(@ModelAttribute Appointment appointment) {
        String prefix = env.getProperty("appointment");
        String id = prefix + insertService.getmaxcount("appointment", "id", 4);
        appointment.setId(id);
        if (appointment.getEnquirieid() != null && !appointment.getEnquirieid().isEmpty()) {
            insertService.insert(appointment);
        } else {
            appointment.setEnquirieid("");
            insertService.insert(appointment);
        }
        return "redirect:appointmentCalendarlink";
    }

    //insert new follow ups
    @RequestMapping(value = "insertFollowups")
    public String insertFollowups(@ModelAttribute Followups followups) {
        String prefix = env.getProperty("followups");
        String id = prefix + insertService.getmaxcount("followups", "id", 4);
        followups.setId(id);
        insertService.insert(followups);
        return "redirect:viewEnquiriyDetailPage?enquiryid=" + followups.getEnquirieid();
    }

    //insert new follow ups
    @RequestMapping(value = "insertFeedbackFollowups")
    public String insertFeedbackFollowups(@ModelAttribute Followups followups) {
        String prefix = env.getProperty("followups");
        String id = prefix + insertService.getmaxcount("followups", "id", 4);
        followups.setId(id);
        insertService.insert(followups);
        return "redirect:userFeedbackLink?fbid=" + followups.getFeedbackid();
    }

    //insert insurance expiring and all details
    @RequestMapping(value = "addInsurance")
    public String addInsurance(@ModelAttribute Insurance insurance) {
        String prefix = env.getProperty("insurance");
        String id = prefix + insertService.getmaxcount("insurance", "id", 5);
        insurance.setId(id);
        insertService.insert(insurance);
        return "redirect:viewInsuranceExpiringGridLink";
    }

    //crm code ends
    //========expense code begins=========
    @RequestMapping(value = "addPurchaseOrder")
    public String addPurchaseOrder(@ModelAttribute PurchaseOrder purchaseOrder, @ModelAttribute PurchaseOrderArray purchaseOrderArray) {
//        String prefix = env.getProperty("purchaseorder");
        List<Branch> prefixList = viewService.getanyhqldatalist("from branch where id='" + purchaseOrder.getBranchid() + "'");
        String poprefix = prefixList.get(0).getPurchase_ord_prefix();
        String id = poprefix + insertService.getmaxcount("purchaseorder", "id", 4);
        purchaseOrder.setId(id);
        //fetching limit information from limit approvals table
        String limit = env.getProperty("purchase_order_limit");
        List<ApprovalLimit> limitdtls = viewService.getanyhqldatalist("from approvallimit where id='" + limit + "'");
        if (Float.parseFloat(purchaseOrder.getFinaltotal()) <= Float.parseFloat(limitdtls.get(0).getAmount().toString())) {
            purchaseOrder.setStatus("Approved");
        } else {
            purchaseOrder.setStatus("Pending");
        }
        //-end! of fetching .status set.
        purchaseOrder.setBalance(purchaseOrder.getFinaltotal());
        insertService.insert(purchaseOrder);
        for (int i = 0; i < purchaseOrderArray.getPartid().length; i++) {
            PurchaseorderDetails purchaseorderDetails = new PurchaseorderDetails();
//            String prefix2 = env.getProperty("purchaseorderdetails");
            String poprefixdetail = prefixList.get(0).getPurchase_ord_detail_prefix();
            String id2 = poprefixdetail + insertService.getmaxcount("purchaseorderdetails", "id", 5);
            purchaseorderDetails.setId(id2);
            purchaseorderDetails.setBranddetailid(purchaseOrderArray.getBranddetailid()[i]);
            purchaseorderDetails.setPartid(purchaseOrderArray.getPartid()[i]);
            purchaseorderDetails.setManufacturerid(purchaseOrderArray.getManufacturerid()[i]);
            purchaseorderDetails.setPartQuantity(purchaseOrderArray.getPartQuantity()[i]);
            purchaseorderDetails.setItemtotal(purchaseOrderArray.getItemtotal()[i]);
            purchaseorderDetails.setPurchaseorderid(id);
            purchaseorderDetails.setCostprice(purchaseOrderArray.getCostprice()[i]);
            purchaseorderDetails.setSellingprice(purchaseOrderArray.getSellingprice()[i]);
            insertService.insert(purchaseorderDetails);
        }
        return "redirect:PurchaseOrderGridLink";
    }

    //insert po received
    @RequestMapping(value = "receivePurchaseOrder")
    public String receivePurchaseOrder(@ModelAttribute Inventory inventory, @ModelAttribute PurchaseOrderReceived purchaseOrderReceived) {

        for (int i = 0; i < purchaseOrderReceived.getPartids().length; i++) {
            //insert into inventory
            String prefix2 = env.getProperty("inventory");
            String id = prefix2 + insertService.getmaxcount("inventory", "id", 4);
            inventory.setId(id);
            inventory.setManufacturerid(purchaseOrderReceived.getManufacturerids()[i]);
            inventory.setQuantity(purchaseOrderReceived.getQuantitys()[i]);
            inventory.setSellingprice(purchaseOrderReceived.getSellingprices()[i]);
            inventory.setCostprice(purchaseOrderReceived.getCostprices()[i]);
            inventory.setPartid(purchaseOrderReceived.getPartids()[i]);
            inventory.setType("inward");
            insertService.insert(inventory);

            //insert in carparts available balance
            List<Map<String, Object>> qty = viewService.getanyjdbcdatalist("Select balancequantity from carpartinfo where id='" + inventory.getPartid() + "' and isdelete='No'");
            int a, temp;
            temp = Integer.parseInt(qty.get(0).get("balancequantity").toString());
            a = temp + Integer.parseInt(inventory.getQuantity());
            updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + a + "',modifydate=now() where id='" + inventory.getPartid() + "'");

            //update purchase order details with the status and bill number
            updateService.updateanyhqlquery("update  purchaseorderdetails  set isreceived='Received',modifydate=now(),billnumber='" + purchaseOrderReceived.getBillnumber()[i] + "' where id='" + purchaseOrderReceived.getOldpodsid()[i] + "'");

        }

        //update bill status to database also to general expense table insert
        if (purchaseOrderReceived.getPartids().length == purchaseOrderReceived.getTotalitems()) {
            updateService.updateanyhqlquery("update  purchaseorder set isreceived='Received',modifydate=now() where id='" + purchaseOrderReceived.getPoid() + "'");
        }
        if (purchaseOrderReceived.getPartids().length < purchaseOrderReceived.getTotalitems()) {
            updateService.updateanyhqlquery("update  purchaseorder set isreceived='Partial received',modifydate=now() where id='" + purchaseOrderReceived.getPoid() + "'");
        }
        return "redirect:PurchaseOrderGridLink";
    }

    //code to insert in expense bill date and bill number in purdchase order
    @RequestMapping(value = "insertPurchaseOrderToExpense")
    public String insertPurchaseOrderToExpense(@ModelAttribute PurchaseOrderReceived purchaseOrderReceived) {

        //code to CHECK WHETHER TO UPDATE gENERAL EXPENSE
        String po_of_Branch = purchaseOrderReceived.getPoid().substring(0, 1);
        if (po_of_Branch.equals(env.getProperty("branch_prefix"))) {
            //get actual expense_billnumber details here will also return the final amount of general expense on which tax is to be applied
            List<Map<String, Object>> podetailList = viewService.getanyjdbcdatalist("SELECT *,sum(itemtotal) as expenseamount FROM purchaseorderdetails\n"
                    + "where purchaseorderid='" + purchaseOrderReceived.getPoid() + "' group by expense_billnumber");

            //get tax applied from here and vendor deails also
            List<Map<String, Object>> poList = viewService.getanyjdbcdatalist("SELECT po.*,vn.name as vendorname FROM purchaseorder po\n"
                    + "inner join vendor vn on vn.id=po.vendorid\n"
                    + "where po.id='" + purchaseOrderReceived.getPoid() + "'");

            for (int i = 0; i < podetailList.size(); i++) {
                //check if the po number and bill number entry already exist in general expense starts here
                List<GeneralExpense> generalExpenseList = viewService.getanyhqldatalist("from generalexpense where purchaseorderid='" + purchaseOrderReceived.getPoid() + "' and expense_billnumber='" + podetailList.get(i).get("expense_billnumber") + "'");

                //if exist then update the details in general expense.....else insert into general expense
                GeneralExpense generalExpense = new GeneralExpense();
                if (generalExpenseList.size() > 0) {
                    generalExpense.setId(generalExpenseList.get(0).getId());
                    generalExpense.setLedgerid(generalExpenseList.get(0).getLedgerid());
                    generalExpense.setTowards(generalExpenseList.get(0).getTowards());
                    generalExpense.setTax(generalExpenseList.get(0).getTax());
                    generalExpense.setTaxid(generalExpenseList.get(0).getTaxid());
                    generalExpense.setAmount(podetailList.get(i).get("expenseamount").toString());

                    //calculate tax amount
                    float taxpercent = Float.parseFloat(generalExpenseList.get(0).getTax());
                    float amount = Float.parseFloat(podetailList.get(i).get("expenseamount").toString());
                    float total = amount * taxpercent / 100;
                    float grandtotal = amount + total;
                    generalExpense.setTotal(Float.toString(grandtotal));

                    generalExpense.setPurchaseorderid(purchaseOrderReceived.getPoid());
                    generalExpense.setBankname(generalExpenseList.get(0).getBankname());
                    generalExpense.setMode(generalExpenseList.get(0).getMode());
                    generalExpense.setChequedate(generalExpenseList.get(0).getChequedate());
                    generalExpense.setChequenumber(generalExpenseList.get(0).getChequenumber());
                    generalExpense.setTransactiondate(generalExpenseList.get(0).getTransactiondate());
                    generalExpense.setTransactionnumber(generalExpenseList.get(0).getTransactionnumber());
                    generalExpense.setVouchernumber(generalExpenseList.get(0).getVouchernumber());
                    //more values set here because of changes made ..
                    generalExpense.setVat_tax(generalExpenseList.get(0).getVat_tax());
                    generalExpense.setService_tax(generalExpenseList.get(0).getService_tax());
                    generalExpense.setVat_service_tax(generalExpenseList.get(0).getVat_service_tax());
                    generalExpense.setTax_applicable(generalExpenseList.get(0).getTax_applicable());
                    generalExpense.setExpense_date(generalExpenseList.get(0).getExpense_date());
                    generalExpense.setStatus(generalExpenseList.get(0).getStatus());
                    generalExpense.setSubadminapproval(generalExpenseList.get(0).getSubadminapproval());
                    generalExpense.setAcceptance(generalExpenseList.get(0).getAcceptance());
                    generalExpense.setMode(generalExpenseList.get(0).getMode());

                    if (podetailList.get(i).get("expense_billnumber") != null) {
                        generalExpense.setExpense_billnumber(podetailList.get(i).get("expense_billnumber").toString());
                    }
                    if (podetailList.get(i).get("bill_date") != null) {
                        generalExpense.setBill_date(podetailList.get(i).get("bill_date").toString());
                    }
                    updateService.update(generalExpense);
                } else {
                    //setting the general expense fields as per data from purchase order
                    String prefix2 = env.getProperty("generalexpense");
                    String id = prefix2 + insertService.getmaxcount("generalexpense", "id", 4);
                    generalExpense.setId(id);
                    String ledgerid = env.getProperty("expense_ledgerid");
                    generalExpense.setLedgerid(ledgerid);
                    generalExpense.setTowards(poList.get(0).get("vendorname").toString());
                    generalExpense.setTax(poList.get(0).get("tax").toString());
                    generalExpense.setTaxid(poList.get(0).get("taxid").toString());
                    generalExpense.setAmount(podetailList.get(i).get("expenseamount").toString());

                    //calculate tax amount
                    float taxpercent = Float.parseFloat(poList.get(0).get("tax").toString());
                    float amount = Float.parseFloat(podetailList.get(i).get("expenseamount").toString());
                    float total = amount * taxpercent / 100;
                    float grandtotal = amount + total;
                    generalExpense.setTotal(Float.toString(grandtotal));

                    generalExpense.setPurchaseorderid(poList.get(0).get("id").toString());
                    generalExpense.setBankname("");
                    generalExpense.setMode("");
                    generalExpense.setChequedate("");
                    generalExpense.setChequenumber("");
                    generalExpense.setTransactiondate("");
                    generalExpense.setTransactionnumber("");
                    generalExpense.setVouchernumber("");
                    //more values set here because of changes made ..
                    generalExpense.setVat_tax(poList.get(0).get("taxamount").toString());
                    generalExpense.setService_tax("0");
                    generalExpense.setVat_service_tax("0");
                    generalExpense.setTax_applicable("normal");
                    generalExpense.setExpense_date(poList.get(0).get("date").toString());
                    generalExpense.setStatus(poList.get(0).get("acceptance").toString());
                    generalExpense.setSubadminapproval(poList.get(0).get("acceptance").toString());
                    generalExpense.setAcceptance(poList.get(0).get("acceptance").toString());
                    generalExpense.setMode("Cash");
                    System.out.println("i ka value: " + i);
                    if (podetailList.get(i).get("expense_billnumber") != null) {
                        generalExpense.setExpense_billnumber(podetailList.get(i).get("expense_billnumber").toString());
                    }
                    if (podetailList.get(i).get("bill_date") != null) {
                        generalExpense.setBill_date(podetailList.get(i).get("bill_date").toString());
                    }

                    insertService.insert(generalExpense);
                }
            }

            //code to delete General expense entry begin here
            List<GeneralExpense> generalExpensePoList = viewService.getanyhqldatalist("from generalexpense where purchaseorderid='" + purchaseOrderReceived.getPoid() + "' and isdelete='No'");

            //code to delete General expense entry ends!!! here
            //VOHI DELETE KARNA HAI JO PO WALE ME NAHI HAI FROM GENEREAL EXPENSE
            List expense_billLis = new ArrayList();
            for (int i = 0; i < podetailList.size(); i++) {
                expense_billLis.add(podetailList.get(i).get("expense_billnumber"));
            }

            for (int i = 0; i < generalExpensePoList.size(); i++) {
                if (!expense_billLis.contains(generalExpensePoList.get(i).getExpense_billnumber())) {
                    updateService.updateanyhqlquery("update generalexpense set isdelete='Yes' where id='" + generalExpensePoList.get(i).getId() + "'");
                }
            }
        }
        //code to CHECK WHETHER TO UPDATE gENERAL EXPENSE

        return "redirect:PurchaseOrderGridLink";
    }
    //code to insert in expense bill date and bill number in purdchase order ends!! here

    //insert into approval limit table 
    @RequestMapping(value = "addApprovalLimit")
    public String addApprovalLimit(@ModelAttribute ApprovalLimit approvalLimit) {
        String prefix2 = env.getProperty("approvallimit");
        String id = prefix2 + insertService.getmaxcount("approvallimit", "id", 4);
        approvalLimit.setId(id);
        insertService.insert(approvalLimit);
        return "redirect:approvalMasterLink";
    }

    //insert ino general expense
    @RequestMapping(value = "addGeneralExpense")
    public String addGeneralExpense(@ModelAttribute GeneralExpense generalExpense, @RequestParam(value = "tax_amount", required = false) String tax_amount, @RequestParam(value = "vattax", required = false) String vattax, @RequestParam(value = "servicetax", required = false) String servicetax) {
        String prefix2 = env.getProperty("generalexpense");
        String id = prefix2 + insertService.getmaxcount("generalexpense", "id", 4);
        generalExpense.setId(id);

        if (generalExpense.getTax_applicable().equals("N/A")) {
            generalExpense.setTax("0");
            generalExpense.setTaxid("ATX3");
            generalExpense.setVat_tax("0");
            generalExpense.setService_tax("0");
            generalExpense.setVat_service_tax("0");
            generalExpense.setTotal(generalExpense.getAmount());
        }

        //code for handling the tax type begin here
        if (generalExpense.getTaxid().equals("ATX1")) {
            generalExpense.setVat_tax(tax_amount);
        } else if (generalExpense.getTaxid().equals("ATX2")) {
            generalExpense.setService_tax(tax_amount);
        } else if (generalExpense.getTaxid().equals("ATX3")) {
            generalExpense.setVat_tax("0");
            generalExpense.setService_tax("0");
            generalExpense.setVat_service_tax("0");
        } else if (generalExpense.getTaxid().equals("ATX4")) {
            generalExpense.setVat_tax(vattax);
            generalExpense.setService_tax(servicetax);
            generalExpense.setVat_service_tax(tax_amount);
        }
        //code for handling the tax type end! here

        //fetching limit information from limit approvals table
        String limit = env.getProperty("general_expense_limit");
        List<ApprovalLimit> limitdtls = viewService.getanyhqldatalist("from approvallimit where id='" + limit + "'");
        if (Float.parseFloat(generalExpense.getTotal()) <= Float.parseFloat(limitdtls.get(0).getAmount().toString())) {
            generalExpense.setStatus("Approved");
            generalExpense.setSubadminapproval("Approved");
            generalExpense.setAcceptance("Approved");
        } else {
            generalExpense.setStatus("Pending");
            generalExpense.setSubadminapproval("Pending");
            generalExpense.setAcceptance("Pending");
        }
        //-end! of fetching .status set.

        insertService.insert(generalExpense);
        return "redirect:generalExpenseLink";
    }

//    feature Feedback code begins here
    //add feedback
    @RequestMapping(value = "insertFeedback")
    public String insertFeedback(@ModelAttribute Feedback feedback) {
        feedback.setStatus("complete");
        updateService.update(feedback);
        return "redirect:fbgridLink";
    }

    //adding attendance here
//    @RequestMapping(value = "insertAttendance")
//    public String insertAttendance(@ModelAttribute Attendance attendance, @RequestParam(value = "employee_ids") List employee_ids, @RequestParam(value = "attendanceStatus") List attendanceStatus) {
//
//        //setting various satus for employee attendance
//        for (int i = 0; i < employee_ids.size(); i++) {
//            attendance.setEmployee_id(employee_ids.get(i).toString());
//            if (attendanceStatus.get(i).toString().equals("Present")) {
//                attendance.setStatus("P");
//            }
//
//            if (attendanceStatus.get(i).toString().equals("Absent")) {
//                attendance.setStatus("A");
//            }
//
//            if (attendanceStatus.get(i).toString().equals("Half-day")) {
//                attendance.setStatus("H");
//            }
//
//            if (attendanceStatus.get(i).toString().equals("Overtime")) {
//                attendance.setStatus("O");
//            }
//
//            if (attendanceStatus.get(i).toString().equals("Holiday")) {
//                attendance.setStatus("OF");
//            }
//
//            if (attendanceStatus.get(i).toString().equals("N/A")) {
//                attendance.setStatus("N/A");
//            }
//            
//            String id = "LATT" + insertService.getmaxcount("attendance", "id", 5);
//            attendance.setId(id);
//
//            insertService.insert(attendance);
//        }
//        return "redirect:attendanceAddLink";
//    }
    @RequestMapping(value = "insertAttendance")
    public String insertAttendance(@RequestParam(value = "employee_ids") List employee_ids, @RequestParam(value = "attendanceStatus") List attendanceStatus) {
        //getting month
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
        Date date = new Date();
        String month = dateFormat.format(date);

        //getting date
        DateFormat dateFormat2 = new SimpleDateFormat("dd");
        Date date2 = new Date();
        String columnname = dateFormat2.format(date2);

        //getting the date to update the respected date column
//        String columnname = myday.replaceFirst("^0+(?!$)", "");
        //preparing status abbreivation to update in table
        for (int i = 0; i < employee_ids.size(); i++) {
            String setStatus = "";
            if (attendanceStatus.get(i).toString().equals("Present")) {
                setStatus = "P";
            }

            if (attendanceStatus.get(i).toString().equals("Absent")) {
                setStatus = "A";
            }

            if (attendanceStatus.get(i).toString().equals("Half-day")) {
                setStatus = "H";
            }

            if (attendanceStatus.get(i).toString().equals("Overtime")) {
                setStatus = "O";
            }

            if (attendanceStatus.get(i).toString().equals("Holiday")) {
                setStatus = "OF";
            }

            if (attendanceStatus.get(i).toString().equals("N/A")) {
                setStatus = "N/A";
            }
            String updateQuery = "update daily_attendance set `" + columnname + "`='" + setStatus + "',modifydate=now() where employee_id='" + employee_ids.get(i).toString() + "' and month='" + month + "' ";

            List<Map<String, Object>> employeeCheck = viewService.getanyjdbcdatalist("select * from daily_attendance where month='" + month + "' and employee_id='" + employee_ids.get(i).toString() + "'");
            if (employeeCheck.size() > 0) {
                updateService.updateanyhqlquery(updateQuery);
            } else {
                String prefix2 = env.getProperty("daily_attendance");
                String id = prefix2 + insertService.getmaxcount("daily_attendance", "id", 5);
                try {
                    String query = "INSERT INTO daily_attendance(id, employee_id, month)VALUES ('" + id + "', '" + employee_ids.get(i).toString() + "', '" + month + "')";
                    insertService.setanyjdbcdatalist(query);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                updateService.updateanyhqlquery(updateQuery);
            }

        }
        return "redirect:attendanceAddLink";
    }

    //rediret to the grid page after isnerting in the data
    @RequestMapping(value = "addCustomerAdvance")
    public String addCustomerAdvance(@ModelAttribute CustomerAdvance customerAdvance) {
        String prefix2 = env.getProperty("customer_advance");
        String id = prefix2 + insertService.getmaxcount("customer_advance", "id", 4);
        customerAdvance.setId(id);
        insertService.insert(customerAdvance);
        List<Customer> customerlist = viewService.getanyhqldatalist("from customer  where id='" + customerAdvance.getCustomerid() + "'");
        float basicamount = customerlist.get(0).getAdvance_amount();
        float finalamount = basicamount + customerAdvance.getAdvance_amount();
        updateService.updateanyhqlquery("update customer set advance_amount='" + finalamount + "',modifydate=now() where id='" + customerAdvance.getCustomerid() + "'");
        return "redirect:customerAdvanceGridLink";
    }

    //end of customer advance
    //add pay ment module begin here=========
    //inserts payment 
    @RequestMapping(value = "addPayment")
    public String addPayment(@ModelAttribute Payment payment,
            @RequestParam(value = "negativepayableinvoiceamount", required = false) String negativepayableinvoiceamount,
            @RequestParam(value = "payableinvoiceamount") String payableinvoiceamount,
            @RequestParam(value = "balanceadvanceamount", required = false) String balanceadvanceamount,
            @ModelAttribute GeneralIncome generalIncome,
            @RequestParam(value = "tax_amount", required = false) String tax_amount,
            @RequestParam(value = "jobno", required = false) String jobno,
            @RequestParam(value = "vattax", required = false) String vattax,
            @RequestParam(value = "servicetax", required = false) String servicetax,
            @RequestParam(value = "writeoff", required = false) String writeoff) {

        //inserts to payment table
        String prefix2 = env.getProperty("payment");
        String id3 = prefix2 + insertService.getmaxcount("payment", "id", 4);
        payment.setId(id3);
        insertService.insert(payment);
        //end of insert to payment

        //insert into general income code begin here
        String prefix3 = env.getProperty("generalincome");
        String id = prefix3 + insertService.getmaxcount("generalincome", "id", 4);

        generalIncome.setId(id);
        if (generalIncome.getTax_applicable().equals("N/A")) {
            generalIncome.setTax("0");
            generalIncome.setTaxid("ATX3");
            generalIncome.setVat_tax("0");
            generalIncome.setService_tax("0");
            generalIncome.setVat_service_tax("0");
            generalIncome.setTotal(generalIncome.getAmount());
        }

        //code for handling the tax type begin here
        if (generalIncome.getTaxid().equals("ATX1")) {
            generalIncome.setVat_tax(tax_amount);
        } else if (generalIncome.getTaxid().equals("ATX2")) {
            generalIncome.setService_tax(tax_amount);
        } else if (generalIncome.getTaxid().equals("ATX3")) {
            generalIncome.setVat_tax("0");
            generalIncome.setService_tax("0");
            generalIncome.setVat_service_tax("0");
        } else if (generalIncome.getTaxid().equals("ATX4")) {
            generalIncome.setVat_tax(vattax);
            generalIncome.setService_tax(servicetax);
            generalIncome.setVat_service_tax(tax_amount);
        }
        //code for handling the tax type end! here
        generalIncome.setVouchernumber("");

        insertService.insert(generalIncome);
        //insert into general income code ends! here

        //update invoice table with the balance payment
        double payablecheck = Double.parseDouble(payableinvoiceamount);
        double negativepayablecheck;
        if (negativepayableinvoiceamount.equals("")) {
            negativepayablecheck = 0;
        } else {
            negativepayablecheck = Double.parseDouble(negativepayableinvoiceamount);
        }
        if (payableinvoiceamount.equals("0.00")) {
            if (jobno != null && !jobno.isEmpty()) {
                hideSteps(jobno);
            }
            updateService.updateanyhqlquery("update invoice set balanceamount='" + payableinvoiceamount + "', ispaid='Yes',modifydate=now() where id='" + payment.getInvoiceid() + "'");
        } else if (payableinvoiceamount.equals("0")) {
            if (jobno != null && !jobno.isEmpty()) {
                hideSteps(jobno);
            }
            updateService.updateanyhqlquery("update invoice set balanceamount='" + payableinvoiceamount + "', ispaid='Yes',modifydate=now() where id='" + payment.getInvoiceid() + "'");
        } else {
            updateService.updateanyhqlquery("update invoice set balanceamount='" + payableinvoiceamount + "',modifydate=now() where id='" + payment.getInvoiceid() + "'");
        }
        if (negativepayablecheck < 0) {
            double sundrydr = Math.abs(Double.parseDouble(negativepayableinvoiceamount));
            updateService.updateanyhqlquery("update invoice set balanceamount='0', ispaid='Yes', sundry_debitors='" + sundrydr + "',modifydate=now() where id='" + payment.getInvoiceid() + "'");
        }
        //end of updating invoice balance.

        //update the customer advance amount in customer master
        if (balanceadvanceamount != null) {
            updateService.updateanyhqlquery("update customer set advance_amount='" + balanceadvanceamount + "',modifydate=now() where id='" + payment.getCustomerid() + "'");
        }
        
        //code for writeoff goes here
        if (writeoff.equals("ON")) {
            updateService.updateanyhqlquery("update invoice set balanceamount='0', writeoff='"+payableinvoiceamount+"',modifydate=now() where id='" + payment.getInvoiceid() + "'");
        }
        return "redirect:invoiceMasterLink";
    }

    //code to hide all steps f this customer here
    public void hideSteps(String jobno) {
        List<Jobsheet> idlist = viewService.getanyhqldatalist("from jobsheet where id='" + jobno + "'");
        String estimateid = (String) idlist.get(0).getEstimateid();
        String servicechecklistid = (String) idlist.get(0).getCvid();
        List<Estimate> idlist2 = viewService.getanyhqldatalist("from estimate where id='" + estimateid + "'");
        String pointchecklist = (String) idlist2.get(0).getPclid();
        updateService.updateanyhqlquery("update jobsheet set ishidden='Yes',modifydate=now() where id='" + jobno + "'");
        updateService.updateanyhqlquery("update pointchecklist set ishidden='Yes',modifydate=now() where id='" + pointchecklist + "'");
        updateService.updateanyhqlquery("update estimate set ishidden='Yes',modifydate=now() where id='" + estimateid + "'");
        updateService.updateanyhqlquery("update customervehicles set ishidden='Yes',modifydate=now() where id='" + servicechecklistid + "'");

    }

//    @RequestMapping
    //general income module begin here
    //insert ino general expense
    @RequestMapping(value = "addGeneralIncome")
    public String addGeneralIncome(@ModelAttribute GeneralIncome generalIncome, @RequestParam(value = "tax_amount", required = false) String tax_amount, @RequestParam(value = "vattax", required = false) String vattax, @RequestParam(value = "servicetax", required = false) String servicetax) {
        String prefix2 = env.getProperty("generalincome");
        String id = prefix2 + insertService.getmaxcount("generalincome", "id", 4);

        generalIncome.setId(id);
        if (generalIncome.getTax_applicable().equals("N/A")) {
            generalIncome.setTax("0");
            generalIncome.setTaxid("ATX3");
            generalIncome.setVat_tax("0");
            generalIncome.setService_tax("0");
            generalIncome.setVat_service_tax("0");
            generalIncome.setTotal(generalIncome.getAmount());
        }

        //code for handling the tax type begin here
        if (generalIncome.getTaxid().equals("ATX1")) {
            generalIncome.setVat_tax(tax_amount);
        } else if (generalIncome.getTaxid().equals("ATX2")) {
            generalIncome.setService_tax(tax_amount);
        } else if (generalIncome.getTaxid().equals("ATX3")) {
            generalIncome.setVat_tax("0");
            generalIncome.setService_tax("0");
            generalIncome.setVat_service_tax("0");
        } else if (generalIncome.getTaxid().equals("ATX4")) {
            generalIncome.setVat_tax(vattax);
            generalIncome.setService_tax(servicetax);
            generalIncome.setVat_service_tax(tax_amount);
        }
        //code for handling the tax type end! here

        insertService.insert(generalIncome);
        return "redirect:generalIncomeLink";
    }

    @RequestMapping(value = "addReminderCustomer")
    public String addReminderCustomer(@ModelAttribute ReminderCustomer reminderCustomer) {
        String prefix2 = env.getProperty("reminder_customer");
        String id = prefix2 + insertService.getmaxcount("reminder_customer", "id", 4);
        reminderCustomer.setId(id);
        insertService.insert(reminderCustomer);
        return "redirect:reminderCustomerLink";
    }

    //code to insert purchase order from spares login
    @RequestMapping(value = "savepurchaseorder")
    public String savepurchaseorder(@RequestParam(value = "branchid") TreeSet<String> branchids, @RequestParam(value = "vendorid") TreeSet<String> vendorids, @ModelAttribute PurchaseOrderArraySpares orderArraySpares) {
        List<Map<String, Object>> Mylist = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < orderArraySpares.getPartid().size(); i++) {
            Map<String, Object> setmap = new HashMap<String, Object>();
            setmap.put("branchid", orderArraySpares.getBranchid().get(i));
            setmap.put("vendorid", orderArraySpares.getVendorid().get(i));
            setmap.put("partid", orderArraySpares.getPartid().get(i));
            setmap.put("manufacturerid", orderArraySpares.getManufacturerid().get(i));
            setmap.put("branddetailid", orderArraySpares.getBranddetailid().get(i));
            setmap.put("costprice", orderArraySpares.getCostprice().get(i));
            setmap.put("sellingprice", orderArraySpares.getSellingprice().get(i));
            setmap.put("partQuantity", orderArraySpares.getPartQuantity().get(i));
            setmap.put("itemtotal", orderArraySpares.getItemtotal().get(i));
            Mylist.add(setmap);
        }
        List<String> purchaseOrderList = new ArrayList<String>();

        for (String branch : branchids) {
            PurchaseOrder purchaseOrder = new PurchaseOrder();
            PurchaseorderDetails purchaseorderDetails = new PurchaseorderDetails();

            for (String vendor : vendorids) {
                boolean isPurchaseOrderCreated = false;

                for (int k = 0; k < Mylist.size(); k++) {
                    List<Branch> prefixList = viewService.getanyhqldatalist("from branch where id='" + branch + "'");
                    if (!isPurchaseOrderCreated) {
                        if (Mylist.get(k).get("branchid").equals(branch) && Mylist.get(k).get("vendorid").equals(vendor)) {

                            String poprefix = prefixList.get(0).getPurchase_ord_prefix();
                            String id = poprefix + insertService.getmaxcount("purchaseorder", "id", 4);
                            purchaseOrder.setId(id);
                            purchaseOrder.setVendorid(vendor);
                            purchaseOrder.setBranchid(branch);
                            purchaseOrder.setComment(" ");
                            isPurchaseOrderCreated = true;
                            purchaseOrderList.add(id);

                            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            Date date = new Date();
                            String today = dateFormat.format(date);
                            purchaseOrder.setDate(today);

                            insertService.insert(purchaseOrder);
                            String poprefixdetail = prefixList.get(0).getPurchase_ord_detail_prefix();
                            String id2 = poprefixdetail + insertService.getmaxcount("purchaseorderdetails", "id", 5);
                            purchaseorderDetails.setId(id2);
                            purchaseorderDetails.setBranddetailid(Mylist.get(k).get("branddetailid").toString());
                            purchaseorderDetails.setPartid(Mylist.get(k).get("partid").toString());
                            purchaseorderDetails.setManufacturerid(Mylist.get(k).get("manufacturerid").toString());
                            purchaseorderDetails.setPartQuantity(Mylist.get(k).get("partQuantity").toString());
                            purchaseorderDetails.setItemtotal(Mylist.get(k).get("itemtotal").toString());
                            purchaseorderDetails.setPurchaseorderid(id);
                            purchaseorderDetails.setCostprice(Mylist.get(k).get("costprice").toString());
                            purchaseorderDetails.setSellingprice(Mylist.get(k).get("sellingprice").toString());
                            insertService.insert(purchaseorderDetails);
                        }
                    } else {
                        if (Mylist.get(k).get("branchid").equals(branch) && Mylist.get(k).get("vendorid").equals(vendor)) {

                            String poprefixdetail = prefixList.get(0).getPurchase_ord_detail_prefix();
                            String id2 = poprefixdetail + insertService.getmaxcount("purchaseorderdetails", "id", 5);
                            purchaseorderDetails.setId(id2);
                            purchaseorderDetails.setBranddetailid(Mylist.get(k).get("branddetailid").toString());
                            purchaseorderDetails.setPartid(Mylist.get(k).get("partid").toString());
                            purchaseorderDetails.setManufacturerid(Mylist.get(k).get("manufacturerid").toString());
                            purchaseorderDetails.setPartQuantity(Mylist.get(k).get("partQuantity").toString());
                            purchaseorderDetails.setItemtotal(Mylist.get(k).get("itemtotal").toString());
                            purchaseorderDetails.setPurchaseorderid(purchaseOrder.getId());
                            purchaseorderDetails.setCostprice(Mylist.get(k).get("costprice").toString());
                            purchaseorderDetails.setSellingprice(Mylist.get(k).get("sellingprice").toString());
                            insertService.insert(purchaseorderDetails);
                        }
                    }
                }
            }
        }

        //update missing fields
        //getting vat value id for vat is :ATX1
        String vatTaxid = "ATX1";
        List<Taxes> taxList = viewService.getanyhqldatalist("from taxes where id='" + vatTaxid + "'");
        String limit = env.getProperty("purchase_order_limit");
        List<ApprovalLimit> limitdtls = viewService.getanyhqldatalist("from approvallimit where id='" + limit + "'");
        for (int i = 0; i < purchaseOrderList.size(); i++) {
            String status;
            List<Map<String, Object>> podetailSum = viewService.getanyjdbcdatalist("SELECT sum(itemtotal) sparepartfinal FROM purchaseorderdetails where purchaseorderid='" + purchaseOrderList.get(i) + "' and isdelete='No'");
            Double taxTotal = Double.parseDouble(podetailSum.get(0).get("sparepartfinal").toString()) * Double.parseDouble(taxList.get(0).getPercent()) / 100;
            Double finalTotal = Double.parseDouble(podetailSum.get(0).get("sparepartfinal").toString()) + taxTotal;

            //fetching limit information from limit approvals table
            if (finalTotal <= Double.parseDouble(limitdtls.get(0).getAmount())) {
                status = "Approved";
            } else {
                status = "Pending";
            }
            //-end! of fetching .status set.
            String poid = purchaseOrderList.get(i).toString();
            System.out.println("nityanand " + poid);

//            updateService.updateanyhqlquery("update purchaseorder set paymentterms='7', finaltotal='" + finalTotal + "',balance='" + finalTotal + "', taxid='" + vatTaxid + "', taxamount='" + taxTotal + "',tax='" + taxList.get(0).getPercent() + "' sparepartsfinal='" + podetailSum.get(0).get("sparepartfinal").toString() + "', status='" + status + "',isreceived='Not received' where id='" + purchaseOrderList.get(i) + "'");
            updateService.updateanyjdbcdatalist("update purchaseorder set paymentterms='7', finaltotal='" + finalTotal + "',balance='" + finalTotal + "', taxid='" + vatTaxid + "', taxamount='" + taxTotal + "',tax='" + taxList.get(0).getPercent() + "', sparepartsfinal='" + podetailSum.get(0).get("sparepartfinal").toString() + "', status='" + status + "',isreceived='Not received' where id='" + poid + "'");
        }

        return "redirect:lowQuantityPartPageLink";

    }

    //rediredt to add reminder page
    @RequestMapping(value = "accepttheseItems")
    public String accepttheseItems(@RequestParam(value = "id") String transferid) {
        List<InventoryTransfer> transfers = viewService.getanyhqldatalist("from inventory_transfer where id='" + transferid + "'");
        Inventory inventory = new Inventory();
        String pre = env.getProperty("inventory");
        String id = pre + insertService.getmaxcount("inventory", "id", 4);
        inventory.setId(id);
        inventory.setPartid(transfers.get(0).getPartid());
        inventory.setType("inward");
        inventory.setCostprice(transfers.get(0).getCostprice());
        inventory.setSellingprice(transfers.get(0).getSellingprice());
        inventory.setQuantity(transfers.get(0).getQuantity());
        inventory.setManufacturerid(transfers.get(0).getManufacturerid());
        inventory.setVendor(transfers.get(0).getVendor());
        insertService.insert(inventory);
        //insert into inventory table complete

        //updating inventory transfer complete here
        List<Map<String, Object>> qty = viewService.getanyjdbcdatalist("Select balancequantity from carpartinfo where id='" + inventory.getPartid() + "' and isdelete='No'");
        int a, temp;
        temp = Integer.parseInt(qty.get(0).get("balancequantity").toString());
        a = temp + Integer.parseInt(inventory.getQuantity());
        updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + a + "',modifydate=now() where id='" + inventory.getPartid() + "'");

        //updating inventory transfer begin here
        updateService.updateanyhqlquery("update inventory_transfer set is_transferred='Yes' where id='" + transferid + "'");
        return "redirect:viewreceivables";
    }

    //code for consumable begin here
    @RequestMapping(value = "saveConsumable")
    public String saveConsumable(@ModelAttribute ConsumableDtoArray dtoArray, @RequestParam(value = "myjsid") String jobsheetid) {

        //code for insert in consumable detail table begin here
        for (int i = 0; i < dtoArray.getPartid().length; i++) {
            ConsumableDetails details = new ConsumableDetails();
            String pre = env.getProperty("consumable_details");
            String id = pre + insertService.getmaxcount("consumable_details", "id", 4);
            details.setId(id);
            details.setJobsheetid(jobsheetid);
            details.setPartid(dtoArray.getPartid()[i]);
            details.setType("outward");
            details.setSellingprice(dtoArray.getSellingprice()[i]);
            details.setQuantity(dtoArray.getQuantity()[i]);
            details.setManufacturerid(dtoArray.getManufacturerid()[i]);
            details.setTotal(dtoArray.getTotal()[i]);

            //code to update carpartinfo begin here
            int partqty = Integer.parseInt(dtoArray.getQuantity()[i]);
            CarPartInfo c = (CarPartInfo) viewService.getspecifichqldata(CarPartInfo.class, dtoArray.getPartid()[i]);
            int availableqty = Integer.parseInt(c.getBalancequantity());
            int result = availableqty - partqty;
            updateService.updateanyhqlquery("update  carpartinfo  set balancequantity='" + result + "',modifydate=now() where id='" + dtoArray.getPartid()[i] + "'");
            //code to update carpartinfo ends! here

            insertService.insert(details);
            //code for insert in consumable detail table ends! here

            //code for insert into invenory begins here
            Inventory inventory = new Inventory();
            String pree = env.getProperty("inventory");
            String inventoryid = pree + insertService.getmaxcount("inventory", "id", 4);
            inventory.setId(inventoryid);
            inventory.setPartid(dtoArray.getPartid()[i]);
            inventory.setJobsheetid(jobsheetid);
            inventory.setType("outward");
            inventory.setSellingprice(Float.parseFloat(dtoArray.getSellingprice()[i]));
            inventory.setQuantity(dtoArray.getQuantity()[i]);
            inventory.setManufacturerid(dtoArray.getManufacturerid()[i]);
            inventory.setTotal(dtoArray.getTotal()[i]);
            inventory.setConsumableid(id);
            insertService.insert(inventory);
            //code for insert into invenory ends! here
        }

        return "redirect:viewSpareRequisitionGrid";
    }
}
