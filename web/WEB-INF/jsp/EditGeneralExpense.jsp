<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditGeneralExpense
    Created on : 08-Jun-2015, 17:57:33
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit General Expense</title>             
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>

            $(document).ready(function () {

                

                var ledger;
                $(function () {

                    ledger = [
            <c:forEach var="oa" items="${ledgerdtls}">
                        {value: "${oa.id}", label: "${oa.accountname}"},
            </c:forEach>
                    ];

                    var source = [];
                    var mapping = {};
                    for (var i = 0; i < ledger.length; i++) {
                        source.push(ledger[i].label);
                        mapping[ledger[i].label] = ledger[i].value;
                    }
                    $("#tags").autocomplete({
                        source: source,
                        select: function (event, ui) {
                            $("#ledgerid").val(mapping[ui.item.value]);
                        },
                        change: function () {
                            var val = $(this).val();
                            var exist = $.inArray(val, source);
                            if (exist < 0) {
                                $(this).val("");
                                return false;
                            }
                        }
                    });


                    //payment mode slectiion code begin here start!
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
                            $("#chequedt").prop("required", false);
                            $("#carddetails").prop("required", false);
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
                $("#mode").trigger("change");
            });
            //give grand total
//            function getGrandTotal() {
//                var taxpercent = $('#taxpercent').val()
//                var amount = $("#amount").val();
//                var taxamount = Number(taxpercent / 100) * Number(amount);
//                var mytotal = Number(amount) + Number(taxamount);
//                $('#total').val(mytotal.toFixed(2));
//            }
        </script>
        <script>
            //give grand total & tax coding start! here
            function getGrandTotal() {
                var taxapplied = $('#tax_applicable').val();
                if (taxapplied === 'N/A') {
                    $('.tax').hide();
                    $('.taxamount').hide();
                    $('.total').hide();
                    var settotal = $('#amount').val();
                    $('#total').val(settotal);

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

            $(function () {
                $("#accordion").accordion();
            });
        </script>
    </head>
    <body>
        <a href="viewGeneralExpenseDetails?expenseid=${param.expenseid}" class="view">Back</a>
        <h2>Edit General Expenses</h2>
        <br />
        <form action="editGeneralExpense" method="POST">
            <input type="hidden" name="id" value="${expensedtls.id}" />
            <input type="hidden" name="oldmode" value="${expensedtls.mode}" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td align="left" valign="top" valign="top">Date</td>
                    <td align="left" valign="top" valign="top">
                        <input type="text" required="" name="expense_date" value="${expensedtls.expense_date}" class="datepicker" id="textfield2" />
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Ledger Name</td>
                    <td width="66%" align="left" valign="top">
                        <select name="ledgerid">
                            <c:forEach var="ld" items="${ledgerdtls}">
                                <c:choose>
                                    <c:when test="${ld.id==expensedtls.ledgerid}">
                                        <option value="${ld.id}" selected="">${ld.accountname}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${ld.id}">${ld.accountname}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Account</td>
                    <td width="66%" align="left" valign="top">
                        <select name="bank_accountid">
                            <c:forEach var="ld" items="${bankdtls}">
                                <c:choose>
                                    <c:when test="${ld.id==expensedtls.bank_accountid}">
                                        <option value="${ld.id}" selected="">${ld.bank_name}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${ld.id}">${ld.bank_name}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top" valign="top">Tax Applicable</td>
                    <td align="left" valign="top" valign="top">
                        <select name="tax_applicable" id="tax_applicable" onchange="getGrandTotal()">
                            <c:choose>
                                <c:when test="${expensedtls.tax_applicable=='N/A'}">
                                    <option value="N/A" selected="">N/A</option>
                                    <option value="normal">normal</option>
                                    <option value="reverse">reverse</option>
                                </c:when>
                                <c:when test="${expensedtls.tax_applicable=='normal'}">
                                    <option value="N/A">N/A</option>
                                    <option value="normal" selected="">normal</option>
                                    <option value="reverse">reverse</option>
                                </c:when>
                                <c:when test="${expensedtls.tax_applicable=='reverse'}">
                                    <option value="N/A">N/A</option>
                                    <option value="normal">normal</option>
                                    <option value="reverse" selected="">reverse</option>
                                </c:when>
                            </c:choose>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">To</td>
                    <td width="66%" align="left" valign="top"><input type="text" value="${expensedtls.towards}" maxlength="40" required name="towards" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Amount</td>
                    <td width="66%" align="left" valign="top"><input type="number" step="0.01" max="99999999.99"  onclick="getGrandTotal()" onchange="getGrandTotal()" required name="amount" value="${expensedtls.amount}" id="amount" /></td>
                </tr>
                <tr class="tax">
                    <td width="34%" align="left" valign="top">Tax</td>
                    <td width="66%" align="left" valign="top">
                        <select name="taxdetails" onchange="getGrandTotal()" id="taxdetails" required="">
                            <c:forEach var="ob" items="${taxdtls}">
                                <c:choose>
                                    <c:when test="${expensedtls.taxid==ob.id}">
                                        <option value="${ob.id},${ob.percent}" selected="">${ob.name} (${ob.percent}%)</option>    
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${ob.id},${ob.percent}">${ob.name} (${ob.percent}%)</option>    
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select> 
                        <input type="hidden" name="taxid" id="taxpk" value="${expensedtls.taxid}" /> 
                        <input type="hidden" name="tax" id="taxpercent" value="${expensedtls.tax}" /> 
                    </td>
                </tr>
                <tr class="taxamount">
                    <td width="34%" align="left" valign="top">Tax amount(Rs.)</td>
                    <td width="66%" align="left" valign="top">
                        <c:choose>
                            <c:when test="${expensedtls.taxid=='ATX1'}">
                                <input type="text" readonly="" name="tax_amount" id="taxamount" value="${expensedtls.vat_tax}" />
                                <input type="hidden" readonly="" name="vattax" id="vattax" value="0" />
                                <input type="hidden" readonly="" name="servicetax" id="servicetax" value="0" />
                            </c:when>
                            <c:when test="${expensedtls.taxid=='ATX2'}">
                                <input type="text" readonly="" name="tax_amount" id="taxamount" value="${expensedtls.service_tax}" />
                                <input type="hidden" readonly="" name="vattax" id="vattax" value="0" />
                                <input type="hidden" readonly="" name="servicetax" id="servicetax" value="0" />
                            </c:when>
                            <c:when test="${expensedtls.taxid=='ATX3'}">
                                <input type="text" readonly="" name="tax_amount" id="taxamount" value="0" />
                                <input type="hidden" readonly="" name="vattax" id="vattax" value="0" />
                                <input type="hidden" readonly="" name="servicetax" id="servicetax" value="0" />
                            </c:when>
                            <c:when test="${expensedtls.taxid=='ATX4'}">
                                <input type="text" readonly="" name="tax_amount" id="taxamount" value="${expensedtls.vat_service_tax}" />
                                <input type="hidden" readonly="" name="vattax" id="vattax" value="0" />
                                <input type="hidden" readonly="" name="servicetax" id="servicetax" value="0" />
                            </c:when>
                        </c:choose>
                    </td>
                </tr>
                <tr class="total">
                    <td width="34%" align="left" valign="top">Total (Rs.)</td>
                    <td width="66%" align="left" valign="top"><input type="text" readonly="" name="total" id="total" value="${expensedtls.total}" /></td>
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
                                    <option value="Card">Card</option>
                                </c:when>
                                <c:when test="${expensedtls.mode=='Online'}">
                                    <option value="Cash">Cash</option>
                                    <option value="Cheque" >Cheque</option>
                                    <option value="Online" selected>Online</option>
                                    <option value="Card">Card</option>
                                </c:when>
                                <c:when test="${expensedtls.mode=='Card'}">
                                    <option value="Cash">Cash</option>
                                    <option value="Cheque" >Cheque</option>
                                    <option value="Online">Online</option>
                                    <option value="Card" selected>Card</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="Cash" selected>Cash</option>
                                    <option value="Cheque" >Cheque</option>
                                    <option value="Online" >Online</option>
                                    <option value="Card">Card</option>
                                </c:otherwise>
                            </c:choose>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Purchase Order/Invoice No.</td>
                    <td width="66%" align="left" valign="top"><input type="text" maxlength="10" name="purchaseorderid" value="${expensedtls.purchaseorderid}" id="textfield2" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Voucher No.</td>
                    <td width="66%" align="left" valign="top"><input type="text" maxlength="10" name="vouchernumber" id="textfield2" value="${expensedtls.vouchernumber}" /></td>
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
                            $("#card").hide();
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

                    <table id="card"  width="100%" cellpadding="5">
                        <tr>
                            <td width="34%" align="left" valign="top">Details</td>
                            <td width="66%" align="left" valign="top"><textarea name="carddetails" rows="4" maxlength="600" cols="20" id="carddetails"></textarea></td>
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
                            $("#card").hide();
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

                    <table id="card"  width="100%" cellpadding="5">
                        <tr>
                            <td width="34%" align="left" valign="top">Details</td>
                            <td width="66%" align="left" valign="top"><textarea name="carddetails" rows="4" maxlength="600" cols="20" id="carddetails"></textarea></td>
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
                            $("#card").hide();
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

                    <table id="card"  width="100%" cellpadding="5">
                        <tr>
                            <td width="34%" align="left" valign="top">Details</td>
                            <td width="66%" align="left" valign="top"><textarea name="carddetails" rows="4" maxlength="600" cols="20" id="carddetails"></textarea></td>
                        </tr>
                    </table>
                </c:when>
                <c:when test="${expensedtls.mode=='Card'}">
                    <script>
                        $(document).ready(function () {
                            $("#online").hide();
                            $("#bank").hide();
                        });
                    </script>

                    <table id="card"  width="100%" cellpadding="5">
                        <tr>
                            <td width="34%" align="left" valign="top">Details</td>
                            <td width="66%" align="left" valign="top"><textarea name="carddetails" rows="4" maxlength="600" cols="20" id="carddetails">${expensedtls.carddetails}</textarea></td>
                        </tr>
                    </table>
                    <table id="online"  width="100%" cellpadding="5">
                        <tr>
                            <td width="34%" align="left" valign="top">Transaction no.</td>
                            <td width="66%" align="left" valign="top"><input type="text" value=""  name="transactionnumber" id="transactionno" /></td>
                        </tr>
                        <tr>
                            <td width="34%" align="left" valign="top">Transaction date</td>
                            <td width="66%" align="left" valign="top"><input type="text" value="" name="transactiondate" class="datepicker" id="transactiondt" /></td>
                        </tr>
                    </table>
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
                    <td width="66%" align="left" valign="top"><input type="submit" value="Update" onclick="getGrandTotal()" class="view3" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <br>
        </form>
    </body>
</html>
