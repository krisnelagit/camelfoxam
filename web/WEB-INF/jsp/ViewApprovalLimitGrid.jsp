<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewApprovalLimitGrid
    Created on : 05-Jun-2015, 13:11:49
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Approval Limit</title>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <script src="js/jquery.dataTables.js"></script>             
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();

                //popup for addng category begin here
                $("#dialognk").hide();
                //on click of edit
                $(".email_link").click(function (e) {
                    e.preventDefault();
                    var lalid = $(this).attr('href');
                    $(".limitid").val('');
                    $(".limitname").val('');
                    $(".limitamount").val('');
                    $("#message").html("");
                    $.ajax({
                        url: "getApprovalLimitDetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            limitid: lalid
                        },
                        cache: false,
                        success: function (data) {
                            if (data) {
                                $(".limitid").val(data[0].id);
                                $(".limitname").val(data[0].name);
                                $(".limitamount").val(data[0].amount);

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
                            }

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
                        data: {id: id, deskname: "approvallimit"
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
        <!--<a href="approvalLimitCreateLink" class="view">Create</a>-->
        <h2>Approval Limit</h2>
        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td>ID.</td>
                    <td>Name</td>
                    <td>Amount</td>
                    <td>&nbsp;</td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${limitdt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left">${ob.amount}</td>
                        <td align="left"><a class="email_link" href="${ob.id}"><img src="images/edit.png" width="16" height="15"></a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a></td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>

        <div id="dialognk" title="Approval edit">
            <form action="editApprovalLimit" method="POST">
                <input type="hidden" name="id" class="limitid" value="" />
                <table width="100%" cellpadding="5">
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Limit Name&nbsp;&nbsp;</td>
                        <td width="66%" align="left" valign="top"><input readonly="" type="text" name="name" class="limitname" id="textfield2" /></td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Amount(Rs.)&nbsp;&nbsp;</td>
                        <td width="66%" align="left" valign="top"><input type="text" required="" pattern="[0-9]+(\.[0-9][0-9]?)?" title="Please enter a valid amount" name="amount" maxlength="15"  class="limitamount" id="textfield2" /></td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" id="ibutton" value="Save" class="view3" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
                    </tr> 
                </table>
                <br><font face="verdana" size="2"><div id="message"></div></font>
                <br>
            </form>
        </div>
    </body>
</html>
