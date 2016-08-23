/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import java.util.LinkedList;

/**
 *
 * @author user
 */
public class NewClass {

    public static void main(String[] args) {
        String myvalue = "-20";
        int a=0;
        for (String retval : myvalue.split("-", 2)) {
            if(a>0){
                System.out.println(retval);
            }            
            a++;
        }
        
//        double x = Math.abs();
        
//        System.out.println(x);
    }
}
