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
public class CleaningDto {
    private String cleaning,car_washing,car_vacuuming,tyre_polish,dashboard_polish,engine_cleaning,underchasis_cleaning,trunk_cleaning;

    public CleaningDto(String cleaning, String car_washing, String car_vacuuming, String tyre_polish, String dashboard_polish, String engine_cleaning, String underchasis_cleaning, String trunk_cleaning) {
        this.cleaning = cleaning;
        this.car_washing = car_washing;
        this.car_vacuuming = car_vacuuming;
        this.tyre_polish = tyre_polish;
        this.dashboard_polish = dashboard_polish;
        this.engine_cleaning = engine_cleaning;
        this.underchasis_cleaning = underchasis_cleaning;
        this.trunk_cleaning = trunk_cleaning;
    }

    

    public CleaningDto() {
    }

    public String getCleaning() {
        return cleaning;
    }

    public void setCleaning(String cleaning) {
        this.cleaning = cleaning;
    }

    public String getCar_washing() {
        return car_washing;
    }

    public void setCar_washing(String car_washing) {
        this.car_washing = car_washing;
    }

    public String getCar_vacuuming() {
        return car_vacuuming;
    }

    public void setCar_vacuuming(String car_vacuuming) {
        this.car_vacuuming = car_vacuuming;
    }

    public String getTyre_polish() {
        return tyre_polish;
    }

    public void setTyre_polish(String tyre_polish) {
        this.tyre_polish = tyre_polish;
    }

    public String getDashboard_polish() {
        return dashboard_polish;
    }

    public void setDashboard_polish(String dashboard_polish) {
        this.dashboard_polish = dashboard_polish;
    }

    public String getEngine_cleaning() {
        return engine_cleaning;
    }

    public void setEngine_cleaning(String engine_cleaning) {
        this.engine_cleaning = engine_cleaning;
    }

    public String getUnderchasis_cleaning() {
        return underchasis_cleaning;
    }

    public void setUnderchasis_cleaning(String underchasis_cleaning) {
        this.underchasis_cleaning = underchasis_cleaning;
    }

    public String getTrunk_cleaning() {
        return trunk_cleaning;
    }

    public void setTrunk_cleaning(String trunk_cleaning) {
        this.trunk_cleaning = trunk_cleaning;
    }
    
    
}
