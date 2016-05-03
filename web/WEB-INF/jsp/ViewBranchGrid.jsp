<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewBranchGrid
    Created on : 16-Jun-2015, 19:06:47
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Branch Grid</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script src="js/jquery-1.10.2.min.js"></script>
        <script src="js/jquery.dataTables.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui_1.css">
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();

                //popup for addng category begin here
                $("#dialognk").hide();
                //on click of view
                $(".email_link").click(function (e) {
                    e.preventDefault();
                    var brid = $(this).attr('href');
                    $("#id").text('');
                    $("#name").text('');
                    $("#mobile").text('');
                    $("#email").text('');
                    $("#address").text('');
                    $.ajax({
                        url: "getBranchDetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            brid: brid
                        },
                        cache: false,
                        success: function (data) {
                            $("#name").text(data[0].name);
                            $("#mobile").text(data[0].phonenumber);
                            $("#email").text(data[0].email);
                            $("#address").text(data[0].name);
                            
                            $("a#editbranch").attr("href", "editBranchPage?brid="+brid);
                            
                    $("#dialognk").dialog({
                        modal: true,
                        effect: 'drop'
                    });
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
                        data: {id: id, deskname: "branch"
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
        <a href="branchCreateLink" class="view">Create</a>
        <h2>View Branch</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>ID.</td>
                    <td>Name</td>
                    <td>Phone number</td>
                    <td>Email </td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${branchListDt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left">${ob.phonenumber}</td>
                        <td align="left">${ob.email}</td>
                        <td align="left">
                            <a href="editBranchPage?brid=${ob.id}"><img src="images/edit.png" alt="" width="14" height="16" title="Edit Branch"/></a> &nbsp;&nbsp;<a href="${ob.id}" class="email_link"><img src="images/view.png" width="21" height="13" />&nbsp;&nbsp;</a><a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                        </td>
                    </tr>
                </c:forEach>
                <c:set value="${count+1}" var="count"></c:set>
            </tbody>
        </table>

        <div id="dialognk" title="Branch Detail">

            <a href="#" id="editbranch" class="view">Edit</a>
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Branch Name</td>
                    <td width="66%" align="left" valign="top"><span id="name"></span></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Mobile Number</td>
                    <td width="66%" align="left" valign="top"><span id="mobile"></span></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email</td>
                    <td width="66%" align="left" valign="top"><span id="email"></span></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Address</td>
                    <td width="66%" align="left" valign="top"><span id="address"></span></td>
                </tr>
                <tr>    
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
