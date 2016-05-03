<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditLedger
    Created on : 05-Jun-2015, 18:39:01
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Ledger</title>           
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
        <h2>Edit Ledger</h2>
        <br />
        <form action="updateLedgerAccount" method="POST">
            <input type="hidden" name="id" value="${editLedgerDtls.id}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Group </td>
                    <td width="66%" align="left" valign="top">
                        <select name="ledgergroupid" id="allGroups">
                            <option value="" selected disabled>--select--</option>
                            <c:forEach var="oa" items="${ledgergroupdtls}">
                                <c:choose>
                                    <c:when test="${oa.id==editLedgerDtls.ledgergroupid}">
                                        <option value="${oa.id}" selected="">${oa.name}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${oa.id}">${oa.name}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                        <a href="addLedgerGroupPopup" class="email_link"><img src="images/addh.png" alt="Delete" height="15" width="15" >Add</a>
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Ledger Name</td>
                    <td width="66%" align="left" valign="top"><input type="text" required name="accountname" value="${editLedgerDtls.accountname}" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Ledger type</td>
                    <td width="66%" align="left" valign="top">
                        <select name="ledger_type">
                            <c:choose>
                                <c:when test="${editLedgerDtls.ledger_type=='income'}">
                                    <option value="income" selected="">income</option>
                                    <option value="expense">expense</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="income">income</option>
                                    <option value="expense" selected="">expense</option>
                                </c:otherwise>
                            </c:choose>
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
                        <td><input type="submit" id="ibutton" value="Save" class="btn btn-success" />&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <tr>    
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br><font face="verdana" size="2"><div id="message"></div></font>
                <br>
            </form>
        </div>
    </body>
</html>
