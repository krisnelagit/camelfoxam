<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddLedger
    Created on : 05-Jun-2015, 17:36:54
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Ledger</title>             
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>        
        <script>
            $(document).ready(function () {
                //popup for addng category begin here
                $("#dialog").hide();

                //on click of this comes up he popup
                $(".email_link").click(function (e) {
                    e.preventDefault();
                    $("#message").html("");
                    $("#dialog").dialog({
                        modal: true
                    });
                });

                //on dialog form submit insert via ajax popup
                $('#ibutton').click(function (e) {
                    e.preventDefault();
                    var ajaxdata = $(".groupname").val();
                    if ($('.groupname').val() != '') {
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
                                    $(".groupname").val('');

                                    $("#message").html("");
                                    $.ajax({
                                        url: "ajaxGetLedgerGroups",
                                        dataType: 'json',
                                        type: 'POST',
                                        data: {
                                            name: ajaxdata
                                        },
                                        cache: false,
                                        success: function (data) {
                                            if (data)
                                            {
                                                $('#allGroups').find('option').remove();
                                                $('#allGroups').append('<option value="" selected disabled>--select--</option>');
                                                for (var i = 0; i < data.length; i++) {
                                                    $('#allGroups').append('<option value="' + data[i].id + '">' + data[i].name + '</option>');
                                                }
                                            }
                                        }
                                    });
                                    $("#dialog").dialog("close");
                                    alert(ajaxdata + " Group Added");
                                }
                            }
                        });
                    } else {
                        alert("Please enter group name");
                    }
                });
            });
        </script>
    </head>
    <body>
        <a href="ledgerMasterLink" class="view">Back</a>
        <h2>Add Ledger</h2>
        <br />
        <form action="addLedgerAccount" method="POST">
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Group </td>
                    <td width="66%" align="left" valign="top">
                        <select required="" name="ledgergroupid" id="allGroups">
                            <option value="" selected disabled>--select--</option>
                            <c:forEach var="oa" items="${ledgergroupdtls}">
                                <option value="${oa.id}">${oa.name}</option>
                            </c:forEach>
                        </select>
                        <a href="addLedgerGroupPopup" class="email_link"><img src="images/addh.png" alt="Delete" height="15" width="15" >Add</a>
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Ledger Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" required name="accountname" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Ledger type</td>
                    <td width="66%" align="left" valign="top">
                        <select name="ledger_type">
                            <option value="income">income</option>
                            <option value="expense">expense</option>
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
    </body>
</html>
