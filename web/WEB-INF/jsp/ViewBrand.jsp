<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewBrand
    Created on : 17-Mar-2015, 10:15:58
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Brand</title>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui_1.css">
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                //popup for Edit followup details
                $("#dialognkEditDetail").hide();
                //on click of edit
                $(".email_link3").click(function (e) {
                    e.preventDefault();
                    var fsid = $(this).attr('href');
                    $("#brid").val('');
                    $("#brandname").text('');
                    $.ajax({
                        url: "editBrandLink",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            id: fsid
                        },
                        cache: false,
                        success: function (data) {
                            $("#brid").val(data[0].id);
                            $("#brandname").val(data[0].name);

                            $("#dialognkEditDetail").dialog({
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
                
                //popup for addng followups begin here
                $("#dialognk").hide();
                //on click of create
                $(".create_link").click(function (e) {
                    e.preventDefault();
                    $("#dialognk").dialog({
                        modal: true,
                        effect: 'drop',
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });
                });
                
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
                        data: {id: id, deskname: "brand"
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
        <a href="#" class="view create_link">Create</a>
        <h2>Brand List</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td >Sr. No.</td>
                    <td>Brand id</td>
                    <td>Brand Name</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${brandListDt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left"> <a href="carMasterCreateLink?id=${ob.id}" title="Add car name"><img src="images/detail_icon.png" width="16" height="15"></a>&nbsp;&nbsp;<a href="${ob.id}" title="Edit brand name" class="email_link3"><img src="images/edit.png" width="16" height="15"></a>&nbsp;&nbsp;<a href="editBrandDetailsLink?brandid=${ob.id}" title="Edit car name"><img src="images/edit_icon.png" width="16" height="15"></a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);" title="Delete" ><img src="images/delete.png" width="16" height="17" /></a></td>
                    </tr> 
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </tbody>
        </table>

        <!--popup for edit brand name begin here-->
        <div id="dialognkEditDetail" title="Edit Brand">
            <form action="updateBrand" method="POST">        
                <table width="100%" cellpadding="5">
                    <tr>
                    <input type="hidden" name="id" id="brid" value="${brandidDt.id}" />
                    <td width="34%" align="left" valign="top">Brand Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" maxlength="20" required name="name" id="brandname" value="" /></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" value="Update" class="view3" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br>
            </form>
        </div>
        <!--popup for edit brand name end here-->
        
        <!--popup for create brand name begin here-->
        <div id="dialognk" title="Add Brand">
            <form action="addBrand" method="POST">        
                <table width="100%" cellpadding="5">
                    <tr>
                    <td width="34%" align="left" valign="top">Brand Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" maxlength="20" required name="name" id="textfield2" /></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" value="Save" class="view3" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br>
            </form>
        </div>
        <!--popup for create brand name end here-->
    </body>
</html>
