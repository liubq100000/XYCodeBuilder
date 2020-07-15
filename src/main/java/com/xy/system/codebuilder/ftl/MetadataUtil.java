package com.xy.system.codebuilder.ftl;

import com.xy.system.codebuilder.domain.DataSourceVO;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 负责获取表的元信息
 * 列的元信息
 */

public class MetadataUtil {


    /**
     * 建立数据库连接
     *
     * @param dataSource
     * @return
     * @throws Exception
     */
    public static Connection openConnection(DataSourceVO dataSource) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection(dataSource.getUrl(), dataSource.getUsername(), dataSource.getPassword());

    }


    /**
     * 列信息数组的集合。List中每个元素是一个数组，代表一个列的信息；
     * 每个数组的元素1是列名，元素2是注释，元素3是类型
     *
     * @return
     */
    public static List<Attribute> getTableColumnsInfo(DataSourceVO dataSource, String tableName) throws Exception {
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        List<Attribute> columnInfoList = new ArrayList<Attribute>();
        try {
            conn = openConnection(dataSource);
            st = conn.createStatement();
            rs2 = st.executeQuery("SELECT column_name,column_comment FROM information_schema.columns WHERE table_name ='"+tableName+"' AND table_schema='"+dataSource.getDbName()+"'");
            Map<String,String> remarkMap = new HashMap<>();
            while(rs2.next()){
                remarkMap.put(rs2.getString(1),rs2.getString(2));
            }
            rs = st.executeQuery("select * from " + tableName);
            ResultSetMetaData rsMetaData = rs.getMetaData();
            String name;
            String type;
            int size;
            for (int index = 0; index < rsMetaData.getColumnCount(); index++) {
                name = rsMetaData.getColumnName(index + 1);
                type = rsMetaData.getColumnTypeName(index + 1);
                size = rsMetaData.getColumnDisplaySize(index + 1);
                columnInfoList.add(new Attribute(name, JavaNameUtil.dbTypeChangeJavaType(type), remarkMap.get(name),size));
            }
        } finally {
            if (rs2 != null) {
                try {
                    rs2.close();
                } catch (SQLException e) {
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                }
            }
            if (st != null) {
                try {
                    st.close();
                } catch (SQLException e) {
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                }
            }
        }
        return columnInfoList;
    }

    /**
     * 列信息数组的集合。List中每个元素是一个数组，代表一个列的信息；
     * 每个数组的元素1是列名，元素2是注释，元素3是类型
     *
     * @return
     */
    public static List<String> getTableInfo(DataSourceVO dataSource) throws Exception {
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        List<String> tableNames = new ArrayList<String>();
        try {
            conn = openConnection(dataSource);
            st = conn.createStatement();
            rs = st.executeQuery("SELECT table_name  FROM information_schema.tables WHERE table_schema='" + dataSource.getDbName() + "'");
            ResultSetMetaData rsMetaData = rs.getMetaData();
            while (rs.next()) {
                tableNames.add(rs.getString(1));
            }
            return tableNames;
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                }
            }
            if (st != null) {
                try {
                    st.close();
                } catch (SQLException e) {
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                }
            }
        }
    }

}