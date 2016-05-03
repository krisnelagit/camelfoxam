<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewCategory
    Created on : 17-Mar-2015, 18:44:10
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui_1.css">
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                //popup for Edit followup details
                $("#dialognkEditDetail").hide();
                //on click of edit
                $(".email_link").click(function (e) {
                    e.preventDefault();
                    var fsid = $(this).attr('href');
                    $("#categoryid").val('');
                    $("#categoryname").text('');
                    $.ajax({
                        url: "editCategoryDetailsLink",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            categoryid: fsid
                        },
                        cache: false,
                        success: function (data) {
                            $("#categoryid").val(data[0].id);
                            $("#categoryname").val(data[0].name);
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
                        data: {id: id, deskname: "category"
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
        <div id="dialog"></div> 
        <a href="categoryMasterCreateLink" class="view">Create</a>
        <h2>Category List</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Id</td>
                    <td>Category Name</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${categoryListDt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left"> <a href="${ob.id}" class="email_link"><img src="images/edit.png" width="16" height="15"></a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a></td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>

        <!--popup for edit Category name begin here-->
        <div id="dialognkEditDetail" title="Edit Category">
            <form action="updateCategory" method="POST">        
                <table width="100%" cellpadding="5">
                    <tr>
                    <input type="hidden" name="id" id="categoryid" />
                    <td width="34%" align="left" valign="top">Brand Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" pattern=".{3,40}" required="" title="3 to 40 characters max name allowed" name="name" id="categoryname" /></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" value="Update" class="view3" style="cursor: pointer" /></td>
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
    </body>
</html>
