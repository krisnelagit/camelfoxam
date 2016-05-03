<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewLedgersGroupGrid
    Created on : 05-Jun-2015, 17:17:35
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Ledgers</title>      
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                //popup for Edit followup details
                $("#dialognkEditDetail").hide();
                //on click of edit
                $(".edit_email_link").click(function (e) {
                    e.preventDefault();
                    var fsid = $(this).attr('href');
                    $("#brid").val('');
                    $("#brandname").text('');
                    $.ajax({
                        url: "editledgergroupLink",
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
                //hiding create group dialog 
                $("#dialog").hide();

                //on click of this comes up he popup
                $(".email_link").click(function (e) {
                    e.preventDefault();
                    $("#message").html("");
                    $("#dialog").dialog({
                        modal: true
                    });
                });

                //on dialog form submit insert via ajax popup begins here
                $('#ibutton').click(function (e) {
                    e.preventDefault();
                    var ajaxdata = $(".groupname").val();
                    if ($('.groupname').val() !== '') {
                        $.ajax({
                            url: "saveLedgerGroup",
                            //type: "post",
                            data: {
                                name: ajaxdata
                            },
                            cache: false,
                            success: function (data) {
                                if (data === "error") {
                                    $("#message").html("Oops this Group already exist!").slideDown('slow');
                                } else {
                                    window.location.href = "ledgerGroupMasterLink";
//                                    $("#redirectgroup").click();
                                }
                            }
                        });
                    } else {
                        alert("Please enter group name");
                    }
                });
                
                //on dialog form submit insert via ajax popup ends! here

                $('#table_id').DataTable();
            });
        </script>
        <script>
            function confirmdelete(id, ob)
            {
                var res = confirm('Are you sure to delete?');
                if (res === true)
                {
                    $(ob).closest('tr').find('td').fadeOut(600,
                            function () {
                                $(ob).parents('tr:first').remove();
                            });

                    $.ajax({
                        type: "post",
                        url: "deleterecord",
                        data: {id: id, deskname: "ledgergroup"
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
        <a href="addLedgerGroupPopup" class="view email_link">Create</a>
        <a href="ledgerGroupMasterLink" id="redirectgroup"></a>
        <h2>Ledgers Group</h2>
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
                <c:forEach var="ob" items="${groupdt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.name}</td>
                        <td align="left"><a class="edit_email_link" title="Edit group name" href="${ob.id}"><img src="images/edit.png" width="16" height="15"></a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a></td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>
            </tbody>
        </table>


        <!--Dialog For add new group begin here-->
        <div id="dialog" title="Group Create">
            <form action="addLedgerGroup" method="POST">
                <table width="100%" cellpadding="5">
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="34%" align="left" valign="top">Name &nbsp;&nbsp;</td>
                        <td width="66%" align="left" valign="top"><input type="text" name="name" class="groupname" id="textfield2" /></td>
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
        <!--Dialog For add new group ends! here-->
        
        <!--edit group dialog here-->
        <div id="dialognkEditDetail" title="Edit Group">
            <form action="updateLedgerGroup" method="POST">        
                <table width="100%" cellpadding="5">
                    <tr>
                    <input type="hidden" name="id" id="brid" value="" />
                    <td width="34%" align="left" valign="top">Group Name</td>
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
        <!--edit group dialog here-->
    </body>
</html>
