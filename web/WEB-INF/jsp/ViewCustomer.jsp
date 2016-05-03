<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewCustomer
    Created on : 18-Mar-2015, 16:17:50
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Customer</title>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />        
        <script src="js/jquery-ui.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $("#dialog").hide();
                
                if('${param.isexist}' === "Yes"){
                    $("#dialog").show();
                    $( "#dialog" ).dialog({
                        modal: true,
                        effect: 'drop',
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });
                }
                
                $('#table_id').DataTable();
                var email="${param.email}";
                var sms="${param.sms}";
                
                if(email=="send"){
                    alert("email sent !!");
                }
                
                if(email=="notsend"){
                    alert("email not sent !!");
                }
                
                if(sms=="smssent"){
                    alert("Sms sent !!");
                }
                
                if(sms=="notsent"){
                    alert("Sms not sent !!");
                }
                
            });
        </script>
        <script>
            function confirmdelete(id, ob)
            {
                var res = confirm('Are you sure to delete?');
                if (res == true)
                {
                    $(ob).closest('tr').find('td').fadeOut(600,
                            function () {
                                $(ob).parents('tr:first').remove();
                            });

                    $.ajax({
                        type: "post",
                        url: "deleterecord",
                        data: {id: id, deskname: "customer"
                        },
                        success: function (data) {
                        },
                        error: function () {
                        }
                    });
                }
            }
        </script>
    </head>
    <body>
        <a href="customerMasterCreateLink" class="view">Create</a>
        <h2>Customer List</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Id</td>
                    <td>Customer Name</td>
                    <td>Address</td>
                    <td>Mobile number</td>
                    <td>Email</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${customerListDt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left">${ob.address}</td>
                        <td align="left">${ob.mobilenumber}</td>
                        <td align="left">${ob.email}</td>
                        <td align="left">
                            <a href="viewCustomerDetailsLink?customerid=${ob.id}" title="view customer details"><img src="images/view.png" width="16" height="15"></a>&nbsp;&nbsp; 
                            <a href="editCustomerDetailsLink?customerid=${ob.id}" title="edit customer details"><img src="images/edit.png" width="16" height="15"></a>&nbsp;&nbsp;
                            <a href="sendcustomersmsLink?customerid=${ob.id}" title="Send SMS"><img src="images/sms.png" width="16" height="15"></a>&nbsp;&nbsp;
                            <a href="sendcustomeremailLink?customerid=${ob.id}" title="Send Email"><img src="images/email.png" width="16" height="15"></a>&nbsp;&nbsp;
                            <a href="" onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" title="delete customer" /></a>.
                        </td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>
                <div id="dialog" title="Message">
                    <br/>
                    <br/>
                <center><b>Customer with this number already exist!!</b></center>                    
                </div>
    </body>
</html>

