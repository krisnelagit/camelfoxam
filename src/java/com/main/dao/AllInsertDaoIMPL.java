/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author krisnela
 */
@Transactional
@Repository
public class AllInsertDaoIMPL implements AllInsertDao {

    @Autowired
    SessionFactory sessionfactory;
    
    JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public void insert(Object entity) {
        sessionfactory.getCurrentSession().save(entity);
    }

    @Override
    public String getmaxcount(String tablename, String columnname, int substringof) {
        String getcount;
        SQLQuery data = sessionfactory.getCurrentSession().createSQLQuery("select max(cast(substring(" + columnname + " ," + substringof + ",CHAR_LENGTH(" + columnname + ") ) as decimal(15,0)))+1 from " + tablename + "");
        List count = data.list();
        if (count.get(0) == null) {
            getcount = "1";
        } else {
            getcount = count.get(0).toString();
        }
        return getcount;
    }

//    @Override
    public int setanyjdbcdatalist(String query) {
        return jdbcTemplate.update(query);
    }
}
