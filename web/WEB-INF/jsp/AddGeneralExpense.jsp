<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddGeneralExpense
    Created on : 08-Jun-2015, 11:31:32
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add General Expense</title> 
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {
                getGrandTotal();
                $(function () {
                    //payment mode slectiion code begin here start!
                    $("#bank").hide();
                    $("#online").hide();
                    $("#card").hide();
                    $("#mode").change(function () {
                        if ($("#mode").val() === "Cheque") {
                            $("#bank").show();
                            $("#online").hide();
                            $("#card").hide();
                            $("#banknames").prop("required", true);
                            $("#chequeno").prop("required", true);
                            $("#chequedt").prop("required", true);

                            $("#transactionno").prop("required", false);
                            $("#transactiondt").prop("required", false);
                            $("#carddetails").prop("required", false);
                        }

                        if ($("#mode").val() === "Online") {
                            $("#online").show();
                            $("#bank").hide();
                            $("#card").hide();
                            $("#transactionno").prop("required", true);
                            $("#transactiondt").prop("required", true);

                            $("#banknames").prop("required", false);
                            $("#chequeno").prop("required", false);
                            $("#carddetails").prop("required", false);
                            $("#chequedt").prop("required", false);

                        }

                        if ($("#mode").val() === "Cash") {
                            $("#bank").hide();
                            $("#online").hide();
                            $("#card").hide();

                            $("#banknames").prop("required", false);
                            $("#chequeno").prop("required", false);
                            $("#chequedt").prop("required", false);
                            $("#transactionno").prop("required", false);
                            $("#transactiondt").prop("required", false);
                            $("#carddetails").prop("required", false);

                        }

                        if ($("#mode").val() === "Card") {
                            $("#bank").hide();
                            $("#online").hide();
                            $("#card").show();
                            $("#carddetails").prop("required", true);

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
            //give grand total & tax coding start! here
            function getGrandTotal() {
                var taxapplied = $('#tax_applicable').val();
                if (taxapplied === 'N/A') {
                    $('.tax').hide();
                    $('.taxamount').hide();
                    $('.total').hide();
                } else if (taxapplied === 'normal') {
                    $('.tax').show();
                    $('.taxamount').show();
                    $('.total').show();
                    //got tax details here and split foor id and percent
                    var taxdetails = $('#taxdetails').val();
                    var splitvar = taxdetails.split(',');
                    $("#taxpk").val(splitvar[0]);//it gives tax id
                    $("#taxpercent").val(splitvar[1]);//it gives tax percent
                    var amount = $("#amount").val();
                    var taxamount = Number(splitvar[1] / 100) * Number(amount);

                    var mytotal = Number(amount) + Number(taxamount);
                    $('#total').val(mytotal.toFixed(2));
                    $('#taxamount').val(taxamount);

                    //calucaltion if vat+ service tax begin here
                    if (splitvar[0] === 'ATX4') {
                        var optionValues = [];
                        var i = 0;
                        $("#taxdetails option").each(function () {
                            if (i > 1) {
                                return false;
                            }
                            optionValues.push($(this).val());
                            i++;
                        });
                        for (var k = 0; k <= optionValues.length; k++) {
                            //operation performed TO split and save tax appropiately
                            var splitvarb = optionValues[k].split(',');
                            if (splitvarb[0] === 'ATX1') {
                                var taxamount2 = Number(splitvarb[1] / 100) * Number(amount);
                                $('#vattax').val(taxamount2);
                            }
                            if (splitvarb[0] === 'ATX2') {
                                var taxamount2 = Number(splitvarb[1] / 100) * Number(amount);
                                $('#servicetax').val(taxamount2);
                            }
                        }
                    }
                    
                    if (splitvar[0] != 'ATX4') {
                        $('#vattax').val("0");
                        $('#servicetax').val("0");
                    }
                    //calucaltion if vat+ service tax end! here
                } else {
                    $('.tax').show();
                    $('.taxamount').show();
                    $('.total').show();
                    //got tax details here and split foor id and percent
                    var taxdetails = $('#taxdetails').val();
                    var splitvar = taxdetails.split(',');
                    $("#taxpk").val(splitvar[0]);//it gives tax id
                    $("#taxpercent").val(splitvar[1]);//it gives tax percent
                    var amount = $("#amount").val();
                    var taxamount = Number(splitvar[1] / 100) * Number(amount);

                    var mytotal = Number(amount) - Number(taxamount);
                    $('#total').val(mytotal.toFixed(2));
                    $('#taxamount').val(taxamount);

                    //calucaltion if vat+ service tax begin here for reverse
                    if (splitvar[0] === 'ATX4') {
                        var optionValues = [];
                        var i = 0;
                        $("#taxdetails option").each(function () {
                            if (i > 1) {
                                return false;
                            }
                            optionValues.push($(this).val());
                            i++;
                        });
                        for (var k = 0; k <= optionValues.length; k++) {
                            //operation performed TO split and save tax appropiately
                            var splitvarb = optionValues[k].split(',');
                            
                            if (splitvarb[0] === 'ATX1') {
                                var taxamount2 = Number(splitvarb[1] / 100) * Number(amount);
                                $('#vattax').val(taxamount2);
                            }
                            if (splitvarb[0] === 'ATX2') {
                                var taxamount2 = Number(splitvarb[1] / 100) * Number(amount);
                                $('#servicetax').val(taxamount2);
                            }
                        }
                    }
                    if (splitvar[0] != 'ATX4') {
                        $('#vattax').val("0");
                        $('#servicetax').val("0");
                    }
                }

            }
            //give grand total & tax coding end! hee
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
        <a href="generalExpenseLink" class="view">Back</a>
        <h2>Add General Expenses</h2>
        <br />
        <form action="addGeneralExpense" method="POST">
            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top" valign="top">Date</td>
                    <td align="left" valign="top" valign="top">
                        <input type="text" required="" name="expense_date" class="datepicker" id="textfield2" />
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Ledger Name<font color="red">*</font></td>
                    <td width="66%" align="left" valign="top">
                        <select name="ledgerid">
                            <c:forEach var="ld" items="${ledgerdtls}">
                                <option value="${ld.id}">${ld.accountname}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top" valign="top">Account</td>
                    <td align="left" valign="top" valign="top">
                        <select name="bank_accountid">
                            <c:forEach var="ld" items="${bankdtls}">
                                <option value="${ld.id}">${ld.bank_name}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top" valign="top">Tax Applicable</td>
                    <td align="left" valign="top" valign="top">
                        <select name="tax_applicable" id="tax_applicable" onchange="getGrandTotal()">
                            <option value="N/A">N/A</option>
                            <option value="normal">normal</option>
                            <option value="reverse">reverse</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">To<font color="red">*</font></td>
                    <td width="66%" align="left" valign="top"><input type="text" maxlength="40" required name="towards" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Amount<font color="red">*</font></td>
                    <td width="66%" align="left" valign="top"><input type="number" step="0.01" max="99999999.99" onclick="getGrandTotal()" onchange="getGrandTotal()" required name="amount" id="amount" /></td>
                </tr>
                <tr class="tax">
                    <td width="34%" align="left" valign="top">Tax<font color="red">*</font></td>
                    <td width="66%" align="left" valign="top">
                        <select name="taxdetails" onchange="getGrandTotal()" id="taxdetails" required="">
                            <c:forEach var="ob" items="${taxdtls}">
                                <option value="${ob.id},${ob.percent}">${ob.name} (${ob.percent}%)</option>          
                            </c:forEach>
                        </select>
                        <input type="hidden" name="taxid" id="taxpk" value="" />
                        <input type="hidden" name="tax" id="taxpercent" value="" /> 
                    </td>
                </tr>
                <tr class="taxamount">
                    <td width="34%" align="left" valign="top">Tax amount(Rs.)</td>
                    <td width="66%" align="left" valign="top">
                        <input type="text" readonly="" name="tax_amount" id="taxamount" value="" />
                        <input type="hidden" readonly="" name="vattax" id="vattax" value="0" />
                        <input type="hidden" readonly="" name="servicetax" id="servicetax" value="0" />
                    </td>
                </tr>
                <tr class="total">
                    <td width="34%" align="left" valign="top">Total (Rs.)</td>
                    <td width="66%" align="left" valign="top"><input type="text" readonly="" name="total" id="total" value="" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Payment mode<font color="red">*</font></td>
                    <td width="66%" align="left" valign="top">
                        <select name="mode" id="mode" required="">
                            <option value="Cash" selected >Cash</option>
                            <option value="Cheque">Cheque</option>
                            <option value="Online">Online</option>
                            <option value="Card">Card</option>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Purchase Order/Invoice No.</td>
                    <td width="66%" align="left" valign="top"><input type="text" maxlength="10" name="purchaseorderid" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Voucher No.</td>
                    <td width="66%" align="left" valign="top"><input type="text" maxlength="10" name="vouchernumber" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Narration</td>
                    <td width="66%" align="left" valign="top">
                        <textarea name="narration" rows="4" cols="20">
                        </textarea>
                    </td>
                </tr>
            </table>
            <table id="bank"  width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Bank name</td>
                    <td width="66%" align="left" valign="top"><input type="text" pattern="^[a-zA-Z]*$" title="Please enter a valid Bank name." maxlength="30" name="bankname" id="banknames" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Cheque no.</td>
                    <td width="66%" align="left" valign="top"><input type="text" maxlength="10"  name="chequenumber" id="chequeno" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Cheque date</td>
                    <td width="66%" align="left" valign="top">
                        <!--<input type="text" name="chequedate" class="datepicker" id="textfield2" />-->
                        <input  class="datepicker" type="text" name="chequedate" id="chequedt" />
                    </td>
                </tr>
            </table>
            <table id="online"  width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Transaction no.</td>
                    <td width="66%" align="left" valign="top"><input type="text"  name="transactionnumber" maxlength="16" id="transactionno" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Transaction date</td>
                    <td width="66%" align="left" valign="top"><input type="text" name="transactiondate" class="datepicker" id="transactiondt" /></td>
                </tr>
            </table>
            <table id="card"  width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Details</td>
                    <td width="66%" align="left" valign="top"><textarea name="carddetails" rows="4" maxlength="600" cols="20" id="carddetails"></textarea></td>
                </tr>
            </table>
            <table  width="100%" cellpadding="5">
                <tr>    
                    <td width="34%" align="left" valign="top">&nbsp;</td>
                    <td width="66%" align="left" valign="top"><input type="submit" value="Save" class="view3" style="cursor: pointer" />&nbsp;</td>
                </tr>
            </table>
            <br>
        </form>
    </body>
</html>
