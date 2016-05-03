package com.main.sync;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DatabaseConnectLocal {

    Connection conn = null;
    PreparedStatement ps = null;

    public DatabaseConnectLocal() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/karworx", "root", "krisnela");
            System.out.println("this is connection success in local");
            
//            conn = (Connection) DriverManager.getConnection("jdbc:mysql://192.168.0.2:3306/karworx_aurangabad", "root", "krisnela");
        } catch (Exception e) {
            System.out.println("this is connection error local");
            e.printStackTrace();
        }

    }

    public Connection getConnection() {
        return conn;
    }

}
