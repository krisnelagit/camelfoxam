package com.main.sync;

import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

public class Synchronization {

    public static final String modifyDate = "modifydate";

    Connection ServerConnection;
    Connection LocalConnection;

    public Synchronization() {
        this.LocalConnection = new DatabaseConnectLocal().getConnection();
        this.ServerConnection = new DatabaseConnectServer().getConnection();
    }

    public boolean syncDatabaseLocalToServer() {
        boolean isSuccess = true;
        System.out.println("Local to Server Sync started..Aurangabad!");
        try {
            Statement LocalStatement = LocalConnection.createStatement();
            Statement ServerStatement = ServerConnection.createStatement();
            DatabaseMetaData metadata = LocalConnection.getMetaData();
            ResultSet rs = metadata.getTables(null, null, "%", null);
            while (rs.next()) {
                
                if (!rs.getString(3).equals("carpartinfo") || !rs.getString(3).equals("labourservices") || !rs.getString(3).equals("taxes")) {
                    String primaryKeyColName = "";
                    System.out.println(rs.getString(3));
                    ResultSet LocalResultSetTable;
                    ResultSet ServerResultSetTable;

                    if (rs.getString(3).equals("brand") || rs.getString(3).equals("branddetails") || rs.getString(3).equals("labourinventory") || rs.getString(3).equals("carpartvault") || rs.getString(3).equals("vendor") || rs.getString(3).equals("branch") || rs.getString(3).equals("customer") || rs.getString(3).equals("ledger") || rs.getString(3).equals("ledgergroup") || rs.getString(3).equals("bank_account") || rs.getString(3).equals("category") || rs.getString(3).equals("manufacturer") || rs.getString(3).equals("userdetails") || rs.getString(3).equals("invoice") || rs.getString(3).equals("invoicedetails") || rs.getString(3).equals("inventory_transfer")) {
                        LocalResultSetTable = LocalStatement.executeQuery("select * from `" + rs.getString(3) + "`");
                        ServerResultSetTable = ServerStatement.executeQuery("select * from `" + rs.getString(3) + "`");
                    } else {
                        LocalResultSetTable = LocalStatement.executeQuery("select * from `" + rs.getString(3) + "`");
                        ServerResultSetTable = ServerStatement.executeQuery("select * from `" + rs.getString(3) + "` where id like 'A%'");
                    }

                    primaryKeyColName = getPrimaryKeyColumnsForTable(LocalConnection, rs.getString(3));
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
                                    if ((columnName[i].equals("partid") && rs.getString(3).equals("inventory_transfer"))) {
                                        insertStringBuffer.append("`" + columnName[i] + "`,");
                                        insertValues.append("'" + LocalResultSetTable.getString(i + 1).replace("ACPI", "MCPI") + "',");
                                    } else {
                                        insertStringBuffer.append("`" + columnName[i] + "`,");
                                        insertValues.append("'" + LocalResultSetTable.getString(i + 1) + "',");
                                    }

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
                                        System.out.println("is this null: " + temp);
                                        if (temp == null) {
                                            temp = "";
                                        }
                                        if (temp.contains("'")) {
                                            temp = temp.replace("'", "\\'");
                                        }
                                        updateStringBuffer.append("`" + columnName[i] + "`='" + temp + "',");
                                    }
                                    updateStringBuffer.replace(updateStringBuffer.lastIndexOf(","), updateStringBuffer.lastIndexOf(",") + 1, "");
                                    updateStringBuffer.append(" where `" + primaryKeyColName + "`='" + LocalResultSetTable.getString(primaryKeyColName) + "'");
                                    System.out.println(updateStringBuffer.toString());
                                    ServerStatement.execute(updateStringBuffer.toString());
//                                 PreparedStatement ps = ServerConnection.prepareStatement(updateStringBuffer.toString());
//                            ps.executeUpdate();

                                }
                            }

                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        isSuccess = false;
                        return isSuccess;

                    }

                } else {
                    System.out.println("Encountered with Carpartinfo and is skipped");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            isSuccess = false;
            System.out.println("Local to Server Sync ended..Aurangabad! with errors");
            return isSuccess;
        }
        System.out.println("Local to Server Sync ended..Aurangabad!");
        return isSuccess;

    }

    public boolean syncDatabaseServerToLocal() {
        boolean isSuccess = true;
        System.out.println("Server to Local Sync started..Aurangabad!");
        try {
            Statement LocalStatement = LocalConnection.createStatement();
            Statement ServerStatement = ServerConnection.createStatement();
            DatabaseMetaData metadata = ServerConnection.getMetaData();
            ResultSet rs = metadata.getTables(null, null, "%", null);
            while (rs.next()) {
                
                if (!rs.getString(3).equals("carpartinfo") || !rs.getString(3).equals("labourservices") || !rs.getString(3).equals("taxes")) {
                    String primaryKeyColName = "";
                    System.out.println(rs.getString(3));

                    ResultSet LocalResultSetTable;
                    ResultSet ServerResultSetTable;

                    if (rs.getString(3).equals("brand") || rs.getString(3).equals("branddetails") || rs.getString(3).equals("carpartvault") || rs.getString(3).equals("vendor") || rs.getString(3).equals("branch") || rs.getString(3).equals("customer") || rs.getString(3).equals("ledger") || rs.getString(3).equals("ledgergroup") || rs.getString(3).equals("bank_account") || rs.getString(3).equals("invoice") || rs.getString(3).equals("invoicedetails") || rs.getString(3).equals("labourinventory")|| rs.getString(3).equals("manufacturer") || rs.getString(3).equals("category") || rs.getString(3).equals("inventory_transfer")) {
                        LocalResultSetTable = LocalStatement.executeQuery("select * from `" + rs.getString(3) + "`");
                        ServerResultSetTable = ServerStatement.executeQuery("select * from `" + rs.getString(3) + "`");
                    } else {
                        LocalResultSetTable = LocalStatement.executeQuery("select * from `" + rs.getString(3) + "` where id like 'A%'");
                        ServerResultSetTable = ServerStatement.executeQuery("select * from `" + rs.getString(3) + "` where id like 'A%'");
                    }
                    primaryKeyColName = getPrimaryKeyColumnsForTable(ServerConnection, rs.getString(3));
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
                                if ((columnName[i].equals("partid") && rs.getString(3).equals("purchaseorder")) || (columnName[i].equals("partid") && rs.getString(3).equals("purchaseorderdetails")) || (columnName[i].equals("partid") && rs.getString(3).equals("inventory_transfer"))) {
                                    insertStringBuffer.append("`" + columnName[i] + "`,");
                                    insertValues.append("'" + ServerResultSetTable.getString(i + 1).replace("MCPI", "ACPI") + "',");
                                } else {
                                    insertStringBuffer.append("`" + columnName[i] + "`,");
                                    insertValues.append("'" + ServerResultSetTable.getString(i + 1) + "',");
                                }
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

                                        updateStringBuffer.append("`" + columnName[i] + "`='" + ServerResultSetTable.getString(i + 1) + "',");
                                    }
                                    updateStringBuffer.replace(updateStringBuffer.lastIndexOf(","), updateStringBuffer.lastIndexOf(",") + 1, "");
                                    updateStringBuffer.append(" where `" + primaryKeyColName + "`='" + ServerResultSetTable.getString(primaryKeyColName) + "'");
                                    System.out.println(updateStringBuffer.toString());
//                            PreparedStatement ps = LocalConnection.prepareStatement(updateStringBuffer.toString());
//                            ps.executeUpdate();
                                    LocalStatement.execute(updateStringBuffer.toString());

                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                isSuccess = false;
                                return isSuccess;
                            }

                        }
                    }

                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            isSuccess = false;
            System.out.println("Server to Local Sync ended..Aurangabad! with errors");
            return isSuccess;
        }
        System.out.println("Server to Local Sync ended..Aurangabad!");
        return isSuccess;

    }

    public static void main(String[] args) {
        Synchronization synchronization = new Synchronization();
        synchronization.syncDatabaseLocalToServer();
        synchronization.syncDatabaseServerToLocal();
    }

    public static String getPrimaryKeyColumnsForTable(Connection connection, String tableName) throws SQLException {
        try {
            String pkColumnName = "";
            ResultSet pkColumns = connection.getMetaData().getPrimaryKeys(null, null, tableName);
            while (pkColumns.next()) {
                pkColumnName = pkColumns.getString("COLUMN_NAME");
                Integer pkPosition = pkColumns.getInt("KEY_SEQ");
                out.println("" + pkColumnName + " is the " + pkPosition + ". column of the primary key of the table " + tableName);
            }
            return pkColumnName;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }

    public String ifContainsId(List<Map<String, Object>> list, String value) {
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                System.out.println("My id from list : " + list.get(i).toString() + " and the value : " + value);
                if (list.get(i).get("id").equals(value)) {

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
