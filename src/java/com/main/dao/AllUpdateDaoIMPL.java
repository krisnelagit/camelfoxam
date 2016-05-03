/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.main.dao;

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
public class AllUpdateDaoIMPL implements AllUpdateDao{
    @Autowired SessionFactory sessionfactory;
    
    JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public void update(Object entity) {
        sessionfactory.getCurrentSession().merge(entity);
    }

    @Override
    public void updateanyhqlquery(String query) {
        SQLQuery sQLQuery=sessionfactory.getCurrentSession().createSQLQuery(query);
        sQLQuery.executeUpdate();
    }

    @Override
    public int updateanyjdbcdatalist(String query) {
//        this.jdbcTemplate.update();
        return jdbcTemplate.update(query);
    }
    
}
