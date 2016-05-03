/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.sync;

import org.springframework.scheduling.annotation.Scheduled;

/**
 *
 * @author user
 */
public class TimelySync {

    @Scheduled(cron = "0 0 0/1 1/1 * ?")
    public void timelyServiceMethod() {
//        System.out.println("**********Krisnela Timely sync Process started for Aurangabad*****************");
//        Synchronization synchronization = new Synchronization();
//        boolean localToServer = synchronization.syncDatabaseLocalToServer();
//        boolean serverToLocal = synchronization.syncDatabaseServerToLocal();
//
//        if (localToServer && serverToLocal) {
//            System.out.println("**********Krisnela Timely sync Process Ended!! for Mumbai*****************");
//        } else {
//            System.out.println("**********Krisnela Timely sync Process Ended!! with errors for Mumbai*****************");
//        }
    }
}
