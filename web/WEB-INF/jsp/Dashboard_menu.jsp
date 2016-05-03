<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : Dashboard_menu
    Created on : 22-Aug-2015, 11:46:49
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard_menu</title>.
        <Script>
            $(document).ready(function () {
                $('#modps').removeClass().addClass('psbox');
            });

        </script>
        <style>
            .psbox {
                position: relative;
                margin: 0 auto;
                width: 960px;
                height: auto;
                padding: 20px;
                top: 30px;
                /* border-radius: 5px; */
                /* background-color: #fff; */
                -moz-box-shadow: 1px 1px 5px #CCCCCC;
                /* -webkit-box-shadow: 1px 1px 5px #CCCCCC; */
                /* box-shadow: 1px 1px 5px #CCCCCC; */
            }
        </style>
    </head>
    <body>
        <br/>
        <div class="box_container">
            
            <c:if test="${sessionScope.USERTYPE.equals('crm')}">
                <div class="box"> 
                    <a href="crm_Dashboard?prefixid=${prefixdt}">
                        <div class="box02" style="margin: 0px;width: 158px">
                            <div class="img02" style="margin-top: -20px;">
                                <img src="images/dashboard_ccrm.png" height="70" width="70">
                            </div>
                            <div class="text03">CRM Dashboard</div>
                        </div>
                    </a> 
                </div>
            </c:if>
                        
            <c:if test="${sessionScope.USERTYPE.equals('admin') ||sessionScope.USERTYPE.equals('floor manager')}">
                <div class="box"> 
                    <a href="operation_Dashboard?prefixid=${prefixdt}">
                        <div class="box02" style="margin: 0px;width: 158px">
                            <div class="img02" style="margin-top: -20px;">
                                <img src="images/dashboard_operation.png" height="70" width="70">
                            </div>
                            <div class="text03">Operation Dashboard</div>
                        </div>
                    </a> 
                </div>

                <div class="box"> 
                    <a href="crm_Dashboard?prefixid=${prefixdt}">
                        <div class="box02" style="margin: 0px;width: 158px">
                            <div class="img02" style="margin-top: -20px;">
                                <img src="images/dashboard_ccrm.png" height="70" width="70">
                            </div>
                            <div class="text03">CRM Dashboard</div>
                        </div>
                    </a> 
                </div>

                <div class="box"> 
                    <a href="accounts_Dashboard?prefixid=${prefixdt}">
                        <div class="box02" style="margin: 0px;width: 158px">
                            <div class="img02" style="margin-top: -20px;">
                                <img src="images/dashboard_accounts.png" height="70" width="70">
                            </div>
                            <div class="text03">Accounts Dashboard</div>
                        </div>
                    </a> 
                </div>

                <!--            <div class="box"> 
                                <a href="estimate.html">
                                    <div class="box02" style="margin: 0px;width: 158px">
                                        <div class="img02">
                                            <img src="images/dashboard_inventory.png" height="70" width="70">
                                        </div>
                                        <div class="text03">Inventory Dashboard</div>
                                    </div>
                                </a> 
                            </div>-->

                <div class="box"> 
                    <a href="estimate.html">
                        <div class="box02" style="margin: 0px;width: 158px">
                            <div class="img02" style="margin-top: -20px;">
                                <img src="images/dashboard_hr.png" height="70" width="70">
                            </div>
                            <div class="text03">HR Dashboard</div>
                        </div>
                    </a> 
                </div>
            </c:if>
        </div>
    </body>
</html>
