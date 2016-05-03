<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewSparepartList
    Created on : 07-Jul-2015, 11:41:32
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Item List</title>
        <link rel="stylesheet" type="text/css" href="css/tabs.css">

        <script src="js/jquery.dataTables.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
                $('#table_id2').DataTable();
            });

            function confirmdelete(id, ob)
            {
                var res = confirm('Are you sure you want to delete?');
                if (res == true)
                {
                    $(ob).closest('tr').find('td').fadeOut(600,
                            function () {
                                $(ob).parents('tr:first').remove();
                            });

                    $.ajax({
                        type: "post",
                        url: "deleterecord",
                        data: {id: id, deskname: "carparts"
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
        <!--<a href="CreateCarParts" class="view">Create</a>-->
        <h2>Items</h2>
        <br />
        <ul id="tabs">
            <li><a href="#" name="#tab1">All parts</a></li>
            <li><a href="#" name="#tab2">Negative parts</a></li> 
        </ul> 
         <div id="content">
            <div id="tab1">
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <th>Sr No.</th>
                    <th>Id</th>
                    <th>Part name</th>
                    <th>&nbsp;</th>
                    <th>Balance qty.</th>
                    <th>&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="count" value="1"></c:set>
                <c:forEach var="ob" items="${sparepartdetails}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.partname}</td>
                        <td align="left">${ob.categoryname}</td>
                        <td align="left">${ob.balancequantity}</td>
                        <td align="left"> 
                            <a href="viewspareparts?id=${ob.vaultid}"><img src="images/view.png" width="16" height="13" /></a>&nbsp;&nbsp;
                            <!--<a href="inventory-transfer?branddetailid=$ {param.id}&carpartid=$ {ob.id}"><img src="images/transfer.png" width="18" height="17" title="Transfer"/></a>&nbsp;&nbsp;-->
                            <a href="inventoryqty?id=${ob.id}&carmodel=${param.id}"><img src="images/add-qty.png" width="18" height="16" title="Add Quantity"/></a>&nbsp;&nbsp;
                            <!--<a onclick="confirmdelete('${ob.id}', this);"> <img src="images/delete.png" width="16" height="17" /></a>-->
                        </td>
                    </tr>
                    <c:set var="count" value="${count+1}"></c:set>
                </c:forEach>
            </tbody>
        </table>
            </div>
                <div id="tab2">
                    <table class="display tablestyle" id="table_id2">
            <thead>
                <tr>
                    <th>Sr No.</th>
                    <th>Id</th>
                    <th>Part name</th>
                    <th>&nbsp;</th>
                    <th>Balance qty.</th>
                    <th>&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="count" value="1"></c:set>
                <c:forEach var="ob" items="${negativesparepartdetails}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.partname}</td>
                        <td align="left">${ob.categoryname}</td>
                        <td align="left">${ob.balancequantity}</td>
                        <td align="left"> 
                            <a href="viewspareparts?id=${ob.vaultid}"><img src="images/view.png" width="16" height="13" /></a>&nbsp;&nbsp;
                            <!--<a href="inventory-transfer?branddetailid=$ {param.id}&carpartid=$ {ob.id}"><img src="images/transfer.png" width="18" height="17" title="Transfer"/></a>&nbsp;&nbsp;-->
                            <a href="inventoryqty?id=${ob.id}&carmodel=${param.id}"><img src="images/add-qty.png" width="18" height="16" title="Add Quantity"/></a>&nbsp;&nbsp;
                            <!--<a onclick="confirmdelete('${ob.id}', this);"> <img src="images/delete.png" width="16" height="17" /></a>-->
                        </td>
                    </tr>
                    <c:set var="count" value="${count+1}"></c:set>
                </c:forEach>
            </tbody>
        </table>
                </div>
        <script>
            $(document).ready(function () {
                var table = $('#table_id').DataTable();

                $("#table_id thead th").each(function (i) {
                    if (i == 3) {


                        var select = $('<select><option value="">--Category--</option><option value="">All</option></select>')
                                .appendTo($(this))
                                .on('change', function () {
                                    table.column(i)
                                            .search($(this).val())
                                            .draw();
                                });

                        table.column(i).data().unique().sort().each(function (d, j) {
                            select.append('<option value="' + d + '">' + d + '</option>')
                        });

                    }
                });
            });
        </script>

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
