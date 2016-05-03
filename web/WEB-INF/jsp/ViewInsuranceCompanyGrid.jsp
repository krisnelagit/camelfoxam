<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewInsuranceCompanyGrid
    Created on : 07-Jul-2015, 17:59:07
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Insurance Company</title>
        <script src="js/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui_1.css">
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                //popup for Edit followup details
                $("#dialognkEditDetail").hide();
                //on click of edit
                $(".edit_Link").click(function (e) {
                    e.preventDefault();
                    var insruancecompanyid = $(this).attr('href');
                    $("#insuranceids").val('');
                    $("#editcompanyname").text('');
                    $.ajax({
                        url: "getInsuranceCompanyDetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            insruancecompanyid: insruancecompanyid
                        },
                        cache: false,
                        success: function (data) {
                            $("#insuranceids").val(data[0].id);
                            $("#editcompanyname").val(data[0].name);
                            //required validations here
                            $("#editcompanyname").prop("required", true);
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

                //popup for addng Company begin here
                $("#dialognk").hide();
                //on click of create
                $(".create_link").click(function (e) {
                    e.preventDefault();
                    $("#companyname").text('');
                    $("#companyname").prop("required", true);
                    $("#dialognk").dialog({
                        modal: true,
                        effect: 'drop'
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
                        data: {id: id, deskname: "insurance_company"
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
        <h2>View Insurance Company</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>ID.</td>
                    <td>Name</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${companyListDt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left">
                            <a href="${ob.id}" class="edit_Link"><img src="images/edit.png" alt="" width="14" height="16" title="Edit Company"/></a> &nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a>
                        </td>
                    </tr>
                </c:forEach>
                <c:set value="${count+1}" var="count"></c:set>
            </tbody>
        </table>

        <!--create Insurance company popup begin here-->
        <div id="dialognk" title="Add Insurance Company">
            <form method="POST" action="addInsuranceCompany">
                <table width="100%" cellpadding="5">
                    <tr>
                        <td width="34%" align="left" valign="top">Name</td>
                        <td width="66%" align="left" valign="top"><input type="text" name="name" id="companyname" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">&nbsp;</td>
                        <td width="66%" align="left" valign="top"><input type="submit" value="Save" class="view3" style="cursor: pointer" /></td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </form>
        </div>
        <!--create insurance company poup end here-->

        <!--edit Insurance company popup begin here-->
        <div id="dialognkEditDetail" title="Add Insurance Company">
            <form method="POST" action="updateInsuranceCompany">
                <input type="hidden" name="id" value="" id="insuranceids" />
                <table width="100%" cellpadding="5">
                    <tr>
                        <td width="34%" align="left" valign="top">Name</td>
                        <td width="66%" align="left" valign="top"><input type="text" name="name" id="editcompanyname" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">&nbsp;</td>
                        <td width="66%" align="left" valign="top"><input type="submit" value="Save" class="view3" style="cursor: pointer" /></td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </form>
        </div>
        <!--edit insurance company poup end here-->
    </body>
</html>
