/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.model;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TreeSet;
import javax.imageio.ImageIO;

/**
 *
 * @author user
 */
public class Demo {

    public static void main( String[] args ){
      imageIoWrite();
    }
    
    public static void imageIoWrite() {
    	 BufferedImage bImage = null;
         try {
             File initialImage = new File("E:\\AthNityanand\\testimages\\2015n02n20n12n38n34n8.png");
             bImage = ImageIO.read(initialImage);

//             ImageIO.write(bImage, "gif", new File("C://Users/Rou/Desktop/image.gif"));
             ImageIO.write(bImage, "jpg", new File("E:\\AthNityanand\\testimages\\jituimages\\2015n02n20n12n38n34n8.png"));
//             ImageIO.write(bImage, "bmp", new File("C://Users/Rou/Desktop/image.bmp"));

         } catch (IOException e) {
               System.out.println("Exception occured :" + e.getMessage());
         }
         System.out.println("Images were written succesfully.");
    }

}