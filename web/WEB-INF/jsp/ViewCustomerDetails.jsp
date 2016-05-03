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
                $("#dialogjobDetail").hide();
                $("#dialogestimateDetail").hide();
                $("#dialogpointchecklistDetail").hide();
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
                                    $('.popupbody').append('<tr><td align="left">' + data[i].invoiceid + '</td><td align="left">' + data[i].vehiclenumber + '</td><td align="left">' + data[i].servicedate + '</td><td align="left"><a href="viewCustomerInsuranceInvoice?invoiceid=' + data[i].invoiceid + '"><img src="images/view.png" width="16" height="15" /></a></tr>')
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
                $(".jobsheet_link2").click(function (e) {
                    e.preventDefault();
                    var vehiclenumber = $(this).attr('href');
                    $('.popupbody2').children("tr").remove();
                    $.ajax({
                        url: "getJobDetails",
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
                                    $('.popupbody2').append('<tr><td align="left">' + data[i].jobno + '</td><td align="left">' + data[i].vehiclenumber + '</td><td align="left">' + data[i].jobdate + '</td><td align="left"><a href="viewTaskLink?jsid=' + data[i].jobno + '"><img src="images/view.png" width="16" height="15" /></a></tr>')
                                }
                                $('#table_id3').DataTable();
                                //our view dialog
                                $("#dialogjobDetail").dialog({
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
                $(".estimate_link2").click(function (e) {
                    e.preventDefault();
                    var vehiclenumber = $(this).attr('href');
                    $('.popupbody3').children("tr").remove();
                    $.ajax({
                        url: "getEstimateDetails",
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
                                    $('.popupbody3').append('<tr><td align="left">' + data[i].estimateid + '</td><td align="left">' + data[i].vehiclenumber + '</td><td align="left">' + data[i].estimatedate + '</td><td align="left"><a href="estimate-view?estid=' + data[i].estimateid + '"><img src="images/view.png" width="16" height="15" /></a></tr>')
                                }
                                $('#table_id4').DataTable();
                                //our view dialog
                                $("#dialogestimateDetail").dialog({
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
                $(".pointchecklist_link2").click(function (e) {
                    e.preventDefault();
                    var vehiclenumber = $(this).attr('href');
                    $('.popupbody4').children("tr").remove();
                    $.ajax({
                        url: "getpclDetails",
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
                                    $('.popupbody4').append('<tr><td align="left">' + data[i].pclid + '</td><td align="left">' + data[i].vehiclenumber + '</td><td align="left">' + data[i].pointdate + '</td><td align="left"><a href="180pointchecklistviewdetails?pclid=' + data[i].pclid + '"><img src="images/view.png" width="16" height="15" /></a></tr>')
                                }
                                $('#table_id5').DataTable();
                                //our view dialog
                                $("#dialogpointchecklistDetail").dialog({
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
                        url: "getservicechecklistDetails",
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
                                    $('.popupbody5').append('<tr><td align="left">' + data[i].clid + '</td><td align="left">' + data[i].vehiclenumber + '</td><td align="left">' + data[i].cldate + '</td><td align="left"><a href="viewServiceCheckList.html?id=' + data[i].clid + '&bdid='+data[i].brandid+'"><img src="images/view.png" width="16" height="15" /></a></tr>')
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
                if (res === true)
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
        <a href="viewAllPayments?customerid=${param.customerid}" title="view all payments made" onclick="" class="view button-001 paymenthistory"><img src="images/wallet33.png" width="15" height="13"/>&nbsp;History</a>
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
            <tr>
                <td align="left" valign="top">Password</td>
                <td align="left" valign="top">${customerprofile.password}</td>
            </tr>

            <tr>
                <td>&nbsp;</td>
                <td>
                    <a href="editCustomerDetailsLink?customerid=${customerprofile.id}" class="view2">Edit</a>&nbsp;&nbsp;&nbsp;
                    <!--<a href="" class="view2" onclick="confirmdelete('${customerprofile.id}', this);">Delete</a>&nbsp;&nbsp;&nbsp;-->
                </td>
            </tr>
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
                        <td align="left">${ob.carbrand}</td>
                        <td align="left">${ob.carmodel}</td>
                        <td align="left">${ob.vehiclenumber}</td>
                        <td align="left">${ob.times}</td>
                        <td align="left">
                            <a class="invoice_link2" href="${ob.vehiclenumber}">
                                <img src="images/view.png" width="16" height="15">
                            </a>&nbsp;
                            <a class="jobsheet_link2" href="${ob.vehiclenumber}">
                                <img src="images/psjs.png" width="14" height="16" title="Job Sheet">
                            </a>&nbsp;
                            <a class="estimate_link2" href="${ob.vehiclenumber}">
                                <img src="images/eslitmate_icon.png" alt="" width="14" height="16" title="Estimate">
                            </a>&nbsp;
                            <a class="pointchecklist_link2" href="${ob.vehiclenumber}">
                                <img src="images/180_icon.png" width="16" height="14" title="180 point Check List">
                            </a>&nbsp;
                            <a class="servicechecklist_link2" href="${ob.vehiclenumber}">
                                <img src="images/180_icona.png" width="16" height="14" title="180 point Check List">
                            </a>&nbsp;
                        </td>
                            <!--&nbsp;&nbsp; <a href="editCustomerDetailsLink?customerid=$ {ob.id}"><img src="images/edit.png" width="16" height="15"></a>&nbsp;&nbsp;-->
                            <!--<a href="" onclick="confirmdelete('$ {ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a>-->
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

        <!--invoice list for the vehicle in pop up start here-->
        <div id="dialogjobDetail" title="Job details">
            <table class="display tablestyle" id="table_id3">
                <thead>
                    <tr>
                        <td>Job id</td>
                        <td>Vehicle number</td>
                        <td>Service date</td>
                        <td>&nbsp;</td>
                    </tr>
                </thead>
                <tbody class="popupbody2">

                </tbody>
            </table>
        </div>
        <!--invoice list for the vehicle in pop up end here-->

        <!--estimate list for the vehicle in pop up start here-->
        <div id="dialogestimateDetail" title="Estimate">
            <table class="display tablestyle" id="table_id4">
                <thead>
                    <tr>
                        <td>Estimate id</td>
                        <td>Vehicle number</td>
                        <td>Date</td>
                        <td>&nbsp;</td>
                    </tr>
                </thead>
                <tbody class="popupbody3">

                </tbody>
            </table>
        </div>
        <!--invoice list for the vehicle in pop up end here-->

        <!--estimate list for the vehicle in pop up start here-->
        <div id="dialogpointchecklistDetail" title="180 point">
            <table class="display tablestyle" id="table_id5">
                <thead>
                    <tr>
                        <td>180 id</td>
                        <td>Vehicle number</td>
                        <td>Date</td>
                        <td>&nbsp;</td>
                    </tr>
                </thead>
                <tbody class="popupbody4">

                </tbody>
            </table>
        </div>
        <!--invoice list for the vehicle in pop up end here-->

        <!--estimate list for the vehicle in pop up start here-->
        <div id="dialogservicechecklistDetail" title="Service Checklist">
            <table class="display tablestyle" id="table_id6">
                <thead>
                    <tr>
                        <td>checklist id</td>
                        <td>Vehicle number</td>
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
