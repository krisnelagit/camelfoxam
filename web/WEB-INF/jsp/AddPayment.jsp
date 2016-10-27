<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddPayment
    Created on : 20-Jul-2015, 13:38:27
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Make Payment</title>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(document).ready(function () {
                var currentDate = new Date();
                $(".datepicker").datepicker({
                    dateFormat: 'yy-mm-dd'
                });
                var hedate = $.datepicker.formatDate('yy-mm-dd', new Date(currentDate));
                $(".datepicker").val(hedate);

                //payment mode slectiion code begin here start!
                $("#bankaccount").hide();
                $("#bankaccount").prop("disabled", true);
                $("#cashaccount").show();

                $("#bank").hide();
                $("#online").hide();
                $("#card").hide();
                $("#mode").change(function () {
                    if ($("#mode").val() === "Cheque") {
                        $("#bank").show();
                        $("#bankaccount").show();
                        $("#bankaccount").prop("disabled", false);
                        $("#cashaccount").hide();
                        $("#cashaccount").prop("disabled", true);
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
                        $("#bankaccount").show();
                        $("#bankaccount").prop("disabled", false);
                        $("#cashaccount").hide();
                        $("#cashaccount").prop("disabled", true);
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
                        $("#bankaccount").hide();
                        $("#bankaccount").prop("disabled", true);
                        $("#cashaccount").show();
                        $("#cashaccount").prop("disabled", false);

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
                        $("#bankaccount").show();
                        $("#bankaccount").prop("disabled", false);
                        $("#cashaccount").hide();
                        $("#cashaccount").prop("disabled", true);
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

        </script>
        <script>
            //give grand total
            function calculateBalancePayable(ob) {
                var balance = $("#balanceamt").val();
//                var enteredamount = $("#amount").val();
                var payable = 0;
                //coding for tax altered begin here
                //got tax details here and split foor id and percent
                var taxdetails = $('#taxdetails').val();
                console.log(" tax detail begin " + taxdetails);
                var splitvar = taxdetails.split(',');
                $("#taxpk").val(splitvar[0]);//it gives tax id
                $("#taxpercent").val(splitvar[1]);//it gives tax percent
                var enteredamount = $("#amount").val();
                //reverse tax calculation coding begin here
                var multipliedvalue = Number(enteredamount) * Number(100);
                var taxmod = Number(splitvar[1]) + Number(100);
                var mytotal = Number(multipliedvalue) / Number(taxmod);

//                var mytotal=Number(enteredamount)*100/100;
//                alert("Enterd:"+enteredamount+" mytotal:"+mytotal);
                var taxes = Number(enteredamount) - Number(mytotal);
//                alert(mytotal+" tot, tax:"+taxes);
                $('#total').val(mytotal.toFixed(2));
                $('#taxamount').val(taxes.toFixed(2));
//                Number(splitvar[1] / 100)
                //reverse tax calculation coding ends! here




//                var taxamount = Number(splitvar[1] / 100) * Number(enteredamount);
//                alert("enteredamt:"+enteredamount+" taxamt:"+taxamount );
//
//                var mytotal = Number(enteredamount) - Number(taxamount);
//                $('#total').val(mytotal.toFixed(2));
//                $('#taxamount').val(taxamount.toFixed(2));

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
                    console.log("optionValues.length : " + optionValues.length);
                    for (var k = 0; k < optionValues.length; k++) {
                        //operation performed TO split and save tax appropiately
                        console.log("ab ye from option k : " + optionValues[k]);
                        var splitvarb = optionValues[k].split(',');
                        console.log("vat1 : " + splitvarb[1]);
                        if (splitvarb[0] === 'ATX1') {
                            var taxamount2 = Number(splitvarb[1] / 100) * Number(enteredamount);
                            $('#vattax').val(taxamount2);
                        }

                        if (splitvarb[0] === 'ATX2') {
                            var taxamount2 = Number(splitvarb[1] / 100) * Number(enteredamount);
                            $('#servicetax').val(taxamount2);
                        }
                    }
                }

                if (splitvar[0] !== 'ATX4') {
                    $('#vattax').val("0");
                    $('#servicetax').val("0");
                }
                //calucaltion if vat+ service tax end! here
                //coding for tax altered end here
                var enteredamount = $("#amount").val();
                if ($("#useAdvance").is(':checked')) {
                    var advanceAmount = $("#advanceamt").val();
                    var balanceadvanceAmount = $("#balanceadvanceamount").val();

                    if (advanceAmount > balance) {
                        $("#payableinvoiceamount").val(0);
                    }
                    if ((Number(balance) > Number(advanceAmount)) && (Number(balanceadvanceAmount) > 0)) {
                        payable = Number(balance) - Number(advanceAmount) - Number(mytotal);
                        $("#payableinvoiceamount").val(payable.toFixed(2));
                    } else if ((Number(balance) > Number(advanceAmount)) && (Number(balanceadvanceAmount) === 0)) {

                        var valamount = $("#amount").val();
                        payable = Number(balance) - Number(valamount);
                        $("#payableinvoiceamount").val(payable.toFixed(2));
                    } else {
                        payable = Number(balance) - Number(advanceAmount);
                        $("#payableinvoiceamount").val(payable.toFixed(2));
                    }



                    if (mytotal > balance) {
                        $("#payableinvoiceamount").val(0);
                        payable = "0";
                        $("#payableinvoiceamount").val(payable.toFixed(2));
                    }
                    if (payable < 0) {
                        $("#payableinvoiceamount").val(0);
                        $("#negativepayableinvoiceamount").val(payable.toFixed(2));
                    }


                } else {
                    console.log("inside else " + balance + " eneterd " + enteredamount);

                    payable = Number(balance) - Number(enteredamount);
                    console.log("inside payable " + payable);
                    if (payable > 0) {
                        $("#payableinvoiceamount").val(payable.toFixed(2));
                    } else {
                        $("#payableinvoiceamount").val(0);
                        $("#negativepayableinvoiceamount").val(payable.toFixed(2));
                    }

                }
            }
            //calculation checkbox for adding balance to the amount 
            function calculateAddedAmount(ob) {
                var fin = 0;
                if ($("#useAdvance").is(':checked')) {
                    //adds value to enter amount textbox
                    var advanceAmount = $("#advanceamt").val();
                    var balance = $("#balanceamt").val();
                    var mystotal = $('#total').val();
//                    alert(balance);
                    if (Number(advanceAmount) > Number(balance)) {
                        fin = Number(advanceAmount) - Number(balance);
                        $("#balanceadvanceamount").val(fin.toFixed(2));
                        $("#negativepayableinvoiceamount").val(fin.toFixed(2));
                        $("#payableinvoiceamount").val(0);
                        //code to get the ampunt paid begin here 04-11-2015
                        var amountpaid = Number(advanceAmount) - Number(fin);
//                        alert(amountpaid);
                        $("#amount").val(amountpaid);

                    } else if (Number(balance) > Number(advanceAmount)) {
                        fin = Number(balance) - Number(advanceAmount);
//                        alert("from fin " + fin);
                        $("#payableinvoiceamount").val(fin.toFixed(2));
                        $("#balanceadvanceamount").val(0);
                        //mod nitz 04-11-2015 to get the amount value on screen for user 
                        $("#amount").val(advanceAmount);
                        //calculating payable invoice amount
                        $("#amount").focus();
                    }
                    if (Number(mystotal) > Number(balance)) {
//                        alert(mystotal + " ff " + balance);
                        $("#payableinvoiceamount").val(0);
                    }
                } else {
                    $("#amount").val(fin);
                    $("#balanceadvanceamount").val(fin);
                    $("#payableinvoiceamount").val(fin);
                }
            }

        </script>

    </head>
    <body>
        <a href="invoiceMasterLink" class="view">Back</a>
        <h2>Make Payment</h2>
        <hr>
        <br />
        <form action="addPayment" id="paymentform" method="POST">   
            <input type="hidden" name="invoiceid" value="${invoiceDetails.invoiceid}" />
            <input type="hidden" name="jobno" value="${invoiceDetails.jobno}" />
            <input type="hidden" name="customerid" value="${customerDetails.id}" />
            <input type="hidden" name="ledgerid" value="${customerDetails.ledgerid}" />
            <input type="hidden" name="tax_applicable" value="normal" />
            <input type="hidden" name="towards" value="${customerDetails.name}" id="textfield2" />
            <!--CHANGE THE LEDGER ID LATER-->
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Customer name</td>
                    <td width="66%" align="left" valign="top">${customerDetails.name}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Mobile no.</td>
                    <td width="66%" align="left" valign="top">${customerDetails.mobilenumber}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Email</td>
                    <td width="66%" align="left" valign="top">${customerDetails.email}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Invoice id</td>
                    <td width="66%" align="left" valign="top">${invoiceDetails.invoiceid}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Invoice Total</td>
                    <td width="66%" align="left" valign="top">${invoiceDetails.amountTotal}</td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Balance amt.(Rs.) from invoice</td>
                    <td width="66%" align="left" valign="top">
                        ${invoiceDetails.balanceamount}
                        <input type="hidden" name="balanceamount" id="balanceamt" value="${invoiceDetails.balanceamount}" />
                    </td>
                </tr>
                <!--                <tr>
                                    <td width="34%" align="left" valign="top">VAT tax(Rs.)</td>
                                    <td width="66%" align="left" valign="top">
                                        $ {invoiceDetails.taxAmount1}
                                    </td>
                                </tr>
                                <tr>
                                    <td width="34%" align="left" valign="top">SERVICE tax(Rs.)</td>
                                    <td width="66%" align="left" valign="top">
                                        $ {invoiceDetails.taxAmount2}
                                    </td>
                                </tr>-->
                <c:choose>
                    <c:when test="${customerDetails.advance_amount > 0}">
                        <tr>
                            <td width="34%" align="left" valign="top">Advance amt.(Rs.)</td>
                            <td width="66%" align="left" valign="top">
                                <input type="number" step="0.01" name="balance" readonly="" value="${customerDetails.advance_amount}" id="advanceamt" />
                                <input type="checkbox" name="useadvance" value="${customerDetails.advance_amount}" onchange="calculateAddedAmount(this);
                                        calculateBalancePayable(this)" id="useAdvance" />
                            </td>
                        </tr>
                    </c:when>
                </c:choose>
                <c:choose>
                    <c:when test="${invoiceDetails.isinsurance=='Yes'}">
                        <tr>
                            <td width="34%" align="left" valign="top">Payment by<font color="red">*</font></td>
                            <td width="66%" align="left" valign="top">
                                <select name="paymentby" id="paymentby" required="">
                                    <option value="customer">customer</option>
                                    <option value="insurance">insurance</option>
                                </select> 
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="paymentby" value="customer" />
                    </c:otherwise>
                </c:choose>
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
                    <td width="34%" align="left" valign="top">Account</td>
                    <td width="66%" align="left" valign="top">
                        <select name="bank_accountid" id="bankaccount">
                            <c:forEach var="ld" items="${bankaccountdtls}">
                                <option value="${ld.id}">${ld.bank_name}</option>
                            </c:forEach>
                        </select>
                        <select name="bank_accountid" id="cashaccount">
                            <c:forEach var="ld" items="${cashaccountdtls}">
                                <option value="${ld.id}">${ld.bank_name}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Date</td>
                    <td width="66%" align="left" valign="top"><input type="text" required="" name="income_date" id="paymendate" class="datepicker" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Enter amt.(Rs.)</td>
                    <td width="66%" align="left" valign="top">
                        <input type="number" step="0.01" name="total" id="amount" onchange="calculateBalancePayable(this);" />
                        <input type="hidden" readonly="" name="amount" id="total" value="" />
                        <input type="hidden" name="taxdetails" id="taxdetails" value="${taxdtlsID},${taxdtlsPercent}" />
                        <input type="hidden" name="taxid" id="taxpk" value="" />
                        <input type="hidden" name="tax" id="taxpercent" value="" /> 
                        <input type="hidden" readonly="" name="tax_amount" id="taxamount" value="" />
                        <input type="hidden" readonly="" name="vattax" id="vattax" value="0" />
                        <input type="hidden" readonly="" name="servicetax" id="servicetax" value="0" />
                    </td>
                </tr>
<!--                <tr class="tax">
                    <td width="34%" align="left" valign="top">Tax<font color="red">*</font></td>
                    <td width="66%" align="left" valign="top">
                                                <select name="taxdetails" onchange="calculateBalancePayable(this)" id="taxdetails" required="">
                                                    <c :forEach var="ob" items="$ {taxdtls}">
                                                        <option value="$ {ob.id},$ {ob.percent}">$ {ob.name} ($ {ob.percent}%)</option>          
                                                    </c :forEach>
                                                </select>

                    </td>
                </tr>-->
                <c:choose>
                    <c:when test="${customerDetails.advance_amount > 0}">
                        <tr>
                            <td width="34%" align="left" valign="top">Balance Advance amt.(Rs.)</td>
                            <td width="66%" align="left" valign="top">
                                <input type="text" name="balanceadvanceamount" id="balanceadvanceamount" readonly="" />
                            </td>
                        </tr>
                    </c:when>
                </c:choose>
                <tr>
                    <td width="34%" align="left" valign="top">Payable amt.(Rs.)</td>
                    <td width="66%" align="left" valign="top">
                        <input type="text" name="payableinvoiceamount" id="payableinvoiceamount" readonly="" />
                        <input type="hidden" name="negativepayableinvoiceamount" id="negativepayableinvoiceamount" />
                        <input type="checkbox" name="writeoff" value="ON" />(Discount/Writeoff)
                    </td>
                </tr>
            </table>
            <table id="bank"  width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Bank name</td>
                    <td width="66%" align="left" valign="top"><input type="text" pattern="^[a-zA-Z]*$" title="Please enter a valid Bank name." name="bankname" id="banknames" /></td>
                </tr>
                <tr>
                    <td width="34%" align="left" valign="top">Cheque no.</td>
                    <td width="66%" align="left" valign="top"><input type="text"  name="chequenumber" id="chequeno" /></td>
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
                    <td width="66%" align="left" valign="top"><input type="text"  name="transactionnumber" id="transactionno" /></td>
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
