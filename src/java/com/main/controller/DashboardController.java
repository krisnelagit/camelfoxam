/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import com.main.service.AllInsertService;
import com.main.service.AllViewService;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author user
 */
@Controller
public class DashboardController {

    @Autowired
    AllViewService viewService;

    @Autowired
    AllInsertService insertService;

    @Autowired
    Environment env;

    //dahsboard coding begin here
    //code below get the branch prefix andredirects
    @RequestMapping(value = "gotobranchinfo")
    public String gotobranchinfo(@RequestParam(value = "prefixid") String prefixid, Map<String, Object> map) {
        map.put("prefixdt", prefixid);
        return "Dashboard_menu";
    }

    @RequestMapping(value = "crm_Dashboard")
    public ModelAndView crm_Dashboard(@RequestParam(value = "prefixid") String prefix) {
        ModelAndView modelAndView = new ModelAndView("Dashboard_crm");

        //todays enquries begin here
        String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
        modelAndView.addObject("enquiriesDt", viewService.getanyhqldatalist("from enquiries where isdelete='No' and iscustomer='No' and savedate like '" + todayDate + "%' and id like '" + prefix + "%'"));

        //todays followups begin here
        modelAndView.addObject("followupdt", viewService.getanyjdbcdatalist("SELECT fo.id,eq.name,fo.nextfollowup,fo.fpstatus,fo.followedby,date(fo.savedate)as date FROM followups fo\n"
                + "inner join enquiries eq on eq.id=fo.enquirieid\n"
                + "where fo.isdelete='No' and fo.savedate like '" + todayDate + "%' and fo.id like '" + prefix + "%' order by length(fo.id) desc,fo.id desc"));

        //todays appointments begin here
        modelAndView.addObject("datatabledtt", viewService.getanyjdbcdatalist("SELECT ap.id,ap.datetime,eq.name,ap.subject,ap.appointmentowner,ap.address,ap.apdescription FROM appointment ap\n"
                + "inner join enquiries eq on eq.id=ap.enquirieid\n"
                + "where ap.isdelete='No' and ap.savedate like '" + todayDate + "%' and ap.id like '" + prefix + "%' order by length(ap.id) desc,ap.id desc"));

        return modelAndView;
    }
}
