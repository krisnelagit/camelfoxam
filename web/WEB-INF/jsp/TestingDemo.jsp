<%-- 
    Document   : TestingDemo
    Created on : 09-Jun-2015, 13:00:36
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>jQuery UI Datepicker - Default functionality</title>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
$(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
                        $(".datepicker").datepicker("option", "showAnim", 'drop');

                //payment mode slectiion code begin here start!
                $("#bank").hide();
                $("#online").hide();
                $("#mode").change(function () {

                    if ($("#mode").val() === "Cheque") {
                        $("#bank").show();
                        $("#online").hide();
                        $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
                        $(".datepicker").datepicker("option", "showAnim", 'drop');
                    }

                    if ($("#mode").val() === "Online") {
                        $("#online").show();
                        $("#bank").hide();
                        $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
                        $(".datepicker").datepicker("option", "showAnim", 'drop');
                    }

                    if ($("#mode").val() === "Cash") {
                        $("#bank").hide();
                        $("#online").hide();
                    }
                });
                //payment mode coding end!
            });
        </script>
    </head>
    <body>

        <p>Date: <input type="text" class="datepicker"></p>

        <select name="mode" id="mode" required="">
            <option value="Cash" selected >Cash</option>
            <option value="Cheque">Cheque</option>
            <option value="Online">Online</option>
        </select> 
        <table id="bank"  width="100%" cellpadding="5">
            <tr>
                <td width="34%" align="left" valign="top">Bank name</td>
                <td width="66%" align="left" valign="top"><input type="text" required name="bankname" id="textfield2" /></td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Cheque no.</td>
                <td width="66%" align="left" valign="top"><input type="text" required name="chequenumber" id="textfield2" /></td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Cheque date</td>
                <td width="66%" align="left" valign="top">
                    <!--<input type="text" name="chequedate" class="datepicker" id="textfield2" />-->
                    <input required class="datepicker" type="text" name="chequedate" id="textfield2" />
                </td>
            </tr>
        </table>
        <table id="online"  width="100%" cellpadding="5">
            <tr>
                <td width="34%" align="left" valign="top">Transaction no.</td>
                <td width="66%" align="left" valign="top"><input type="text" required name="transactionnumber" id="textfield2" /></td>
            </tr>
            <tr>
                <td width="34%" align="left" valign="top">Transaction date</td>
                <td width="66%" align="left" valign="top"><input type="text" name="transactiondate" class="datepicker" id="textfield2" /></td>
            </tr>
        </table>


    </body>
</html>
