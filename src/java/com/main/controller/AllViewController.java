/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.google.gson.Gson;
import com.main.mailer.CustomerSms;
import com.main.mailer.EmailSessionBean;
import com.main.model.Branch;
import com.main.model.Brand;
import com.main.model.BrandDetails;
import com.main.model.CarPartInfo;
import com.main.model.CarPartVault;
import com.main.model.CarParts;
import com.main.model.Category;
import com.main.model.Customer;
import com.main.model.CustomerVehicles;
import com.main.model.Enquiries;
import com.main.model.Estimate;
import com.main.model.EstimateDetails;
import com.main.model.Followups;
import com.main.model.Inventory;
import com.main.model.Invoice;
import com.main.model.Jobsheet;
import com.main.model.Manufacturer;
import com.main.model.LabourServices;
import com.main.model.PointChecklist;
import com.main.model.Taxes;
import com.main.model.UserDetails;
import com.main.model.Vendor;
import com.main.model.Workman;
import com.main.service.AllInsertService;
import com.main.service.AllViewService;
import com.main.sync.CarpartsSynchronization;
import com.main.sync.Synchronization;
import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
@Controller
public class AllViewController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    Environment env;

    @RequestMapping(value = {"/", "Login"})
    public String redirectdemo() {
        return "Login";
    }

    //user requesto access and delete car part option thus the coding begin here
    @RequestMapping(value = "viewCarVaultLink")
    public ModelAndView viewCarVaultLink() {
        ModelAndView modelAndView = new ModelAndView("ViewCarPartVaultGrid");
        modelAndView.addObject("vaultDetails", viewService.getanyjdbcdatalist("SELECT cpv.name as carpartvaultname,cpv.id as cpvid,cg.name as categoryname,cg.id as cgid FROM carpartvault cpv\n"
                + "inner join category cg on cg.id=cpv.categoryid\n"
                + "where cpv.isdelete='No'"));
        return modelAndView;
    }

//    spareparts modification coding begin here nothing changes in logic just the page view is created again 
    //view vehicle list for the brand selected to view parts
    @RequestMapping(value = "viewVehicleList")
    public ModelAndView viewVehicleList() {
        ModelAndView modelAndView = new ModelAndView("ViewSparesCarList");
        modelAndView.addObject("sparesVehicleDetails", viewService.getanyjdbcdatalist("SELECT *,bd.id as branddetailid FROM branddetails bd\n"
                + "inner join brand br on br.id=bd.brandid\n"
                + "where bd.isdelete='No' and bd.id not in ('" + env.getProperty("generic_brand_detailid") + "','" + env.getProperty("consumable_brand_detailid") + "')"));
        return modelAndView;
    }

    //view viewSparesList for the vehicle model selected
    @RequestMapping(value = "viewSparesList")
    public ModelAndView viewSparesList(@RequestParam(value = "id") String branddetailid) {
        ModelAndView modelAndView = new ModelAndView("ViewSparepartList");
        modelAndView.addObject("sparepartdetails", viewService.getanyjdbcdatalist("SELECT cpi.*,cpv.name as partname,cg.name as categoryname FROM carpartinfo cpi \n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join category cg on cg.id=cpv.categoryid\n"
                + "where cpi.branddetailid='" + branddetailid + "' and cpi.isdelete='No' and cpi.balancequantity>='0'"));
        modelAndView.addObject("negativesparepartdetails", viewService.getanyjdbcdatalist("SELECT cpi.*,cpv.name as partname,cg.name as categoryname FROM carpartinfo cpi \n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join category cg on cg.id=cpv.categoryid\n"
                + "where cpi.branddetailid='" + branddetailid + "' and cpi.isdelete='No' and cpi.balancequantity<'0'"));
        return modelAndView;
    }

    //redirects to add new car part page with category details in it
    @RequestMapping("CreateCarParts")
    public ModelAndView CreateCarParts() {
        ModelAndView modelAndView = new ModelAndView("AddCarParts");
        modelAndView.addObject("catdtls", viewService.getanyhqldatalist("from category where isdelete<>'Yes'"));
        return modelAndView;
    }

    //redirects to add new car part page with category details in it
    @RequestMapping("CreateGenericCarParts")
    public ModelAndView CreateGenericCarParts() {
        ModelAndView modelAndView = new ModelAndView("AddGenericCarParts");
        modelAndView.addObject("catdtls", viewService.getanyhqldatalist("from category where isdelete<>'Yes'"));
        return modelAndView;
    }

    //redirects to add new car part page with CreateGenericCarParts details in it
    @RequestMapping("CreateConsumableCarParts")
    public ModelAndView CreateConsumableCarParts() {
        ModelAndView modelAndView = new ModelAndView("AddConsumbaleCarParts");
        modelAndView.addObject("catdtls", viewService.getanyhqldatalist("from category where isdelete<>'Yes'"));
        return modelAndView;
    }

    //view sparepart generic vehicle code goes here
    @RequestMapping(value = "viewGenericVehicleList")
    public ModelAndView viewGenericVehicleList() {
        ModelAndView modelAndView = new ModelAndView("ViewGenericSparesCarList");
        modelAndView.addObject("sparesVehicleDetails", viewService.getanyjdbcdatalist("SELECT *,bd.id as branddetailid FROM branddetails bd\n"
                + "inner join brand br on br.id=bd.brandid\n"
                + "where bd.isdelete='No' and bd.id='" + env.getProperty("generic_brand_detailid") + "'"));
        return modelAndView;
    }
    //view sparepart generic vehicle code ends! here

    //view CONSUMABLE  vehicle code goes here
    @RequestMapping(value = "viewConsumableVehicleList")
    public ModelAndView viewConsumableVehicleList() {
        ModelAndView modelAndView = new ModelAndView("ViewConsumableSparesCarList");
        modelAndView.addObject("sparesVehicleDetails", viewService.getanyjdbcdatalist("SELECT *,bd.id as branddetailid FROM branddetails bd\n"
                + "inner join brand br on br.id=bd.brandid\n"
                + "where bd.isdelete='No' and bd.id='" + env.getProperty("consumable_brand_detailid") + "'"));
        return modelAndView;
    }
    //view CONSUMABLE  vehicle code ends! here

    //view viewSparesList for the generic vehicle model selected
    @RequestMapping(value = "viewGenericSparesList")
    public ModelAndView viewGenericSparesList(@RequestParam(value = "id") String branddetailid) {
        ModelAndView modelAndView = new ModelAndView("ViewGenericSparepartList");
        modelAndView.addObject("sparepartdetails", viewService.getanyjdbcdatalist("SELECT cpi.*,cpv.name as partname,cg.name as categoryname FROM carpartinfo cpi \n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join category cg on cg.id=cpv.categoryid\n"
                + "where cpi.branddetailid='" + branddetailid + "' and cpi.isdelete='No' and cpi.balancequantity>=0"));
        modelAndView.addObject("negativesparepartdetails", viewService.getanyjdbcdatalist("SELECT cpi.*,cpv.name as partname,cg.name as categoryname FROM carpartinfo cpi \n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join category cg on cg.id=cpv.categoryid\n"
                + "where cpi.branddetailid='" + branddetailid + "' and cpi.isdelete='No' and cpi.balancequantity<0"));
        return modelAndView;
    }

//    @RequestMapping(value = "getbranddetails", method = RequestMethod.POST)
//    public void getbranddetails(@RequestParam(value = "brandid") String brandid, HttpServletResponse response) throws IOException {
//        String json = "";
//        List<BrandDetails> bdtls = viewService.getanyhqldatalist("from branddetails where brandid='" + brandid + "' and isdelete<>'Yes'");
//        List<Map<String, Object>> sendlistbdlts = new ArrayList<Map<String, Object>>();
//        for (int i = 0; bdtls.size() > 0 && i < bdtls.size(); i++) {
//            Map<String, Object> setmap = new HashMap<String, Object>();
//            setmap.put("id", bdtls.get(i).getId());
//            setmap.put("name", bdtls.get(i).getVehiclename());
//            sendlistbdlts.add(setmap);
//        }
//        json = new Gson().toJson(sendlistbdlts);
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//        response.getWriter().write(json);
//    }
    //redirects with data to edit car part info which updates carpart vault
    @RequestMapping(value = "editspareparts")
    public ModelAndView editspareparts(@RequestParam("id") String partid) {
        ModelAndView modelAndView = new ModelAndView("EditSpareParts");
        modelAndView.addObject("catdtls", viewService.getanyhqldatalist("from category where isdelete<>'Yes'"));
        modelAndView.addObject("getparts", viewService.getspecifichqldata(CarPartVault.class, partid));
        return modelAndView;
    }

    @RequestMapping(value = "viewspareparts")
    public ModelAndView viewspareparts(@RequestParam("id") String partid) {
        ModelAndView modelAndView = new ModelAndView("ViewSparePartDetails");
        modelAndView.addObject("catdtls", viewService.getanyhqldatalist("from category where isdelete<>'Yes'"));
        modelAndView.addObject("getparts", viewService.getspecifichqldata(CarPartVault.class, partid));
        return modelAndView;
    }

    @RequestMapping(value = "inventoryqty")
    public ModelAndView inventoryqty(@RequestParam(value = "id") String partid) {
        ModelAndView modelAndView = new ModelAndView("CreateInventory");
        modelAndView.addObject("manufacturer", viewService.getanyhqldatalist("from manufacturer where isdelete<>'Yes'"));
        modelAndView.addObject("vendor", viewService.getanyhqldatalist("from vendor where isdelete<>'Yes'"));
        modelAndView.addObject("inventoryinward", viewService.getanyjdbcdatalist("SELECT i.*,m.name as brand,v.name as vendorname FROM inventory i\n"
                + "left join manufacturer m on m.id=i.manufacturerid\n"
                + "left join vendor v on v.id=i.vendor\n"
                + " where i.partid='" + partid + "' and i.type='inward' and i.isdelete<>'Yes'"));
        modelAndView.addObject("inventoryoutward", viewService.getanyjdbcdatalist("SELECT i.*,m.name as brand, ifnull(v.name, 'NA')vendorname FROM inventory i\n"
                + "left join manufacturer m on m.id=i.manufacturerid\n"
                + "left join vendor v on v.id=i.vendor\n"
                + " where i.partid='" + partid + "' and i.type='outward' and i.isdelete<>'Yes'"));
        modelAndView.addObject("taxdt", viewService.getanyjdbcdatalist("SELECT * from taxes where isdelete<>'Yes' and id not in('ATX2','ATX3','ATX4')"));
        return modelAndView;
    }

    //code for internal transfer begi here
    @RequestMapping(value = "internaltransfer")
    public ModelAndView internaltransfer(@RequestParam(value = "id") String inventoryid, @RequestParam(value = "partid") String partid, @RequestParam(value = "carmodel") String branddetailid) {
        ModelAndView modelAndView = new ModelAndView("AddInternalTransfer");
        modelAndView.addObject("inventorydetails", viewService.getanyhqldatalist("from inventory where id='" + inventoryid + "'").get(0));
        modelAndView.addObject("carnamedetails", viewService.getanyhqldatalist("from branddetails where id='" + branddetailid + "'").get(0));
        modelAndView.addObject("partbalancedetails", viewService.getanyhqldatalist("from carpartinfo where id='" + partid + "'").get(0));
        modelAndView.addObject("carmodellist", viewService.getanyhqldatalist("from branddetails where isdelete='No'"));
        modelAndView.addObject("carpartvailtdt", viewService.getanyjdbcdatalist("select * from carpartinfo cpi\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where cpi.id='" + partid + "'").get(0));
        return modelAndView;
    }

    //code for internal transfer begi here
    @RequestMapping(value = "branchtransfer")
    public ModelAndView branchtransfer(@RequestParam(value = "id") String inventoryid, @RequestParam(value = "partid") String partid, @RequestParam(value = "carmodel") String branddetailid) {
        ModelAndView modelAndView = new ModelAndView("AddBranchTransfer");
        modelAndView.addObject("inventorydetails", viewService.getanyhqldatalist("from inventory where id='" + inventoryid + "'").get(0));
        modelAndView.addObject("carnamedetails", viewService.getanyhqldatalist("from branddetails where id='" + branddetailid + "'").get(0));
        modelAndView.addObject("partbalancedetails", viewService.getanyhqldatalist("from carpartinfo where id='" + partid + "'").get(0));
        modelAndView.addObject("branchlist", viewService.getanyhqldatalist("from branch where isdelete='No'"));
        modelAndView.addObject("carpartvailtdt", viewService.getanyjdbcdatalist("select * from carpartinfo cpi\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where cpi.id='" + partid + "'").get(0));
        return modelAndView;
    }

    @RequestMapping(value = "createcustomerinvoice")
    public ModelAndView createcustomerinvoice() {
        ModelAndView modelAndView = new ModelAndView("CreateCustomerInvoice");
        modelAndView.addObject("customers", viewService.getanyhqldatalist("from customer where isdelete<>'Yes'"));
        modelAndView.addObject("vehicles", viewService.getanyhqldatalist("from branddetails where isdelete<>'Yes'"));
        modelAndView.addObject("insuranceCompanyDetails", viewService.getanyhqldatalist("from insurance_company where isdelete<>'Yes'"));
//        modelAndView.addObject("carparts", viewService.getanyhqldatalist("from carparts where isdelete<>'Yes'"));
        modelAndView.addObject("services", viewService.getanyhqldatalist("from labourservices where isdelete<>'Yes'"));
        modelAndView.addObject("vatDetails", viewService.getanyhqldatalist("from taxes where isdelete<>'Yes' and id='ATX1' or id='ATX2'"));
        return modelAndView;
    }

    //get manufacturer & all info in ajax on createcustomerinvocie form page
    @RequestMapping(value = "getinventorydata", method = RequestMethod.POST)
    public void getinventorydata(@RequestParam(value = "id") String partid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getinventory = new ArrayList<Map<String, Object>>();
//        getinventory = viewService.getanyjdbcdatalist("SELECT i.*,m.name as mfgname,m.id as mfgid\n"
//                    + "FROM inventory i\n"
//                    + "left join manufacturer m on m.id=i.manufacturerid\n"
//                    + "where i.partid='" + partid + "' and i.type='inward' and i.isdelete<>'Yes'\n"
//                    + "group by manufacturerid");
        getinventory = viewService.getanyjdbcdatalist("SELECT m.name as mfgname,m.id as mfgid\n"
                + "FROM manufacturer m\n"
                + "where m.isdelete='No'\n"
                + "order by m.name");
        if (getinventory.size() <= 0) {

        }

        List<Map<String, Object>> jsonlist = new ArrayList<Map<String, Object>>();
        for (int i = 0; getinventory.size() > 0 && i < getinventory.size(); i++) {
            Map<String, Object> setjsonmap = new HashMap<String, Object>();
            setjsonmap.put("mfgname", getinventory.get(i).get("mfgname"));
            setjsonmap.put("id", getinventory.get(i).get("mfgid"));
            jsonlist.add(setjsonmap);
        }
        jsondata = new Gson().toJson(jsonlist);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //get manufacturer & all info in ajax on createcustomerinvocie form page
    @RequestMapping(value = "getmanufacturerdata", method = RequestMethod.POST)
    public void getmanufacturerdata(@RequestParam(value = "id") String partid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Manufacturer> getinventory = viewService.getanyhqldatalist("from manufacturer where isdelete='No'");

        jsondata = new Gson().toJson(getinventory);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //estimateion page modification led to adition of this now we get last five prices instead of the above function getinventorydata
    @RequestMapping(value = "getLastFivePricesEstimate", method = RequestMethod.POST)
    public void getLastFivePricesEstimate(@RequestParam(value = "id") String partid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getFivePriceList = viewService.getanyjdbcdatalist("SELECT costprice as maxprice FROM inventory where partid='" + partid + "' and type='inward' ORDER BY costprice DESC LIMIT 5");
        jsondata = new Gson().toJson(getFivePriceList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

//    get list of all manufacturers nitzedit
    @RequestMapping(value = "getManufacturerData", method = RequestMethod.POST)
    public void getManufacturerData(@RequestParam(value = "id") String partid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> manufacturerDataList = viewService.getanyhqldatalist("from manufacturer where isdelete='No'");
        jsondata = new Gson().toJson(manufacturerDataList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //get labour charges & all info in ajax on createcustomerinvocie form page
    @RequestMapping(value = "getservicedata", method = RequestMethod.POST)
    public void getservicedata(@RequestParam(value = "serviceid") String serviceid, @RequestParam(value = "carid") String carid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getServices = viewService.getanyjdbcdatalist("SELECT * FROM labourservices where id='" + serviceid + "' and isdelete='No';");
        List<Map<String, Object>> jsonlist = new ArrayList<Map<String, Object>>();
        for (int i = 0; getServices.size() > 0 && i < getServices.size(); i++) {
            Map<String, Object> setjsonmap = new HashMap<String, Object>();
            setjsonmap.put("name", getServices.get(i).get("name"));
            setjsonmap.put("id", getServices.get(i).get("id"));
            setjsonmap.put("description", getServices.get(i).get("description"));
            if (carid.equals("a")) {
                setjsonmap.put("rate", getServices.get(i).get("rate_a"));
            } else if (carid.equals("b")) {
                setjsonmap.put("rate", getServices.get(i).get("rate_b"));
            } else if (carid.equals("c")) {
                setjsonmap.put("rate", getServices.get(i).get("rate_c"));
            } else if (carid.equals("d")) {
                setjsonmap.put("rate", getServices.get(i).get("rate_d"));
            }

            jsonlist.add(setjsonmap);
        }
        jsondata = new Gson().toJson(jsonlist);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //invoice mfg name ke liye sending max price query written here
    @RequestMapping(value = "pricelist")
    public @ResponseBody
    String priceList(@RequestParam(value = "partid") String partid, @RequestParam(value = "mfgid") String mfgid, HttpServletResponse response) {
        List<Map<String, Object>> getinventoryprice = viewService.getanyjdbcdatalist("SELECT MAX(costprice) as maxprice FROM inventory where manufacturerid='" + mfgid + "' and partid='" + partid + "' and type='inward'");
        String maxSellprice;
        if (getinventoryprice.get(0).get("maxprice") != null) {
            maxSellprice = getinventoryprice.get(0).get("maxprice").toString();
        } else {
            maxSellprice = "0";
        }

        return maxSellprice;
    }

    // nitya work done  
    //========master coding begin here============
    //redirects to View brand form page
    @RequestMapping("brandMasterLink")
    public ModelAndView brandMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewBrand");
        modelAndView.addObject("brandListDt", viewService.getanyhqldatalist("from brand where isdelete='No' and id not in ('" + env.getProperty("generic_brandid") + "','" + env.getProperty("consumable_brandid") + "')"));
        return modelAndView;
    }

    //redirects to add brand page
    @RequestMapping("brandMasterCreateLink")
    public String brandMasterCreateLink() {
        return "AddBrand";
    }

    @RequestMapping(value = "editBrandLink", method = RequestMethod.POST)
    public void editBrandLink(@RequestParam(value = "id") String brandId, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from brand where id='" + brandId + "'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    @RequestMapping(value = "editledgergroupLink", method = RequestMethod.POST)
    public void editledgergroupLink(@RequestParam(value = "id") String brandId, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from ledgergroup where id='" + brandId + "'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //view branch details in apopup
    @RequestMapping(value = "getBranchDetails", method = RequestMethod.POST)
    public void getBranchDetails(@RequestParam(value = "brid") String branchid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getBranchList = viewService.getanyhqldatalist("from branch where id='" + branchid + "' ");
        jsondata = new Gson().toJson(getBranchList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirects to edit brand details page
    @RequestMapping(value = "editBrandDetailsLink")
    public ModelAndView editBrandDetailsLink(@RequestParam(value = "brandid") String brandId) {
        ModelAndView modelAndView = new ModelAndView("EditBrandDetails");
        modelAndView.addObject("branddt", viewService.getanyhqldatalist("from brand where isdelete='No'"));
        modelAndView.addObject("carDt", viewService.getanyhqldatalist("from branddetails where brandid='" + brandId + "' and isdelete='No'"));
        return modelAndView;
    }

    //view Limit Grid page rediection
    @RequestMapping(value = "approvalMasterLink")
    public ModelAndView approvalMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewApprovalLimitGrid");
        modelAndView.addObject("limitdt", viewService.getanyhqldatalist("from approvallimit where isdelete='No'"));
        return modelAndView;
    }

    //redirect to add form for approval limit
    @RequestMapping(value = "approvalLimitCreateLink")
    public String approvalLimitCreateLink() {
        return "AddApprovalLimit";
    }

    //redirect to edit popup for approval limit
    @RequestMapping(value = "getApprovalLimitDetails", method = RequestMethod.POST)
    public void getApprovalLimitDetails(@RequestParam(value = "limitid") String limitid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from approvallimit where id='" + limitid + "'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to add form for ledger 
    @RequestMapping(value = "ledgerCreateLink")
    public ModelAndView ledgerCreateLink() {
        ModelAndView modelAndView = new ModelAndView("AddLedger");
        modelAndView.addObject("ledgergroupdtls", viewService.getanyhqldatalist("from ledgergroup where isdelete='No'"));
        return modelAndView;
    }

    //redirect to ledger master grid which represent along with it groups
    @RequestMapping(value = "ledgerMasterLink")
    public ModelAndView ledgerMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewLedgersGrid");
        modelAndView.addObject("ledgerdt", viewService.getanyjdbcdatalist("SELECT ld.*,ldg.name as groupname FROM ledger ld\n"
                + "inner join ledgergroup ldg on ldg.id=ld.ledgergroupid\n"
                + "where ld.isdelete='No'"));
        return modelAndView;
    }

    @RequestMapping(value = "ledgerGroupMasterLink")
    public ModelAndView ledgerGroupMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewLedgersGroupGrid");
        modelAndView.addObject("groupdt", viewService.getanyhqldatalist("from ledgergroup where isdelete='No'"));
        return modelAndView;
    }

    //redirect to bank account master grid 
    @RequestMapping(value = "bankAccountMasterLink")
    public ModelAndView bankAccountMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewBankAccountGrid");
        modelAndView.addObject("bankdt", viewService.getanyhqldatalist("from bank_account where isdelete='No'"));
        return modelAndView;
    }

    //redirect to add form for ledger 
    @RequestMapping(value = "bankAccountCreateLink")
    public ModelAndView bankAccountCreateLink() {
        ModelAndView modelAndView = new ModelAndView("AddBankAccount");
        modelAndView.addObject("ledgergroupdtls", viewService.getanyhqldatalist("from ledgergroup where isdelete='No'"));
        return modelAndView;
    }

    //redirect to edit ledger 
    @RequestMapping(value = "editLedgerLink")
    public ModelAndView editLedgerLink(@RequestParam(value = "laid") String laid) {
        ModelAndView modelAndView = new ModelAndView("EditLedger");
        modelAndView.addObject("editLedgerDtls", viewService.getanyjdbcdatalist("SELECT ld.*,ldg.name as groupname FROM ledger ld\n"
                + "inner join ledgergroup ldg on ldg.id=ld.ledgergroupid\n"
                + "where ld.id='" + laid + "'").get(0));
        modelAndView.addObject("ledgergroupdtls", viewService.getanyhqldatalist("from ledgergroup where isdelete='No'"));
        return modelAndView;
    }

    //ajax call to get updated group s for ledgers creation
    @RequestMapping(value = "ajaxGetLedgerGroups", method = RequestMethod.POST)
    public void ajaxGetLedgerGroups(@RequestParam("name") String name, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getGroupList = viewService.getanyhqldatalist("from ledgergroup where isdelete='No'");
        jsondata = new Gson().toJson(getGroupList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirects to View vendor form page
    @RequestMapping("vendorMasterLink")
    public ModelAndView vendorMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewVendors");
        modelAndView.addObject("vendorListDt", viewService.getanyhqldatalist("from vendor where isdelete='No'"));
        return modelAndView;
    }

    //redirects to View manufacturer form page
    @RequestMapping("mfgMasterLink")
    public ModelAndView mfgMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewMfg");
        modelAndView.addObject("mfgListDt", viewService.getanyhqldatalist("from manufacturer where isdelete='No'"));
        return modelAndView;
    }

    //redirects to edit vendor details page
    @RequestMapping(value = "editVendorDetailsLink")
    public ModelAndView editVendorDetailsLink(@RequestParam(value = "vendorid") String vendorId) {
        ModelAndView modelAndView = new ModelAndView("EditVendor");
        modelAndView.addObject("vendorDt", viewService.getspecifichqldata(Vendor.class, vendorId));
        return modelAndView;
    }

    //redirects to add new vendor details page
    @RequestMapping("vendorMasterCreateLink")
    public String vendorMasterCreateLink() {
        return "AddVendor";
    }

    //redirects to Add car form page with brand names in dropdown
    @RequestMapping("carMasterCreateLink")
    public ModelAndView carMasterCreateLink() {
        ModelAndView modelAndView = new ModelAndView("AddCar");
        modelAndView.addObject("branddt", viewService.getanyhqldatalist("from brand where isdelete='No'"));
        return modelAndView;
    }

    //redirects to add new Manufacturer details page
    @RequestMapping("mfgMasterCreateLink")
    public String mfgMasterCreateLink() {
        return "AddMfg";
    }

    //redirect with data to mfg edit page
    @RequestMapping("editMfgDetailsLink")
    public ModelAndView editMfgDetailsLink(@RequestParam(value = "mfgid") String mfgid) {
        ModelAndView modelAndView = new ModelAndView("EditMfg");
        modelAndView.addObject("manufacturerDt", viewService.getspecifichqldata(Manufacturer.class, mfgid));
        return modelAndView;
    }

    //modal category link for edit
    @RequestMapping(value = "editCategoryDetailsLink", method = RequestMethod.POST)
    public void editCategoryDetailsLink(@RequestParam(value = "categoryid") String categoryid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from category where id='" + categoryid + "'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirects to Category master details page
    @RequestMapping(value = "categoryMasterLink")
    public ModelAndView categoryMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewCategory");
        modelAndView.addObject("categoryListDt", viewService.getanyhqldatalist("from category where isdelete='No' order by savedate "));
        return modelAndView;
    }

    //redirects to Branch master details page
    @RequestMapping(value = "branchMasterLink")
    public ModelAndView branchMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewBranchGrid");
        modelAndView.addObject("branchListDt", viewService.getanyhqldatalist("from branch where isdelete='No' order by savedate "));
        return modelAndView;
    }

    //redirects to Branch master details page
    @RequestMapping(value = "insuranceCompanyMasterLink")
    public ModelAndView insuranceCompanyMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewInsuranceCompanyGrid");
        modelAndView.addObject("companyListDt", viewService.getanyhqldatalist("from insurance_company where isdelete='No' order by savedate "));
        return modelAndView;
    }

    //redirects to Add Category form page
    @RequestMapping("branchCreateLink")
    public String branchCreateLink() {
        return "AddBranch";
    }

    //edit branch page redirection
    @RequestMapping(value = "editBranchPage")
    public ModelAndView editBranchPage(@RequestParam(value = "brid") String branchid) {
        ModelAndView modelAndView = new ModelAndView("EditBranch");
        modelAndView.addObject("editBranchDtls", viewService.getspecifichqldata(Branch.class, branchid));
        return modelAndView;
    }

    //redirects to Add Category form page
    @RequestMapping("categoryMasterCreateLink")
    public String categoryMasterCreateLink() {
        return "AddCategory";
    }

    //redirects to View Customer form page
    @RequestMapping("customerMasterLink")
    public ModelAndView customerMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewCustomer");
        modelAndView.addObject("customerListDt", viewService.getanyhqldatalist("from customer where isdelete='No' and id like '" + env.getProperty("branch_prefix") + "%' order by savedate desc"));
        return modelAndView;
    }

    //view customer payment details begin here
    @RequestMapping("viewAllPayments")
    public ModelAndView viewAllPayments(@RequestParam(value = "customerid") String customerid) {
        ModelAndView modelAndView = new ModelAndView("ViewAllPayments");
        modelAndView.addObject("customerListDt", viewService.getanyjdbcdatalist("SELECT ge.towards,iv.vehiclenumber,ge.income_date,ge.mode,ge.total FROM generalincome ge\n"
                + "inner join invoice iv on iv.id=ge.invoiceid\n"
                + "inner join customer cu on cu.mobilenumber=iv.customermobilenumber\n"
                + "where cu.id='" + customerid + "' and ge.isdelete='No' and iv.isdelete='No'"));
        return modelAndView;
    }
    //view customer payment details ends! here

    //redirect to send sms and 
    @RequestMapping("sendcustomersmsLink")
    public String sendcustomersmsLink(@RequestParam(value = "customerid") String customerid) throws Exception {
        List<Customer> customerDetailList = viewService.getanyhqldatalist("from customer where id='" + customerid + "'");
        //code for creating the url
        String message = "Your Karworx password : " + customerDetailList.get(0).getPassword();
        message = message.replaceAll(" ", "%20");

        String smsurl = "http://mysms.net.in/api/smsapi.aspx?username=" + env.getProperty("smsusername") + "&password=" + env.getProperty("password") + "&to=" + customerDetailList.get(0).getMobilenumber() + "&from=" + env.getProperty("senderid") + "&message=" + message;
        //CODE TO SEND SMS BEGIN HERE
        CustomerSms sms = new CustomerSms();
        int code = sms.sendGet(smsurl);
        if (code == 200) {
            return "redirect:customerMasterLink?sms=smssent";
        } else {
            return "redirect:customerMasterLink?sms=notsent";
        }
        //CODE TO SEND SMS ENDS! HERE        
    }

    //redirect to send email 
    @RequestMapping("sendcustomeremailLink")
    public String sendcustomeremailLink(@RequestParam(value = "customerid") String customerid) throws Exception {
        List<Customer> customerDetailList = viewService.getanyhqldatalist("from customer where id='" + customerid + "'");
        //code for creating the url
        String subject = "Karworx Password";
        String message = "Your Karworx password : " + customerDetailList.get(0).getPassword();
        String to = customerDetailList.get(0).getEmail();
        String yourname = "Karworx";

        //CODE TO SEND email BEGIN HERE
        EmailSessionBean sessionBean = new EmailSessionBean();
        String status = sessionBean.sendCustomerMail(subject, message, to, yourname);
        if (status.equals("sent")) {
            return "redirect:customerMasterLink?email=send";
        } else {
            return "redirect:customerMasterLink?email=notsend";
        }
        //CODE TO SEND email ENDS! HERE

    }

    //redirects to Add Customer form page
    @RequestMapping("customerMasterCreateLink")
    public String customerMasterCreateLink() {
        return "AddCustomer";
    }

    //redirect with data to customer edit page
    @RequestMapping("editCustomerDetailsLink")
    public ModelAndView editCustomerDetailsLink(@RequestParam(value = "customerid") String customerid) {
        ModelAndView modelAndView = new ModelAndView("EditCustomer");
        modelAndView.addObject("customerDt", viewService.getspecifichqldata(Customer.class, customerid));
        return modelAndView;
    }

    //view custome master customers service history and available cars
    @RequestMapping(value = "viewCustomerDetailsLink")
    public ModelAndView viewCustomerDetailsLink(@RequestParam(value = "customerid") String customerid) {
        ModelAndView modelAndView = new ModelAndView("ViewCustomerDetails");
        modelAndView.addObject("customerprofile", viewService.getspecifichqldata(Customer.class, customerid));
        //old query to show customer vehicles details fromservice chklist table 
//        modelAndView.addObject("customerdetails", viewService.getanyjdbcdatalist("SELECT *,count(vehiclenumber) as times FROM customervehicles where custid='" + customerid + "' group by vehiclenumber"));
        //new query written here to show ciustomer vehicles from invoice
        List<Customer> customerList = viewService.getanyhqldatalist("from customer where id='" + customerid + "'");
        modelAndView.addObject("customerdetails", viewService.getanyjdbcdatalist("select bdd.vehiclename as carmodel,bd.name as carbrand,iv.vehiclenumber,count(vehiclenumber) as times from invoice iv \n"
                + "inner join branddetails bdd on bdd.id=iv.vehicleid \n"
                + "inner join brand bd on bd.id=bdd.brandid\n"
                + "where iv.customermobilenumber='" + customerList.get(0).getMobilenumber() + "' and iv.isdelete='No' group by vehiclenumber"));
        return modelAndView;
    }

    //redirect to invoice popup with invoice list for vehicles
    @RequestMapping(value = "getInvoiceDetails", method = RequestMethod.POST)
    public void getInvoiceDetails(@RequestParam(value = "vehiclenumber") String vehiclenumber, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyjdbcdatalist("SELECT inv.id as invoiceid,inv.vehiclenumber,inv.savedate as servicedate\n"
                + "FROM invoice inv\n"
                + "WHERE inv.vehiclenumber='" + vehiclenumber + "' and inv.isdelete='No'\n"
                + "group by inv.id");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to invoice popup with invoice list for vehicles
    @RequestMapping(value = "getJobDetails", method = RequestMethod.POST)
    public void getJobDetails(@RequestParam(value = "vehiclenumber") String vehiclenumber, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyjdbcdatalist("SELECT js.id as jobno,inv.vehiclenumber,js.savedate as jobdate\n"
                + "FROM invoice inv\n"
                + "inner join jobsheet js on js.id=inv.jobno\n"
                + "WHERE inv.vehiclenumber='" + vehiclenumber + "' and inv.isdelete='No' and inv.isconvert='Yes'\n"
                + "group by inv.id");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to invoice popup with invoice list for vehicles
    @RequestMapping(value = "getEstimateDetails", method = RequestMethod.POST)
    public void getEstimateDetails(@RequestParam(value = "vehiclenumber") String vehiclenumber, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyjdbcdatalist("SELECT est.id as estimateid,inv.vehiclenumber,est.savedate as estimatedate\n"
                + "FROM invoice inv\n"
                + "inner join jobsheet js on js.id=inv.jobno\n"
                + "inner join estimate est on est.id=js.estimateid\n"
                + "WHERE inv.vehiclenumber='" + vehiclenumber + "' and inv.isdelete='No' and inv.isconvert='Yes'\n"
                + "group by inv.id");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to invoice popup with invoice list for vehicles
    @RequestMapping(value = "getpclDetails", method = RequestMethod.POST)
    public void getpclDetails(@RequestParam(value = "vehiclenumber") String vehiclenumber, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyjdbcdatalist("SELECT pc.id as pclid,inv.vehiclenumber,pc.savedate as pointdate\n"
                + "FROM invoice inv\n"
                + "inner join jobsheet js on js.id=inv.jobno\n"
                + "inner join estimate est on est.id=js.estimateid\n"
                + "inner join pointchecklist pc on pc.id=est.pclid\n"
                + "WHERE inv.vehiclenumber='" + vehiclenumber + "' and inv.isdelete='No' and inv.isconvert='Yes'\n"
                + "group by inv.id");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to invoice popup with invoice list for vehicles
    @RequestMapping(value = "getservicechecklistDetails", method = RequestMethod.POST)
    public void getservicechecklistDetails(@RequestParam(value = "vehiclenumber") String vehiclenumber, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyjdbcdatalist("SELECT cv.id as clid,cv.brandid,inv.vehiclenumber,cv.savedate as cldate\n"
                + "FROM invoice inv\n"
                + "inner join jobsheet js on js.id=inv.jobno\n"
                + "inner join estimate est on est.id=js.estimateid\n"
                + "inner join pointchecklist pc on pc.id=est.pclid\n"
                + "inner join customervehicles cv on cv.id=pc.customervehiclesid\n"
                + "WHERE inv.vehiclenumber='" + vehiclenumber + "' and inv.isdelete='No' and inv.isconvert='Yes'\n"
                + "group by inv.id");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to invoice popup with invoice list for vehicles
    @RequestMapping(value = "getservicechecklistsearchDetails", method = RequestMethod.POST)
    public void getservicechecklistsearchDetails(@RequestParam(value = "vehiclenumber") String vehiclenumber, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyjdbcdatalist("SELECT cv.id,cv.custid,cv.carbrand,cv.carmodel,cv.vehiclenumber,cv.is180ready,SUBSTRING_INDEX(cv.savedate, ' ', 1) as cldate FROM customervehicles cv \n"
                + "where cv.vehiclenumber='" + vehiclenumber + "' and cv.isdelete='No'\n"
                + "group by cv.id\n"
                + "order by length(cv.id) desc,cv.id desc");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    @RequestMapping(value = "trackCarStatus")
    public ModelAndView trackCarStatus(@RequestParam(value = "id") String checklistid) {
        ModelAndView modelAndView = new ModelAndView("TrackStatus");
        //code for transaction
        Map<String, Object> getmap = new HashMap<String, Object>();
        getmap.put("servicechecklist", "Yes");
        //get 180 point details
        List<CustomerVehicles> cvlist = viewService.getanyhqldatalist("from customervehicles where id='" + checklistid + "'");
        if (cvlist.size() > 0) {
            getmap.put("checklistid", cvlist.get(0).getId());
            getmap.put("brandid", cvlist.get(0).getBrandid());
            getmap.put("pointready", cvlist.get(0).getIs180ready());

            List<PointChecklist> pointlist = viewService.getanyhqldatalist("from pointchecklist where customervehiclesid='" + cvlist.get(0).getId() + "'");
            if (pointlist.size() > 0) {
                getmap.put("pointid", pointlist.get(0).getId());
                getmap.put("estimate", pointlist.get(0).getIsestimate());
                List<Estimate> estimatelist = viewService.getanyhqldatalist("from estimate where pclid='" + pointlist.get(0).getId() + "'");
                if (estimatelist.size() > 0) {
                    getmap.put("estimateid", estimatelist.get(0).getId());
                    getmap.put("jobsheet", estimatelist.get(0).getIsjobsheetready());
                    List<Jobsheet> js = viewService.getanyhqldatalist("from jobsheet where estimateid='" + estimatelist.get(0).getId() + "'");
                    if (js.size() > 0) {
                        getmap.put("jobid", js.get(0).getId());
                        getmap.put("sparepart", js.get(0).getIsrequisitionready());
                        getmap.put("invoice", js.get(0).getIsinvoiceconverted());
                        if (js.get(0).getVerified().equals("Yes") && js.get(0).getCleaning().equals("done")
                                && js.get(0).getCar_washing().equals("done") && js.get(0).getCar_vacuuming().equals("done")
                                && js.get(0).getTyre_polish().equals("done") && js.get(0).getDashboard_polish().equals("done")
                                && js.get(0).getEngine_cleaning().equals("done") && js.get(0).getUnderchasis_cleaning().equals("done")
                                && js.get(0).getTrunk_cleaning().equals("done")) {
                            getmap.put("cleaning", "Yes");
                        } else {
                            getmap.put("cleaning", "No");
                        }
                        if (js.get(0).getIsinvoiceconverted().equals("Yes")) {
                            List<Invoice> invoicelist = viewService.getanyhqldatalist("from invoice where jobno='" + js.get(0).getId() + "'");
                            getmap.put("invoiceid", invoicelist.get(0).getId());
                        }

                    } else {
                        getmap.put("sparepart", "No");
                        getmap.put("invoice", "No");
                        getmap.put("cleaning", "No");
                    }

                } else {
                    getmap.put("jobsheet", "No");
                    getmap.put("sparepart", "No");
                    getmap.put("invoice", "No");
                    getmap.put("cleaning", "No");
                }
            } else {
                getmap.put("estimate", "No");
                getmap.put("jobsheet", "No");
                getmap.put("sparepart", "No");
                getmap.put("invoice", "No");
                getmap.put("cleaning", "No");
            }

        } else {
            getmap.put("pointready", "No");
            getmap.put("estimate", "No");
            getmap.put("jobsheet", "No");
            getmap.put("sparepart", "No");
            getmap.put("invoice", "No");
            getmap.put("cleaning", "No");
        }
        modelAndView.addObject("trackdt", getmap);

        return modelAndView;
    }

    //redirects to View Customer Invoice form page
    @RequestMapping("invoiceMasterLink")
    public ModelAndView invoiceMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewInvoice");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
        Date date = new Date();
        String month = dateFormat.format(date);
        modelAndView.addObject("currentmonth", month);
        modelAndView.addObject("invoiceListDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.name,SUBSTRING(inv.savedate,1,7) as monthcheck,substring_index(inv.savedate,' ',1)as invoicedate  FROM invoice inv\n"
                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                + "where inv.isdelete='No' and cu.isdelete='No' and inv.ispaid='No' order by length(inv.id) desc,inv.id desc"));
        return modelAndView;
    }

    //code to view invoice reasons here
    @RequestMapping(value = "viewInvoiceReasonsLink")
    public ModelAndView viewInvoiceReasonsLink() {
        ModelAndView modelAndView = new ModelAndView("ViewInvoiceReasons");
        modelAndView.addObject("reasonsdt", viewService.getanyjdbcdatalist("SELECT ie.*,ud.name,ud.`type` FROM invoice_edit ie\n"
                + "inner join userdetails ud on ud.id=ie.userid\n"
                + "where ie.isdelete='No' order by length(ie.id) desc,ie.id desc"));
        return modelAndView;
    }

    //redirects to View Customer Invoice form page
    @RequestMapping("paidcustomerinvoice")
    public ModelAndView paidcustomerinvoice() {
        ModelAndView modelAndView = new ModelAndView("ViewPaidInvoice");
        modelAndView.addObject("invoiceListDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.name,substring_index(inv.savedate,' ',1)as invoicedate FROM invoice inv\n"
                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                + "where inv.isdelete='No' and cu.isdelete='No' and inv.ispaid<>'No' order by length(inv.id) desc,inv.id desc"));
        return modelAndView;
    }

    //redirects to View Services form page
    @RequestMapping("serviceMasterLink")
    public ModelAndView serviceMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewServices");
        modelAndView.addObject("serviceListDt", viewService.getanyhqldatalist("from labourservices where isdelete='No'"));
        return modelAndView;
    }

    //redirects to Add Customer form page
    @RequestMapping("serviceMasterCreateLink")
    public String serviceMasterCreateLink() {
        return "AddService";
    }

    //redirect with data to Services edit page
    @RequestMapping("editServiceDetailsLink")
    public ModelAndView editServiceDetailsLink(@RequestParam(value = "serviceid") String serviceid) {
        ModelAndView modelAndView = new ModelAndView("EditServices");
        modelAndView.addObject("servicesDt", viewService.getspecifichqldata(LabourServices.class, serviceid));
        return modelAndView;
    }

    //redirects to View taxes form page
    @RequestMapping("taxMasterLink")
    public ModelAndView taxMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewTaxes");
        modelAndView.addObject("taxListDt", viewService.getanyhqldatalist("from taxes where isdelete='No'"));
        return modelAndView;
    }

    //redirect to add tax
    @RequestMapping(value = "taxMasterCreateLink")
    public String taxMasterCreateLink() {
        return "AddTax";
    }

    //redirect with data to tax edit page
    @RequestMapping("editTaxDetailsLink")
    public ModelAndView editTaxDetailsLink(@RequestParam(value = "taxid") String taxid) {
        ModelAndView modelAndView = new ModelAndView("EditTaxes");
        modelAndView.addObject("taxesDt", viewService.getspecifichqldata(Taxes.class, taxid));
        return modelAndView;
    }

    //get invoice related car type data from here
    @RequestMapping(value = "getCarType")
    public @ResponseBody
    String getCarType(@RequestParam(value = "carid") String carid, HttpServletResponse response) {
        List<BrandDetails> brandDetailsList = viewService.getanyhqldatalist("from branddetails where id='" + carid + "'");
        String carType = brandDetailsList.get(0).getLabourChargeType();
        return carType;
    }

    //redirects to view customer invoice page
    @RequestMapping("viewCustomerInvoice")
    public ModelAndView viewCustomerInvoice(@RequestParam(value = "invoiceid") String invoiceId) {
        ModelAndView modelAndView = new ModelAndView("ViewCustomerInsuranceInvoice");

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
        Date date = new Date();
        String month = dateFormat.format(date);
        modelAndView.addObject("currentmonth", month);
        modelAndView.addObject("vatDetails", viewService.getanyhqldatalist("from taxes where isdelete<>'Yes' and id in('ATX1','ATX2')"));

        //view invoice data required for getting data
        List<Map<Object, String>> invoicemap = viewService.getanyjdbcdatalist("SELECT iv.*,bd.vehiclename,bdd.name as make, SUBSTRING(iv.savedate,1,7) as monthcheck\n"
                + "FROM invoice iv\n"
                + "left join branddetails bd on bd.id=iv.vehicleid\n"
                + "left join brand bdd on bdd.id=bd.brandid\n"
                + "where iv.id='" + invoiceId + "'");

        modelAndView.addObject("invoiceDt", invoicemap.get(0));

        if (invoicemap.get(0).get("isinsurance").equals("Yes")) {
            if (invoicemap.get(0).get("insurancetype").equals("Full Payment")) {
                modelAndView.addObject("insuranceinvoiceDt", viewService.getanyjdbcdatalist("SELECT CAST(iv.sparepartsfinal AS UNSIGNED)+ CAST(iv.labourfinal AS UNSIGNED) as claimtotal,\n"
                        + "CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as taxtotal,\n"
                        + "CAST(iv.labourfinal AS UNSIGNED)+CAST(iv.sparepartsfinal AS UNSIGNED)+CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as grandtotal\n"
                        + "FROM invoice iv\n"
                        + "where iv.id='" + invoiceId + "'").get(0));
            }
        }

        Invoice invoicemobile = (Invoice) viewService.getspecifichqldata(Invoice.class, invoiceId);
        String custnumber = invoicemobile.getCustomermobilenumber();

        List<Map<String, Object>> customerlist = viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                + "FROM invoice inv\n"
                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                + "inner join customervehicles cv on cv.custid=cu.id\n"
                + "where cu.mobilenumber='" + custnumber + "'\n"
                + "group by cu.mobilenumber");

        if (customerlist.size() > 0) {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "inner join customervehicles cv on cv.custid=cu.id\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        } else {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        }

        //normal inovice create ka view[carparts]
        modelAndView.addObject("labourandpartdt", viewService.getanyjdbcdatalist("SELECT i.*,i.partname as itemname,mfg.name as mfgname \n"
                + "FROM invoicedetails i \n"
                + "left join  carpartinfo cpi on cpi.id=i.partid\n"
                + "left join  carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "left join  manufacturer mfg on mfg.id=i.manufacturerid \n"
                + "where i.invoiceid='" + invoiceId + "' and i.isdelete='No'"));
        //convert ka labour info
        modelAndView.addObject("labourinventorydt", viewService.getanyjdbcdatalist("SELECT *,servicename as name FROM labourinventory\n"
                + "where invoiceid='" + invoiceId + "' and isdelete='No' and total>0"));
        return modelAndView;

    }

    //redirects to view customer invoice page
    @RequestMapping("viewLiabilityInvoice")
    public ModelAndView viewLiabilityInvoice(@RequestParam(value = "invoiceid") String invoiceId) {
        ModelAndView modelAndView = new ModelAndView("ViewLiabilityInvoice");

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
        Date date = new Date();
        String month = dateFormat.format(date);
        modelAndView.addObject("currentmonth", month);
        modelAndView.addObject("vatDetails", viewService.getanyhqldatalist("from taxes where isdelete<>'Yes' and id in('ATX1','ATX2')"));

        //view invoice data required for getting data
        List<Map<Object, String>> invoicemap = viewService.getanyjdbcdatalist("SELECT iv.*,bd.vehiclename,bdd.name as make, SUBSTRING(iv.savedate,1,7) as monthcheck\n"
                + "FROM invoice iv\n"
                + "left join branddetails bd on bd.id=iv.vehicleid\n"
                + "left join brand bdd on bdd.id=bd.brandid\n"
                + "where iv.id='" + invoiceId + "'");

        modelAndView.addObject("invoiceDt", invoicemap.get(0));

        if (invoicemap.get(0).get("isinsurance").equals("Yes")) {
            if (invoicemap.get(0).get("insurancetype").equals("Full Payment")) {
                modelAndView.addObject("insuranceinvoiceDt", viewService.getanyjdbcdatalist("SELECT CAST(iv.sparepartsfinal AS UNSIGNED)+ CAST(iv.labourfinal AS UNSIGNED) as claimtotal,\n"
                        + "CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as taxtotal,\n"
                        + "CAST(iv.labourfinal AS UNSIGNED)+CAST(iv.sparepartsfinal AS UNSIGNED)+CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as grandtotal\n"
                        + "FROM invoice iv\n"
                        + "where iv.id='" + invoiceId + "'").get(0));
            }
        }

        Invoice invoicemobile = (Invoice) viewService.getspecifichqldata(Invoice.class, invoiceId);
        String custnumber = invoicemobile.getCustomermobilenumber();

        List<Map<String, Object>> customerlist = viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                + "FROM invoice inv\n"
                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                + "inner join customervehicles cv on cv.custid=cu.id\n"
                + "where cu.mobilenumber='" + custnumber + "'\n"
                + "group by cu.mobilenumber");

        if (customerlist.size() > 0) {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "inner join customervehicles cv on cv.custid=cu.id\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        } else {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        }

        //normal inovice create ka view[carparts]
        modelAndView.addObject("labourandpartdt", viewService.getanyjdbcdatalist("SELECT i.*,i.partname as itemname,mfg.name as mfgname \n"
                + "FROM invoicedetails i \n"
                + "left join  carpartinfo cpi on cpi.id=i.partid\n"
                + "left join  carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "left join  manufacturer mfg on mfg.id=i.manufacturerid \n"
                + "where i.invoiceid='" + invoiceId + "' and i.isdelete='No'"));
        //convert ka labour info
        modelAndView.addObject("labourinventorydt", viewService.getanyjdbcdatalist("SELECT *,servicename as name FROM labourinventory\n"
                + "where invoiceid='" + invoiceId + "' and isdelete='No' and total>0"));
        
        //calculate customerliability total code begins here (parts+ labor)
        List<Map<String,Object>> sparecount=viewService.getanyjdbcdatalist("SELECT sum(insurancecustomeramount) partliability FROM karworx.invoicedetails where invoiceid='"+invoiceId+"'");        
        double d = Double.valueOf((Double) sparecount.get(0).get("partliability"));            
        modelAndView.addObject("sparelab", d);
        List<Map<String,Object>> laborcount=viewService.getanyjdbcdatalist("SELECT Sum(customerinsurance) laborliability FROM karworx.labourinventory where invoiceid='"+invoiceId+"';");
        double e = Double.valueOf((Double) laborcount.get(0).get("laborliability"));
        modelAndView.addObject("laborlab", e);
        //calculate customerliability total code ends! here
        return modelAndView;

    }

    //redirects to  Customer tax Insurance invoice page
    @RequestMapping("viewCustomertaxInsuranceInvoice")
    public ModelAndView viewCustomertaxInsuranceInvoice(@RequestParam(value = "invoiceid") String invoiceId) {
        ModelAndView modelAndView = new ModelAndView("ViewCustomerTaxInsuranceInvoice");
        modelAndView.addObject("vatDetails", viewService.getanyhqldatalist("from taxes where isdelete<>'Yes' and id in('ATX1','ATX2')"));

        //view invoice data required for getting data
        List<Map<Object, String>> invoicemap = viewService.getanyjdbcdatalist("SELECT iv.*,bd.vehiclename,bdd.name as make\n"
                + "FROM invoice iv\n"
                + "left join branddetails bd on bd.id=iv.vehicleid\n"
                + "left join brand bdd on bdd.id=bd.brandid\n"
                + "where iv.id='" + invoiceId + "'");

        modelAndView.addObject("invoiceDt", invoicemap.get(0));

        if (invoicemap.get(0).get("isinsurance").equals("Yes")) {
            if (invoicemap.get(0).get("insurancetype").equals("Full Payment")) {
                modelAndView.addObject("insuranceinvoiceDt", viewService.getanyjdbcdatalist("SELECT CAST(iv.sparepartsfinal AS UNSIGNED)+ CAST(iv.labourfinal AS UNSIGNED) as claimtotal,\n"
                        + "CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as taxtotal,\n"
                        + "CAST(iv.labourfinal AS UNSIGNED)+CAST(iv.sparepartsfinal AS UNSIGNED)+CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as grandtotal\n"
                        + "FROM invoice iv\n"
                        + "where iv.id='" + invoiceId + "'").get(0));
            }
        }

        Invoice invoicemobile = (Invoice) viewService.getspecifichqldata(Invoice.class, invoiceId);
        String custnumber = invoicemobile.getCustomermobilenumber();

        List<Map<String, Object>> customerlist = viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                + "FROM invoice inv\n"
                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                + "inner join customervehicles cv on cv.custid=cu.id\n"
                + "where cu.mobilenumber='" + custnumber + "'\n"
                + "group by cu.mobilenumber");

        if (customerlist.size() > 0) {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "inner join customervehicles cv on cv.custid=cu.id\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        } else {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        }

//        modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
//                + "FROM invoice inv\n"
//                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
//                + "inner join customervehicles cv on cv.custid=cu.id\n"
//                + "where cu.mobilenumber='" + custnumber + "'\n"
//                + "group by cu.mobilenumber").get(0));
        //normal inovice create ka view[carparts]
        modelAndView.addObject("labourandpartdt", viewService.getanyjdbcdatalist("SELECT i.*,i.partname as itemname,mfg.name as mfgname \n"
                + "FROM invoicedetails i \n"
                + "left join  carpartinfo cpi on cpi.id=i.partid\n"
                + "left join  carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "left join  manufacturer mfg on mfg.id=i.manufacturerid \n"
                + "where i.invoiceid='" + invoiceId + "' and i.isdelete='No'"));
        //convert ka labour info
        modelAndView.addObject("labourinventorydt", viewService.getanyjdbcdatalist("SELECT *,servicename as name FROM labourinventory\n"
                + "where invoiceid='" + invoiceId + "' and isdelete='No' and total>0"));
        return modelAndView;

    }

    //redirects to  Customer Insurance invoice page
    @RequestMapping("sendMailInvoice")
    public ModelAndView sendMailInvoice(@RequestParam(value = "invoiceid") String invoiceId) {
        ModelAndView modelAndView = new ModelAndView("InvoiceMail");
        modelAndView.addObject("vatDetails", viewService.getanyhqldatalist("from taxes where isdelete<>'Yes' and id in('ATX1','ATX2')"));

        //view invoice data required for getting data
        List<Map<Object, String>> invoicemap = viewService.getanyjdbcdatalist("SELECT iv.*,bd.vehiclename,bdd.name as make\n"
                + "FROM invoice iv\n"
                + "left join branddetails bd on bd.id=iv.vehicleid\n"
                + "left join brand bdd on bdd.id=bd.brandid\n"
                + "where iv.id='" + invoiceId + "'");

        modelAndView.addObject("invoiceDt", invoicemap.get(0));

        if (invoicemap.get(0).get("isinsurance").equals("Yes")) {
            if (invoicemap.get(0).get("insurancetype").equals("Full Payment")) {
                modelAndView.addObject("insuranceinvoiceDt", viewService.getanyjdbcdatalist("SELECT CAST(iv.sparepartsfinal AS UNSIGNED)+ CAST(iv.labourfinal AS UNSIGNED) as claimtotal,\n"
                        + "CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as taxtotal,\n"
                        + "CAST(iv.labourfinal AS UNSIGNED)+CAST(iv.sparepartsfinal AS UNSIGNED)+CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as grandtotal\n"
                        + "FROM invoice iv\n"
                        + "where iv.id='" + invoiceId + "'").get(0));
            }
        }

        Invoice invoicemobile = (Invoice) viewService.getspecifichqldata(Invoice.class, invoiceId);
        String custnumber = invoicemobile.getCustomermobilenumber();

        List<Map<String, Object>> customerlist = viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                + "FROM invoice inv\n"
                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                + "inner join customervehicles cv on cv.custid=cu.id\n"
                + "where cu.mobilenumber='" + custnumber + "'\n"
                + "group by cu.mobilenumber");

        if (customerlist.size() > 0) {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "inner join customervehicles cv on cv.custid=cu.id\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        } else {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        }

//        modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
//                + "FROM invoice inv\n"
//                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
//                + "inner join customervehicles cv on cv.custid=cu.id\n"
//                + "where cu.mobilenumber='" + custnumber + "'\n"
//                + "group by cu.mobilenumber").get(0));
        //normal inovice create ka view[carparts]
        modelAndView.addObject("labourandpartdt", viewService.getanyjdbcdatalist("SELECT i.*,i.partname as itemname,mfg.name as mfgname \n"
                + "FROM invoicedetails i \n"
                + "left join  carpartinfo cpi on cpi.id=i.partid\n"
                + "left join  carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "left join  manufacturer mfg on mfg.id=i.manufacturerid \n"
                + "where i.invoiceid='" + invoiceId + "' and i.isdelete='No'"));
        //convert ka labour info
        modelAndView.addObject("labourinventorydt", viewService.getanyjdbcdatalist("SELECT *,servicename as name FROM labourinventory\n"
                + "where invoiceid='" + invoiceId + "' and isdelete='No' and total>0"));
        return modelAndView;

    }

    //redirects to  Customer Insurance invoice page
    @RequestMapping("viewProformaInvoice")
    public ModelAndView viewProformaInvoice(@RequestParam(value = "invoiceid") String invoiceId) {
        ModelAndView modelAndView = new ModelAndView("InvoiceProformaMail");
        modelAndView.addObject("vatDetails", viewService.getanyhqldatalist("from taxes where isdelete<>'Yes' and id in('ATX1','ATX2')"));

        //view invoice data required for getting data
        List<Map<Object, String>> invoicemap = viewService.getanyjdbcdatalist("SELECT iv.*,bd.vehiclename,bdd.name as make\n"
                + "FROM invoice iv\n"
                + "left join branddetails bd on bd.id=iv.vehicleid\n"
                + "left join brand bdd on bdd.id=bd.brandid\n"
                + "where iv.id='" + invoiceId + "'");

        modelAndView.addObject("invoiceDt", invoicemap.get(0));

        if (invoicemap.get(0).get("isinsurance").equals("Yes")) {
            if (invoicemap.get(0).get("insurancetype").equals("Full Payment")) {
                modelAndView.addObject("insuranceinvoiceDt", viewService.getanyjdbcdatalist("SELECT CAST(iv.sparepartsfinal AS UNSIGNED)+ CAST(iv.labourfinal AS UNSIGNED) as claimtotal,\n"
                        + "CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as taxtotal,\n"
                        + "CAST(iv.labourfinal AS UNSIGNED)+CAST(iv.sparepartsfinal AS UNSIGNED)+CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as grandtotal\n"
                        + "FROM invoice iv\n"
                        + "where iv.id='" + invoiceId + "'").get(0));
            }
        }

        Invoice invoicemobile = (Invoice) viewService.getspecifichqldata(Invoice.class, invoiceId);
        String custnumber = invoicemobile.getCustomermobilenumber();

        List<Map<String, Object>> customerlist = viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                + "FROM invoice inv\n"
                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                + "inner join customervehicles cv on cv.custid=cu.id\n"
                + "where cu.mobilenumber='" + custnumber + "'\n"
                + "group by cu.mobilenumber");

        if (customerlist.size() > 0) {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "inner join customervehicles cv on cv.custid=cu.id\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        } else {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        }

//        modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
//                + "FROM invoice inv\n"
//                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
//                + "inner join customervehicles cv on cv.custid=cu.id\n"
//                + "where cu.mobilenumber='" + custnumber + "'\n"
//                + "group by cu.mobilenumber").get(0));
        //normal inovice create ka view[carparts]
        modelAndView.addObject("labourandpartdt", viewService.getanyjdbcdatalist("SELECT i.*,i.partname as itemname,mfg.name as mfgname \n"
                + "FROM invoicedetails i \n"
                + "left join  carpartinfo cpi on cpi.id=i.partid\n"
                + "left join  carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "left join  manufacturer mfg on mfg.id=i.manufacturerid \n"
                + "where i.invoiceid='" + invoiceId + "' and i.isdelete='No'"));
        //convert ka labour info
        modelAndView.addObject("labourinventorydt", viewService.getanyjdbcdatalist("SELECT *,servicename as name FROM labourinventory\n"
                + "where invoiceid='" + invoiceId + "' and isdelete='No' and total>0"));
        return modelAndView;

    }

    //redirects to  Customer Insurance invoice page
    @RequestMapping("sendMailTaxInvoice")
    public ModelAndView sendMailTaxInvoice(@RequestParam(value = "invoiceid") String invoiceId) {
        ModelAndView modelAndView = new ModelAndView("InvoiceTaxMail");
        modelAndView.addObject("vatDetails", viewService.getanyhqldatalist("from taxes where isdelete<>'Yes' and id in('ATX1','ATX2')"));

        //view invoice data required for getting data
        List<Map<Object, String>> invoicemap = viewService.getanyjdbcdatalist("SELECT iv.*,bd.vehiclename,bdd.name as make\n"
                + "FROM invoice iv\n"
                + "left join branddetails bd on bd.id=iv.vehicleid\n"
                + "left join brand bdd on bdd.id=bd.brandid\n"
                + "where iv.id='" + invoiceId + "'");

        modelAndView.addObject("invoiceDt", invoicemap.get(0));

        if (invoicemap.get(0).get("isinsurance").equals("Yes")) {
            if (invoicemap.get(0).get("insurancetype").equals("Full Payment")) {
                modelAndView.addObject("insuranceinvoiceDt", viewService.getanyjdbcdatalist("SELECT CAST(iv.sparepartsfinal AS UNSIGNED)+ CAST(iv.labourfinal AS UNSIGNED) as claimtotal,\n"
                        + "CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as taxtotal,\n"
                        + "CAST(iv.labourfinal AS UNSIGNED)+CAST(iv.sparepartsfinal AS UNSIGNED)+CAST(iv.taxAmount1 AS UNSIGNED)+ CAST(iv.taxAmount2 AS UNSIGNED) as grandtotal\n"
                        + "FROM invoice iv\n"
                        + "where iv.id='" + invoiceId + "'").get(0));
            }
        }

        Invoice invoicemobile = (Invoice) viewService.getspecifichqldata(Invoice.class, invoiceId);
        String custnumber = invoicemobile.getCustomermobilenumber();

        List<Map<String, Object>> customerlist = viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                + "FROM invoice inv\n"
                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                + "inner join customervehicles cv on cv.custid=cu.id\n"
                + "where cu.mobilenumber='" + custnumber + "'\n"
                + "group by cu.mobilenumber");

        if (customerlist.size() > 0) {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "inner join customervehicles cv on cv.custid=cu.id\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        } else {
            modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*\n"
                    + "FROM invoice inv\n"
                    + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                    + "where cu.mobilenumber='" + custnumber + "'\n"
                    + "group by cu.mobilenumber").get(0));
        }

//        modelAndView.addObject("customerinvoiceDt", viewService.getanyjdbcdatalist("SELECT inv.*,cu.*,cv.km_in\n"
//                + "FROM invoice inv\n"
//                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
//                + "inner join customervehicles cv on cv.custid=cu.id\n"
//                + "where cu.mobilenumber='" + custnumber + "'\n"
//                + "group by cu.mobilenumber").get(0));
        //normal inovice create ka view[carparts]
        modelAndView.addObject("labourandpartdt", viewService.getanyjdbcdatalist("SELECT i.*,i.partname as itemname,mfg.name as mfgname \n"
                + "FROM invoicedetails i \n"
                + "left join  carpartinfo cpi on cpi.id=i.partid\n"
                + "left join  carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "left join  manufacturer mfg on mfg.id=i.manufacturerid \n"
                + "where i.invoiceid='" + invoiceId + "' and i.isdelete='No'"));
        //convert ka labour info
        modelAndView.addObject("labourinventorydt", viewService.getanyjdbcdatalist("SELECT *,servicename as name FROM labourinventory\n"
                + "where invoiceid='" + invoiceId + "' and isdelete='No' and total>0"));
        return modelAndView;

    }

    //redirect to view popup for payment hisory 20-11-2015 begin here
    @RequestMapping(value = "getPaymentDetails", method = RequestMethod.POST)
    public void getPaymentDetails(@RequestParam(value = "invoiceid") String invoiceid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getPaymentList = viewService.getanyhqldatalist("from generalincome where invoiceid='" + invoiceid + "' and isdelete='No'");
        jsondata = new Gson().toJson(getPaymentList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }
    //redirect to view popup for payment hisory 20-11-2015 ends! here

    //redirects with data to edit invoice page
    @RequestMapping(value = "editInvoiceDetailsLink")
    public ModelAndView editInvoiceDetailsLink(@RequestParam(value = "invoiceid") String invoiceId) {
        ModelAndView modelAndView = new ModelAndView("EditInvoice");

        //code to change invoice number begins here
        List<Map<String, Object>> missinglist = new ArrayList<Map<String, Object>>();
        List<Map<String, Double>> mylist = viewService.getanyjdbcdatalist("SELECT SUBSTRING(a.invoiceid from 4)+1 AS start, MIN(SUBSTRING(b.invoiceid from 4)) - 1 AS end\n"
                + "FROM invoice AS a, invoice AS b\n"
                + "WHERE a.invoiceid like '" + env.getProperty("branch_prefix") + "%' and b.invoiceid like '" + env.getProperty("branch_prefix") + "%' and SUBSTRING(a.invoiceid from 4) < SUBSTRING(b.invoiceid from 4)\n"
                + "GROUP BY SUBSTRING(a.invoiceid from 4)\n"
                + "HAVING start < MIN(SUBSTRING(b.invoiceid from 4))");
        if (mylist.size() > 0) {

            for (int i = 0; i < mylist.size(); i++) {
                int start = mylist.get(i).get("start").intValue();
                int end = mylist.get(i).get("end").intValue();
                //if start and end same then add else +1 in loop 

                if (start == end) {
                    Map<String, Object> setmap = new HashMap<String, Object>();
                    setmap.put("missingid", env.getProperty("invoice") + "" + start);
                    missinglist.add(setmap);
                } else {
                    for (int j = start; j <= end; j++) {
                        Map<String, Object> setmap = new HashMap<String, Object>();
                        setmap.put("missingid", env.getProperty("invoice") + "" + j);
                        missinglist.add(setmap);
                    }
                }

            }
        }
        modelAndView.addObject("missingiddt", missinglist);
        //code to change invoice number ends! here

        //ajax data required for adding data .
        modelAndView.addObject("customers", viewService.getanyhqldatalist("from customer where isdelete<>'Yes'"));
        modelAndView.addObject("vehicles", viewService.getanyhqldatalist("from branddetails where isdelete<>'Yes'"));
//        modelAndView.addObject("carparts", viewService.getanyhqldatalist("from carparts where isdelete<>'Yes'"));
        modelAndView.addObject("services", viewService.getanyhqldatalist("from labourservices where isdelete<>'Yes'"));
        modelAndView.addObject("allmfgdata", viewService.getanyhqldatalist("from manufacturer where isdelete<>'Yes'"));
        modelAndView.addObject("insuranceCompanyDetails", viewService.getanyhqldatalist("from insurance_company where isdelete<>'Yes'"));
        List<Taxes> taxList = viewService.getanyhqldatalist("from taxes where isdelete<>'Yes' and id in('ATX1','ATX2')");
        modelAndView.addObject("vatDetails", taxList);

        //invoice data required for getting data
        List<Invoice> invoicemapforInsurance = viewService.getanyhqldatalist("from invoice where id='" + invoiceId + "' and isdelete='No'");
        List<Map<Object, String>> invoicemap;
        if (invoicemapforInsurance.get(0).getIsinsurance().equals("No")) {
            invoicemap = viewService.getanyjdbcdatalist("SELECT iv.*,bd.vehiclename,bd.labourChargeType FROM invoice iv\n"
                    + "inner join branddetails bd on bd.id=iv.vehicleid\n"
                    + "where iv.id='" + invoiceId + "'");
        } else {
            invoicemap = viewService.getanyjdbcdatalist("SELECT iv.*,bd.vehiclename,bd.labourChargeType,ic.id as insurancecompanyid,ic.name as insurancecompanyname  \n"
                    + "FROM invoice iv\n"
                    + "inner join branddetails bd on bd.id=iv.vehicleid\n"
                    + "inner join insurance_company ic on ic.id=iv.insurancecompany\n"
                    + "where iv.id='" + invoiceId + "'");
            //code for caclulating liabilities goes here
            List<Map<String, Object>> liabilityList = viewService.getanyjdbcdatalist("SELECT sum(i.insurancecompanyamount) company,sum(i.insurancecustomeramount) customer\n"
                    + "FROM invoicedetails i \n"
                    + "where i.invoiceid='" + invoiceId + "' and i.isdelete='No'");
            List<Map<String, Object>> laborliabilityList = viewService.getanyjdbcdatalist("SELECT sum(companyinsurance) company,sum(customerinsurance) customer FROM labourinventory\n"
                    + "where invoiceid='" + invoiceId + "' and isdelete='No'");

            //code for all part calculations goes here
            DecimalFormat df = new DecimalFormat("####0.00");
            double company, customer, vattax, servicetax, companyresult, customerresult;
            String companyy = liabilityList.get(0).get("company").toString();
            company = Double.parseDouble(companyy);
            
            customer = Double.parseDouble(liabilityList.get(0).get("customer").toString());
            vattax = Double.parseDouble(taxList.get(0).getPercent().toString());
            servicetax = Double.parseDouble(taxList.get(1).getPercent().toString());
            
            companyresult = company * vattax / 100;
            customerresult = customer * vattax / 100;
            modelAndView.addObject("liabilitypartcompanysum", company);
            modelAndView.addObject("liabilitypartcompany", companyresult + company);
            modelAndView.addObject("liabilitypartcompanytax", companyresult);
            modelAndView.addObject("liabilitypartcustomersum", customer);
            modelAndView.addObject("liabilitypartcustomer", customerresult + customer);
            modelAndView.addObject("liabilitypartcustomertax", customerresult);
            //code for all labor calculations goes here
            company = Double.parseDouble(laborliabilityList.get(0).get("company").toString());
            customer = Double.parseDouble(laborliabilityList.get(0).get("customer").toString());
            
            companyresult = company * servicetax / 100;
            customerresult = customer * servicetax / 100;
            modelAndView.addObject("liabilitylaborcompanysum", company);
            modelAndView.addObject("liabilitylaborcompany", companyresult + company);
            modelAndView.addObject("liabilitylaborcompanytax", companyresult);
            modelAndView.addObject("liabilitylaborcustomersum", customer);
            modelAndView.addObject("liabilitylaborcustomer", customerresult + customer);
            modelAndView.addObject("liabilitylaborcustomertax", customerresult);
        }
        modelAndView.addObject("invoiceDt", invoicemap.get(0));

        String vehicleid = invoicemap.get(0).get("vehicleid");
        
        List<Map<String, Object>> getparts = viewService.getanyjdbcdatalist("SELECT cpi.*,cpv.name as partname \n"
                + "FROM carpartinfo cpi\n"
                + "left join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where branddetailid='" + vehicleid + "'\n"
                + "and cpv.isdelete<>'Yes' and cpi.id like '" + env.getProperty("branch_prefix") + "%'");
        List<Map<String, Object>> jsonlist = new ArrayList<Map<String, Object>>();
        for (int i = 0; getparts.size() > 0 && i < getparts.size(); i++) {
            Map<String, Object> setjsonmap = new HashMap<String, Object>();
            setjsonmap.put("partname", getparts.get(i).get("partname"));
            setjsonmap.put("id", getparts.get(i).get("id"));
            jsonlist.add(setjsonmap);
        }
        modelAndView.addObject("carparts", jsonlist);

        //normal create k time pe
        modelAndView.addObject("labourandpartdt", viewService.getanyjdbcdatalist("SELECT i.*,i.partname as itemname,mfg.name as mfgname \n"
                + "FROM invoicedetails i                \n"
                + "left join  carpartinfo cpi on cpi.id=i.partid\n"
                + "left join  carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "left join  manufacturer mfg on mfg.id=i.manufacturerid                \n"
                + "where i.invoiceid='" + invoiceId + "' and i.isdelete='No'"));
        //convert ka labour info
        modelAndView.addObject("labourinventorydt", viewService.getanyjdbcdatalist("SELECT *,servicename as name FROM labourinventory\n"
                + "where invoiceid='" + invoiceId + "' and isdelete='No'"));
        return modelAndView;
    }

    //get manufacturer & all info in ajax on createcustomerinvocie form page
    @RequestMapping(value = "getpartdata", method = RequestMethod.POST)
    public void getpartdata(@RequestParam(value = "id") String vehicleid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getparts = viewService.getanyjdbcdatalist("SELECT cpi.*,cpv.name as partname \n"
                + "FROM carpartinfo cpi\n"
                + "left join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where cpi.isdelete='No' and cpi.branddetailid in('" + vehicleid + "','" + env.getProperty("generic_brand_detailid") + "') and cpv.isdelete='No'  \n"
                + "and cpv.itemtype='part'");
        List<Map<String, Object>> jsonlist = new ArrayList<Map<String, Object>>();
        for (int i = 0; getparts.size() > 0 && i < getparts.size(); i++) {
            Map<String, Object> setjsonmap = new HashMap<String, Object>();
            setjsonmap.put("partname", getparts.get(i).get("partname"));
            setjsonmap.put("id", getparts.get(i).get("id"));
            jsonlist.add(setjsonmap);
        }
        jsondata = new Gson().toJson(jsonlist);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //get manufacturer & all info in ajax on create customer consumable form page
    @RequestMapping(value = "getconsumabledata", method = RequestMethod.POST)
    public void getconsumabledata(@RequestParam(value = "id") String vehicleid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        String branchPrefix = env.getProperty("branch_prefix");
        List<Map<String, Object>> getparts = viewService.getanyjdbcdatalist("SELECT cpi.*,cpv.name as partname \n"
                + "FROM carpartinfo cpi\n"
                + "left join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where cpi.branddetailid in ('" + vehicleid + "','" + env.getProperty("consumable_brand_detailid") + "')\n"
                + "and cpv.isdelete<>'Yes' and cpv.itemtype='consumable' and cpi.id like '" + branchPrefix + "%'");
        List<Map<String, Object>> jsonlist = new ArrayList<Map<String, Object>>();
        for (int i = 0; getparts.size() > 0 && i < getparts.size(); i++) {
            Map<String, Object> setjsonmap = new HashMap<String, Object>();
            setjsonmap.put("partname", getparts.get(i).get("partname"));
            setjsonmap.put("id", getparts.get(i).get("id"));
            jsonlist.add(setjsonmap);
        }
        jsondata = new Gson().toJson(jsonlist);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //view all customer tickets
    @RequestMapping(value = "viewCustomerTickets")
    public ModelAndView viewCustomerTickets() {
        ModelAndView modelAndView = new ModelAndView("ViewCustomerTickets");
        modelAndView.addObject("customerticketsDt", viewService.getanyjdbcdatalist("SELECT tc.* ,ct.name\n"
                + "FROM tickets tc\n"
                + "left join customers ct on ct.id=tc.userid"));
        return modelAndView;
    }

    //latest
    //view Service Check List grid page
    @RequestMapping(value = "service_checklist_grid")
    public ModelAndView servicechecklisgrid() {
        ModelAndView modelAndView = new ModelAndView("ServiceCheckList");
        modelAndView.addObject("servicedtls", viewService.getanyjdbcdatalist("SELECT cv.*,cv.id as cvid,c.name,cvd.id as cvdid FROM customervehicles cv\n"
                + "inner join customervehiclesdetails cvd on cvd.custvehicleid=cv.id\n"
                + "inner join customer c on cv.custid=c.id where c.isdelete='No' and cv.isdelete='No' and cv.ishidden='No' order by cv.savedate desc"));
        return modelAndView;
    }

    @RequestMapping(value = "create_service_checklist")
    public ModelAndView create_service_checklist() {
        ModelAndView modelAndView = new ModelAndView("CreateServiceCheckList");
        modelAndView.addObject("custdtls", viewService.getanyhqldatalist("from customer where isdelete<>'Yes'"));
        modelAndView.addObject("brand", viewService.getanyhqldatalist("from brand where isdelete<>'Yes'"));
        modelAndView.addObject("carbranddetails", viewService.getanyhqldatalist("from brand where isdelete='No' "));
//        modelAndView.addObject("branddetails", viewService.getanyhqldatalist("from branddetails where isdelete<>'Yes'"));
        return modelAndView;

    }

    //edit service checklist link redirects to service checklist page
    @RequestMapping(value = "EditServiceCheckList")
    public ModelAndView EditServiceCheckList(@RequestParam(value = "id") String id, String bdid) {
        ModelAndView modelAndView = new ModelAndView("EditServiceCheckList");
        modelAndView.addObject("custdtls", viewService.getanyhqldatalist("from customer"));
        modelAndView.addObject("servicedtls", viewService.getanyjdbcdatalist("SELECT *,cv.id as cvid,cvd.id as cvdid,c.name as custname,c.mobilenumber as cusmobile FROM customervehicles cv\n"
                + "left join customervehiclesdetails cvd on cvd.custvehicleid=cv.id\n"
                + "left join customer c on c.id=cv.custid\n"
                + "where cv.isdelete<>'Yes' and cv.id='" + id + "'").get(0));
        modelAndView.addObject("brand", viewService.getanyhqldatalist("from brand where isdelete<>'Yes'"));
        modelAndView.addObject("branddetails", viewService.getanyhqldatalist("from branddetails where isdelete<>'Yes' and brandid='" + bdid + "'"));
        return modelAndView;
    }

    //edit service checklist link redirects to service checklist page
    @RequestMapping(value = "viewServiceCheckList")
    public ModelAndView viewServiceCheckList(@RequestParam(value = "id") String id, String bdid) {
        ModelAndView modelAndView = new ModelAndView("ViewServiceCheckList");
        modelAndView.addObject("custdtls", viewService.getanyhqldatalist("from customer"));
        modelAndView.addObject("servicedtls", viewService.getanyjdbcdatalist("SELECT *,cv.id as cvid,cvd.id as cvdid,c.name as custname,c.mobilenumber as cusmobile FROM customervehicles cv\n"
                + "left join customervehiclesdetails cvd on cvd.custvehicleid=cv.id\n"
                + "left join customer c on c.id=cv.custid\n"
                + "where cv.isdelete<>'Yes' and cv.id='" + id + "'").get(0));
        modelAndView.addObject("brand", viewService.getanyhqldatalist("from brand where isdelete<>'Yes'"));
        modelAndView.addObject("branddetails", viewService.getanyhqldatalist("from branddetails where isdelete<>'Yes' and brandid='" + bdid + "'"));
        return modelAndView;
    }

    @RequestMapping(value = "getcustdata", method = RequestMethod.POST)
    public @ResponseBody
    String getcustdata(@RequestParam(value = "custno") String getcustmobile) {
        List<Customer> clist = viewService.getanyhqldatalist("from customer where mobilenumber='" + getcustmobile + "'");
        String idandname = clist.get(0).getId() + "," + clist.get(0).getName();
        return idandname;
    }

    @RequestMapping(value = "getcustvehicles", method = RequestMethod.POST)
    public void getcustvehicles(@RequestParam("custid") String custid, HttpServletResponse response) throws IOException {
        ArrayList<Map<String, Object>> custlistdata = new ArrayList<Map<String, Object>>();
        try {
            List<Map<String, Object>> customervehicles = viewService.getanyjdbcdatalist("select cv.brandid,cv.vehiclenumber,cv.branddetailid, bd.name brandname,bdd.vehiclename\n"
                    + "from customervehicles cv\n"
                    + "inner join brand bd on bd.id=cv.brandid\n"
                    + "inner join branddetails bdd on bdd.id=cv.branddetailid\n"
                    + "WHERE cv.custid='" + custid + "' AND cv.isdelete='NO' group by cv.vehiclenumber");

            List<CustomerVehicles> cv = viewService.getanyhqldatalist("from customervehicles where custid='" + custid + "' and isdelete='No' group by vehiclenumber ");

            for (int i = 0; customervehicles.size() > 0 && i < customervehicles.size(); i++) {
                Map<String, Object> getmap = new HashMap<String, Object>();
                getmap.put("vehicle", customervehicles.get(i).get("vehiclenumber"));
                getmap.put("brandid", customervehicles.get(i).get("brandid"));
                getmap.put("branddetailid", customervehicles.get(i).get("branddetailid"));
                getmap.put("brandname", customervehicles.get(i).get("brandname"));
                getmap.put("vehiclename", customervehicles.get(i).get("vehiclename"));
                custlistdata.add(getmap);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String json = new Gson().toJson(custlistdata);
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.getWriter().write(json);

    }

    @RequestMapping(value = "getvehicledetails", method = RequestMethod.POST)
    public void getvehicledetails(@RequestParam("vno") String vno, HttpServletResponse response) throws IOException {
        List<CustomerVehicles> cv = viewService.getanyhqldatalist("from customervehicles where vehiclenumber='" + vno + "'");
        ArrayList<Map<String, Object>> custlistdata = new ArrayList<Map<String, Object>>();

        Map<String, Object> getmap = new HashMap<String, Object>();
        getmap.put("vehicle", cv.get(0).getVehiclenumber());
        getmap.put("brand", cv.get(0).getCarbrand());
        getmap.put("model", cv.get(0).getCarmodel());
        getmap.put("license", cv.get(0).getLicensenumber());
        getmap.put("vinno", cv.get(0).getVinnumber());
        getmap.put("id", cv.get(0).getId());
        getmap.put("brandid", cv.get(0).getBrandid());
        getmap.put("branddetailid", cv.get(0).getBranddetailid());
        custlistdata.add(getmap);
        String json = new Gson().toJson(custlistdata);
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.getWriter().write(json);

    }

    @RequestMapping(value = "gebranddetails", method = RequestMethod.POST)
    public void gebranddetails(@RequestParam(value = "brandid") String brandid, HttpServletResponse response) throws IOException {
        List<BrandDetails> branddetails = viewService.getanyhqldatalist("from branddetails where isdelete<>'Yes' and brandid='" + brandid + "'");
        List<Map<String, Object>> setdatalist = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < branddetails.size(); i++) {
            Map<String, Object> setmap = new HashMap<String, Object>();
            setmap.put("id", branddetails.get(i).getId());
            setmap.put("name", branddetails.get(i).getVehiclename());
            setdatalist.add(setmap);
        }
        String jsonstring = new Gson().toJson(setdatalist);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonstring);
    }

    //view estimate grid
    @RequestMapping(value = "estimate")
    public String estimate(Map<String, Object> map) {
        map.put("estimatedtls", viewService.getanyjdbcdatalist("SELECT est.isjobsheetready, est.id as estid,est.approval,cu.name as custname,cv.carmodel,cv.vehiclenumber,est.savedate FROM estimate est\n"
                + "inner join customervehicles cv on cv.id=est.cvid\n"
                + "inner join customer cu on cu.id=cv.custid where cu.isdelete='No' and est.isdelete='No' and est.ishidden='No' order by length(est.id) desc,est.id desc"));
        return "Estimate";
    }

    //verify admin login
    @RequestMapping(value = "verifylogin", method = RequestMethod.POST)
    public ModelAndView verifylogin(@RequestParam(value = "username") String username, @RequestParam(value = "password") String password, HttpSession session) {
        ModelAndView modelAndView = null;
        List<UserDetails> userlist = viewService.getanyhqldatalist("from userdetails where username='" + username + "' and password='" + password + "' and isdelete<>'Yes'");
        if (userlist != null && userlist.size() > 0 && userlist.get(0).getUsername().equals(username) && userlist.get(0).getPassword().equals(password)) {
            session.setAttribute("USERID", userlist.get(0).getId());
            session.setAttribute("USERNAME", userlist.get(0).getName());
            session.setAttribute("USERTYPE", userlist.get(0).getType());
            session.setAttribute("PASSWORD", userlist.get(0).getPassword());
            String mainbranchid = env.getProperty("this_branch_id");
            List<Branch> branchList = viewService.getanyhqldatalist("from branch where id='" + mainbranchid + "'");
            session.setAttribute("BRANCHNAME", branchList.get(0).getPurchase_ord_prefix());

            if (userlist.get(0).getType().equals("spares")) {
                //coding for dashboard new estimete count begin here
                List<Map<String, Object>> estimateList = viewService.getanyjdbcdatalist("select count(id) as newestimates from estimate where isjobsheetready='No'");
                session.setAttribute("ESTIMATECOUNT", estimateList.get(0).get("newestimates"));

                List<Map<String, Object>> quantityList = viewService.getanyjdbcdatalist("SELECT count(estd.estimateid) as needcount  FROM estimatedetails estd\n"
                        + "inner join carpartinfo cpi on cpi.id=estd.partlistid\n"
                        + "where cpi.balancequantity<=0 and estd.approval='Yes' and estd.ispurchaseorder_ready='No'");
                session.setAttribute("QUANTITYCOUNT", quantityList.get(0).get("needcount"));

                List<Map<String, Object>> requisitionList = viewService.getanyjdbcdatalist("select count(id) as idcount from jobsheet\n"
                        + "where isdelete='No' and isrequisitionready='No'");
                session.setAttribute("REQUISITIONCOUNT", requisitionList.get(0).get("idcount"));
                //coding for dashboard new estimete count end here
                modelAndView = new ModelAndView("redirect:estimate");
            } else if (userlist.get(0).getType().equals("crm")) {
                modelAndView = new ModelAndView("redirect:crm_Dashboard?prefixid=A");
            } else {
                modelAndView = new ModelAndView("redirect:gotobranchinfo?prefixid=A");
            }
        } else {
            modelAndView = new ModelAndView("Login", "errmsg", "Authentication error please check your username/password");
        }
        return modelAndView;
    }

    //logout
//    @RequestMapping(value = "logout")
//    public String logout(HttpSession session) {
//        session.invalidate();
//        return "redirect:Login";
//    }
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        if (request.getSession().getAttribute("USERNAME") != null) {
            request.getSession().invalidate();

            return "redirect:/Login";
        }
        return "redirect:/Login";
    }

    // latest
    //nitz work done
    //12:41 24/04/2015 view 180 point checklist page with static data 
    @RequestMapping(value = "180pointchecklist")
    public ModelAndView view180pointCheckList(@RequestParam(value = "id") String cvdid, @RequestParam(value = "branddetailid") String brandid) {
        ModelAndView modelAndView = new ModelAndView("180pointChecklistPage");
        modelAndView.addObject("custdt", viewService.getanyjdbcdatalist("select cvd.id as cvdid,cv.id as cvid,cv.vehiclenumber as vehiclenumber,cv.carmodel as carmodel,cv.km_in,cvd.fuellevel,cvd.additionalwork from customervehiclesdetails cvd\n"
                + "left join customervehicles cv on cv.id = cvd.custvehicleid\n"
                + "where cvd.isdelete='No'\n"
                + "and cvd.id='" + cvdid + "'").get(0));
        List<Map<String, Object>> listofcheckList = new ArrayList<Map<String, Object>>();
        List<Category> categorys = viewService.getanyhqldatalist("from category where isdelete<>'Yes' and id!='" + env.getProperty("used_categoryid") + "'");
        for (int i = 0; i < categorys.size(); i++) {
            List<CarPartVault> carPartVaults = viewService.getanyhqldatalist("from carpartvault where categoryid='" + categorys.get(i).getId() + "' and isdelete='No'");
            Map<String, Object> getmap = new HashMap<String, Object>();
            getmap.put("categoryname", categorys.get(i).getName());
            List<Map<String, Object>> listofpartinfo = new ArrayList<Map<String, Object>>();
            for (int j = 0; j < carPartVaults.size(); j++) {
                List<CarPartInfo> partinfo = viewService.getanyjdbcdatalist("SELECT cpi.id as cpiid,cpv.name as partname FROM carpartinfo cpi\n"
                        + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                        + "where cpi.isdelete='No' and cpi.branddetailid in('" + brandid + "','" + env.getProperty("generic_brand_detailid") + "')  and cpi.vaultid='" + carPartVaults.get(j).getId() + "' and cpv.itemtype='part'");
                if (partinfo.size() > 0) {
                    Map<String, Object> getmap2 = new HashMap<String, Object>();
                    getmap2.put("categoryname", partinfo);
                    listofpartinfo.add(getmap2);
                }
            }
            getmap.put("listofcpv", listofpartinfo);
            listofcheckList.add(getmap);
        }
        modelAndView.addObject("allpartdetails", listofcheckList);
        return modelAndView;
    }

    //view 180pointchecklist grid page
    @RequestMapping(value = "180pointchecklistgridlink")
    public ModelAndView pointchecklistgridlink() {
        ModelAndView modelAndView = new ModelAndView("View180PointCheckListGrid");
        modelAndView.addObject("pointchecklistdt", viewService.getanyjdbcdatalist("SELECT pcl.date as pcldate,pcl.id,pcl.isestimate as estimatestatus,pcl.customervehiclesid,cv.vehiclenumber,cv.carmodel,cv.branddetailid FROM pointchecklist pcl\n"
                + "inner join customervehicles cv on cv.id=pcl.customervehiclesid \n"
                + "inner join customer c on cv.custid=c.id\n"
                + "where c.isdelete='No' and pcl.isdelete='No' and pcl.ishidden='No' order by pcl.savedate desc"));
        return modelAndView;
    }

    //180pointchecklistviewdetails redirect to detail page
    @RequestMapping(value = "180pointchecklistviewdetails")
    public ModelAndView pointchecklistviewdetails(@RequestParam(value = "pclid") String pclid) {
        ModelAndView modelAndView = new ModelAndView("180pointChecklistViewDetails");
        modelAndView.addObject("pcldt", viewService.getanyjdbcdatalist("SELECT pcl.date as pcldate,pcl.servicechecklistid,pcl.id,pcl.customervehiclesid ,cv.vehiclenumber,cv.branddetailid,cv.carmodel,cv.km_in,cvd.fuellevel,cvd.additionalwork,pcl.isestimate FROM pointchecklist pcl\n"
                + "inner join customervehicles cv on cv.id=pcl.customervehiclesid \n"
                + "inner join customervehiclesdetails cvd on cvd.custvehicleid=cv.id\n"
                + "where pcl.isdelete='No' and pcl.id='" + pclid + "'").get(0));

        List<Map<String, Object>> listof180point = new ArrayList<Map<String, Object>>();

        List<Map<String, Object>> categoryids = viewService.getanyjdbcdatalist("select cpv.categoryid,cg.name as categoryname from pointchecklistdetails pcld\n"
                + "inner JOIN carpartinfo cpi on cpi.id=pcld.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join category cg on cg.id=cpv.categoryid\n"
                + "where pointchecklistid='" + pclid + "'\n"
                + "group by cpv.categoryid");

        for (int i = 0; i < categoryids.size(); i++) {
            List<Map<String, Object>> partlists = viewService.getanyjdbcdatalist("SELECT * from pointchecklistdetails pcld\n"
                    + "inner join carpartinfo cpi on cpi.id=pcld.partlistid\n"
                    + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                    + "where cpv.categoryid='" + categoryids.get(i).get("categoryid") + "' and pointchecklistid='" + pclid + "'");

            Map<String, Object> getmap = new HashMap<String, Object>();
            getmap.put("categoryname", categoryids.get(i).get("categoryname"));
            getmap.put("partlistdt", partlists);
            listof180point.add(getmap);
        }
        modelAndView.addObject("partandcategoriesdt", listof180point);
        return modelAndView;
    }

    //redirect to edit 180_point_checklist_page with data
    @RequestMapping(value = "edit180pointchecklist")
    public ModelAndView edit180pointchecklist(@RequestParam(value = "id") String pclid, @RequestParam(value = "brandid") String brandid) {
        ModelAndView modelAndView = new ModelAndView("Edit180pointChecklistPage");
        modelAndView.addObject("pcldt", viewService.getanyjdbcdatalist("SELECT pcl.date as pcldate,pcl.id,pcl.customervehiclesid ,cv.vehiclenumber,cv.carmodel,cv.km_in,cvd.fuellevel,cvd.additionalwork FROM pointchecklist pcl\n"
                + "inner join customervehicles cv on cv.id=pcl.customervehiclesid \n"
                + "inner join customervehiclesdetails cvd on cvd.custvehicleid=cv.id\n"
                + "where pcl.isdelete='No' and pcl.id='" + pclid + "'").get(0));

        //all data for selection and changes
        List<Map<String, Object>> listofcheckList = new ArrayList<Map<String, Object>>();
        List<Category> categorys = viewService.getanyhqldatalist("from category where isdelete<>'Yes' and id!='" + env.getProperty("used_categoryid") + "'");

        for (int i = 0; i < categorys.size(); i++) {
            List<Map<String, Object>> carPartVaults = viewService.getanyjdbcdatalist("SELECT cpi.id,cpv.name FROM carpartinfo cpi \n"
                    + "inner join carpartvault cpv on cpv.id=cpi.vaultid where categoryid='" + categorys.get(i).getId() + "' \n"
                    + "and cpi.id in(SELECT partlistid FROM pointchecklistdetails where pointchecklistid='" + pclid + "') and cpi.isdelete='No'");

            List<Map<String, Object>> carPartVaults1 = viewService.getanyjdbcdatalist("SELECT cpi.id,cpv.name FROM carpartinfo cpi\n"
                    + "inner join carpartvault cpv on cpv.id=cpi.vaultid where categoryid='" + categorys.get(i).getId() + "'  and cpi.branddetailid in ('" + brandid + "','" + env.getProperty("generic_brand_detailid") + "')\n"
                    + "and cpi.id not in(SELECT partlistid FROM pointchecklistdetails where pointchecklistid='" + pclid + "')and cpi.isdelete='No'");

            Map<String, Object> getmap = new HashMap<String, Object>();
            getmap.put("categoryname", categorys.get(i).getName());
            getmap.put("matchpartlist", carPartVaults);
            getmap.put("notmatchpartlist", carPartVaults1);
            listofcheckList.add(getmap);
        }
        modelAndView.addObject("allpartdetails", listofcheckList);
        return modelAndView;
    }

    //view create estimate page with static data
    @RequestMapping("addEstimatePage")
    public ModelAndView addEstimatePage(@RequestParam("pclid") String pclid) {
        ModelAndView modelAndView = new ModelAndView("AddEstimate");
        modelAndView.addObject("pcldtncustdt", viewService.getanyjdbcdatalist("SELECT pcl.date as pcldate,pcl.customervehiclesid as cvid,cvd.additionalwork,pcl.id,cv.vehiclenumber,cv.carmodel,cv.branddetailid,cv.vehiclenumber,cu.name,bd.labourChargeType\n"
                + "FROM pointchecklist pcl \n"
                + "inner join customervehicles cv on cv.id=pcl.customervehiclesid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "inner join branddetails bd on bd.id=cv.branddetailid\n"
                + "inner join customervehiclesdetails cvd on cvd.custvehicleid=pcl.customervehiclesid\n"
                + "where pcl.isdelete='No' and pcl.id='" + pclid + "'").get(0));

        //nitz edit begin here
        List<Map<String, Object>> listofestimateparts = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> partdetailsList = viewService.getanyjdbcdatalist("SELECT pcd.partlistid,cpv.name as partname,cpv.a,cpv.b,cpv.c,cpv.d \n"
                + "FROM pointchecklistdetails pcd\n"
                + "inner join carpartinfo cpi on cpi.id=pcd.partlistid\n"
                + "left join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where pcd.pointchecklistid='" + pclid + "'\n"
                + "order by pcd.partlistid desc");

        for (int j = 0; j < partdetailsList.size(); j++) {
            List getFivePrice = viewService.getanyjdbcdatalist("SELECT costprice as maxprice FROM inventory where partid='" + partdetailsList.get(j).get("partlistid") + "' and type='inward' ORDER BY costprice DESC LIMIT 5");

            Map<String, Object> getmap = new HashMap<String, Object>();
            getmap.put("partname", partdetailsList.get(j).get("partname"));
            getmap.put("partlistid", partdetailsList.get(j).get("partlistid"));
            getmap.put("a", partdetailsList.get(j).get("a"));
            getmap.put("b", partdetailsList.get(j).get("b"));
            getmap.put("c", partdetailsList.get(j).get("c"));
            getmap.put("listofPrice", getFivePrice);
            listofestimateparts.add(getmap);
        }
        modelAndView.addObject("partlistdtls", listofestimateparts);
        modelAndView.addObject("vehicles", viewService.getanyhqldatalist("from branddetails where isdelete<>'Yes'"));
        modelAndView.addObject("mfgdtls", viewService.getanyhqldatalist("from manufacturer where isdelete='No'"));
        modelAndView.addObject("services", viewService.getanyhqldatalist("from labourservices where isdelete<>'Yes'"));
        modelAndView.addObject("partdtls", viewService.getanyhqldatalist("from carpartvault where isdelete='No'"));
        return modelAndView;
    }

    //view create estimate page with static data
    @RequestMapping("editEstimatePage")
    public ModelAndView editEstimatePage(@RequestParam("estid") String estid) {
        ModelAndView modelAndView = new ModelAndView("EditEstimate");
        modelAndView.addObject("estimatedtncustdt", viewService.getanyjdbcdatalist("SELECT est.id as estid,cv.carmodel,est.cvid,cv.branddetailid,cv.vehiclenumber,cu.name,cvd.savedate,bd.labourChargeType\n"
                + "FROM estimate est\n"
                + "inner join customervehicles cv on cv.id=est.cvid\n"
                + "inner join customervehiclesdetails cvd on cvd.custvehicleid=cv.id\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "inner join branddetails bd on bd.id=cv.branddetailid\n"
                + "where est.id='" + estid + "'").get(0));
        //nitz edit begin here

        //getting list of car part begin here
        List<Map<String, Object>> listofestimateparts = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> listofparts = viewService.getanyjdbcdatalist("SELECT estd.id as estdid,estd.partlistid,estd.partlistname as partname,estd.description,estd.partrs,estd.labourrs,estd.quantity,estd.totalpartrs\n"
                + "FROM estimatedetails estd\n"
                + "inner join carpartinfo cpi on cpi.id=estd.partlistid\n"
                + "left join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where estd.estimateid='" + estid + "' and estd.isdelete='No' and estd.item_type='part'\n"
                + "order by estd.partlistid desc");

        for (int j = 0; j < listofparts.size(); j++) {

            List getFivePrice = viewService.getanyjdbcdatalist("SELECT costprice as maxprice FROM inventory where partid='" + listofparts.get(j).get("partlistid") + "' and type='inward' ORDER BY costprice DESC LIMIT 5");

            Map<String, Object> getmap = new HashMap<String, Object>();
            getmap.put("estdid", listofparts.get(j).get("estdid"));
            getmap.put("partlistid", listofparts.get(j).get("partlistid"));
            getmap.put("partname", listofparts.get(j).get("partname"));
            getmap.put("description", listofparts.get(j).get("description"));
            getmap.put("partrs", listofparts.get(j).get("partrs"));
            getmap.put("labourrs", listofparts.get(j).get("labourrs"));
            getmap.put("quantity", listofparts.get(j).get("quantity"));
            getmap.put("totalpartrs", listofparts.get(j).get("totalpartrs"));
            getmap.put("listofPrice", getFivePrice);
            listofestimateparts.add(getmap);
        }
        //getting list of car part ends! here

        //getting list of labour service begin here
        List<Map<String, Object>> listofestimateLabour = viewService.getanyjdbcdatalist("SELECT estd.id as estdid,estd.partlistid,estd.partlistname as servicename,estd.description,estd.labourrs\n"
                + "FROM estimatedetails estd\n"
                + "inner join labourservices ls on ls.id=estd.partlistid\n"
                + "where estd.estimateid='" + estid + "' and estd.isdelete='No' and estd.item_type='service'\n"
                + "order by estd.partlistid desc");

        //getting list of labour service begin here
        modelAndView.addObject("partlistdtls", listofestimateparts);
        modelAndView.addObject("servicelistdtls", listofestimateLabour);
        modelAndView.addObject("mfgdtls", viewService.getanyhqldatalist("from manufacturer where isdelete='No'"));
        modelAndView.addObject("services", viewService.getanyhqldatalist("from labourservices where isdelete<>'Yes'"));
        modelAndView.addObject("partdtls", viewService.getanyhqldatalist("from carpartvault where isdelete='No'"));
        return modelAndView;
    }

    //12:41 24/04/2015 
    //view estimate page
    @RequestMapping("estimate-view")
    public ModelAndView estimateView(@RequestParam(value = "estid") String estid) {
        ModelAndView modelAndView = new ModelAndView("ViewEstimate");
        modelAndView.addObject("estcustdtls", viewService.getanyjdbcdatalist("SELECT est.id as estimateid,pcl.date as pcldate,pcl.id as pclid,cu.name as customername,cv.carmodel as carmodel,cv.vehiclenumber as vehiclenumber,est.approval \n"
                + "FROM estimate est\n"
                + "left join pointchecklist pcl on pcl.id=est.pclid\n"
                + "left join customervehicles cv on cv.id=pcl.customervehiclesid\n"
                + "left join customer cu on cu.id=cv.custid\n"
                + "where est.id='" + estid + "'").get(0));

        modelAndView.addObject("estpartdtls", viewService.getanyjdbcdatalist("select ed.*,ed.partrs,ed.labourrs,ed.description,ed.partlistname as partname from estimatedetails ed\n"
                + "inner join estimate est on est.id=ed.estimateid\n"
                + "inner join carpartinfo cpi on cpi.id=ed.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where ed.estimateid='" + estid + "' and ed.isdelete='No' and ed.item_type='part'"));

        modelAndView.addObject("estservicedtls", viewService.getanyjdbcdatalist("SELECT estd.id as estdid,estd.partlistid,estd.partlistname as servicename,estd.description,estd.labourrs\n"
                + "FROM estimatedetails estd\n"
                + "inner join labourservices ls on ls.id=estd.partlistid\n"
                + "where estd.estimateid='" + estid + "' and estd.isdelete='No' and estd.item_type='service'\n"
                + "order by estd.partlistid desc"));

        modelAndView.addObject("vatDetails", viewService.getanyhqldatalist("from taxes where isdelete<>'Yes' and id in('ATX1','ATX2')"));

        return modelAndView;
    }

    //view estimate mail page
    @RequestMapping("estimate-viewmail")
    public ModelAndView estimateViewMail(@RequestParam(value = "estid") String estid) {
        ModelAndView modelAndView = new ModelAndView("EstimateMail");
        modelAndView.addObject("estcustdtls", viewService.getanyjdbcdatalist("SELECT est.id as estimateid,pcl.date as pcldate,pcl.id as pclid,cu.name as customername,cu.address,cu.mobilenumber,cu.email,cv.carbrand as make,cv.carmodel as carmodel,cv.vehiclenumber as vehiclenumber,est.approval \n"
                + "FROM estimate est\n"
                + "left join pointchecklist pcl on pcl.id=est.pclid\n"
                + "left join customervehicles cv on cv.id=pcl.customervehiclesid\n"
                + "left join customer cu on cu.id=cv.custid\n"
                + "where est.id='" + estid + "'").get(0));

        modelAndView.addObject("estpartdtls", viewService.getanyjdbcdatalist("select ed.*,ed.partrs,ed.labourrs,ed.description,ed.partlistname as partname from estimatedetails ed\n"
                + "inner join estimate est on est.id=ed.estimateid\n"
                + "inner join carpartinfo cpi on cpi.id=ed.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where ed.estimateid='" + estid + "' and ed.isdelete='No' and ed.item_type='part'"));

        modelAndView.addObject("estservicedtls", viewService.getanyjdbcdatalist("SELECT estd.id as estdid,estd.partlistid,estd.partlistname as servicename,estd.description,estd.labourrs\n"
                + "FROM estimatedetails estd\n"
                + "inner join labourservices ls on ls.id=estd.partlistid\n"
                + "where estd.estimateid='" + estid + "' and estd.isdelete='No' and estd.item_type='service'\n"
                + "order by estd.partlistid desc"));

        return modelAndView;
    }

    //view wqorkman master grid
    @RequestMapping(value = "viewWorkmanLink")
    public ModelAndView viewWorkmanGrid() {
        ModelAndView modelAndView = new ModelAndView("ViewWorkmanGrid");
        modelAndView.addObject("workmanListDt", viewService.getanyhqldatalist("from workman where isdelete='No'"));
        return modelAndView;
    }

    //redirect to edit data page for woprkman
    @RequestMapping(value = "editWorkmanDetailsLink", method = RequestMethod.POST)
    public void editWorkmanDetailsLink(@RequestParam(value = "wmid") String wmid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getWorkmanList = viewService.getanyhqldatalist("from workman where id='" + wmid + "'");
        jsondata = new Gson().toJson(getWorkmanList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to view jobsheet grid page table
    @RequestMapping(value = "viewJobsheetGridLink")
    public ModelAndView viewJobsheetGridLink() {
        ModelAndView modelAndView = new ModelAndView("ViewJobsheetGrid");
        modelAndView.addObject("jobdtls", viewService.getanyjdbcdatalist("SELECT js.id as jsid,cu.name as custname,cv.carmodel,cv.branddetailid,cv.vehiclenumber,js.isinvoiceconverted,js.istaskcompleted FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where cu.isdelete='No' and js.isdelete='No' and js.ishidden='No' order by length(js.id) desc,js.id desc"));
        return modelAndView;
    }

    //redirect to view jobsheet grid page table
    @RequestMapping(value = "viewJobsheetVerificationGridLink")
    public ModelAndView viewJobsheetVerificationGridLink() {
        ModelAndView modelAndView = new ModelAndView("ViewJobsheetVerificationGrid");
        modelAndView.addObject("jobdtls", viewService.getanyjdbcdatalist("SELECT js.id as jsid,cu.name as custname,cv.carmodel,cv.branddetailid,cv.vehiclenumber,js.isinvoiceconverted,js.istaskcompleted FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where cu.isdelete='No' and js.isdelete='No' and js.ishidden='No' order by length(js.id) desc,js.id desc"));
        return modelAndView;
    }

    //redirect to edit job details with data
    @RequestMapping(value = "editJobDetailsLink")
    public ModelAndView editJobDetailsLink(@RequestParam(value = "jsid") String jsid) {
        ModelAndView modelAndView = new ModelAndView("EditJobDetails");
        modelAndView.addObject("jsuserdtls", viewService.getanyjdbcdatalist("SELECT js.id as jobno,cu.name as custname,cv.carbrand,cv.vehiclenumber licensenumber,cv.vinnumber,cv.date as custdate FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where js.id='" + jsid + "'").get(0));
        modelAndView.addObject("jobpartdtls", viewService.getanyjdbcdatalist("select jsd.id as jsdid,jsd.estimatetime as estimatetime,ed.partlistname as partname,ed.description,wm.id as wmid from jobsheetdetails jsd\n"
                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                + "inner join carpartinfo cpi on cpi.id=ed.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join workman wm on wm.id=jsd.workmanid\n"
                + "where jsd.jobsheetid='" + jsid + "' and ed.item_type='part' and ed.isdelete='No'"));
        modelAndView.addObject("jobservicedtls", viewService.getanyjdbcdatalist("select jsd.id as jsdid,jsd.estimatetime as estimatetime,ed.partlistname as servicename,ed.description,wm.id as wmid from jobsheetdetails jsd\n"
                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                + "inner join labourservices ls on ls.id=ed.partlistid\n"
                + "inner join workman wm on wm.id=jsd.workmanid\n"
                + "where jsd.jobsheetid='" + jsid + "' and ed.item_type='service' and ed.isdelete='No'"));
        modelAndView.addObject("workmandt", viewService.getanyhqldatalist("from workman where isdelete='No' and employee_type='workman'"));
        return modelAndView;
    }

    //redirect to view job detail and to put verify
    @RequestMapping(value = "viewTaskLink")
    public ModelAndView viewTaskLink(@RequestParam(value = "jsid") String jsid) {
        ModelAndView modelAndView = new ModelAndView("ViewTaskDetails");
        modelAndView.addObject("jsuserdtls", viewService.getanyjdbcdatalist("SELECT js.id as jobno,cu.name as custname,cv.carbrand,cv.vehiclenumber licensenumber,cvd.additionalwork,cv.vinnumber,cv.date as custdate \n"
                + "FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "inner join customervehiclesdetails  cvd on cvd.custvehicleid=js.cvid\n"
                + "where js.id='" + jsid + "'").get(0));
        modelAndView.addObject("jobdtls", viewService.getanyjdbcdatalist("SELECT jsd.id as jsdid,jsd.estimatetime,ed.partlistname as partname, ed.description,wm.name as workmanname FROM jobsheetdetails jsd\n"
                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                + "inner join carpartinfo cpi on cpi.id=ed.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join workman wm on wm.id=jsd.workmanid\n"
                + "where jsd.jobsheetid='" + jsid + "' and ed.item_type='part'"));
        modelAndView.addObject("servicedtls", viewService.getanyjdbcdatalist("SELECT jsd.id as jsdid,jsd.estimatetime,ed.partlistname as servicename, ed.description,wm.name as workmanname FROM jobsheetdetails jsd\n"
                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                + "inner join labourservices ls on ls.id=ed.partlistid\n"
                + "inner join workman wm on wm.id=jsd.workmanid\n"
                + "where jsd.jobsheetid='" + jsid + "' and ed.item_type='service'"));

        //code for task timer code begin here
        List<Jobsheet> jobList = viewService.getanyhqldatalist("from jobsheet where id='" + jsid + "' and isrequisitionready='Yes'");
        if (jobList.size() > 0) {
            modelAndView.addObject("taskdtls", viewService.getanyjdbcdatalist("SELECT distinct tb.*,wm.name, SUM(jsd.estimatetime) totalestimatetime,jsd.partstatus\n"
                    + "FROM taskboard tb\n"
                    + "inner join workman wm on wm.id=tb.workmanid\n"
                    + "inner join jobsheetdetails jsd on jsd.jobsheetid=tb.jobsheetid and tb.workmanid=jsd.workmanid\n"
                    + "where jsd.jobsheetid='" + jsid + "' and jsd.partstatus IN ('assigned','') group by tb.id\n"
                    + "order by name"));
        } else {
            modelAndView.addObject("taskdtls", viewService.getanyjdbcdatalist("SELECT tb.*,wm.name,tb.estimatetime as totalestimatetime,jsd.partstatus FROM jobsheetdetails jsd\n"
                    + "inner join workman wm on wm.id=jsd.workmanid\n"
                    + "inner join taskboard tb on tb.jobsheetid=jsd.jobsheetid and tb.workmanid=jsd.workmanid\n"
                    + "where jsd.jobsheetid='" + jsid + "' and jsd.partstatus='assigned'"));
        }
        //code for task timer code ends! here

//        modelAndView.addObject("taskdtls", viewService.getanyjdbcdatalist("SELECT tb.*,wm.name,tb.estimatetime as totalestimatetime\n"
//                + "FROM taskboard tb\n"
//                + "inner join workman wm on wm.id=tb.workmanid\n"
//                + "where tb.jobsheetid='" + jsid + "'"));
        return modelAndView;
    }

    //redirect to add job details with data
    @RequestMapping(value = "jobsheet-add")
    public ModelAndView addJobDetailsLink(@RequestParam(value = "estid") String estid) {
        ModelAndView modelAndView = new ModelAndView("AddJobsheet");
        modelAndView.addObject("estuserdtls", viewService.getanyjdbcdatalist("SELECT est.id as estid,cu.name as custname,cv.carbrand,cv.vinnumber,cvd.additionalwork,cv.vehiclenumber licensenumber,cv.date as custdate,est.cvid as cvid FROM estimate est\n"
                + "inner join customervehicles cv on cv.id=est.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "inner join customervehiclesdetails cvd on cvd.custvehicleid=est.cvid\n"
                + "where est.id='" + estid + "'").get(0));

        //nitz changes ad now adding labourt estimae so jobshet will now show service k liye bhi workman assining
        modelAndView.addObject("approvedpartdtls", viewService.getanyjdbcdatalist("select ed.id as estdid,ed.*,ed.partlistname as partname,ed.description from estimate est\n"
                + "inner join estimatedetails ed on ed.estimateid=est.id\n"
                + "inner join carpartinfo cpi on cpi.id=ed.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where est.id='" + estid + "'  and ed.approval='Yes' and ed.item_type='part'"));

        modelAndView.addObject("approvedservicedtls", viewService.getanyjdbcdatalist("select ed.id as estdid,ed.*,ed.partlistname as servicename,ed.description from estimate est\n"
                + "inner join estimatedetails ed on ed.estimateid=est.id\n"
                + "inner join labourservices ls on ls.id=ed.partlistid\n"
                + "where est.id='" + estid + "'  and ed.approval='Yes' and ed.item_type='service'"));

        modelAndView.addObject("workmandt", viewService.getanyhqldatalist("from workman where isdelete='No' and employee_type='workman'"));
        return modelAndView;
    }

    //redirect to view spare Requisition grid page table
    @RequestMapping(value = "viewSpareRequisitionGrid")
    public ModelAndView viewSpareRequisitionGrid() {
        ModelAndView modelAndView = new ModelAndView("ViewSpareRequisitionGrid");
        modelAndView.addObject("jobdtls", viewService.getanyjdbcdatalist("SELECT js.id as jsid,cu.name as custname,cv.carmodel,cv.vehiclenumber,js.isrequisitionready FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where cu.isdelete='No' and js.isdelete='No' and js.ishidden='No' order by length(js.id) desc,js.id desc"));
        return modelAndView;
    }

    //redirect to view editRequisition page with data
    @RequestMapping(value = "editRequisitionPage")
    public ModelAndView editRequisitionPage(@RequestParam(value = "jsid") String jsid) {
        ModelAndView modelAndView = new ModelAndView("EditSpareRequisition");
        modelAndView.addObject("jsuserdtls", viewService.getanyjdbcdatalist("SELECT js.id as jobno,cu.name as custname,cv.carbrand,cv.vehiclenumber licensenumber,cv.vinnumber,cv.date as custdate FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where js.id='" + jsid + "'").get(0));

        List<Map<String, Object>> assignlist = viewService.getanyjdbcdatalist("select jsd.partstatus,jsd.id as jsdid,jsd.mfgid as partmfgid,cpv.name as partname,cpi.id as partid,mf.name as mfgname,ed.description,wm.name as workmanname,jsd.partstatus from jobsheetdetails jsd\n"
                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                + "inner join carpartinfo cpi on cpi.id=ed.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join manufacturer mf on mf.id=jsd.mfgid\n"
                + "inner join workman wm on wm.id=jsd.workmanid\n"
                + "where jsd.jobsheetid='" + jsid + "'");
        if (assignlist.size() > 0) {

            //nitz edit begin here
            List<Map<String, Object>> listofjobsheetparts = new ArrayList<Map<String, Object>>();
            for (int j = 0; j < assignlist.size(); j++) {
                //code to get from inventory
                List<Map<String, Object>> getinventory = new ArrayList<Map<String, Object>>();
                getinventory = viewService.getanyjdbcdatalist("SELECT mf.id as mfgid,mf.`name` as mfgname\n"
                        + "FROM inventory inv\n"
                        + "inner join carpartinfo cpi on cpi.id=inv.partid\n"
                        + "inner join manufacturer mf on mf.id= inv.manufacturerid\n"
                        + "where cpi.id='" + assignlist.get(j).get("partid") + "' and cpi.balancequantity>0 \n"
                        + "and inv.`type`='inward' and mf.isdelete='No' and inv.isdelete='No' group by mf.id");

                if (!(getinventory.size() > 0)) {
                    getinventory = viewService.getanyjdbcdatalist("SELECT m.name as mfgname,m.id as mfgid FROM manufacturer m\n"
                            + "where m.isdelete<>'Yes'");
                }

                List<Map<String, Object>> jsonlist = new ArrayList<Map<String, Object>>();

                for (int i = 0; getinventory.size() > 0 && i < getinventory.size(); i++) {
                    Map<String, Object> setjsonmap = new HashMap<String, Object>();
                    setjsonmap.put("mfgname", getinventory.get(i).get("mfgname"));
                    setjsonmap.put("id", getinventory.get(i).get("mfgid"));
                    jsonlist.add(setjsonmap);
                }

                Map<String, Object> getmap = new HashMap<String, Object>();
                getmap.put("partname", assignlist.get(j).get("partname"));
                getmap.put("partmfgid", assignlist.get(j).get("partmfgid"));
                getmap.put("jsdid", assignlist.get(j).get("jsdid"));
                getmap.put("description", assignlist.get(j).get("description"));
                getmap.put("workmanname", assignlist.get(j).get("workmanname"));
                getmap.put("partstatus", assignlist.get(j).get("partstatus"));
                getmap.put("workmanname", assignlist.get(j).get("workmanname"));
                getmap.put("mfglist", jsonlist);
                listofjobsheetparts.add(getmap);
            }

            modelAndView.addObject("jobpartdtls", listofjobsheetparts);
        } else {
            modelAndView = new ModelAndView("EditSpareRequisition", "errmsg", "No workman assigned yet");
        }
        modelAndView.addObject("workmandt", viewService.getanyhqldatalist("from workman where isdelete='No'"));
        return modelAndView;
    }

    //code to view consumable page
    @RequestMapping(value = "editConsumablePage")
    public ModelAndView editConsumablePage(@RequestParam(value = "jsid") String jsid) {
        ModelAndView modelAndView = new ModelAndView("EditConsumable");

        modelAndView.addObject("jsuserdtls", viewService.getanyjdbcdatalist("SELECT js.id as jobno,cu.name as custname,cv.carbrand,cv.licensenumber,cv.vinnumber,cv.date as custdate FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where js.id='" + jsid + "'").get(0));

        modelAndView.addObject("jobdtls", viewService.getanyjdbcdatalist("SELECT cd.*,cpv.name as partname,mfg.name as mfgname FROM consumable_details cd\n"
                + "inner join carpartinfo cpi on cpi.id=cd.partid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join manufacturer mfg on mfg.id=cd.manufacturerid\n"
                + "where cd.jobsheetid='" + jsid + "' and cd.isdelete='No'"));

//        modelAndView.addObject("mfglist", viewService.getanyhqldatalist("from manufacturer where isdelete='No'"));        
        return modelAndView;
    }

    //redirect to view create Requisition page with data
    @RequestMapping(value = "addRequisitionPage")
    public ModelAndView addRequisitionPage(@RequestParam(value = "jsid") String jsid) {
        ModelAndView modelAndView = new ModelAndView("AddSpareRequisition");
        modelAndView.addObject("jsuserdtls", viewService.getanyjdbcdatalist("SELECT js.id as jobno,cu.name as custname,cv.carbrand,cv.vehiclenumber licensenumber,cv.vinnumber,cv.date as custdate FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where js.id='" + jsid + "'").get(0));

        //nitz edit begin here
        List<Map<String, Object>> listofjobsheetparts = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> partDetailList = viewService.getanyjdbcdatalist("select jsd.partstatus,cpi.id as partid,jsd.id as jsdid,ed.partlistname as partname,ed.description,wm.name as workmanname from jobsheetdetails jsd\n"
                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                + "inner join carpartinfo cpi on cpi.id=ed.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join workman wm on wm.id=jsd.workmanid\n"
                + "where jsd.jobsheetid='" + jsid + "' and jsd.isdelete='No' and jsd.partstatus is null");

        for (int j = 0; j < partDetailList.size(); j++) {
            //code written here gets the data from inventory 
            List<Map<String, Object>> getinventory = new ArrayList<Map<String, Object>>();
            getinventory = viewService.getanyjdbcdatalist("SELECT mf.id as mfgid,mf.`name` as mfgname\n"
                    + "FROM inventory inv\n"
                    + "inner join carpartinfo cpi on cpi.id=inv.partid\n"
                    + "inner join manufacturer mf on mf.id= inv.manufacturerid\n"
                    + "where cpi.id='" + partDetailList.get(j).get("partid") + "' and cpi.balancequantity>0 \n"
                    + "and inv.`type`='inward' and mf.isdelete='No' and inv.isdelete='No' group by mf.id");

            if (!(getinventory.size() > 0)) {
                getinventory = viewService.getanyjdbcdatalist("SELECT m.name as mfgname,m.id as mfgid FROM manufacturer m\n"
                        + "where m.isdelete<>'Yes'");
            }

            List<Map<String, Object>> jsonlist = new ArrayList<Map<String, Object>>();

            for (int i = 0; getinventory.size() > 0 && i < getinventory.size(); i++) {
                Map<String, Object> setjsonmap = new HashMap<String, Object>();
                setjsonmap.put("mfgname", getinventory.get(i).get("mfgname"));
                setjsonmap.put("id", getinventory.get(i).get("mfgid"));
                jsonlist.add(setjsonmap);
            }
            //getting data from inventory ends here .! got details of mfglist
//            List<BrandDetails> carlist=viewService.getanyhqldatalist("from branddetails where isdelete='No'");

            Map<String, Object> getmap = new HashMap<String, Object>();
            getmap.put("partname", partDetailList.get(j).get("partname"));
            getmap.put("partid", partDetailList.get(j).get("partid"));
            getmap.put("jsdid", partDetailList.get(j).get("jsdid"));
            getmap.put("description", partDetailList.get(j).get("description"));
            getmap.put("workmanname", partDetailList.get(j).get("workmanname"));
//            getmap.put("carlist", carlist);
            getmap.put("mfglist", jsonlist);
            listofjobsheetparts.add(getmap);
        }

        modelAndView.addObject("jobpartdtls", listofjobsheetparts);
        modelAndView.addObject("workmandt", viewService.getanyhqldatalist("from workman where isdelete='No'"));
        return modelAndView;
    }

    //add consumable redirect page redirect here
    @RequestMapping(value = "addConsumablePage")
    public ModelAndView addConsumablePage(@RequestParam(value = "jsid") String jsid) {
        ModelAndView modelAndView = new ModelAndView("AddConsumable");
        modelAndView.addObject("jsuserdtls", viewService.getanyjdbcdatalist("SELECT js.id as jobno,cu.name as custname,cv.carbrand,cv.vehiclenumber licensenumber,cv.vinnumber,cv.date as custdate,cv.branddetailid FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where js.id='" + jsid + "'").get(0));
        //mod to get direct part names in automcomplete begin here
        String branchPrefix = env.getProperty("branch_prefix");
        List<Map<String, Object>> getparts = viewService.getanyjdbcdatalist("SELECT cpi.*,cpv.name as partname \n"
                + "FROM carpartinfo cpi\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where cpi.branddetailid='" + env.getProperty("consumable_brand_detailid") + "'\n"
                + "and cpv.isdelete<>'Yes' and cpv.itemtype='consumable' and cpi.id like '" + branchPrefix + "%'");
        List<Map<String, Object>> jsonlist = new ArrayList<Map<String, Object>>();
        for (int i = 0; getparts.size() > 0 && i < getparts.size(); i++) {
            Map<String, Object> setjsonmap = new HashMap<String, Object>();
            setjsonmap.put("partname", getparts.get(i).get("partname"));
            setjsonmap.put("id", getparts.get(i).get("id"));
            jsonlist.add(setjsonmap);
        }
        modelAndView.addObject("consumablepartdt", jsonlist);
        //mod to get direct part names in automcomplete ends! here

        return modelAndView;
    }

    //convert to invoice coding begin here
    @RequestMapping(value = "converttoinovice")
    public ModelAndView convertToInovice(@RequestParam(value = "jsid") String jsid, @RequestParam(value = "carbrandid") String carbrandid) {
        ModelAndView modelAndView = new ModelAndView("ConvertToCustomerInvoice");
        modelAndView.addObject("custdtls", viewService.getanyjdbcdatalist("select cu.mobilenumber,cu.name as customername,cu.id as customerid,cv.carmodel,cv.vehiclenumber,cu.name as custname,cv.branddetailid,js.istaskcompleted,js.verified,js.cleaning from jobsheet js\n"
                + "left join customervehicles cv on cv.id=js.cvid\n"
                + "left join customer cu on cu.id=cv.custid\n"
                + "where js.id='" + jsid + "'").get(0));

        //code to set labor autocomplete here
        modelAndView.addObject("services", viewService.getanyhqldatalist("from labourservices where isdelete<>'Yes'"));
        //code to set mfg data for parts here
        modelAndView.addObject("manufacturerdt", viewService.getanyhqldatalist("from manufacturer where isdelete<>'Yes'"));
        //code for insurance company details here
        modelAndView.addObject("insuranceCompanyDetails", viewService.getanyhqldatalist("from insurance_company where isdelete<>'Yes'"));
        //code for tax data set here
        modelAndView.addObject("vatDetails", viewService.getanyhqldatalist("from taxes where isdelete<>'Yes' and id in('ATX1','ATX2')"));
        //car brand dt of customer here
        modelAndView.addObject("cartypedt", viewService.getspecifichqldata(BrandDetails.class, carbrandid));
//        modelAndView.addObject("userpartdtls", viewService.getanyjdbcdatalist("select jsd.id as jsdid,ed.partlistname as partname,mf.name as mfgname,mf.id as mdfgid,ed.partrs as partrs,cpi.id as cpiid,ed.labourrs as labourrs ,ed.description,ed.quantity,ed.totalpartrs from jobsheetdetails jsd\n"
//                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
//                + "inner join carpartinfo cpi  on cpi.id=ed.partlistid\n"
//                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
//                + "inner join manufacturer mf on mf.id=jsd.mfgid\n"
//                + "where jsd.jobsheetid='" + jsid + "' and jsd.isdelete='No' and ed.item_type='part'"));
//
//        modelAndView.addObject("userservicedtls", viewService.getanyjdbcdatalist("select jsd.id as jsdid,ed.partlistname as servicename,ed.partrs as partrs,ls.id as serviceid,ed.labourrs as labourrs ,ed.description,ed.quantity,ed.totalpartrs from jobsheetdetails jsd\n"
//                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
//                + "inner join labourservices ls on ls.id=ed.partlistid\n"
//                + "where jsd.jobsheetid='" + jsid + "' and jsd.isdelete='No' and ed.item_type='service'"));

        //code to ger carparts data set here
        List<Map<String, Object>> getparts = viewService.getanyjdbcdatalist("SELECT cpi.*,cpv.name as partname \n"
                + "FROM carpartinfo cpi\n"
                + "left join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where branddetailid='" + carbrandid + "'\n"
                + "and cpv.isdelete<>'Yes' and cpi.id like '" + env.getProperty("branch_prefix") + "%'");
        List<Map<String, Object>> jsonlist = new ArrayList<Map<String, Object>>();
        for (int i = 0; getparts.size() > 0 && i < getparts.size(); i++) {
            Map<String, Object> setjsonmap = new HashMap<String, Object>();
            setjsonmap.put("partname", getparts.get(i).get("partname"));
            setjsonmap.put("id", getparts.get(i).get("id"));
            jsonlist.add(setjsonmap);
        }
        modelAndView.addObject("carparts", jsonlist);
        //mod code to work autocomplete carpart in convert ends! here

        //user selected part data here
        modelAndView.addObject("userpartdtls", viewService.getanyjdbcdatalist("select jsd.id as jsdid,ed.partlistname as partname,mf.name as mfgname,mf.id as mdfgid,ed.partrs as partrs,cpi.id as cpiid,ed.labourrs as labourrs ,ed.description,ed.quantity,ed.totalpartrs from jobsheetdetails jsd\n"
                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                + "inner join carpartinfo cpi  on cpi.id=ed.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join manufacturer mf on mf.id=jsd.mfgid\n"
                + "where jsd.jobsheetid='" + jsid + "' and jsd.isdelete='No' and ed.item_type='part'"));
        //code for all part calculations goes here
        DecimalFormat df = new DecimalFormat("####0.00");
        String resultpart = giveTotal("part", jsid);
        double parttotal = Double.parseDouble(resultpart);
        modelAndView.addObject("parttotaldt", df.format(parttotal));

        //user selected labour data here
        modelAndView.addObject("userservicedtls", viewService.getanyjdbcdatalist("select jsd.id as jsdid,ed.partlistname as servicename,ed.partrs as partrs,ls.id as serviceid,ed.labourrs as labourrs ,ed.description,ed.quantity,ed.totalpartrs from jobsheetdetails jsd\n"
                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                + "inner join labourservices ls on ls.id=ed.partlistid\n"
                + "where jsd.jobsheetid='" + jsid + "' and jsd.isdelete='No' and ed.item_type='service'"));
        String resultlabor = giveTotal("service", jsid);
        double labortotal = Double.parseDouble(resultlabor);
        modelAndView.addObject("labortotaldt", df.format(labortotal));

        //calcultion for taxes go here
        List<Taxes> taxList = viewService.getanyhqldatalist("from taxes where isdelete<>'Yes' and id in('ATX1','ATX2')");
        double vattax = Double.parseDouble(taxList.get(0).getPercent());
        double parttax = parttotal * vattax / 100;
        double servicetax = Double.parseDouble(taxList.get(1).getPercent());
        double labortax = labortotal * servicetax / 100;
        double grandtotal = parttotal + parttax + labortotal + labortax;
        modelAndView.addObject("grandtotaldt", df.format(grandtotal));
        modelAndView.addObject("vatdt", parttax);
        modelAndView.addObject("servicetaxdt", labortax);
        

        return modelAndView;
    }

    public String giveTotal(String itemtype, String jsid) {
        String totalrs = "";
        List<Map<String, Object>> totalList = new ArrayList<Map<String, Object>>();
        if (itemtype.equals("part")) {
            totalList = viewService.getanyjdbcdatalist("select sum(ed.totalpartrs) totals from jobsheetdetails jsd\n"
                    + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                    + "where jsd.jobsheetid='" + jsid + "' and jsd.isdelete='No' and ed.item_type='" + itemtype + "';");
        } else {
            totalList = viewService.getanyjdbcdatalist("select sum(ed.labourrs) totals from jobsheetdetails jsd\n"
                    + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                    + "where jsd.jobsheetid='" + jsid + "' and jsd.isdelete='No'");
        }
        totalrs = "" + totalList.get(0).get("totals");
        System.out.println("hello " + totalrs);

        return totalrs;
    }

    //redirects to View Customer Invoice form page
    @RequestMapping("cleaningListLink")
    public ModelAndView cleaningListLink() {
        ModelAndView modelAndView = new ModelAndView("CleaningList");
        modelAndView.addObject("cleaningListDt", viewService.getanyjdbcdatalist("SELECT js.id as jsid,cv.date as date,cu.name as custname,cv.licensenumber,cv.carbrand,cv.carmodel,cv.vehiclenumber,cv.vinnumber,js.cleaning FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where cu.isdelete='No' and verified='Yes' and js.ishidden='No' and js.isdelete='No'"));
        return modelAndView;
    }

    //redirects to edit cleaning popup page
    @RequestMapping(value = "editCleaningLink", method = RequestMethod.POST)
    public void editCleaningLink(@RequestParam(value = "jsid") String jsid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from jobsheet where id='" + jsid + "'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //====================CRMcode begin here===========================//
    //view Service Check List grid page 13:44 18/05/2015
    @RequestMapping(value = "enquiriesgridlink")
    public ModelAndView enquiriesgridlink() {
        ModelAndView modelAndView = new ModelAndView("EnquiriesGrid");
        modelAndView.addObject("enquiriesDt", viewService.getanyhqldatalist("from enquiries where isdelete='No' and iscustomer='No' order by length(id) desc,id desc"));
        return modelAndView;
    }

    //redirect to add new enquiry
    @RequestMapping(value = "create_Enquiries")
    public ModelAndView createEnquiries() {
        ModelAndView modelAndView = new ModelAndView("AddEnquiries");
        modelAndView.addObject("carbranddetails", viewService.getanyhqldatalist("from brand where isdelete='No' "));
        modelAndView.addObject("insuranceCompanyDetails", viewService.getanyhqldatalist("from insurance_company where isdelete='No'"));
        return modelAndView;
    }

    //ajax get brand dtails car models
    @RequestMapping(value = "getModelDetails", method = RequestMethod.POST)
    public void getModelDetails(@RequestParam(value = "brandid") String brandid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> carmodeldetail = viewService.getanyhqldatalist("FROM branddetails where brandid='" + brandid + "' and isdelete='No'");
        jsondata = new Gson().toJson(carmodeldetail);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to view enquiry
    @RequestMapping(value = "viewEnquiriyDetailPage")
    public ModelAndView viewEnquiriyDetail(@RequestParam(value = "enquiryid") String enquiryid) {
        List<Enquiries> enquiryList = viewService.getanyhqldatalist("from enquiries where id='" + enquiryid + "'");
        ModelAndView modelAndView = new ModelAndView("ViewEnquiryDetails");
        if (enquiryList.get(0).getStatus().equals("Insurance")) {
            modelAndView.addObject("enquirydtl", viewService.getanyjdbcdatalist("SELECT *,eq.name as custname,eq.id as enquiryid,inc.name as insurancecompanyname FROM enquiries eq\n"
                    + "inner join brand br on br.id=eq.brandid\n"
                    + "inner join branddetails brd on brd.id=eq.branddetailid\n"
                    + "inner join insurance_company inc on inc.id=eq.insurancecompany\n"
                    + "where eq.id='" + enquiryid + "'").get(0));
        } else {
            modelAndView.addObject("enquirydtl", viewService.getanyjdbcdatalist("SELECT *,eq.name as custname,eq.id as enquiryid FROM enquiries eq\n"
                    + "inner join brand br on br.id=eq.brandid\n"
                    + "inner join branddetails brd on brd.id=eq.branddetailid\n"
                    + "where eq.id='" + enquiryid + "'").get(0));
        }
        return modelAndView;
    }

    //redirect to edit enquiry
    @RequestMapping(value = "editLeadDetailsLink")
    public ModelAndView editLeadDetailsLink(@RequestParam(value = "enquiryid") String enquiryid) {
        ModelAndView modelAndView = new ModelAndView("EditEnquiryDetails");

        List<Map<String, Object>> enquirylist = viewService.getanyjdbcdatalist("SELECT * FROM enquiries eq\n"
                + "inner join brand br on br.id=eq.brandid\n"
                + "inner join branddetails brd on brd.id=eq.branddetailid\n"
                + "where eq.id='" + enquiryid + "'");

        modelAndView.addObject("insuranceCompanyDetails", viewService.getanyhqldatalist("from insurance_company where isdelete='No' and id like '" + env.getProperty("branch_prefix") + "%'"));

        if (enquirylist.get(0).get("status").equals("Insurance")) {
            modelAndView.addObject("enquirydtl", viewService.getanyjdbcdatalist("SELECT *,eq.name as custname,inc.name as insurancecompanyname FROM enquiries eq\n"
                    + "inner join brand br on br.id=eq.brandid\n"
                    + "inner join branddetails brd on brd.id=eq.branddetailid\n"
                    + "inner join insurance_company inc on inc.id=eq.insurancecompany\n"
                    + "where eq.id='" + enquiryid + "'").get(0));
        } else {
            modelAndView.addObject("enquirydtl", viewService.getanyjdbcdatalist("SELECT *,eq.name as custname FROM enquiries eq\n"
                    + "inner join brand br on br.id=eq.brandid\n"
                    + "inner join branddetails brd on brd.id=eq.branddetailid\n"
                    + "where eq.id='" + enquiryid + "'").get(0));
        }

        modelAndView.addObject("carbranddetails", viewService.getanyhqldatalist("from brand where isdelete='No' "));

        modelAndView.addObject("modelforselected", viewService.getanyhqldatalist("FROM branddetails where brandid='" + enquirylist.get(0).get("brandid") + "' and isdelete='No'"));

        return modelAndView;
    }

    //redirect to convert to custome page
    @RequestMapping(value = "viewConvertToCustomerPage")
    public ModelAndView viewConvertToCustomerPage(@RequestParam(value = "enquiryid") String enquiryid) {
        ModelAndView modelAndView = new ModelAndView("ViewConvertToCustomer");
        modelAndView.addObject("enquirydtl", viewService.getanyjdbcdatalist("SELECT *,eq.name as custname FROM enquiries eq\n"
                + "inner join brand br on br.id=eq.brandid\n"
                + "inner join branddetails brd on brd.id=eq.branddetailid\n"
                + "where eq.id='" + enquiryid + "'").get(0));
        return modelAndView;
    }

    //redirect to follow up grid page cumulative 
    @RequestMapping(value = "followupgridlink")
    public ModelAndView followupgridlink() {
        ModelAndView modelAndView = new ModelAndView("ViewFollowUpGrid");
        modelAndView.addObject("followupdt", viewService.getanyjdbcdatalist("SELECT fo.id,eq.name,fo.nextfollowup,fo.fpstatus,fo.followedby,date(fo.savedate)as date FROM followups fo\n"
                + "inner join enquiries eq on eq.id=fo.enquirieid\n"
                + "where fo.isdelete='No'\n"
                + "order by length(fo.id) desc,fo.id desc"));
        return modelAndView;
    }

    //redirect to follow up detail 
    @RequestMapping(value = "viewFollowUpDetails")
    public ModelAndView viewFollowUpDetails(@RequestParam(value = "followupid") String followupid) {
        ModelAndView modelAndView = new ModelAndView("ViewFollowUpDetails");
        modelAndView.addObject("followupdt", viewService.getspecifichqldata(Followups.class, followupid));
        return modelAndView;
    }

    //redirect to edit followup detail page
    @RequestMapping(value = "editFollowupDetailsLink")
    public ModelAndView editFollowupDetailsLink(@RequestParam(value = "followupid") String followupid) {
        ModelAndView modelAndView = new ModelAndView("EditFollowUpDetail");
        modelAndView.addObject("editFollowupdt", viewService.getspecifichqldata(Followups.class, followupid));
        return modelAndView;
    }

    //rediect to calendar appointment page
    @RequestMapping(value = "appointmentCalendarlink")
    public ModelAndView appointmentCalendarlink() {
        ModelAndView modelAndView = new ModelAndView("ViewCalendar");
        modelAndView.addObject("calendardt", viewService.getanyjdbcdatalist("SELECT ap.id,eq.name as title,substring(datetime,1,10) as date,ap.datetime,ap.subject,ap.address as addr,ap.apdescription,ap.appointmentowner FROM appointment ap\n"
                + "inner join enquiries eq on eq.id=ap.enquirieid where ap.isdelete='No'"));

        modelAndView.addObject("datatabledtt", viewService.getanyjdbcdatalist("SELECT ap.id,ap.datetime,eq.name,ap.subject,ap.appointmentowner,ap.address,ap.apdescription FROM appointment ap\n"
                + "inner join enquiries eq on eq.id=ap.enquirieid where ap.isdelete='No' order by length(ap.id) desc,ap.id desc"));
        return modelAndView;
    }

    //view insurance expiring grid page
    @RequestMapping(value = "viewInsuranceExpiringGridLink")
    public ModelAndView viewInsuranceExpiringGridLink() {
        ModelAndView modelAndView = new ModelAndView("ViewInsuranceExpiringGrid");
        modelAndView.addObject("insurancedtls", viewService.getanyjdbcdatalist("SELECT ins.*,cu.name as custname,cu.mobilenumber,bdd.vehiclename,cu.email FROM insurance ins\n"
                + "inner join customer cu on cu.id=ins.customerid\n"
                + "inner join branddetails bdd on bdd.id=ins.branddetailid\n"
                + "where ins.isdelete='No'"));
        return modelAndView;
    }

    //view create insurance page
    @RequestMapping(value = "create_Cust_Insurance")
    public ModelAndView create_Cust_Insurance() {
        ModelAndView modelAndView = new ModelAndView("AddCustomerInsurance");
        modelAndView.addObject("customerdt", viewService.getanyhqldatalist("from customer where isdelete='No'"));
        modelAndView.addObject("branddt", viewService.getanyhqldatalist("from brand where isdelete='No'"));
        modelAndView.addObject("insuranceCompanyDetails", viewService.getanyhqldatalist("from insurance_company where isdelete='No'"));
        return modelAndView;
    }

    //get customer details on i9nsurace expiring page
    @RequestMapping(value = "getCustomerDetailsurl", method = RequestMethod.POST)
    public void getCustomerDetailsurl(@RequestParam(value = "custmobile") String customerMobileNo, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> customerdetail = viewService.getanyhqldatalist("from customer where mobilenumber='" + customerMobileNo + "' and isdelete='No'");
        jsondata = new Gson().toJson(customerdetail);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //get insruance add pagecar detials
    @RequestMapping(value = "getinsurancecarBrand", method = RequestMethod.POST)
    public void getinsurancecarBrand(@RequestParam(value = "brandid") String brandid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> carList = viewService.getanyhqldatalist("from branddetails where brandid='" + brandid + "' and isdelete='No'");
        jsondata = new Gson().toJson(carList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //view individual insurance detials
    @RequestMapping(value = "viewInsuranceDetails")
    public ModelAndView viewInsuranceDetails(@RequestParam(value = "insuranceid") String insuranceid) {
        ModelAndView modelAndView = new ModelAndView("ViewInsuranceExpiring");
        modelAndView.addObject("insurancedetailsdt", viewService.getanyjdbcdatalist("SELECT ins.*,cu.name as custname,cu.mobilenumber,cu.address,bdd.vehiclename,cu.email,bd.name as brandname,insc.name as insurancecompanyname FROM insurance ins\n"
                + "inner join customer cu on cu.id=ins.customerid\n"
                + "inner join brand bd on bd.id=ins.brandid\n"
                + "inner join branddetails bdd on bdd.id=ins.branddetailid\n"
                + "inner join insurance_company insc on insc.id=ins.insurancecompany\n"
                + "where ins.id='" + insuranceid + "'").get(0));
        return modelAndView;
    }

    //edit insuance expiring detials page
    @RequestMapping(value = "editInsuranceDetailsLink")
    public ModelAndView editInsuranceDetailsLink(@RequestParam(value = "insuranceid") String insuranceid, @RequestParam(value = "brandid") String brandid) {
        ModelAndView modelAndView = new ModelAndView("EditInsuranceExpiring");
        modelAndView.addObject("insurancedetailsdt", viewService.getanyjdbcdatalist("SELECT ins.*,cu.name as custname,cu.mobilenumber,cu.address,bdd.vehiclename,cu.email,bd.name as brandname,insc.name as insurancecompanyname FROM insurance ins\n"
                + "inner join customer cu on cu.id=ins.customerid\n"
                + "inner join brand bd on bd.id=ins.brandid\n"
                + "inner join branddetails bdd on bdd.id=ins.branddetailid\n"
                + "inner join insurance_company insc on insc.id=ins.insurancecompany\n"
                + "where ins.id='" + insuranceid + "'").get(0));
        modelAndView.addObject("customerdt", viewService.getanyhqldatalist("from customer where isdelete='No'"));
        modelAndView.addObject("branddt", viewService.getanyhqldatalist("from brand where isdelete='No'"));
        modelAndView.addObject("insuranceCompanyDetails", viewService.getanyhqldatalist("from insurance_company where isdelete='No'"));
        modelAndView.addObject("branddetailsdt", viewService.getanyhqldatalist("from branddetails where isdelete='No' and brandid='" + brandid + "'"));
        return modelAndView;
    }

    //============crmend===================
    //============expense coding begin here==================
    //redirect to purcase order gir cumulative view
    @RequestMapping(value = "PurchaseOrderGridLink")
    public ModelAndView create_PurchaseOrderLink() {
        ModelAndView modelAndView = new ModelAndView("ViewPurchaseOrderGrid");
        modelAndView.addObject("purchaseorderdt", viewService.getanyjdbcdatalist("SELECT po.*,vn.name as vendorname FROM purchaseorder po\n"
                + "inner join vendor vn on vn.id=po.vendorid\n"
                + "where po.isdelete='No' order by length(po.id) desc,po.id desc"));
        String mainBranchId = env.getProperty("this_branch_id");
        modelAndView.addObject("branchverifydt", viewService.getspecifichqldata(Branch.class, mainBranchId));
        modelAndView.addObject("vendordt", viewService.getanyhqldatalist("from vendor"));
        return modelAndView;
    }

    //redirect to create new purchase order link
    @RequestMapping(value = "create_PurchaseOrderLink")
    public ModelAndView createPurchaseOrderLink() {
        String vatid = "ATX1";
        ModelAndView modelAndView = new ModelAndView("AddPurchaseOrder");
        modelAndView.addObject("vendordt", viewService.getanyhqldatalist("from vendor where isdelete='No'"));
        modelAndView.addObject("vehicles", viewService.getanyhqldatalist("from branddetails where isdelete<>'Yes'"));
        modelAndView.addObject("taxdt", viewService.getspecifichqldata(Taxes.class, vatid));
        modelAndView.addObject("branchdtls", viewService.getanyhqldatalist("from branch where isdelete<>'Yes'"));
        modelAndView.addObject("manufacturerdtls", viewService.getanyhqldatalist("from manufacturer where isdelete<>'Yes'"));
        return modelAndView;
    }

    //get vendor payment terms details 
    @RequestMapping(value = "getVendorDetailsurl", method = RequestMethod.POST)
    public void getVendorDetailsurl(@RequestParam(value = "vendorid") String vendorid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> vendordetail = viewService.getanyhqldatalist("from vendor where id='" + vendorid + "' and isdelete='No'");
        jsondata = new Gson().toJson(vendordetail);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //ajax to get pricelist history for various parts vendorwise
    @RequestMapping(value = "pricelistvendorwisehistory", method = RequestMethod.POST)
    public void pricelistvendorwisehistory(@RequestParam(value = "mfgid") String mfgid, @RequestParam(value = "partid") String partid, @RequestParam(value = "vendorid") String vendorid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> jsonlist = viewService.getanyjdbcdatalist("SELECT q.sellingprice,q.quantity,q.modifydate FROM (SELECT sellingprice,quantity,modifydate FROM inventory\n"
                + "where manufacturerid='" + mfgid + "' and partid='" + partid + "' and type='inward' and vendor='" + vendorid + "'\n"
                + "ORDER BY modifydate DESC LIMIT 5) q ORDER BY q.modifydate DESC");

        jsondata = new Gson().toJson(jsonlist);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);

    }

    //ajax to get pricelist history for various parts
    @RequestMapping(value = "pricelistpartwisehistory", method = RequestMethod.POST)
    public void pricelistpartwisehistory(@RequestParam(value = "mfgid") String mfgid, @RequestParam(value = "partid") String partid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> jsonlist = viewService.getanyjdbcdatalist("SELECT q.sellingprice,q.quantity,q.modifydate FROM (SELECT sellingprice,quantity,modifydate FROM inventory\n"
                + "where manufacturerid='" + mfgid + "' and partid='" + partid + "' and type='inward'\n"
                + "ORDER BY modifydate DESC LIMIT 5) q ORDER BY q.modifydate DESC");

        jsondata = new Gson().toJson(jsonlist);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);

    }

    //redirect to view PO details
    @RequestMapping(value = "ViewPurchaseOrderDetails")
    public ModelAndView ViewPurchaseOrderDetails(@RequestParam(value = "poid") String poid) {
        ModelAndView modelAndView = new ModelAndView("ViewPurchaseOrderDetails");
        modelAndView.addObject("purchasedetailsdt", viewService.getanyjdbcdatalist("SELECT po.*,vn.name as vendorname,vn.address,vn.mobilenumber,vn.email FROM purchaseorder po\n"
                + "inner join vendor vn on vn.id=po.vendorid\n"
                + "where po.isdelete='No' and po.id='" + poid + "'").get(0));

        modelAndView.addObject("purchaseorderdetailsdt", viewService.getanyjdbcdatalist("SELECT pods.*,cpv.name as partname,mfg.name as mfgname,bdd.vehiclename FROM purchaseorderdetails pods\n"
                + "inner join carpartinfo cpi on cpi.id=pods.partid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join manufacturer mfg on mfg.id=pods.manufacturerid\n"
                + "inner join branddetails bdd on bdd.id=pods.branddetailid\n"
                + "where pods.purchaseorderid='" + poid + "' and pods.isdelete='No'"));
        return modelAndView;
    }

    //redirect to view PO details
    @RequestMapping(value = "viewvendormail")
    public ModelAndView viewvendormail(@RequestParam(value = "poid") String poid) {
        ModelAndView modelAndView = new ModelAndView("ViewVendorMail");
        modelAndView.addObject("purchasedetailsdt", viewService.getanyjdbcdatalist("SELECT po.*,vn.name as vendorname,vn.address,vn.mobilenumber,vn.email FROM purchaseorder po\n"
                + "inner join vendor vn on vn.id=po.vendorid\n"
                + "where po.isdelete='No' and po.id='" + poid + "'").get(0));

        modelAndView.addObject("purchaseorderdetailsdt", viewService.getanyjdbcdatalist("SELECT pods.*,cpv.name as partname,mfg.name as mfgname,bdd.vehiclename FROM purchaseorderdetails pods\n"
                + "inner join carpartinfo cpi on cpi.id=pods.partid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join manufacturer mfg on mfg.id=pods.manufacturerid\n"
                + "inner join branddetails bdd on bdd.id=pods.branddetailid\n"
                + "where pods.purchaseorderid='" + poid + "' and pods.isdelete='No'"));
        return modelAndView;
    }

    //redirects to edit purchase order and details
    @RequestMapping(value = "editPurchaseOrderLink")
    public ModelAndView editPurchaseOrderLink(@RequestParam(value = "poid") String poid) {
        String vatid = "ATX1";
        ModelAndView modelAndView = new ModelAndView("EditPurchaseOrder");
        modelAndView.addObject("purchasedetailsdt", viewService.getanyjdbcdatalist("SELECT po.*,vn.name as vendorname,vn.address,vn.mobilenumber,vn.email FROM purchaseorder po\n"
                + "inner join vendor vn on vn.id=po.vendorid\n"
                + "where po.isdelete='No' and po.id='" + poid + "'").get(0));

        modelAndView.addObject("purchaseorderdetailsdt", viewService.getanyjdbcdatalist("SELECT pods.*,cpv.name as partname,mfg.name as mfgname,bdd.vehiclename FROM purchaseorderdetails pods\n"
                + "inner join carpartinfo cpi on cpi.id=pods.partid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join manufacturer mfg on mfg.id=pods.manufacturerid\n"
                + "inner join branddetails bdd on bdd.id=pods.branddetailid\n"
                + "where pods.purchaseorderid='" + poid + "' and pods.isdelete='No'"));

        modelAndView.addObject("vendordt", viewService.getanyhqldatalist("from vendor where isdelete='No'"));
        modelAndView.addObject("vehicles", viewService.getanyhqldatalist("from branddetails where isdelete<>'Yes'"));
        modelAndView.addObject("taxdt", viewService.getspecifichqldata(Taxes.class, vatid));
        modelAndView.addObject("branchdtls", viewService.getanyhqldatalist("from branch where isdelete<>'Yes'"));
        modelAndView.addObject("manufacturerdtls", viewService.getanyhqldatalist("from manufacturer where isdelete<>'Yes'"));
        return modelAndView;
    }

    //po received
    @RequestMapping(value = "ViewReceivedPurchaseOrderDetails")
    public ModelAndView ViewReceivedPurchaseOrderDetails(@RequestParam(value = "poid") String poid) {
        ModelAndView modelAndView = new ModelAndView("ViewReceivedPurchaseOrderDetails");
        modelAndView.addObject("purchasedetailsdt", viewService.getanyjdbcdatalist("SELECT po.*,vn.name as vendorname,vn.address,vn.mobilenumber,vn.email FROM purchaseorder po\n"
                + "inner join vendor vn on vn.id=po.vendorid\n"
                + "where po.isdelete='No' and po.id='" + poid + "'").get(0));

        //nitz edit begin here
        List<Map<String, Object>> reclist = viewService.getanyjdbcdatalist("SELECT pods.*,cpv.name as partname,mfg.name as mfgname,bdd.vehiclename FROM purchaseorderdetails pods\n"
                + "inner join carpartinfo cpi on cpi.id=pods.partid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join manufacturer mfg on mfg.id=pods.manufacturerid\n"
                + "inner join branddetails bdd on bdd.id=pods.branddetailid\n"
                + "where pods.purchaseorderid='" + poid + "' and pods.isdelete='No' and pods.isreceived='No'");

        if (reclist.size() > 0) {
            modelAndView.addObject("purchaseorderdetailsdt", reclist);
        } else {
            modelAndView = new ModelAndView("ViewReceivedPurchaseOrderDetails", "errmsg", "No more items to receive");
        }

        modelAndView.addObject("vendordt", viewService.getanyhqldatalist("from vendor where isdelete='No'"));
//        modelAndView.addObject("vehicles", viewService.getanyhqldatalist("from branddetails where isdelete<>'Yes'"));
        modelAndView.addObject("taxdt", viewService.getanyhqldatalist("from taxes where isdelete<>'Yes'"));
        return modelAndView;
    }

    //po received
    @RequestMapping(value = "ViewPurchaseOrderBillDetails")
    public ModelAndView ViewPurchaseOrderBillDetails(@RequestParam(value = "poid") String poid) {
        ModelAndView modelAndView = new ModelAndView("ViewPurchaseOrderBillDetails");
        modelAndView.addObject("purchasedetailsdt", viewService.getanyjdbcdatalist("SELECT po.*,vn.name as vendorname,vn.address,vn.mobilenumber,vn.email FROM purchaseorder po\n"
                + "inner join vendor vn on vn.id=po.vendorid\n"
                + "where po.isdelete='No' and po.id='" + poid + "'").get(0));

        //nitz edit begin here
        List<Map<String, Object>> reclist = viewService.getanyjdbcdatalist("SELECT pods.*,cpv.name as partname,mfg.name as mfgname,bdd.vehiclename FROM purchaseorderdetails pods\n"
                + "inner join carpartinfo cpi on cpi.id=pods.partid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join manufacturer mfg on mfg.id=pods.manufacturerid\n"
                + "inner join branddetails bdd on bdd.id=pods.branddetailid\n"
                + "where pods.purchaseorderid='" + poid + "' and pods.isdelete='No'");

        if (reclist.size() > 0) {
            modelAndView.addObject("purchaseorderdetailsdt", reclist);
        } else {
            modelAndView = new ModelAndView("ViewReceivedPurchaseOrderDetails", "errmsg", "No more items to receive");
        }

        modelAndView.addObject("vendordt", viewService.getanyhqldatalist("from vendor where isdelete='No'"));
//        modelAndView.addObject("vehicles", viewService.getanyhqldatalist("from branddetails where isdelete<>'Yes'"));
        modelAndView.addObject("taxdt", viewService.getanyhqldatalist("from taxes where isdelete<>'Yes'"));
        return modelAndView;
    }

    //expense approval for admin coding here
    @RequestMapping(value = "purchaseorderappovalsLink")
    public ModelAndView purchaseorderappovalsLink() {
        ModelAndView modelAndView = new ModelAndView("ViewPurchaseOrderApprovalGrid");
        modelAndView.addObject("purchaseorderdt", viewService.getanyjdbcdatalist("SELECT po.*,vn.name as vendorname FROM purchaseorder po\n"
                + "inner join vendor vn on vn.id=po.vendorid\n"
                + "where po.isdelete='No' order by length(po.id) desc,po.id desc"));
        return modelAndView;
    }

    //ajax call to get po approval details on action page
    @RequestMapping(value = "getPurchaseOrderLimitDetails", method = RequestMethod.POST)
    public void getPurchaseOrderLimitDetails(@RequestParam(value = "poid") String poid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getPoDataList = viewService.getanyhqldatalist("from purchaseorder where id='" + poid + "'");
        jsondata = new Gson().toJson(getPoDataList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to general expenses page
    @RequestMapping(value = "generalExpenseLink")
    public ModelAndView generalExpenseLink() {
        ModelAndView modelAndView = new ModelAndView("ViewGeneralExpenseGrid");
        modelAndView.addObject("generalexpensedtls", viewService.getanyjdbcdatalist("SELECT ge.*,lg.accountname,ldg.name FROM generalexpense ge\n"
                + "inner join ledger lg on lg.id=ge.ledgerid\n"
                + "inner join ledgergroup ldg on ldg.id=lg.ledgergroupid\n"
                + "where ge.isdelete='No'"));
        return modelAndView;
    }

    //redirect to create general expense page
    @RequestMapping(value = "createGeneralExpensesLink")
    public ModelAndView createGeneralExpensesLink() {
        ModelAndView modelAndView = new ModelAndView("AddGeneralExpense");
        modelAndView.addObject("taxdtls", viewService.getanyhqldatalist("from taxes where isdelete='No'"));
        modelAndView.addObject("ledgerdtls", viewService.getanyhqldatalist("from ledger where isdelete='No' and ledger_type='expense'"));
        modelAndView.addObject("bankdtls", viewService.getanyhqldatalist("from bank_account where isdelete='No'"));
        return modelAndView;
    }

    //redirect to view Expenses details
    @RequestMapping(value = "viewGeneralExpenseDetails")
    public ModelAndView viewGeneralExpenseDetails(@RequestParam(value = "expenseid") String expenseid) {
        ModelAndView modelAndView = new ModelAndView("ViewExpensesDetails");
        modelAndView.addObject("expensesdtls", viewService.getanyjdbcdatalist("SELECT ge.*,lg.accountname,ldg.name,ba.bank_name FROM generalexpense ge\n"
                + "inner join ledger lg on lg.id=ge.ledgerid\n"
                + "inner join ledgergroup ldg on ldg.id=lg.ledgergroupid\n"
                + "left join bank_account ba on ba.id=ge.bank_accountid\n"
                + "where ge.isdelete='No' and ge.id='" + expenseid + "'").get(0));
        return modelAndView;
    }

    //redirect to edit expenses details
    @RequestMapping(value = "editExpenseDetails")
    public ModelAndView editExpenseDetails(@RequestParam(value = "expenseid") String expenseid) {
        ModelAndView modelAndView = new ModelAndView("EditGeneralExpense");
        modelAndView.addObject("expensedtls", viewService.getanyjdbcdatalist("SELECT ge.*,lg.accountname,ldg.name FROM generalexpense ge\n"
                + "inner join ledger lg on lg.id=ge.ledgerid\n"
                + "inner join ledgergroup ldg on ldg.id=lg.ledgergroupid\n"
                + "where ge.isdelete='No' and ge.id='" + expenseid + "'").get(0));
        modelAndView.addObject("taxdtls", viewService.getanyhqldatalist("from taxes where isdelete='No'"));
        modelAndView.addObject("ledgerdtls", viewService.getanyhqldatalist("from ledger where isdelete='No' and ledger_type='expense'"));
        modelAndView.addObject("bankdtls", viewService.getanyhqldatalist("from bank_account where isdelete='No'"));
        return modelAndView;
    }

    //redirect to edit expenses details
    @RequestMapping(value = "editPaymentExpenseDetails")
    public ModelAndView editPaymentExpenseDetailss(@RequestParam(value = "expenseid") String expenseid) {
        ModelAndView modelAndView = new ModelAndView("ViewPaymentDetails");
        modelAndView.addObject("expensedtls", viewService.getanyjdbcdatalist("SELECT ge.*,lg.accountname,ldg.name FROM generalexpense ge\n"
                + "inner join ledger lg on lg.id=ge.ledgerid\n"
                + "inner join ledgergroup ldg on ldg.id=lg.ledgergroupid\n"
                + "where ge.isdelete='No' and ge.id='" + expenseid + "'").get(0));
        modelAndView.addObject("taxdtls", viewService.getanyhqldatalist("from taxes where isdelete='No'"));
        modelAndView.addObject("ledgerdtls", viewService.getanyhqldatalist("from ledger where isdelete='No' and ledger_type='expense'"));
        modelAndView.addObject("bankdtls", viewService.getanyhqldatalist("from bank_account where isdelete='No'"));
        return modelAndView;
    }

    //admin to approve the general expenses
    @RequestMapping(value = "expenseappovalsLink")
    public ModelAndView expenseappovalsLink() {
        ModelAndView modelAndView = new ModelAndView("ViewGeneralExpenseApprovalGrid");
        modelAndView.addObject("generalexpensedtls", viewService.getanyjdbcdatalist("SELECT ge.*,lg.accountname,ldg.name FROM generalexpense ge\n"
                + "inner join ledger lg on lg.id=ge.ledgerid\n"
                + "inner join ledgergroup ldg on ldg.id=lg.ledgergroupid\n"
                + "where ge.isdelete='No'"));
        return modelAndView;
    }

    //ajax call to get po approval details on action page
    @RequestMapping(value = "getGeneralExpenseLimitDetails", method = RequestMethod.POST)
    public void getGeneralExpenseLimitDetails(@RequestParam(value = "geid") String geid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getGeDataList = viewService.getanyhqldatalist("from generalexpense where id='" + geid + "'");
        jsondata = new Gson().toJson(getGeDataList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to purcase order payment grid cumulative view
    @RequestMapping(value = "VendorPaymentGridLink")
    public ModelAndView VendorPaymentGridLink() {
        ModelAndView modelAndView = new ModelAndView("ViewVendorPaymentGrid");
        modelAndView.addObject("generalexpensedtls", viewService.getanyjdbcdatalist("SELECT ge.*,lg.accountname,ldg.name FROM generalexpense ge\n"
                + "inner join ledger lg on lg.id=ge.ledgerid\n"
                + "inner join ledgergroup ldg on ldg.id=lg.ledgergroupid\n"
                + "where ge.isdelete='No' and ge.purchaseorderid like '%PO%'"));
        return modelAndView;
    }

    //get vendor payment to view history and also o add payment page
//    @RequestMapping(value = "viewPaymentHistory")
//    public ModelAndView viewPaymentHistory(@RequestParam(value = "poid") String poid) {
//        ModelAndView modelAndView = new ModelAndView("ViewPaymentDetails");
//        modelAndView.addObject("vendordtls", viewService.getanyjdbcdatalist("SELECT po.*,vn.name as vendorname FROM purchaseorder po\n"
//                + "inner join vendor vn on vn.id=po.vendorid\n"
//                + "where po.isdelete='No' AND po.id='LPO1'").get(0));
//        modelAndView.addObject("ledgerdtls", viewService.getanyhqldatalist("from ledger where id='LLA2'").get(0));
//        modelAndView.addObject("historydtls", viewService.getanyhqldatalist("from generalexpense where purchaseorderid='" + poid + "' and isdelete='No'"));
//        return modelAndView;
//    }
    //get vendor details to update general expense table and make payment complete
    @RequestMapping(value = "makePayment")
    public ModelAndView makePayment(@RequestParam(value = "poid") String poid) {
        ModelAndView modelAndView = new ModelAndView("ViewPaymentDetails");
        modelAndView.addObject("vendordtls", viewService.getanyjdbcdatalist("SELECT po.*,vn.name as vendorname FROM purchaseorder po\n"
                + "inner join vendor vn on vn.id=po.vendorid\n"
                + "where po.isdelete='No' AND po.id='" + poid + "'").get(0));
        String ledgerid = env.getProperty("expense_ledgerid");

        modelAndView.addObject("ledgerdtls", viewService.getanyhqldatalist("from ledger where id='" + ledgerid + "'").get(0));
        return modelAndView;
    }

    //expense PO coding end here
    // feature: feedback grid view
    @RequestMapping(value = "fbgridLink")
    public ModelAndView fbgridLink() {
        ModelAndView modelAndView = new ModelAndView("ViewFeedbackGrid");
        modelAndView.addObject("fbListDetails", viewService.getanyjdbcdatalist("SELECT fb.id as fbid,fb.status as fbstatus,inv.*,cu.name as customername,bd.vehiclename as model,br.name as brand FROM feedback fb\n"
                + "inner join invoice inv on inv.id=fb.invoiceid\n"
                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber \n"
                + "inner join branddetails bd on bd.id=inv.vehicleid\n"
                + "inner join brand br on br.id=bd.brandid\n"
                + "where inv.isdelete='No' and fb.isdelete='No' and cu.isdelete='No' and bd.isdelete='No' and br.isdelete='No'\n"
                + "order by fb.savedate desc"));
        return modelAndView;
    }

    //user feedback questionairpage
    @RequestMapping(value = "userFeedbackLink")
    public ModelAndView userFeedbackLink(@RequestParam(value = "fbid") String fbid) {
        ModelAndView modelAndView = new ModelAndView("AddFeedback");
        modelAndView.addObject("invoicedtls", viewService.getanyjdbcdatalist("SELECT fb.id as fbid,fb.status as fbstatus,inv.*,cu.name as customername,bd.vehiclename as model,br.name as brand FROM feedback fb\n"
                + "inner join invoice inv on inv.id=fb.invoiceid\n"
                + "inner join customer cu on cu.mobilenumber=inv.customermobilenumber\n"
                + "inner join branddetails bd on bd.id=inv.vehicleid\n"
                + "inner join brand br on br.id=bd.brandid\n"
                + "where fb.id='" + fbid + "'").get(0));

        modelAndView.addObject("followuphistorydetails", viewService.getanyhqldatalist("FROM followups where type='feedback' and feedbackid='" + fbid + "'"));
        return modelAndView;
    }

    //redirect to edit popup for approval limit
    @RequestMapping(value = "getFollowupDetails", method = RequestMethod.POST)
    public void getFollowupDetails(@RequestParam(value = "fsid") String fsid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from followups where id='" + fsid + "'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to edit popup for Insurance Company 
    @RequestMapping(value = "getInsuranceCompanyDetails", method = RequestMethod.POST)
    public void getInsuranceCompanyDetails(@RequestParam(value = "insruancecompanyid") String insruancecompanyid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getCompanyList = viewService.getanyhqldatalist("from insurance_company where id='" + insruancecompanyid + "'");
        jsondata = new Gson().toJson(getCompanyList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //redirect to add new feedback
    //===================customer===========
    //remember to get estimate id list based on customer id and then pass value here
    @RequestMapping(value = "estimategridlink")
    public ModelAndView estimategridlink(@RequestParam(value = "estimateid") String estid) {
        ModelAndView modelAndView = new ModelAndView("CustomerViewEstimate");
        modelAndView.addObject("estcustdtls", viewService.getanyjdbcdatalist("SELECT est.id as estimateid,cv.id as cvid,pcl.date as pcldate,pcl.id as pclid,cu.name as customername,cv.carmodel as carmodel,cv.vehiclenumber as vehiclenumber \n"
                + "FROM estimate est\n"
                + "left join pointchecklist pcl on pcl.id=est.pclid\n"
                + "left join customervehicles cv on cv.id=pcl.customervehiclesid\n"
                + "left join customer cu on cu.id=cv.custid\n"
                + "where est.id='" + estid + "'").get(0));

        modelAndView.addObject("estpartdtls", viewService.getanyjdbcdatalist("select ed.*,ed.partrs,ed.labourrs,ed.description,ed.partlistname as partname,ed.id as edid from estimatedetails ed\n"
                + "inner join estimate est on est.id=ed.estimateid\n"
                + "inner join carpartinfo cpi on cpi.id=ed.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "where ed.estimateid='" + estid + "' and ed.isdelete='No' and ed.item_type='part'"));

        modelAndView.addObject("estservicedtls", viewService.getanyjdbcdatalist("SELECT estd.id as estdid,estd.partlistid,estd.partlistname as servicename,estd.description,estd.labourrs\n"
                + "FROM estimatedetails estd\n"
                + "inner join labourservices ls on ls.id=estd.partlistid\n"
                + "where estd.estimateid='" + estid + "' and estd.isdelete='No' and estd.item_type='service'\n"
                + "order by estd.partlistid desc"));

        return modelAndView;
    }

    //redirect to view job detail and to put verify
    @RequestMapping(value = "jobVerificationView")
    public ModelAndView jobVerificationView(@RequestParam(value = "jsid") String jsid) {
        ModelAndView modelAndView = new ModelAndView("JobVerification");
        modelAndView.addObject("jsuserdtls", viewService.getanyjdbcdatalist("SELECT js.id as jobno,js.verified,js.istaskcompleted,cu.name as custname,cv.carbrand,cv.vehiclenumber licensenumber,cv.vinnumber,cv.date as custdate,cv.km_in,js.* FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where js.id='" + jsid + "'").get(0));
        modelAndView.addObject("jobdtls", viewService.getanyjdbcdatalist("SELECT jsd.id as jsdid,jsd.verified,jsd.estimatetime,ed.partlistname as partname, ed.description,wm.name as workmanname FROM jobsheetdetails jsd\n"
                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                + "inner join carpartinfo cpi on cpi.id=ed.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join workman wm on wm.id=jsd.workmanid\n"
                + "where jsd.jobsheetid='" + jsid + "' and ed.item_type='part'"));
        modelAndView.addObject("jobservicedtls", viewService.getanyjdbcdatalist("SELECT jsd.id as jsdid,jsd.verified,jsd.estimatetime,ed.partlistname as servicename, ed.description,wm.name as workmanname FROM jobsheetdetails jsd\n"
                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                + "inner join labourservices ls on ls.id=ed.partlistid\n"
                + "inner join workman wm on wm.id=jsd.workmanid\n"
                + "where jsd.jobsheetid='" + jsid + "' and ed.item_type='service'"));

        return modelAndView;
    }

    @RequestMapping(value = "viewRequisitionDetailsLink")
    public ModelAndView viewRequisitionDetailsLink(@RequestParam(value = "jsid") String jsid) {
        ModelAndView modelAndView = new ModelAndView("ViewRequisitionDetails");
        modelAndView.addObject("jsuserdtls", viewService.getanyjdbcdatalist("SELECT js.id as jobno,cu.name as custname,cv.carbrand,cv.licensenumber,cv.vinnumber,cv.date as custdate FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where js.id='" + jsid + "'").get(0));
        modelAndView.addObject("jobdtls", viewService.getanyjdbcdatalist("SELECT jsd.partstatus,jsd.id as jsdid,cpv.name as partname,mfg.name as mfgname, ed.description,wm.name as workmanname FROM jobsheetdetails jsd\n"
                + "inner join estimatedetails ed on ed.id=jsd.estimatedetailid\n"
                + "inner join carpartinfo cpi on cpi.id=ed.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "left join manufacturer mfg on mfg.id=jsd.mfgid\n"
                + "inner join workman wm on wm.id=jsd.workmanid\n"
                + "where jsd.jobsheetid='" + jsid + "'"));
        return modelAndView;
    }

    @RequestMapping(value = "testing")
    public String testing() {
        return "TestingDemo";
    }

    @RequestMapping(value = "viewSynchronizationLink")
    public String viewSynchronizationLink() {
        return "ViewSynchronization";
    }

    //sync coding begin here
    @RequestMapping(value = "startSyncLink")
    public String startSyncLink() {
        Synchronization synchronization = new Synchronization();
        boolean localToServer = synchronization.syncDatabaseLocalToServer();
        boolean serverToLocal = synchronization.syncDatabaseServerToLocal();

        if (localToServer && serverToLocal) {
            return "SyncSuccess";
        } else {
            return "SyncError";
        }
    }

    //car part sync coding begin here
    @RequestMapping(value = "startPartSyncLink")
    public String startPartSyncLink() {
        CarpartsSynchronization carpartsSynchronization = new CarpartsSynchronization();
        carpartsSynchronization.syncDatabaseLocalToServer();
        carpartsSynchronization.syncDatabaseServerToLocal();
        return "SyncSuccess";
    }

    //=====================Attendance coding begin her ==================
    @RequestMapping(value = "attendanceAddLink")
    public ModelAndView attendanceAddLink() {
        ModelAndView modelAndView = new ModelAndView("AddAttendance");

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String today = dateFormat.format(date);
        modelAndView.addObject("todaysDate", today);

        //getting month
        DateFormat dateFormatMonth = new SimpleDateFormat("yyyy-MM");
        Date dateMonth = new Date();
        String month = dateFormatMonth.format(dateMonth);

        //getting day
        DateFormat dateFormatDay = new SimpleDateFormat("dd");
        Date dateDay = new Date();
        String day = dateFormatDay.format(dateDay);

        //according to new logic new insert fom data logic begin here
        List<Map<String, Object>> employeesExist = viewService.getanyjdbcdatalist("select * from daily_attendance where month='" + month + "'");

        if (employeesExist.size() > 0) {
//            modelAndView.addObject("employeedetails", viewService.getanyjdbcdatalist("SELECT * FROM daily_attendance da where da."+day+"='N/A' and month='" + month + "'"));
            modelAndView.addObject("employeedetails", viewService.getanyjdbcdatalist("SELECT * FROM daily_attendance da where (da." + day + "='N/A' and month='" + month + "') or (da." + day + "='-' and month='" + month + "')"));
        } else {
            List<Workman> employeeList = viewService.getanyhqldatalist("from workman where isdelete='No'");

            for (int i = 0; i < employeeList.size(); i++) {
                String prefix2 = env.getProperty("daily_attendance");
                String id = prefix2 + insertService.getmaxcount("daily_attendance", "id", 5);
                String query = "INSERT INTO daily_attendance(id, employee_id, employee_name, month)VALUES ('" + id + "', '" + employeeList.get(i).getId() + "', '" + employeeList.get(i).getName() + "','" + month + "')";
                insertService.setanyjdbcdatalist(query);
            }
            modelAndView.addObject("employeedetails", viewService.getanyjdbcdatalist("SELECT * FROM daily_attendance da where (da." + day + "='N/A' and month='" + month + "') or (da." + day + "='-' and month='" + month + "')"));
        }
        return modelAndView;
    }

    //view Atendance
    @RequestMapping(value = "viewAttendance")
    public ModelAndView viewAttendance() {
        ModelAndView modelAndView = new ModelAndView("ViewAttendanceGrid");

//        getting current month
        DateFormat dateFormat = new SimpleDateFormat("MM");
        Date date = new Date();
        String currentmonth = dateFormat.format(date);

        //getting month
        DateFormat dateFormatMonth = new SimpleDateFormat("yyyy-MM");
        Date dateMonth = new Date();
        String month = dateFormatMonth.format(dateMonth);

        modelAndView.addObject("monthdt", currentmonth);

        modelAndView.addObject("employedetails", viewService.getanyhqldatalist("from workman where isdelete='No'"));
        modelAndView.addObject("monthdetails", viewService.getanyjdbcdatalist("SELECT * FROM daily_attendance group by month"));

        modelAndView.addObject("getMonthlyattendance", viewService.getanyjdbcdatalist("SELECT da.employee_name,da.01 as one,da.02 as  two,da.03 as three,da.04 as four,da.05 as five,da.06 as  six,da.07 as  seven,da.08 as  eight,da.09 as nine,da.10 as ten,da.11 as eleven ,da.12 as  tweleve,da.13 as  thirteen,da.14 as  fourteen,da.15 as  fifteen,da.16 as  sixteen,da.17 as  seventeen,da.18 as  eighteen,da.19 as  nineteen,da.20 as  twenty,da.21 as  twentyone,da.22 as  twentytwo,da.23 as  twentythree,da.24 as  twentyfour,da.25 as  twentyfive,da.26 as  twentysix,da.27 as  twentyseven,da.28 as  twentyeight,da.29 as  twentynine,da.30 as thirty,da.30 as thirtyone FROM daily_attendance da where da.month='" + month + "'"));

//        modelAndView.addObject("attendancedetails", viewService.getanyhqldatalist("from attendance where date BETWEEN '" + currentyear + "-" + currentmonth + "-01' AND '" + currentyear + "-" + currentmonth + "-31'"));
        return modelAndView;
    }

    //onc change view Atendance
    @RequestMapping(value = "showattendance")
    public ModelAndView showattendance(@RequestParam(value = "months") String month) {
        ModelAndView modelAndView = new ModelAndView("ViewAttendanceGrid");

//        modelAndView.addObject("monthdt", currentmonth);
        modelAndView.addObject("employedetails", viewService.getanyhqldatalist("from workman where isdelete='No'"));
        modelAndView.addObject("monthdetails", viewService.getanyjdbcdatalist("SELECT * FROM daily_attendance group by month"));

        modelAndView.addObject("getMonthlyattendance", viewService.getanyjdbcdatalist("SELECT da.employee_name,da.01 as one,da.02 as  two,da.03 as three,da.04 as four,da.05 as five,da.06 as  six,da.07 as  seven,da.08 as  eight,da.09 as nine,da.10 as ten,da.11 as eleven ,da.12 as  tweleve,da.13 as  thirteen,da.14 as  fourteen,da.15 as  fifteen,da.16 as  sixteen,da.17 as  seventeen,da.18 as  eighteen,da.19 as  nineteen,da.20 as  twenty,da.21 as  twentyone,da.22 as  twentytwo,da.23 as  twentythree,da.24 as  twentyfour,da.25 as  twentyfive,da.26 as  twentysix,da.27 as  twentyseven,da.28 as  twentyeight,da.29 as  twentynine,da.30 as thirty,da.30 as thirtyone FROM daily_attendance da where da.month='" + month + "'"));

//        modelAndView.addObject("attendancedetails", viewService.getanyhqldatalist("from attendance where date BETWEEN '" + currentyear + "-" + currentmonth + "-01' AND '" + currentyear + "-" + currentmonth + "-31'"));
        return modelAndView;
    }

    //view attendance grid datewise datatable this is removed
    @RequestMapping(value = "attendanceMasterLink")
    public ModelAndView attendanceMasterLink() {
        ModelAndView modelAndView = new ModelAndView("ViewDatewiseAttendanceGrid");
        modelAndView.addObject("attendancedetails", viewService.getanyjdbcdatalist("SELECT * FROM daily_attendance group by month"));
        return modelAndView;
    }

    //redirect to edit attendance page
    @RequestMapping(value = "editAttendancePage")
    public ModelAndView editAttendancePage(@RequestParam(value = "attmonth") String attmonth) {
        ModelAndView modelAndView = new ModelAndView("EditAttendance");
        modelAndView.addObject("editAttendnaceDetails", viewService.getanyjdbcdatalist("SELECT *,wm.id as wmid,att.id as attid FROM attendance att\n"
                + "inner join workman wm on wm.id=att.employee_id\n"
                + "where att.date='" + attmonth + "'"));
        return modelAndView;
    }

    //rediretc to edit atendance page
    @RequestMapping(value = "attendanceEditLink")
    public String attendanceEditLink() {

        return "EditAttendance";
    }

    @RequestMapping(value = "getAttendanceDetails")
    public ModelAndView getAttendanceDetails(@RequestParam(value = "date") String date) {
        ModelAndView modelAndView = new ModelAndView("EditAttendance");
        //07/14/2015
        String[] dateParts = date.split("/");
        String month = dateParts[0];
        String day = dateParts[1];
        String year = dateParts[2];
        modelAndView.addObject("datedetails", date);
//        modelAndView.addObject("editAttendnaceDetails", viewService.getanyjdbcdatalist("select * from daily_attendance where month='" + year + "-" + month + "'"));
        modelAndView.addObject("editAttendnaceDetails", viewService.getanyjdbcdatalist("SELECT da.id,da.employee_id,da.employee_name,da." + day + " as status FROM daily_attendance da where da.month='" + year + "-" + month + "'"));
        return modelAndView;
    }

    //payment coding begin here==============
    @RequestMapping(value = "makePaymentLink")
    public ModelAndView makePaymentLink(@RequestParam(value = "invoiceid") String invoiceid, @RequestParam(value = "custno") String custno) {
        ModelAndView modelAndView = new ModelAndView("AddPayment");
        modelAndView.addObject("customerDetails", viewService.getanyjdbcdatalist("SELECT cu.id,cu.`name`,cu.mobilenumber,cu.email,cu.advance_amount,ld.id ledgerid FROM customer cu\n"
                + "inner join ledger ld ON ld.customerid=cu.id\n"
                + "where cu.mobilenumber='" + custno + "'").get(0));
        modelAndView.addObject("invoiceDetails", viewService.getspecifichqldata(Invoice.class, invoiceid));
//        modelAndView.addObject("taxdtls", viewService.getanyhqldatalist("from taxes where id not in('ATX3') and isdelete<>'Yes'"));
        modelAndView.addObject("bankaccountdtls", viewService.getanyhqldatalist("from bank_account where isdelete='No' and id not in ('" + env.getProperty("cashinhand") + "')"));
        modelAndView.addObject("cashaccountdtls", viewService.getanyhqldatalist("from bank_account where id='" + env.getProperty("cashinhand") + "' and isdelete='No'"));
        //ledger id from properties file
        String ledgerid = env.getProperty("payment_ledgerid");
        modelAndView.addObject("ledgerid", ledgerid);

        List<Invoice> invoicelist = viewService.getanyhqldatalist("from invoice where id='" + invoiceid + "'");
        if (!invoicelist.get(0).getTaxAmount1().equals("0") && !invoicelist.get(0).getTaxAmount2().equals("0")) {
            //check if it is service + vat
            modelAndView.addObject("taxdtls", viewService.getspecifichqldata(Taxes.class, "ATX4"));
        } else if (!invoicelist.get(0).getTaxAmount1().equals("0")) {
            //check if it is vat
            modelAndView.addObject("taxdtls", viewService.getspecifichqldata(Taxes.class, "ATX1"));
        } else if (!invoicelist.get(0).getTaxAmount2().equals("0")) {
            //check if it is service
            modelAndView.addObject("taxdtls", viewService.getspecifichqldata(Taxes.class, "ATX2"));
        }
        return modelAndView;
    }

    //redirect to view attendance for the date
//    public ModelAndView 
    //customer advance coding begin here ========================
    //view customer adcvance grid here
    @RequestMapping(value = "customerAdvanceGridLink")
    public ModelAndView customerAdvanceGridLink() {
        ModelAndView modelAndView = new ModelAndView("ViewCustomerAdvanceGrid");
        modelAndView.addObject("advancedetails", viewService.getanyjdbcdatalist("SELECT ca.id as caid,bd.name as brandname,bdd.vehiclename as modelname,cu.name as custname,cu.*,ca.*,bd.id as brandid FROM customer_advance ca\n"
                + "inner join customer cu on ca.customerid=cu.id\n"
                + "inner join brand bd on bd.id=ca.brandid\n"
                + "inner join branddetails bdd on bdd.id=ca.branddetailid\n"
                + "where ca.isdelete='No' order by ca.savedate desc"));
        return modelAndView;
    }

    @RequestMapping(value = "createcustomeradvance")
    public ModelAndView createCustomerAdvance() {
        ModelAndView modelAndView = new ModelAndView("AddCustomerAdvance");
        modelAndView.addObject("customerdt", viewService.getanyhqldatalist("from customer where isdelete='No'"));
        modelAndView.addObject("branddt", viewService.getanyhqldatalist("from brand where isdelete='No'"));
        modelAndView.addObject("customerdt", viewService.getanyhqldatalist("from customer where isdelete='No'"));
        return modelAndView;
    }

    @RequestMapping(value = "editAdvanceLink")
    public ModelAndView editAdvanceLink(@RequestParam(value = "advanceid") String advanceid, @RequestParam(value = "brandid") String brandid) {
        ModelAndView modelAndView = new ModelAndView("EditCustomerAdvance");
        modelAndView.addObject("editadvanceDetails", viewService.getanyjdbcdatalist("SELECT ca.id as caid,bd.name as brandname,bdd.vehiclename as modelname,cu.name as custname,cu.*,ca.* FROM customer_advance ca\n"
                + "inner join customer cu on ca.customerid=cu.id\n"
                + "inner join brand bd on bd.id=ca.brandid\n"
                + "inner join branddetails bdd on bdd.id=ca.branddetailid\n"
                + "where ca.id='" + advanceid + "' ").get(0));
        modelAndView.addObject("customerdt", viewService.getanyhqldatalist("from customer where isdelete='No'"));
        modelAndView.addObject("branddt", viewService.getanyhqldatalist("from brand where isdelete='No'"));
        modelAndView.addObject("customerdt", viewService.getanyhqldatalist("from customer where isdelete='No'"));
        modelAndView.addObject("branddetailsdt", viewService.getanyhqldatalist("from branddetails where isdelete='No' and brandid='" + brandid + "'"));
        return modelAndView;
    }

    //customer advance coding end here ========================
    //================customer search begin here===========
    //get customer details on i9nsurace expiring page
    @RequestMapping(value = "getcustomerdetailsearch", method = RequestMethod.POST)
    public void getcustomerdetailsearch(@RequestParam(value = "mobileno") String mobileno, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> customerdetail = viewService.getanyhqldatalist("from customer where mobilenumber like '%" + mobileno + "%' and isdelete='No'");
        jsondata = new Gson().toJson(customerdetail);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //customer search page
    @RequestMapping(value = "CustomerSearchLink")
    public String CustomerSearchPage() {
        return "CustomerSearch";
    }

    //view custome master customers service history and available cars
    @RequestMapping(value = "viewCustomerSearchLink")
    public ModelAndView viewCustomerSearchLink(@RequestParam(value = "customerid") String customerid) {
        ModelAndView modelAndView = new ModelAndView("SearchCustomerDetails");
        modelAndView.addObject("customerprofile", viewService.getspecifichqldata(Customer.class, customerid));
        modelAndView.addObject("customerdetails", viewService.getanyjdbcdatalist("SELECT *,count(vehiclenumber) as times FROM customervehicles where custid='" + customerid + "' group by vehiclenumber"));
        return modelAndView;
    }

    //general income coding begin here============
    //redirect to general Income page
    @RequestMapping(value = "generalIncomeLink")
    public ModelAndView generalIncomeLink() {
        ModelAndView modelAndView = new ModelAndView("ViewGeneralIncomeGrid");
        modelAndView.addObject("generalincomedtls", viewService.getanyjdbcdatalist("SELECT ge.*,lg.accountname,ldg.name FROM generalincome ge\n"
                + "inner join ledger lg on lg.id=ge.ledgerid\n"
                + "inner join ledgergroup ldg on ldg.id=lg.ledgergroupid\n"
                + "where ge.isdelete='No' and lg.isdelete='No' and ldg.isdelete='No' order by length(ge.id) desc,ge.id desc"));
        return modelAndView;
    }

    //redirect to create general income page
    @RequestMapping(value = "createGeneralIncomeLink")
    public ModelAndView createGeneralIncomeLink() {
        ModelAndView modelAndView = new ModelAndView("AddGeneralIncome");
        modelAndView.addObject("taxdtls", viewService.getanyhqldatalist("from taxes where isdelete='No'"));
        modelAndView.addObject("ledgerdtls", viewService.getanyhqldatalist("from ledger where isdelete='No' and ledger_type='income'"));
        modelAndView.addObject("bankdtls", viewService.getanyhqldatalist("from bank_account where isdelete='No'"));
        return modelAndView;
    }

    //redirect to view Expenses details
    @RequestMapping(value = "viewGeneralIncomeDetails")
    public ModelAndView viewGeneralIncomeDetails(@RequestParam(value = "incomeid") String incomeid) {
        ModelAndView modelAndView = new ModelAndView("ViewIncomeDetails");
        modelAndView.addObject("incomedtls", viewService.getanyjdbcdatalist("SELECT ge.*,lg.accountname,ldg.name,ba.bank_name FROM generalincome ge\n"
                + "inner join ledger lg on lg.id=ge.ledgerid\n"
                + "inner join ledgergroup ldg on ldg.id=lg.ledgergroupid\n"
                + "inner join bank_account ba on ba.id=ge.bank_accountid\n"
                + "where ge.isdelete='No' and ge.id='" + incomeid + "'").get(0));
        return modelAndView;
    }

    //redirect to edit expenses details
    @RequestMapping(value = "editIncomeDetails")
    public ModelAndView editIncomeDetails(@RequestParam(value = "incomeid") String incomeid) {
        ModelAndView modelAndView = new ModelAndView("EditGeneralIncome");
        modelAndView.addObject("expensedtls", viewService.getanyjdbcdatalist("SELECT ge.*,lg.accountname,ldg.name FROM generalincome ge\n"
                + "inner join ledger lg on lg.id=ge.ledgerid\n"
                + "inner join ledgergroup ldg on ldg.id=lg.ledgergroupid\n"
                + "where ge.isdelete='No' and ge.id='" + incomeid + "'").get(0));
        modelAndView.addObject("taxdtls", viewService.getanyhqldatalist("from taxes where isdelete='No'"));
        modelAndView.addObject("ledgerdtls", viewService.getanyhqldatalist("from ledger where isdelete='No' and ledger_type='income'"));
        modelAndView.addObject("bankdtls", viewService.getanyhqldatalist("from bank_account where isdelete='No'"));
        return modelAndView;
    }

    //coding for bank account begi here================
    //redirect to edit popup for approval limit
    @RequestMapping(value = "getBankAccountDetails", method = RequestMethod.POST)
    public void getBankAccountDetails(@RequestParam(value = "bankid") String bankid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyhqldatalist("from bank_account where id='" + bankid + "'");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //coduing for bank account end here===============
    //coding for reminde module begin here===============
    @RequestMapping(value = "reminderCustomerLink")
    public ModelAndView reminderCustomerLink() {
        ModelAndView modelAndView = new ModelAndView("ViewReminderCustomerGrid");
        modelAndView.addObject("customerdt", viewService.getanyjdbcdatalist("SELECT *,rc.id as rcid FROM reminder_customer rc\n"
                + "inner join customer cu on cu.id=rc.customerid\n"
                + "where rc.isdelete='No' and cu.isdelete='No'"));
        return modelAndView;
    }

    //view create customer reminder page
    @RequestMapping(value = "customerReminderCreateLink")
    public ModelAndView customerReminderCreateLink() {
        ModelAndView modelAndView = new ModelAndView("AddReminderCustomer");
        modelAndView.addObject("customerdt", viewService.getanyhqldatalist("from customer where isdelete='No'"));
        modelAndView.addObject("insuranceCompanyDetails", viewService.getanyhqldatalist("from insurance_company where isdelete='No'"));
        return modelAndView;
    }

    //view create customer reminder page
    @RequestMapping(value = "editReminderMessagePage")
    public ModelAndView editReminderMessagePage(@RequestParam(value = "rcid") String rcid) {
        ModelAndView modelAndView = new ModelAndView("EditReminderCustomer");
        modelAndView.addObject("customerdt", viewService.getanyhqldatalist("from customer where isdelete='No'"));
        modelAndView.addObject("rccustomerdt", viewService.getanyjdbcdatalist("SELECT *,rc.id as rcid,cu.id as cuid FROM reminder_customer rc\n"
                + "inner join customer cu on cu.id=rc.customerid\n"
                + "where rc.id='" + rcid + "'").get(0));
        List<Map<String, Object>> vehicleList = viewService.getanyjdbcdatalist("SELECT *,rc.id as rcid,cu.id as cuid FROM reminder_customer rc\n"
                + "inner join customer cu on cu.id=rc.customerid\n"
                + "where rc.id='" + rcid + "'");
        modelAndView.addObject("custvehiclesdt", viewService.getanyjdbcdatalist("select iv.vehicleid,bdd.vehiclename\n"
                + "from invoice iv inner join branddetails bdd on bdd.id=iv.vehicleid\n"
                + "where iv.customermobilenumber='" + vehicleList.get(0).get("mobilenumber") + "' group by vehiclenumber"));
        modelAndView.addObject("insuranceCompanyDetails", viewService.getanyhqldatalist("from insurance_company where isdelete='No'"));
        return modelAndView;
    }

    //get customer details on customereminder  page
    @RequestMapping(value = "getCustomerBrandDetailsurl", method = RequestMethod.POST)
    public void getCustomerBrandDetailsurl(@RequestParam(value = "custmobile") String customerMobileNo, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> customerdetail = viewService.getanyjdbcdatalist("select iv.vehicleid,bdd.vehiclename\n"
                + "from invoice iv inner join branddetails bdd on bdd.id=iv.vehicleid\n"
                + "where iv.customermobilenumber='" + customerMobileNo + "' group by vehiclenumber");
        jsondata = new Gson().toJson(customerdetail);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //get customer details on customer reminder page
    @RequestMapping(value = "getReminderCustomerDetails", method = RequestMethod.POST)
    public void getReminderCustomerDetails(@RequestParam(value = "rcid") String rcid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> customerdetail = viewService.getanyhqldatalist("from reminder_customer where id='" + rcid + "'");
        jsondata = new Gson().toJson(customerdetail);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    //coding for reminde module end! here===============
//coding for spares part dashboard begin here
    //view estimate grid
    @RequestMapping(value = "newnotifiedestimate")
    public String newnotifiedestimate(Map<String, Object> map) {
        map.put("estimatedtls", viewService.getanyjdbcdatalist("SELECT est.isjobsheetready, est.id as estid,est.approval,cu.name as custname,cv.carmodel,cv.vehiclenumber,est.savedate FROM estimate est\n"
                + "inner join customervehicles cv on cv.id=est.cvid\n"
                + "inner join customer cu on cu.id=cv.custid where est.isjobsheetready='No'"));
        return "Estimate";
    }

    //redirect to view spare Requisition grid page table
    @RequestMapping(value = "viewNewSpareRequisitionGrid")
    public ModelAndView viewNewSpareRequisitionGrid() {
        ModelAndView modelAndView = new ModelAndView("ViewSpareRequisitionGrid");
        modelAndView.addObject("jobdtls", viewService.getanyjdbcdatalist("SELECT js.id as jsid,cu.name as custname,cv.carmodel,cv.vehiclenumber,js.isrequisitionready FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where js.isdelete='No' and js.isrequisitionready='No'"));
        return modelAndView;
    }

    //redirect : to low quantioty parts list
    @RequestMapping(value = "lowQuantityPartPageLink")
    public ModelAndView lowQuantityPartPageLink() {
        ModelAndView modelAndView = new ModelAndView("ViewlowQuantityPartGrid");
        modelAndView.addObject("partdetails", viewService.getanyjdbcdatalist("SELECT estd.*,cpi.id as cpiid,cpv.name as partname,br.name as brandname,bdd.vehiclename as carmodel FROM estimatedetails estd\n"
                + "inner join carpartinfo cpi on cpi.id=estd.partlistid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join branddetails bdd on bdd.id=cpi.branddetailid\n"
                + "inner join brand br on br.id=bdd.brandid\n"
                + "where cpi.balancequantity<=0 and estd.approval='Yes'\n"
                + "order by length(estd.estimateid) desc,estd.estimateid desc"));
        return modelAndView;
    }

    //===================coding for spares login begin here==========
    @RequestMapping(value = "createPurchaseOrderNeeded")
    public ModelAndView createPurchaseOrderNeeded(@RequestParam(value = "carpartinfoid") String[] carpartinfoid) {
        ModelAndView modelAndView = new ModelAndView("AddPurchaseOrderSparesLogin");
        List<Vendor> vendorList = viewService.getanyhqldatalist("from vendor where isdelete='No'");
        List<Manufacturer> manufacturerList = viewService.getanyhqldatalist("from manufacturer where isdelete='No'");

        List<Map<String, Object>> allPartDataList = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < carpartinfoid.length; i++) {
            String branchPrefix = carpartinfoid[i].substring(0, 1);
            List<Branch> branchList = viewService.getanyhqldatalist("from branch where isdelete='No' and purchase_ord_prefix like '" + branchPrefix + "%'");

            List<Map<String, Object>> partdatalist = viewService.getanyjdbcdatalist("SELECT bdd.id as vehicleid,bdd.vehiclename,cpi.id as partid,cpv.name as partname FROM carpartinfo cpi\n"
                    + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                    + "inner join branddetails bdd on bdd.id=cpi.branddetailid\n"
                    + "where cpi.id='" + carpartinfoid[i] + "'");
            Map<String, Object> getMap = new HashMap<String, Object>();
            getMap.put("vehicleid", partdatalist.get(0).get("vehicleid"));
            getMap.put("vehiclename", partdatalist.get(0).get("vehiclename"));
            getMap.put("partid", partdatalist.get(0).get("partid"));
            getMap.put("partname", partdatalist.get(0).get("partname"));
            getMap.put("vendordetails", vendorList);
            getMap.put("manufacturerdetails", manufacturerList);
            getMap.put("branchid", branchList.get(0).getId());
            allPartDataList.add(getMap);
        }
        modelAndView.addObject("podto", allPartDataList);
        return modelAndView;
    }
    //===================coding for spares login ends! here==========

    //coding for spare part dashboard end! here!
    //code for spare transfered begin here
    @RequestMapping(value = "viewreceivables")
    public ModelAndView viewreceivables() {
        ModelAndView modelAndView = new ModelAndView("Viewreceivables");
        modelAndView.addObject("transferdetails", viewService.getanyjdbcdatalist("SELECT itr.*,br.name as tobranch, brw.name as frombranch,mfg.name as mfgname,vd.name as vendorname,cpv.name as partname FROM inventory_transfer itr\n"
                + "inner join carpartinfo cpi on cpi.id=itr.partid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join manufacturer mfg on mfg.id=itr.manufacturerid\n"
                + "inner join vendor vd on vd.id=itr.vendor\n"
                + "inner join branch br on br.id=itr.to_branch \n"
                + "inner join branch brw on brw.id=itr.from_branch\n"
                + "where itr.is_transferred='No' and itr.isdelete='No'"));
        return modelAndView;
    }

    //code for spare transfered ends! here
    //redirect to edit popup for approval limit
    @RequestMapping(value = "getInventoryTransferDetails", method = RequestMethod.POST)
    public void getInventoryTransferDetails(@RequestParam(value = "transferid") String transferid, HttpServletResponse response) throws IOException {
        String jsondata = "";
        List<Map<String, Object>> getLimitList = viewService.getanyjdbcdatalist("SELECT itr.id,itr.quantity,mfg.name as mfgname,vd.name as vendorname,cpv.name as partname,bdd.vehiclename FROM inventory_transfer itr\n"
                + "inner join carpartinfo cpi on cpi.id=itr.partid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join manufacturer mfg on mfg.id=itr.manufacturerid\n"
                + "inner join vendor vd on vd.id=itr.vendor\n"
                + "inner join branddetails bdd on bdd.id=itr.branddetailid\n"
                + "where itr.id='" + transferid + "' and itr.isdelete='No' order by itr.savedate desc");
        jsondata = new Gson().toJson(getLimitList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsondata);
    }

    @RequestMapping(value = "viewConsumablePage")
    public ModelAndView viewConsumablePage(@RequestParam(value = "jsid") String jsid) {
        ModelAndView modelAndView = new ModelAndView("ViewConsumableDetails");
        modelAndView.addObject("jsuserdtls", viewService.getanyjdbcdatalist("SELECT js.id as jobno,cu.name as custname,cv.carbrand,cv.licensenumber,cv.vinnumber,cv.date as custdate FROM jobsheet js\n"
                + "inner join customervehicles cv on cv.id=js.cvid\n"
                + "inner join customer cu on cu.id=cv.custid\n"
                + "where js.id='" + jsid + "'").get(0));

        modelAndView.addObject("jobdtls", viewService.getanyjdbcdatalist("SELECT cd.*,cpv.name as partname,mfg.name as mfgname FROM consumable_details cd\n"
                + "inner join carpartinfo cpi on cpi.id=cd.partid\n"
                + "inner join carpartvault cpv on cpv.id=cpi.vaultid\n"
                + "inner join manufacturer mfg on mfg.id=cd.manufacturerid\n"
                + "where cd.jobsheetid='" + jsid + "' and cd.isdelete='No'"));
        return modelAndView;
    }
}
