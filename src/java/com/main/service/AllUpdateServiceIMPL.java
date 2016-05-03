/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.main.service;

import com.main.dao.AllUpdateDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author krisnela
 */
@Service
public class AllUpdateServiceIMPL implements AllUpdateService{
    @Autowired AllUpdateDao updateDao;

    @Transactional
    public void update(Object entity) {
        updateDao.update(entity);
    }

    @Transactional
    public void updateanyhqlquery(String query) {
        updateDao.updateanyhqlquery(query);
    }

    @Override
    public int updateanyjdbcdatalist(String query) {
        return updateDao.updateanyjdbcdatalist(query);
    }
}
