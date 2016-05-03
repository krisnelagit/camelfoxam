<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewPaymentDetails
    Created on : 08-Jun-2015, 17:57:33
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Payment Details</title>             
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>

            $(document).ready(function () {

                $("#mode").trigger("change");

                $(function () {

                    //payment mode slectiion code begin here start!
                    $("#mode").change(function () {
                        if ($("#mode").val() === "Cheque") {
                            $("#bank").show();
                            $("#online").hide();
                            $("#banknames").prop("required", true);
                            $("#chequeno").prop("required", true);
                            $("#chequedt").prop("required", true);

                            $("#transactionno").prop("required", false);
                            $("#transactiondt").prop("required", false);
                        }

                        if ($("#mode").val() === "Online") {
                            $("#online").show();
                            $("#bank").hide();
                            $("#transactionno").prop("required", true);
                            $("#transactiondt").prop("required", true);

                            $("#banknames").prop("required", false);
                            $("#chequeno").prop("required", false);
                            $("#chequedt").prop("required", false);
                        }

                        if ($("#mode").val() === "Cash") {
                            $("#bank").hide();
                            $("#online").hide();

                            $("#banknames").prop("required", false);
                            $("#chequeno").prop("required", false);
                            $("#chequedt").prop("required", false);
                            $("#transactionno").prop("required", false);
                            $("#transactiondt").prop("required", false);
                        }
                    });
                    //payment mode coding end!
                });
            });
        </script>
        
        <script>
            $(function () {
                $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
                var currentDate = new Date();
                $(".datepicker").datepicker("setDate", currentDate);
            });
        </script>
    </head>
    <body>
        <a href="VendorPaymentGridLink" class="view">Back</a>
        <h2>Payment details</h2>
        <br />
        <form action="updateVendorPaymentExpense" method="POST">
            <input type="hidden" name="id" value="${expensedtls.id}" />
            <input type="hidden" name="oldmode" value="${expensedtls.mode}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Purchase Order No.</td>
                    <td width="66%" align="left" valign="top">${expensedtls.purchaseorderid}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">To</td>
                    <td width="66%" align="left" valign="top">${expensedtls.towards}</td>
                </tr>
                <tr class="total">
                    <td width="34%" align="left" valign="top">Total (Rs.)</td>
                    <td width="66%" align="left" valign="top">${expensedtls.total}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Payment mode</td>
                    <td width="66%" align="left" valign="top">
                        <select name="mode" id="mode" required="">
                            <c:choose>
                                <c:when test="${expensedtls.mode=='Cheque'}">
                                    <option value="Cash">Cash</option>
                                    <option value="Cheque" selected>Cheque</option>
                                    <option value="Online">Online</option>
                                </c:when>
                                <c:when test="${expensedtls.mode=='Online'}">
                                    <option value="Cash">Cash</option>
                                    <option value="Cheque" >Cheque</option>
                                    <option value="Online" selected>Online</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="Cash" selected>Cash</option>
                                    <option value="Cheque" >Cheque</option>
                                    <option value="Online" >Online</option>
                                </c:otherwise>
                            </c:choose>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Narration</td>
                    <td width="66%" align="left" valign="top">
                        <textarea name="narration" rows="4" cols="20">${expensedtls.narration}
                        </textarea>
                    </td>
                </tr>
            </table>
            <c:choose>
                <c:when test="${expensedtls.mode=='Cash'}">

                    <script>
                        $(document).ready(function () {
                            $("#bank").hide();
                            $("#online").hide();
                        });
                    </script>
                    <table id="bank"  width="100%" cellpadding="5">
                        <tr>
                            <td width="34%" align="left" valign="top">Bank name</td>
                            <td width="66%" align="left" valign="top"><input type="text" value="${expensedtls.bankname}" pattern="^[a-zA-Z]*$" title="Please enter a valid Bank name." name="bankname" id="banknames" /></td>
                        </tr>
                        <tr>
                            <td width="34%" align="left" valign="top">Cheque no.</td>
                            <td width="66%" align="left" valign="top"><input type="text" value="${expensedtls.chequenumber}"  name="chequenumber" id="chequeno" /></td>
                        </tr>
                        <tr>
                            <td width="34%" align="left" valign="top">Cheque date</td>
                            <td width="66%" align="left" valign="top">
                                <!--<input type="text" name="chequedate" class="datepicker" id="textfield2" />-->
                                <input  class="datepicker" type="text" value="${expensedtls.chequedate}" name="chequedate" id="chequedt" />
                            </td>
                        </tr>
                    </table>
                    <table id="online"  width="100%" cellpadding="5">
                        <tr>
                            <td width="34%" align="left" valign="top">Transaction no.</td>
                            <td width="66%" align="left" valign="top"><input type="text" name="transactionnumber" id="transactionno" /></td>
                        </tr>
                        <tr>
                            <td width="34%" align="left" valign="top">Transaction date</td>
                            <td width="66%" align="left" valign="top"><input type="text" name="transactiondate" class="datepicker" id="transactiondt" /></td>
                        </tr>
                    </table>
                </c:when>
                <c:when test="${expensedtls.mode=='Cheque'}">
                    <table id="bank"  width="100%" cellpadding="5">
                        <tr>
                            <td width="34%" align="left" valign="top">Bank name</td>
                            <td width="66%" align="left" valign="top"><input type="text" value="${expensedtls.bankname}" pattern="^[a-zA-Z]*$" title="Please enter a valid Bank name." name="bankname" id="banknames" /></td>
                        </tr>
                        <tr>
                            <td width="34%" align="left" valign="top">Cheque no.</td>
                            <td width="66%" align="left" valign="top"><input type="text" value="${expensedtls.chequenumber}"  name="chequenumber" id="chequeno" /></td>
                        </tr>
                        <tr>
                            <td width="34%" align="left" valign="top">Cheque date</td>
                            <td width="66%" align="left" valign="top">
                                <!--<input type="text" name="chequedate" class="datepicker" id="textfield2" />-->
                                <input  class="datepicker" type="text" value="${expensedtls.chequedate}" name="chequedate" id="chequedt" />
                            </td>
                        </tr>
                    </table>
                    <script>
                        $(document).ready(function () {
                            $("#online").hide();
                        });
                    </script>
                    <table id="online"  width="100%" cellpadding="5">
                        <tr>
                            <td width="34%" align="left" valign="top">Transaction no.</td>
                            <td width="66%" align="left" valign="top"><input type="text" name="transactionnumber" id="transactionno" /></td>
                        </tr>
                        <tr>
                            <td width="34%" align="left" valign="top">Transaction date</td>
                            <td width="66%" align="left" valign="top"><input type="text" name="transactiondate" class="datepicker" id="transactiondt" /></td>
                        </tr>
                    </table>
                </c:when>
                <c:when test="${expensedtls.mode=='Online'}">
                    <table id="online"  width="100%" cellpadding="5">
                        <tr>
                            <td width="34%" align="left" valign="top">Transaction no.</td>
                            <td width="66%" align="left" valign="top"><input type="text" value="${expensedtls.transactionnumber}"  name="transactionnumber" id="transactionno" /></td>
                        </tr>
                        <tr>
                            <td width="34%" align="left" valign="top">Transaction date</td>
                            <td width="66%" align="left" valign="top"><input type="text" value="${expensedtls.transactiondate}" name="transactiondate" class="datepicker" id="transactiondt" /></td>
                        </tr>
                    </table>
                    <script>
                        $(document).ready(function () {
                            $("#bank").hide();
                        });
                    </script>
                    <table id="bank"  width="100%" cellpadding="5">
                        <tr>
                            <td width="34%" align="left" valign="top">Bank name</td>
                            <td width="66%" align="left" valign="top"><input type="text" name="bankname" id="banknames" /></td>
                        </tr>
                        <tr>
                            <td width="34%" align="left" valign="top">Cheque no.</td>
                            <td width="66%" align="left" valign="top"><input type="text" name="chequenumber" id="chequeno" /></td>
                        </tr>
                        <tr>
                            <td width="34%" align="left" valign="top">Cheque date</td>
                            <td width="66%" align="left" valign="top">
                                <input  class="datepicker" type="text" name="chequedate" id="chequedt" />
                            </td>
                        </tr>
                    </table>
                </c:when>
            </c:choose>

            <table  width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">&nbsp;</td>
                    <td width="66%" align="left" valign="top"><input type="submit" value="Update" class="view3" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <br>
        </form>
    </body>
</html>
