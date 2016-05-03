<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : Dashboard_crm
    Created on : 01-Sep-2015, 17:09:18
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/tabs.css">
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">        
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('.table_id').DataTable();
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
                        data: {id: id, deskname: "customervehicles"
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
        <h2>Today's Enquiries</h2>
        <br />
        <ul id="tabs">
            <li><a href="#" name="#tab1">Enquiries</a></li>
            <li><a href="#" name="#tab2">Follow up's</a></li> 
            <li><a href="#" name="#tab2">Appointment's</a></li> 
        </ul>   

        <div id="content">
            <div id="tab1">
                <table class="table_id">
                    <thead>
                        <tr>
                            <td>Sr. No.</td>
                            <td >Id</td>
                            <td >Date</td>
                            <td >Customer Name</td>
                            <td >Mobile</td>
                            <td>Location</td>
                            <td>lead source</td>
                            <td>Status</td>
                            <td>&nbsp;</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set value="1" var="count"></c:set>
                        <c:forEach var="ob" items="${enquiriesDt}">
                            <tr>
                                <td align="left">${count}</td>
                                <td align="left">${ob.id}</td>
                                <td align="left">${ob.date}</td>
                                <td align="left">${ob.name}</td>
                                <td align="left">${ob.mobile}</td>
                                <td align="left">${ob.location}</td>
                                <td align="left">${ob.leadsource}</td>
                                <td align="left">${ob.status}</td>
                                <td align="left"> 
                                    <a href="viewConvertToCustomerPage?enquiryid=${ob.id}&iscu=${ob.iscustomer}"><img src="images/converttocustomer.png" width="16" height="17" title="Convert to customer" />&nbsp;&nbsp;&nbsp;&nbsp;</a><a href="viewEnquiriyDetailPage?enquiryid=${ob.id}"><img src="images/view.png" width="21" height="13" title="View Enquiriy Details" />&nbsp;&nbsp;&nbsp;&nbsp;</a>
                                </td>
                            </tr>  
                            <c:set value="${count+1}" var="count"></c:set>
                        </c:forEach>

                    </tbody>
                </table>
            </div>
            <div id="tab2">    
                <table class="table_id">
                    <thead>
                        <tr>
                            <td>Id</td>
                            <td>Date</td>
                            <td>Customer Name</td>
                            <td>Next Followup</td>
                            <td>Status</td>
                            <td>Followed by</td>
                            <td>&nbsp;</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set value="1" var="count"></c:set>
                        <c:forEach var="ob" items="${followupdt}">
                            <tr>
                                <td align="left">${ob.id}</td>
                                <td align="left">${ob.date}</td>
                                <td align="left">${ob.name}</td>
                                <td align="left">${ob.nextfollowup}</td>
                                <td align="left">${ob.fpstatus}</td>
                                <td align="left">${ob.followedby}</td>
                                <td align="left"> 
                                    <a href="viewFollowUpDetails?followupid=${ob.id}"><img src="images/view.png" width="21" height="13" title="View FollowUp Details" />&nbsp;&nbsp;&nbsp;&nbsp;</a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                                </td>
                            </tr>  
                            <c:set value="${count+1}" var="count"></c:set>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div id="tab3">

                <table class="table_id">
                    <thead>
                        <tr>
                            <td>Sr. No.</td>
                            <td>ID.</td>
                            <td>Date & time</td>
                            <td>Customer Name</td>
                            <td>Address</td>
                            <td>Subject</td>
                            <td>Appointment owner</td>
                            <td>Description</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set value="1" var="count"></c:set>
                        <c:forEach var="obb" items="${datatabledtt}">
                            <tr>
                                <td align="left">${count}</td>
                                <td align="left">${obb.id}</td>
                                <td align="left">${obb.datetime}</td>
                                <td align="left">${obb.name}</td>
                                <td align="left">${obb.address}</td>
                                <td align="left">${obb.subject}</td>
                                <td align="left">${obb.appointmentowner}</td>
                                <td align="left">${obb.apdescription}</td>
                            </tr>
                            <c:set value="${count+1}" var="count"></c:set>
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
