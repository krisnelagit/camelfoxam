<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : CreateInventory
    Created on : 17 Mar, 2015, 12:50:33 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inventory</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="css/tabs.css">
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/jquery-ui.css" />
        <script>

            $(document).ready(function () {
                $('#table_id2').DataTable();
                $('#table_id').DataTable();
                $(function () {
                    $(".email_link").click(function (e) {
                        e.preventDefault();
                        var url = encodeURI($(this).attr("href"));
//                        alert($(this).attr("href"));
//                        alert(url);
                        var mytitle = "Inventory";
                        $("#dialog").load(url, null, function () {
                            $("#dialog").dialog({
                                title: mytitle,
                                modal: true,
                                width: 800,
                                close: function (event, ui) {
                                    $("#dialog").empty(); // remove the content
                                }//END CLOSE
                            });//END DIALOG
                        });//END DIALOG
                    });//END MODAL_LINK
                });//END FUNCTION
            });

            function confirmdelete(id, partid, ob)
            {
                var res = confirm('Are you sure you want to delete?');
                if (res == true)
                {
                    $(ob).closest('tr').find('td').fadeOut(600,
                            function () {
//                        $(this).parents('tr:first').remove();
                                $(ob).parents('tr:first').remove();
                            });

                    $.ajax({
                        type: "post",
                        url: "deleteInventoryRecord",
                        data: {id: id, partids: partid, deskname: "inventory"
                        },
                        success: function (data) {
                        },
                        error: function () {
                        }
                    });
                }
            }

            function calculatetax(a) {
                var splitvar = $(a).val().split(',');
                var costprice = $("#costprice").val();
                var qty = $("#quantity").val();
                var actualcost=Number(costprice)*Number(qty);
                var taxamount = Number(splitvar[1]) / 100 * Number(actualcost);
                console.log(taxamount);
                var total = Number(actualcost) + Number(taxamount);
                console.log(total);
                $("#totalcost").val(total.toFixed(2));
                $("#taxid").val(splitvar[0]);
            }
            
            function calltax(){
                $("#alltaxes").change();
            }


        </script>
    </head>
    <body>
        <div id="dialog"></div>
        <a href="viewSparesList?id=${param.carmodel}" class="view">Back</a>
        <h2>Inventory Quantity</h2>
        <br />
        <form action="insertinventory" method="post">
            <input type="hidden" name="branddetailid" value="${param.carmodel}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top">Manufacturer</td>
                    <td align="left" valign="top">
                        <select name="manufacturerid" id="select" required="">
                            <option disabled="" value="">--select--</option>
                            <c:forEach var="ob" items="${manufacturer}">
                                <option value="${ob.id}">${ob.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top">Vendor Name</td>
                    <td align="left" valign="top">
                        <select name="vendor" id="select2" required="">
                            <option disabled="" value="">--select--</option>
                            <c:forEach var="ob" items="${vendor}">
                                <option value="${ob.id}">${ob.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Quantity</td>
                    <td><label for="textfield2"></label>
                        <input type="number" name="quantity" onchange="calltax()" required="" id="quantity" /></td>
                </tr>
                <tr>
                    <td>Cost Price</td>
                    <td><input type="number" name="costprice" onchange="calltax()" required="" id="costprice" /></td>
                </tr>
                <tr>
                    <td>Selling Price</td>
                    <td><input type="number" name="sellingprice" required="" id="textfield3" /></td>
                </tr>
                <tr>
                    <td>Tax</td>
                    <td>
                        <select name="tax" id="alltaxes" onchange="calculatetax(this)">
                            <c:forEach var="ob" items="${taxdt}">
                                <option value="${ob.id},${ob.percent}">${ob.name} (${ob.percent}%)</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" name="taxid" id="taxid" value="" />
                    </td>
                </tr>
                <tr>
                    <td>Total</td>
                    <td>
                        <input type="text" name="totalamount" value="" id="totalcost" />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td> <input type="submit" value="Save" style="cursor: pointer" class="view3" /> &nbsp;&nbsp;&nbsp;<input style="cursor: pointer" type="reset" value="Reset" class="view3" /></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <input type="hidden" name="partid" value="${param.id}" />
            <input type="hidden" name="type" value="inward" />
        </form>



        <ul id="tabs">
            <li><a href="#" name="#tab1">Inward</a></li>
            <li><a href="#" name="#tab2">Outward</a></li> 
        </ul>  

        <div id="content">
            <div id="tab1">

                <table class="display tablestyle" id="table_id">
                    <thead>
                        <tr>
                            <th align="left">Date</th>
                            <th align="left">Manufacturer</th>
                            <th align="left">Vendor Name</th>
                            <th align="left">Cost Price</th>
                            <th align="left">Selling Price</th>
                            <th align="left">Qty</th>
                            <th align="left">&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ob" items="${inventoryinward}">
                            <tr>
                                <td height="19">${ob.savedate}</td>
                                <td>${ob.brand}</td>
                                <td>${ob.vendorname}</td>
                                <td>${ob.costprice}</td>
                                <td>${ob.sellingprice}</td>
                                <td>${ob.quantity}</td>
                                <td><a href="editinventory?id=${ob.id}&partid=${param.id}" title="Edit inventory" class="email_link"><img src="images/edit.png" width="16" height="15" /></a>&nbsp;&nbsp;<a title="Delete"  onclick="confirmdelete('${ob.id}', '${param.id}', this);"> <img src="images/delete.png" width="16" height="17" /></a>&nbsp;&nbsp;<a title="Internal transfer" href="internaltransfer?id=${ob.id}&partid=${param.id}&carmodel=${param.carmodel}" class="link"><img src="images/file-sharing1.png" width="16" height="15" /></a>&nbsp;&nbsp;<a title="Branch transfer" href="branchtransfer?id=${ob.id}&partid=${param.id}&carmodel=${param.carmodel}" class="link"><img src="images/transfer.png" width="16" height="15" /></a></td>
                            </tr>
                        </c:forEach>

                    </tbody>
                </table> 
            </div>
            <div id="tab2">

                <table class="display tablestyle" id="table_id2">
                    <thead>
                        <tr>
                            <th align="left">Date</th>
                            <th align="left">Invoice id</th>
                            <th align="left">Manufacturer</th>
                            <th align="left">Vendor Name</th>
                            <th align="left">Selling Price</th>
                            <th align="left">Qty</th>
                            <!--<th align="left">&nbsp;</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ob" items="${inventoryoutward}">
                            <tr>
                                <td height="19">${ob.savedate}</td>
                                <td>${ob.invoiceid}</td>
                                <td>${ob.brand}</td>
                                <td>${ob.vendorname}</td>
                                <td>${ob.sellingprice}</td>
                                <td>${ob.quantity}</td>
                                <!--<td><a href="editinventory?id=$ {ob.id}&partid=$ {param.id}" class="email_link"><img src="images/edit.png" width="16" height="15" /></a>&nbsp;&nbsp;<a  onclick="confirmdelete('$ {ob.id}','$ {param.id}', this);"> <img src="images/delete.png" width="16" height="17" /></a>&nbsp;&nbsp;<a href="internaltransfer?id=$ {ob.id}&partid=$ {param.id}&carmodel=$ {param.carmodel}" class="link"><img src="images/file-sharing1.png" width="16" height="15" /></a>&nbsp;&nbsp;<a href="branchtransfer?id=$ {ob.id}&partid=$ {param.id}&carmodel=$ {param.carmodel}" class="link"><img src="images/transfer.png" width="16" height="15" /></a></td>-->
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <script>

                function resetTabs() {

                    $("#content > div").hide(); //Hide all content

                    $("#tabs a").attr("id", ""); //Reset id's      

                }



                var myUrl = window.location.href; //get URL

                var myUrlTab = myUrl.substring(myUrl.indexOf("#")); // For localhost/tabs.html#tab2, myUrlTab = #tab2     

                var myUrlTabName = myUrlTab.substring(0, 4); // For the above example, myUrlTabName = #tab



                (function () {

                    $("#content > div").hide(); // Initially hide all content

                    $("#tabs li:first a").attr("id", "current"); // Activate first tab

                    $("#content > div:first").fadeIn(); // Show first tab content



                    $("#tabs a").on("click", function (e) {

                        e.preventDefault();

                        if ($(this).attr("id") == "current") { //detection for current tab

                            return

                        }

                        else {

                            resetTabs();

                            $(this).attr("id", "current"); // Activate this

                            $($(this).attr('name')).fadeIn(); // Show content for current tab

                        }

                    });



                    for (i = 1; i <= $("#tabs li").length; i++) {

                        if (myUrlTab == myUrlTabName + i) {

                            resetTabs();

                            $("a[name='" + myUrlTab + "']").attr("id", "current"); // Activate url tab

                            $(myUrlTab).fadeIn(); // Show url tab content        

                        }

                    }

                })()

            </script>  

    </body>
</html>
