<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : Viewreceivables
    Created on : 18-Sep-2015, 18:20:48
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View receivables</title>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                //popup for Edit followup details
                $("#dialogreceivables").hide();
                //on click of accept
                $(".accept_link").click(function (e) {
                    e.preventDefault();
                    var transferid = $(this).attr('href');
                    $("#transferid").val('');
                    $("#brandname").text('');
                    $("#partname").text('');
                    $("#manufacturername").text('');
                    $("#vendorname").text('');
                    $("#quantity").text('');

                    $.ajax({
                        url: "getInventoryTransferDetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            transferid: transferid
                        },
                        cache: false,
                        success: function (data) {

                            $("#transferid").val(data[0].id);
                            $("#brandname").text(data[0].vehiclename);
                            $("#partname").text(data[0].partname);
                            $("#manufacturername").text(data[0].mfgname);
                            $("#vendorname").text(data[0].vendorname);
                            $("#quantity").text(data[0].quantity);

                            //our edit dialog
                            $("#dialogreceivables").dialog({
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
                    });
                });
            });//END FUNCTION
        </script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
        </script>
    </head>
    <body>
        <!--<a href="taxMasterCreateLink" class="view">Create</a>-->
        <h2>Transfer List</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Id.</td>
                    <td>From</td>
                    <td>To</td>
                    <td>Vendor</td>
                    <td>Part</td>
                    <td>quantity</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${transferdetails}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.frombranch}</td>
                        <td align="left">${ob.tobranch}</td>
                        <td align="left">${ob.vendorname}</td>
                        <td align="left">${ob.partname}</td>
                        <td align="left">${ob.quantity}</td>
                        <td align="left"> <a href="${ob.id}" class="accept_link"><img src="images/sort16.png" width="16" height="15"></a></td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>

        <!--accept transfered Items detail dialog begin here-->
        <div id="dialogreceivables" title="Receivables">
            <form method="POST" action="accepttheseItems">
                <input type="hidden"  name="id" id="transferid" />
                <table cellpadding="5" width="100%">
                    <tbody>
                        <tr>
                            <td align="left" valign="top" width="25%">Vehicle model</td>
                            <td align="left" valign="top" width="75%">
                                <span id="brandname"></span>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Part name</td>
                            <td align="left" valign="top" width="75%">
                                <span id="partname"></span>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Manufacturer</td>
                            <td align="left" valign="top" width="75%">
                                <span id="manufacturername"></span>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Vendor</td>
                            <td align="left" valign="top" width="75%">
                                <span id="vendorname"></span>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Quantity</td>
                            <td align="left" valign="top" width="75%">
                                <span id="quantity"></span>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">&nbsp;</td>
                            <td align="left" valign="top" width="75%"><input type="submit" class="view3" value="Receive" style="cursor: pointer" /></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <!--edit foloowup detail dialog end here!-->
    </body>
</html>


