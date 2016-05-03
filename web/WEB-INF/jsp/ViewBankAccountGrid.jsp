<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewBankAccountGrid
    Created on : 05-Jun-2015, 17:17:35
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Bank A/C</title>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                //popup for Edit followup details
                $("#dialognkEditDetail").hide();
                //on click of edit
                $(".edit_BankAccount").click(function (e) {
                    e.preventDefault();
                    var baid = $(this).attr('href');
                    $("#bankid").text('');
                    $("#bankname").text('');
                    $("#accountnumber").text('');
                    $("#openingbalance").text('');
                    $("#contactperson").text('');
                    $("#newaddress").text('');
                    $.ajax({
                        url: "getBankAccountDetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            bankid: baid
                        },
                        cache: false,
                        success: function (data) {
                            $("#bankid").val(data[0].id);
                            $("#bankname").val(data[0].bank_name);
                            $("#accountnumber").val(data[0].account_number);
                            $("#openingbalance").val(data[0].opening_balance);
                            $("#contactperson").val(data[0].contactperson);
                            $("#newaddress").val(data[0].address);

                            //required validations here

                            $("#bankname").prop("required", true);

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
                //popup for create bank account begin here
                $("#dialognk").hide();
                //on click of create
                $(".create_bankAccount").click(function (e) {
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
                    $("#bank_name").prop("required", true);
                });
                //popup for create bank account end! here
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
                        data: {id: id, deskname: "bank_account"
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
        <a href="#" class="view create_bankAccount">Create</a>
        <h2>Bank Accounts</h2>
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
                <c:forEach var="ob" items="${bankdt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.id}</td>
                        <td align="left">${ob.bank_name}</td>
                        <td align="left"><a class="edit_BankAccount" href="${ob.id}"><img src="images/edit.png" width="16" height="15"></a>&nbsp;&nbsp;<a onclick="confirmdelete('${ob.id}', this);"><img src="images/delete.png" width="16" height="17" /></a></td>
                    </tr>  
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach>                
            </tbody>
        </table>
        <!--add bank account dialog begin here-->
        <div id="dialognk" title="New Bank Account">
            <form method="POST" action="insertBankAccount">
                <table cellpadding="5" width="100%">
                    <tbody>
                        <tr>
                            <td align="left" valign="top" width="25%">Bank name</td>
                            <td align="left" valign="top" width="75%">
                                <input name="bank_name" id="bank_name" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text">
                            </td>
                        </tr>                        
                        <tr>
                            <td align="left" valign="top" width="25%">Bank A/c number</td>
                            <td align="left" valign="top" width="75%">
                                <input name="account_number" id="account_number" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text">
                            </td>
                        </tr>                        
                        <tr>
                            <td align="left" valign="top" width="25%">Opening balance</td>
                            <td align="left" valign="top" width="75%">
                                <input name="opening_balance" id="opening_balance" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Contact person</td>
                            <td align="left" valign="top" width="75%">
                                <input name="contactperson" id="contact_person" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Address</td>
                            <td align="left" valign="top" width="75%">
                                <textarea name="address" id="new_address" rows="4" cols="20">
                                </textarea>
                            </td>
                        </tr>                        
                        <tr>
                            <td align="left" valign="top" width="25%">&nbsp;</td>
                            <td align="left" valign="top" width="75%"><input type="submit" class="view3" value="Save" style="cursor: pointer" /></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <!--add bank account dialog end here!-->

        <!--edit bank account detail dialog begin here-->
        <div id="dialognkEditDetail" title="Edit Bank Account">
            <form method="POST" action="editbankAccount">
                <input type="hidden" name="id" id="bankid" />
                <table cellpadding="5" width="100%">
                    <tbody>
                        <tr>
                            <td align="left" valign="top" width="25%">Bank name</td>
                            <td align="left" valign="top" width="75%">
                                <input name="bank_name" id="bankname" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Bank A/c number</td>
                            <td align="left" valign="top" width="75%">
                                <input name="account_number" id="accountnumber" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Opening balance</td>
                            <td align="left" valign="top" width="75%">
                                <input name="opening_balance" id="openingbalance" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Contact person</td>
                            <td align="left" valign="top" width="75%">
                                <input name="contactperson" id="contactperson" pattern=".{3,20}" title="3 to 20 characters max name allowed" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="25%">Address</td>
                            <td align="left" valign="top" width="75%">
                                <textarea name="address" id="newaddress" rows="4" cols="20">
                                </textarea>
                            </td>
                        </tr>     
                        <tr>
                            <td align="left" valign="top" width="25%">&nbsp;</td>
                            <td align="left" valign="top" width="75%"><input type="submit" class="view3" value="Save" style="cursor: pointer" /></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <!--edit bank account detail dialog end here!-->
    </body>
</html>
