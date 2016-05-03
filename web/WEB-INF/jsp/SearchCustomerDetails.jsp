<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewCustomerDetails
    Created on : 26-Jun-2015, 11:18:19
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Customer Details</title>     
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script src="js/jquery.dataTables.js"></script>   
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {

                $("#dialognkDetail").hide();
                $("#dialogservicechecklistDetail").hide();
                //on click of edit
                $(".invoice_link2").click(function (e) {
                    e.preventDefault();
                    var vehiclenumber = $(this).attr('href');
                    $('.popupbody').children("tr").remove();
                    $.ajax({
                        url: "getInvoiceDetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            vehiclenumber: vehiclenumber
                        },
                        cache: false,
                        success: function (data) {
                            if (data) {
                                for (var i = 0; i < data.length; i++)
                                {
                                    $('.popupbody').append('<tr><td align="left">' + data[i].invoiceid + '</td><td align="left">' + data[i].vehiclenumber + '</td><td align="left">' + data[i].servicedate + '</td><td align="left"><a href="viewCustomerInvoice?invoiceid=' + data[i].invoiceid + '"><img src="images/view.png" width="16" height="15" /></a></tr>')
                                }
                                $('#table_id2').DataTable();
                                //our view dialog
                                $("#dialognkDetail").dialog({
                                    modal: true,
                                    effect: 'drop',
                                    width: 500,
                                    height: 400,
                                    show: {
                                        effect: "drop"
                                    },
                                    hide: {
                                        effect: "drop"
                                    }
                                });
                            }
                        }, error: function () {
                        }
                    });

                });
                
                //on click of Job detail icon
                $(".servicechecklist_link2").click(function (e) {
                    e.preventDefault();
                    var vehiclenumber = $(this).attr('href');
                    $('.popupbody5').children("tr").remove();
                    $.ajax({
                        url: "getservicechecklistsearchDetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            vehiclenumber: vehiclenumber
                        },
                        cache: false,
                        success: function (data) {
                            if (data) {
                                for (var i = 0; i < data.length; i++)
                                {
                                    $('.popupbody5').append('<tr><td align="left">' + data[i].id + '</td><td align="left">' + data[i].carbrand + '</td><td align="left">' + data[i].carmodel + '</td><td align="left">' + data[i].vehiclenumber + '</td><td align="left">' + data[i].cldate + '</td><td align="left"><a href="trackCarStatus?id=' + data[i].id + '&custid='+data[i].custid+'"><img src="images/view.png" width="16" height="15" /></a></tr>');
                                }
                                $('#table_id6').DataTable();
                                //our view dialog
                                $("#dialogservicechecklistDetail").dialog({
                                    modal: true,
                                    effect: 'drop',
                                    width: 500,
                                    height: 400,
                                    show: {
                                        effect: "drop"
                                    },
                                    hide: {
                                        effect: "drop"
                                    }
                                });
                            }
                        }, error: function () {
                        }
                    });

                });

                $('#table_id').DataTable();
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
        <a href="CustomerSearchLink" class="view">Back to search</a>
        <!--customer profile detail start here-->
        <h2>Customer Information</h2>

        <br />

        <table width="100%" cellpadding="5">
            <tr>
                <td width="35%" align="left" valign="top">Date
                </td>
                <td width="65%" align="left" valign="top">
                    ${customerprofile.savedate}
                </td>
            </tr>


            <tr>
                <td align="left" valign="top">Customer ID</td>
                <td align="left" valign="top">${customerprofile.id}</td>
            </tr>

            <tr>
                <td align="left" valign="top">Customer Name</td>
                <td align="left" valign="top">${customerprofile.name}</td>
            </tr>
            <tr>
                <td align="left" valign="top">Address</td>
                <td align="left" valign="top">
                    ${customerprofile.address}</td>
            </tr>
            <tr>
                <td align="left" valign="top">Phone Number</td>
                <td align="left" valign="top">${customerprofile.mobilenumber}</td>
            </tr>
            <tr>
                <td align="left" valign="top">Email Address</td>
                <td align="left" valign="top">${customerprofile.email}</td>
            </tr>
<!--
            <tr>
                <td>&nbsp;</td>
                <td>
                    <a href="editCustomerDetailsLink?customerid=" class="view2">Edit</a>&nbsp;&nbsp;&nbsp;
                    <a href="#" class="view2">Delete</a>&nbsp;&nbsp;&nbsp;
                </td>
            </tr>-->
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <!--customer profile detail end here-->

        <hr />
        <h2>Service History</h2>

        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td >Date</td>
                    <td >Car brand</td>
                    <td>Car model</td>
                    <td>Vehicle number</td>
                    <td>Visit</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>

                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${customerdetails}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.savedate}</td>
                        <td align="left">${ob.carbrand}</td>
                        <td align="left">${ob.carmodel}</td>
                        <td align="left">${ob.vehiclenumber}</td>
                        <td align="left">${ob.times}</td>
                        <td align="left">
                            <a class="invoice_link2" href="${ob.vehiclenumber}"><img src="images/view.png" width="16" height="15"></a>&nbsp;
                            <a class="servicechecklist_link2" href="${ob.vehiclenumber}">
                                <img src="images/catalog3.png" width="16" height="14" title="Service status List">
                            </a>&nbsp;
                        </td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach> 
            </tbody>
        </table>

        <!--invoice list for the vehicle in pop up start here-->
        <div id="dialognkDetail" title="Invoice details">
            <table class="display tablestyle" id="table_id2">
                <thead>
                    <tr>
                        <td>Invoice id</td>
                        <td>Vehicle number</td>
                        <td>Service date</td>
                        <td>&nbsp;</td>
                    </tr>
                </thead>
                <tbody class="popupbody">

                </tbody>
            </table>
        </div>
        <!--invoice list for the vehicle in pop up end here-->
        
        <!--estimate list for the vehicle in pop up start here-->
        <div id="dialogservicechecklistDetail" title="Service Checklist">
            <table class="display tablestyle" id="table_id6">
                <thead>
                    <tr>
                        <td>Id</td>
                        <td>Make</td>
                        <td>Model</td>
                        <td>Vehicle No.</td>
                        <td>Date</td>
                        <td>&nbsp;</td>
                    </tr>
                </thead>
                <tbody class="popupbody5">

                </tbody>
            </table>
        </div>
        <!--invoice list for the vehicle in pop up end here-->

    </body>
</html>
