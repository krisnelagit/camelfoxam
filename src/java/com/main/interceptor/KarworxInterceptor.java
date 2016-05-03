/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.interceptor;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 *
 * @author user
 */
public class KarworxInterceptor extends HandlerInterceptorAdapter{
    public boolean preHandle(HttpServletRequest request,HttpServletResponse response,Object o) throws IOException{
        StringBuffer pageName=request.getRequestURL();
        String requestMapping=pageName.substring(pageName.lastIndexOf("/"));
        
        if(requestMapping.equals("/login_style.css") || requestMapping.equals("/karlogo_login.jpg") || requestMapping.equals("/krisnela_logo.png") 
                || requestMapping.equals("/")
                || requestMapping.endsWith("/Login") || requestMapping.endsWith("/verifylogin") ){
            return true;
        }else{
            if (request.getSession().getAttribute("USERNAME")!=null) {
                return true;
            }else{
                response.sendRedirect("Login");
                return false;
            }
        }
    }
    
    
}
