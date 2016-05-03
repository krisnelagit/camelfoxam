<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewWorkmanGrid
    Created on : 30-Apr-2015, 18:12:00
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Workman Grid</title>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui_1.css">
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                //popup for Edit followup details
                $("#dialognkEditDetail").hide();
                //on click of edit
                $(".edit_Link").click(function (e) {
                    e.preventDefault();
                    var wmid = $(this).attr('href');
                    $("#editworkmanName").text('');
                    $("#wmid").text('');
                    $.ajax({
                        url: "editWorkmanDetailsLink",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            wmid: wmid
                        },
                        cache: false,
                        success: function (data) {
                            $("#wmid").val(data[0].id);
                            $("#editworkmanName").val(data[0].name);
                            $("#editwmtype").val(data[0].employee_type);

                            //required validations here

                            $("#editworkmanName").prop("required", true);
                            $("#editwmtype").prop("required", true);

                            //our edit dialog
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

                //popup for create followup details
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

                    //required validations here
                    $("#workmanName").prop("required", true);
                    $("#wmtype").prop("required", true);
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
                        data: {id: id, deskname: "workman"
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
        <a href="#" class="view create_link">Create</a>
        <h2>Workman List</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>Id</td>
                    <td>Workman Name</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${workmanListDt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left"> <a href="${ob.id}" class="edit_Link"><img src="images/edit.png" width="16" height="15" title="Edit Details"></a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a></td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>

        <!--Add Workman Modal Begin here-->
        <div id="dialognk" title="New Workman">
            <form action="addWorkman" method="POST">        
                <table width="100%" cellpadding="5">
                    <tr>
                        <td width="34%" align="left" valign="top">Name</td>
                        <td width="66%" align="left" valign="top"><input type="text" required name="name" id="workmanName" pattern=".{3,20}" required="" title="3 to 20 characters max name allowed"/></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Type</td>
                        <td width="66%" align="left" valign="top">
                            <select name="employee_type" id="wmtype" class="select">
                                <option value="workman">workman</option>
                                <option value="Floor manager">Floor manager</option>
                                <option value="Service staff">Service staff</option>
                                <option value="Others">Others</option>
                            </select>
                        </td>
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
        <!--Add Workman Modal End here-->
        
        <!--eduit Workman Modal Begin here-->
        <div id="dialognkEditDetail" title="Edit Workman">
            <form action="updateWorkman" method="POST">  
                <input type="hidden" name="id" id="wmid" />
                <table width="100%" cellpadding="5">
                    <tr>
                        <td width="34%" align="left" valign="top">Name</td>
                        <td width="66%" align="left" valign="top"><input type="text" name="name" id="editworkmanName" pattern=".{3,20}" required="" title="3 to 20 characters max name allowed"/></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Type</td>
                        <td width="66%" align="left" valign="top">
                            <select name="employee_type" id="editwmtype" class="select">
                                <option value="workman">workman</option>
                                <option value="Floor manager">Floor manager</option>
                                <option value="Service staff">Service staff</option>
                                <option value="Others">Others</option>
                            </select>
                        </td>
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
        <!--Add Workman Modal End here-->
        
        
        
    </body>
</html>
