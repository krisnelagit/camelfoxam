/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.sync;

import static com.main.sync.Synchronization.getPrimaryKeyColumnsForTable;
import static com.main.sync.Synchronization.modifyDate;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author user
 */
public class CarpartsSynchronization {

    public static final String modifydate = "modifydate";

    Connection serverConnection;
    Connection localConnection;

    public CarpartsSynchronization() {
        this.localConnection = new DatabaseConnectLocal().getConnection();
        this.serverConnection = new DatabaseConnectServer().getConnection();
    }

    public void syncDatabaseLocalToServer() {
        System.out.println("Car part sync from Local to server Started...Aurangabad!!");
        try {
            Statement LocalStatement = localConnection.createStatement();
            Statement ServerStatement = serverConnection.createStatement();
            DatabaseMetaData metadata = localConnection.getMetaData();
            ResultSet rs = metadata.getTables(null, null, "%", null);
            while (rs.next()) {

                if (rs.getString(3).equals("carpartinfo") || rs.getString(3).equals("labourservices")) {

                    String primaryKeyColName = "";
                    System.out.println(rs.getString(3));

                    ResultSet LocalResultSetTable = LocalStatement.executeQuery("select * from `" + rs.getString(3) + "`");
                    ResultSet ServerResultSetTable = ServerStatement.executeQuery("select * from `" + rs.getString(3) + "` where id like 'A%'");
                    primaryKeyColName = getPrimaryKeyColumnsForTable(localConnection, rs.getString(3));
                    List<Map<String, Object>> serverTableList = new ArrayList<Map<String, Object>>();
                    while (ServerResultSetTable.next()) {
                        Map<String, Object> serverTableMap = new HashMap<String, Object>();
                        serverTableMap.put(primaryKeyColName, ServerResultSetTable.getString(primaryKeyColName));
                        serverTableMap.put(modifyDate, ServerResultSetTable.getString(modifyDate));
                        serverTableList.add(serverTableMap);
                    }

                    ResultSetMetaData metaData = LocalResultSetTable.getMetaData();
                    int count = metaData.getColumnCount(); //number of column
                    String columnName[] = new String[count];

                    for (int i = 1; i <= count; i++) {
                        columnName[i - 1] = metaData.getColumnLabel(i);
                    }

                    try {
                        while (LocalResultSetTable.next()) {
                            String res = ifContainsId(serverTableList, LocalResultSetTable.getString(primaryKeyColName));
                            if (res == null) {
                                StringBuffer insertStringBuffer = new StringBuffer("insert into " + rs.getString(3) + "(");
                                StringBuffer insertValues = new StringBuffer("values (");
                                for (int i = 0; i < count; i++) {
                                    insertStringBuffer.append("`" + columnName[i] + "`,");
                                    insertValues.append("'" + LocalResultSetTable.getString(i + 1) + "',");
                                }
                                insertStringBuffer.replace(insertStringBuffer.lastIndexOf(","), insertStringBuffer.lastIndexOf(",") + 1, "");
                                insertStringBuffer.append(")");
                                insertValues.replace(insertValues.lastIndexOf(","), insertValues.lastIndexOf(",") + 1, "");
                                insertValues.append(");");
                                insertStringBuffer.append(insertValues.toString());
                                System.out.println(insertStringBuffer.toString());
                                ServerStatement.execute(insertStringBuffer.toString());

                            } else {
                                if (convertStringIntoTimestamp(LocalResultSetTable.getString(modifyDate)).compareTo(convertStringIntoTimestamp(res.split("&&")[2])) > 0) {

                                    StringBuffer updateStringBuffer = new StringBuffer("update " + rs.getString(3) + " set ");
                                    for (int i = 0; i < count; i++) {
                                        String temp = LocalResultSetTable.getString(i + 1);
                                        if (temp.contains("'")) {
                                            temp = temp.replace("'", "\\'");
                                        }
                                        updateStringBuffer.append("`" + columnName[i] + "`='" + temp + "',");
                                    }
                                    updateStringBuffer.replace(updateStringBuffer.lastIndexOf(","), updateStringBuffer.lastIndexOf(",") + 1, "");
                                    updateStringBuffer.append(" where `" + primaryKeyColName + "`='" + LocalResultSetTable.getString(primaryKeyColName) + "'");
                                    System.out.println(updateStringBuffer.toString());
                                    ServerStatement.execute(updateStringBuffer.toString());
//                                 PreparedStatement ps = serverConnection.prepareStatement(updateStringBuffer.toString());
//                            ps.executeUpdate();

                                }
                            }

                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("Car part sync from Local to server ended...Aurangabad!!");

    }

    public void syncDatabaseServerToLocal() {
        System.out.println("Car part sync from server to Local Started...Aurangabad!!");
        try {
            Statement LocalStatement = localConnection.createStatement();
            Statement ServerStatement = serverConnection.createStatement();
            DatabaseMetaData metadata = serverConnection.getMetaData();
            ResultSet rs = metadata.getTables(null, null, "%", null);
            while (rs.next()) {
                if (rs.getString(3).equals("carpartinfo") || rs.getString(3).equals("labourservices")) {

                    String primaryKeyColName = "";
                    System.out.println(rs.getString(3));

                    ResultSet LocalResultSetTable = LocalStatement.executeQuery("select * from `" + rs.getString(3) + "`");
                    ResultSet ServerResultSetTable = null;
                    if (rs.getString(3).equals("carpartinfo")) {
                        ServerResultSetTable = ServerStatement.executeQuery("SELECT REPLACE( id, 'M', 'A' ) AS id,branddetailid,vaultid,balancequantity,savedate,modifydate\n"
                                + "FROM `" + rs.getString(3) + "`\n"
                                + "where id like 'M%'");

                    } else if (rs.getString(3).equals("labourservices")) {
                        ServerResultSetTable = ServerStatement.executeQuery("SELECT REPLACE( id, 'M', 'A' ) AS id,name,description,savedate,modifydate\n"
                                + "FROM `" + rs.getString(3) + "`\n"
                                + "where id like 'M%'");
                    }

                    primaryKeyColName = getPrimaryKeyColumnsForTable(serverConnection, rs.getString(3));
                    List<Map<String, Object>> localTableList = new ArrayList<Map<String, Object>>();
                    while (LocalResultSetTable.next()) {
                        Map<String, Object> localTableMap = new HashMap<String, Object>();
                        localTableMap.put(primaryKeyColName, LocalResultSetTable.getString(primaryKeyColName));
                        localTableMap.put(modifyDate, LocalResultSetTable.getString(modifyDate));
                        localTableList.add(localTableMap);
                    }

                    ResultSetMetaData metaData = ServerResultSetTable.getMetaData();
                    int count = metaData.getColumnCount(); //number of column
                    String columnName[] = new String[count];

                    for (int i = 1; i <= count; i++) {
                        columnName[i - 1] = metaData.getColumnLabel(i);
                    }

                    while (ServerResultSetTable.next()) {
                        String res = ifContainsId(localTableList, ServerResultSetTable.getString(primaryKeyColName));
                        if (res == null) {
                            StringBuffer insertStringBuffer = new StringBuffer("insert into " + rs.getString(3) + "(");
                            StringBuffer insertValues = new StringBuffer("values (");
                            for (int i = 0; i < count; i++) {
                                insertStringBuffer.append("`" + columnName[i] + "`,");
                                insertValues.append("'" + ServerResultSetTable.getString(i + 1) + "',");
                            }
                            insertStringBuffer.replace(insertStringBuffer.lastIndexOf(","), insertStringBuffer.lastIndexOf(",") + 1, "");
                            insertStringBuffer.append(")");
                            insertValues.replace(insertValues.lastIndexOf(","), insertValues.lastIndexOf(",") + 1, "");
                            insertValues.append(");");
                            insertStringBuffer.append(insertValues.toString());
                            System.out.println(insertStringBuffer.toString());
                            LocalStatement.execute(insertStringBuffer.toString());

                        } else {
                            try {
                                if (convertStringIntoTimestamp(ServerResultSetTable.getString(modifyDate)).compareTo(convertStringIntoTimestamp(res.split("&&")[2])) > 0) {

                                    StringBuffer updateStringBuffer = new StringBuffer("update " + rs.getString(3) + " set ");
                                    for (int i = 0; i < count; i++) {
                                        if (columnName[i].equals("balancequantity")) {
                                            updateStringBuffer.append(" ");
                                        } else {
                                            updateStringBuffer.append("`" + columnName[i] + "`='" + ServerResultSetTable.getString(i + 1) + "',");
                                        }
                                    }
                                    updateStringBuffer.replace(updateStringBuffer.lastIndexOf(","), updateStringBuffer.lastIndexOf(",") + 1, "");
                                    updateStringBuffer.append(" where `" + primaryKeyColName + "`='" + ServerResultSetTable.getString(primaryKeyColName) + "'");
                                    System.out.println(updateStringBuffer.toString());
//                            PreparedStatement ps = localConnection.prepareStatement(updateStringBuffer.toString());
//                            ps.executeUpdate();
                                    LocalStatement.execute(updateStringBuffer.toString());

                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }

                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("Car part sync from server to Local Ended...Aurangabad!!");
    }

    public String ifContainsId(List<Map<String, Object>> list, String value) {
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                if (list.get(i).containsValue(value)) {
                    return "true&&" + i + "&&" + list.get(i).get(modifyDate);
                }
            }
        }
        return null;
    }

    public Date convertStringIntoTimestamp(String stringTimestamp) {
        try {
            // SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
            return sdf.parse(stringTimestamp);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
