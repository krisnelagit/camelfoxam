
package com.main.sync;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 *
 * @author krisnela
 */
public class DatabaseConnectServer {

    Connection conn = null;


    public DatabaseConnectServer() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = (Connection) DriverManager.getConnection("jdbc:mysql://karworx.com:3306/karworxs_karworx", "karworxs_krisnel", "krisenla@16108");
            System.out.println("this is connection success in server");
//            conn = (Connection) DriverManager.getConnection("jdbc:mysql://192.168.0.4:3306/karworxonline", "root", "krisnela");
        } catch (Exception e) {
            System.out.println("this is connection error server");
            e.printStackTrace();
        }

    }

    public Connection getConnection() {
        return conn;
    }

}
