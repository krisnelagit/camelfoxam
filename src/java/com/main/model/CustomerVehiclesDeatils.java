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
 * @author pc2
 */
@Entity(name = "customervehiclesdetails")
@Table(name = "customervehiclesdetails")
public class CustomerVehiclesDeatils {
@Id
private String id;
    private String servicebooklet="no", docregpaper="no", rimlock="no", toolkit="no", oldpartsrequest="no",fuellevel="no", nomicrofilter="no", instrumentlighting="no", steering="no", microfilter="no",
            handbrake="no", pedalnoise="no", coolingsystem="no", brakefluid="no", steeringfluid="no", vbelt="no", lastinspection="no", cleanwise="no", noticableleaks="no", Vcoolingsystem="no", wiperblades="no", body="no", headlights="no", shockabsorber="no", tyretread="no", frontbrake="no", hoses="no", rearbrake="no", exhaustsystem="no", rearaxle="no", gearbox="no", fueltank="no", Vfullyraisedcoolingsystem="no", finaldrive="no", frontaxle="no", engineleaks="no", carwashcoolingsystem="no", exteriorpolish="no", interiorcleaning="no", wheelrimcleaning="no", bodyprotection="no", antirust="no", additionalwork
            ="no",isdelete = "No", modifydate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()),custvehicleid;
            ;

    public CustomerVehiclesDeatils() {
    }

    public CustomerVehiclesDeatils(String id, String servicebooklet, String docregpaper, String rimlock, String toolkit, String nomicrofilter, String instrumentlighting, String steering, String microfilter, String handbrake, String pedalnoise, String coolingsystem, String brakefluid, String steeringfluid, String vbelt, String lastinspection, String cleanwise, String noticableleaks, String Vcoolingsystem, String wiperblades, String body, String headlights, String shockabsorber, String tyretread, String frontbrake, String hoses, String rearbrake, String exhaustsystem, String rearaxle, String gearbox, String fueltank, String Vfullyraisedcoolingsystem, String finaldrive, String frontaxle, String engineleaks, String carwashcoolingsystem, String exteriorpolish, String interiorcleaning, String wheelrimcleaning, String bodyprotection, String antirust, String additionalwork) {
        this.id = id;
        this.servicebooklet = servicebooklet;
        this.docregpaper = docregpaper;
        this.rimlock = rimlock;
        this.toolkit = toolkit;
        this.nomicrofilter = nomicrofilter;
        this.instrumentlighting = instrumentlighting;
        this.steering = steering;
        this.microfilter = microfilter;
        this.handbrake = handbrake;
        this.pedalnoise = pedalnoise;
        this.coolingsystem = coolingsystem;
        this.brakefluid = brakefluid;
        this.steeringfluid = steeringfluid;
        this.vbelt = vbelt;
        this.lastinspection = lastinspection;
        this.cleanwise = cleanwise;
        this.noticableleaks = noticableleaks;
        this.Vcoolingsystem = Vcoolingsystem;
        this.wiperblades = wiperblades;
        this.body = body;
        this.headlights = headlights;
        this.shockabsorber = shockabsorber;
        this.tyretread = tyretread;
        this.frontbrake = frontbrake;
        this.hoses = hoses;
        this.rearbrake = rearbrake;
        this.exhaustsystem = exhaustsystem;
        this.rearaxle = rearaxle;
        this.gearbox = gearbox;
        this.fueltank = fueltank;
        this.Vfullyraisedcoolingsystem = Vfullyraisedcoolingsystem;
        this.finaldrive = finaldrive;
        this.frontaxle = frontaxle;
        this.engineleaks = engineleaks;
        this.carwashcoolingsystem = carwashcoolingsystem;
        this.exteriorpolish = exteriorpolish;
        this.interiorcleaning = interiorcleaning;
        this.wheelrimcleaning = wheelrimcleaning;
        this.bodyprotection = bodyprotection;
        this.antirust = antirust;
        this.additionalwork = additionalwork;
    }

    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getServicebooklet() {
        return servicebooklet;
    }

    public void setServicebooklet(String servicebooklet) {
        this.servicebooklet = servicebooklet;
    }

    public String getDocregpaper() {
        return docregpaper;
    }

    public void setDocregpaper(String docregpaper) {
        this.docregpaper = docregpaper;
    }

    public String getRimlock() {
        return rimlock;
    }

    public void setRimlock(String rimlock) {
        this.rimlock = rimlock;
    }

    public String getToolkit() {
        return toolkit;
    }

    public void setToolkit(String toolkit) {
        this.toolkit = toolkit;
    }

  

    public String getNomicrofilter() {
        return nomicrofilter;
    }

    public void setNomicrofilter(String nomicrofilter) {
        this.nomicrofilter = nomicrofilter;
    }

    public String getInstrumentlighting() {
        return instrumentlighting;
    }

    public void setInstrumentlighting(String instrumentlighting) {
        this.instrumentlighting = instrumentlighting;
    }

    public String getSteering() {
        return steering;
    }

    public void setSteering(String steering) {
        this.steering = steering;
    }

    public String getMicrofilter() {
        return microfilter;
    }

    public void setMicrofilter(String microfilter) {
        this.microfilter = microfilter;
    }

    public String getHandbrake() {
        return handbrake;
    }

    public void setHandbrake(String handbrake) {
        this.handbrake = handbrake;
    }

    public String getPedalnoise() {
        return pedalnoise;
    }

    public void setPedalnoise(String pedalnoise) {
        this.pedalnoise = pedalnoise;
    }

    public String getCoolingsystem() {
        return coolingsystem;
    }

    public void setCoolingsystem(String coolingsystem) {
        this.coolingsystem = coolingsystem;
    }

    public String getBrakefluid() {
        return brakefluid;
    }

    public void setBrakefluid(String brakefluid) {
        this.brakefluid = brakefluid;
    }

    public String getSteeringfluid() {
        return steeringfluid;
    }

    public void setSteeringfluid(String steeringfluid) {
        this.steeringfluid = steeringfluid;
    }

    public String getVbelt() {
        return vbelt;
    }

    public void setVbelt(String vbelt) {
        this.vbelt = vbelt;
    }

    public String getLastinspection() {
        return lastinspection;
    }

    public void setLastinspection(String lastinspection) {
        this.lastinspection = lastinspection;
    }

    public String getCleanwise() {
        return cleanwise;
    }

    public void setCleanwise(String cleanwise) {
        this.cleanwise = cleanwise;
    }

    public String getNoticableleaks() {
        return noticableleaks;
    }

    public void setNoticableleaks(String noticableleaks) {
        this.noticableleaks = noticableleaks;
    }

    public String getVcoolingsystem() {
        return Vcoolingsystem;
    }

    public void setVcoolingsystem(String Vcoolingsystem) {
        this.Vcoolingsystem = Vcoolingsystem;
    }

    public String getWiperblades() {
        return wiperblades;
    }

    public void setWiperblades(String wiperblades) {
        this.wiperblades = wiperblades;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public String getHeadlights() {
        return headlights;
    }

    public void setHeadlights(String headlights) {
        this.headlights = headlights;
    }

    public String getShockabsorber() {
        return shockabsorber;
    }

    public void setShockabsorber(String shockabsorber) {
        this.shockabsorber = shockabsorber;
    }

    public String getTyretread() {
        return tyretread;
    }

    public void setTyretread(String tyretread) {
        this.tyretread = tyretread;
    }

    public String getFrontbrake() {
        return frontbrake;
    }

    public void setFrontbrake(String frontbrake) {
        this.frontbrake = frontbrake;
    }

    public String getHoses() {
        return hoses;
    }

    public void setHoses(String hoses) {
        this.hoses = hoses;
    }

    public String getRearbrake() {
        return rearbrake;
    }

    public void setRearbrake(String rearbrake) {
        this.rearbrake = rearbrake;
    }

    public String getExhaustsystem() {
        return exhaustsystem;
    }

    public void setExhaustsystem(String exhaustsystem) {
        this.exhaustsystem = exhaustsystem;
    }

    public String getRearaxle() {
        return rearaxle;
    }

    public void setRearaxle(String rearaxle) {
        this.rearaxle = rearaxle;
    }

    public String getGearbox() {
        return gearbox;
    }

    public void setGearbox(String gearbox) {
        this.gearbox = gearbox;
    }

    public String getFueltank() {
        return fueltank;
    }

    public void setFueltank(String fueltank) {
        this.fueltank = fueltank;
    }

    public String getVfullyraisedcoolingsystem() {
        return Vfullyraisedcoolingsystem;
    }

    public void setVfullyraisedcoolingsystem(String Vfullyraisedcoolingsystem) {
        this.Vfullyraisedcoolingsystem = Vfullyraisedcoolingsystem;
    }

    public String getFinaldrive() {
        return finaldrive;
    }

    public void setFinaldrive(String finaldrive) {
        this.finaldrive = finaldrive;
    }

    public String getFrontaxle() {
        return frontaxle;
    }

    public void setFrontaxle(String frontaxle) {
        this.frontaxle = frontaxle;
    }

    public String getEngineleaks() {
        return engineleaks;
    }

    public void setEngineleaks(String engineleaks) {
        this.engineleaks = engineleaks;
    }

    public String getCarwashcoolingsystem() {
        return carwashcoolingsystem;
    }

    public void setCarwashcoolingsystem(String carwashcoolingsystem) {
        this.carwashcoolingsystem = carwashcoolingsystem;
    }

    public String getExteriorpolish() {
        return exteriorpolish;
    }

    public void setExteriorpolish(String exteriorpolish) {
        this.exteriorpolish = exteriorpolish;
    }

    public String getInteriorcleaning() {
        return interiorcleaning;
    }

    public void setInteriorcleaning(String interiorcleaning) {
        this.interiorcleaning = interiorcleaning;
    }

    public String getWheelrimcleaning() {
        return wheelrimcleaning;
    }

    public void setWheelrimcleaning(String wheelrimcleaning) {
        this.wheelrimcleaning = wheelrimcleaning;
    }

    public String getBodyprotection() {
        return bodyprotection;
    }

    public void setBodyprotection(String bodyprotection) {
        this.bodyprotection = bodyprotection;
    }

    public String getAntirust() {
        return antirust;
    }

    public void setAntirust(String antirust) {
        this.antirust = antirust;
    }

    public String getAdditionalwork() {
        return additionalwork;
    }

    public void setAdditionalwork(String additionalwork) {
        this.additionalwork = additionalwork;
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

    public String getOldpartsrequest() {
        return oldpartsrequest;
    }

    public void setOldpartsrequest(String oldpartsrequest) {
        this.oldpartsrequest = oldpartsrequest;
    }

    public String getFuellevel() {
        return fuellevel;
    }

    public void setFuellevel(String fuellevel) {
        this.fuellevel = fuellevel;
    }

    public String getCustvehicleid() {
        return custvehicleid;
    }

    public void setCustvehicleid(String custvehicleid) {
        this.custvehicleid = custvehicleid;
    }

 
}
