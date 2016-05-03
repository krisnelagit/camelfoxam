/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.dao;

import java.util.List;
import java.util.Map;

/**
 *
 * @author krisnela
 */
public interface AllViewDao<T> {

    public List<T> getanyhqldatalist(String query);

    public T getspecifichqldata(Class clazz, Object pk);

    public List<Map<String, Object>> getanyjdbcdatalist(String query);
}
