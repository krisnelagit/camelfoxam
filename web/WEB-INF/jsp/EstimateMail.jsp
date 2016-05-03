<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Estimate Mail</title>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            @media print{
                #printdivinside *
                {
                    font-size: 8px !important;
                }
            }  
        </style>
        <script src="js/jquery-ui.js"></script>
        <!--<link rel="stylesheet" href="css/tablegrid.css" />-->
        <!--<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>-->
        <script type="text/javascript" src="js/jspdf.debug.js"></script>
        <script type="text/javascript">
            function test_value() {
                var junkVal = document.getElementById('amttotal').value;
                junkVal = Math.floor(junkVal);
                var obStr = new String(junkVal);
                numReversed = obStr.split("");
                actnumber = numReversed.reverse();
                if (Number(junkVal) >= 0) {
                    //do nothing
                }
                else {
                    alert('wrong Number cannot be converted');
                    return false;
                }
                if (Number(junkVal) == 0) {
                    document.getElementById('finalamtwords').innerHTML = obStr + '' + 'Rupees Zero Only';
                    return false;
                }
                if (actnumber.length > 9) {
                    alert('Oops!!!! the Number is too big to covertes');
                    return false;
                }
                var iWords = ["Zero", " One", " Two", " Three", " Four", " Five", " Six", " Seven", " Eight", " Nine"];
                var ePlace = ['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', 'Nineteen'];
                var tensPlace = ['dummy', ' Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninety'];
                var iWordsLength = numReversed.length;
                var totalWords = "";
                var inWords = new Array();
                var finalWord = "";
                j = 0;
                for (i = 0; i < iWordsLength; i++) {
                    switch (i)
                    {
                        case 0:
                            if (actnumber[i] == 0 || actnumber[i + 1] == 1) {
                                inWords[j] = '';
                            }
                            else {
                                inWords[j] = iWords[actnumber[i]];
                            }
                            inWords[j] = inWords[j];
                            break;
                        case 1:
                            tens_complication();
                            break;
                        case 2:
                            if (actnumber[i] == 0) {
                                inWords[j] = '';
                            }
                            else if (actnumber[i - 1] != 0 && actnumber[i - 2] != 0) {
                                inWords[j] = iWords[actnumber[i]] + ' Hundred and';
                            }
                            else {
                                inWords[j] = iWords[actnumber[i]] + ' Hundred';
                            }
                            break;
                        case 3:
                            if (actnumber[i] == 0 || actnumber[i + 1] == 1) {
                                inWords[j] = '';
                            }
                            else {
                                inWords[j] = iWords[actnumber[i]];
                            }
                            if (actnumber[i + 1] != 0 || actnumber[i] > 0) { //here
                                inWords[j] = inWords[j] + " Thousand";
                            }
                            break;
                        case 4:
                            tens_complication();
                            break;
                        case 5:
                            if (actnumber[i] == "0" || actnumber[i + 1] == 1) {
                                inWords[j] = '';
                            }
                            else {
                                inWords[j] = iWords[actnumber[i]];
                            }
                            if (actnumber[i + 1] != 0 || actnumber[i] > 0) {   //here 
                                inWords[j] = inWords[j] + " Lakh";
                            }
                            break;
                        case 6:
                            tens_complication();
                            break;
                        case 7:
                            if (actnumber[i] == "0" || actnumber[i + 1] == 1) {
                                inWords[j] = '';
                            }
                            else {
                                inWords[j] = iWords[actnumber[i]];
                            }
                            if (actnumber[i + 1] != 0 || actnumber[i] > 0) { // changed here
                                inWords[j] = inWords[j] + " Crore";
                            }
                            break;
                        case 8:
                            tens_complication();
                            break;
                        default:
                            break;
                    }
                    j++;
                }
                function tens_complication() {
                    if (actnumber[i] == 0) {
                        inWords[j] = '';
                    }
                    else if (actnumber[i] == 1) {
                        inWords[j] = ePlace[actnumber[i - 1]];
                    }
                    else {
                        inWords[j] = tensPlace[actnumber[i]];
                    }
                }
                inWords.reverse();
                for (i = 0; i < inWords.length; i++) {
                    finalWord += inWords[i];
                }
                return finalWord;
            }
            function convert_amount_into_amttotal_paisa() {

                var finalWord1 = test_value();
                var finalWord2 = "";
                var val = document.getElementById('amttotal').value;
                var actual_val = document.getElementById('amttotal').value;
                document.getElementById('amttotal').value = val;
                if (val.indexOf('.') !== -1)
                {
                    val = val.substring(val.indexOf('.') + 1, val.length);
                    if (val === '0' || val === '00') {
                        finalWord2 = "zero paisa only";
                    }
                    else {
                        document.getElementById('amttotal').value = val;
                        finalWord2 = test_value() + " paisa only";
                    }
                    document.getElementById('finalamtwords').innerHTML = finalWord1 + " Rupees and " + finalWord2;
                }
                else {
                    //finalWord2 =  " Zero paisa only";
                    document.getElementById('finalamtwords').innerHTML = finalWord1 + " Rupees Only";
                }
                document.getElementById('amttotal').value = actual_val;
            }
        </script>
        <script>
            //called on ready
            $(document).ready(function () {
                $("#comments").val("");
                $("#dialogPaymentDetail").hide();
                $("#dialogmailDetail").hide();
                $("#send").hide();
                $("#senturmail").hide();
                $("#sendError").hide();
//                convert_amount_into_amttotal_paisa();

                //code written to display mail comment box begin here
                $(".mailclick").click(function (e) {
                    e.preventDefault();
                    //get customer email in the textbox of comment dialog
                    var customerEmail = $("#customeremail").val();
                    $("#emailList").val(customerEmail);

//                    var invoicehistoryid = $(this).attr('href');
                    $("#dialogmailDetail").dialog({
                        modal: true,
                        effect: 'drop',
                        width: 500,
                        height: 300,
                        show: {
                            effect: "drop"
                        },
                        hide: {
                            effect: "drop"
                        }
                    });
                    $("#comments").val("");
                    $("#sendcomments").prop("disabled", false);
                });
                //code written to display mail comment box ends! here

                //code written here to show payment history begins here
                $(".paymenthistory").click(function (e) {
                    e.preventDefault();
                    var invoicehistoryid = $(this).attr('href');

                    $.ajax({
                        url: "getPaymentDetails",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            invoiceid: invoicehistoryid
                        },
                        cache: false,
                        success: function (data) {
                            for (var i = 0; i < data.length; ++i) {
                                $('#paymenttable').append('<tr><td align="center" >' + data[i].income_date + '</td><td>' + data[i].towards + '</td><td align="right">' + data[i].mode + '</td><td align="right">' + data[i].total + '</td></tr>');
                            }

                            //our view payments dialog
                            $("#dialogPaymentDetail").dialog({
                                modal: true,
                                effect: 'drop',
                                width: 600,
                                height: 400,
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
                //code written here to show payment history ends! here

                //code for part total details begin here
                var sum = 0;
                $('.price').each(function () {
                    sum += parseFloat($(this).text());
                });
                console.log("price part" + sum);
                var sum1 = 0;
                $('.labourcharges').each(function () {
                    sum1 += parseFloat($(this).text());
                });
                console.log("price labor" + sum1);
                $('#labourrs').html(sum1);
                $('#partsrs').html(sum);
                var grand = sum + sum1;
                console.log("price grand" + grand);

                $('#grandamount').text(grand);
                //code for part total details ends here

                //code for service total details begin here
                var sum2 = 0;
                $('.labourchargesservice').each(function () {
                    sum2 += parseFloat($(this).text());
                });
                $('#servicelabourrs').html(sum2);

                $('#grandserviceamount').text(sum2);
                //code for service total details ends here

                //code for grand total begin here   
                var grandtotalend = Number(grand) + Number(sum2);
                $('#grandpartserviceamount').text(grandtotalend);
                //code for grand total ends! here 

            });
            //calls print function
            function CallPrint(strid) {
//                $("#divPrint11").html('');
//                $("#divPrint11").append($("#table_id").eq(0).clone()).html();

                var prtContent = document.getElementById(strid);
                var strOldOne = prtContent.innerHTML;
                var WinPrint = window.open('', '', 'letf=0,top=0,width=1500,height=400,toolbar=0,scrollbars=0,sta­tus=0');
                WinPrint.document.write('<link rel="stylesheet" href="css/tablegrid.css" />');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
                prtContent.innerHTML = strOldOne;
            }
            //calls convert to pdf function

            //mod print function begin here
            function printContent(el) {
                var restorepage = document.body.innerHTML;
                var printcontent = document.getElementById(el).innerHTML;
                document.body.innerHTML = printcontent;
                window.print();
                document.body.innerHTML = restorepage;
            }
            //mod print function ends! here

            //mod send mail function to test written on 06-11-2015 begins here
            function convertHTMLtopdf() {
                $("#sendcomments").prop("disabled", true);
                $("#senturmail").hide();
                $("#sendError").hide();
                $("#send").show();
                //invoice name logic                
                var customerdate = $("#custdate").val();
                var customervehicle = $("#custvehicle").val();
                var invoicename = customervehicle + " " + customerdate;

                var customerName = $("#customername").val();
                var customerEmail = $("#emailList").val();
                var emailComments = $("#comments").val();
                var out = document.getElementById("printdiv").innerHTML;
//                console.log(out);
    
                $.ajax({
                    url: "sendmailinfod",
                    type: 'POST',
                    data: {
                        customerName: customerName,
                        customerEmail: customerEmail,
                        mypdfbase: out,
                        emailcomments: emailComments,
                        name: "Estimate for " + invoicename
                    },
                    cache: false,
                    success: function (data) {
                        $("#dialogmailDetail").dialog("close");
                        if (data === 'Yes') {
                            $("#send").hide();
                            $("#senturmail").show();
                        } else {
                            $("#sendError").show();
                        }
                    }, error: function () {
                        alert("i m err");
                    }
                });

//                var pdf = new jsPDF('p', 'pt', 'a4');
//                source = $('#testcase')[0];
//                specialElementHandlers = {
//                    // element with id of "bypass" - jQuery style selector
//                    '#bypassme': function (element, renderer) {
//                        // true = "handled elsewhere, bypass text extraction"
//                        return true
//                    }
//                };
//                margins = {
//                    top: 80,
//                    bottom: 60,
//                    left: 40,
//                    width: 522
//                };
//                pdf.fromHTML(
//                        source, // HTML string or DOM elem ref.
//                        margins.left, // x coord
//                        margins.top, {// y coord
//                            'width': margins.width, // max width of content on PDF
//                            'elementHandlers': specialElementHandlers
//                        },
//                function (dispose) {
//                    // dispose: object with X, Y of the last line add to the PDF 
//                    //          this allow the insertion of new lines after html
//                    // Making Data URI
//                    var out = pdf.output('datauristring');
//                    //ajax call to send mail begin here
//                    var customerName = $("#customername").val();
//                    var customerEmail = $("#customeremail").val();
//                    var emailComments = $("#comments").val();
//                    
//                    //ajax call to send mail ends!! here
//                }, margins);
            }
            //mod send mail function to test written on 06-11-2015 ends!! here

            //mod code witten here is modification to show dialog and allow user to write cusotom mail message begin here
            function showcommentsdialog() {
                $("#dialogmailDetail").show();
                //our add comment dialog
                $("#dialogmailDetail").dialog({
                    modal: true,
                    effect: 'drop',
                    width: 600,
                    height: 400,
                    show: {
                        effect: "drop"
                    },
                    hide: {
                        effect: "drop"
                    }
                });

            }
            //mod code witten here is modification to show dialog and allow user to write cusotom mail message ends! here

        </script>
    </head>
    <body>


        <a href="#" class="view button-001 mailclick">Send Mail</a>  <a href="estimate" class="view button-001">Back</a>


        <label id="send"><h2>Sending mail <img src="images/ajax-loader.gif" alt="loader View"></h2></label><label id="senturmail"><h2>Mail sent successfully <img src="images/MB__mail_icon.png" alt="loader View"></h2></label><label id="sendError"><h2>Please Check Your Connectivity</h2></label>
        <h2>Send Estimate</h2>
        <div id="testcase">
            <div id="printdiv">
                <div id="printdivinside">
                    <div>
                        <div  align="center">
                            <div style="display: inline-block;width: 400px; text-align: left">
                                <strong style="font-size:18px">Kar-Worx & Spa India Pvt. Ltd</strong><br>
                                <p>
                                    Arch no. 25/26, Below Mahalaxmi Bridge,Off. Dr. E. Moses Road, Mumbai - 400034. Tel No.: 022-40028004/5. Email: customer.first@karworx.com
                                </p>
                            </div>
                            <div style="display: inline-block;width: 165px; padding-left: 20px">
                                <img src="https://goo.gl/KsVTbt" width="100" />
                            </div>
                        </div>
                        <div align="center"><strong style="font-size:18px">ESTIMATE</strong></div>                    
                    </div>
                    <div class="box1" align="left" style="display: inline-block;">
                        <strong>${estcustdtls.customername}</strong><input type="hidden" id="customername" name="customername" value="${estcustdtls.customername}" />
                        <input type="hidden" name="" id="jspdfdata" value="" /><br />
                        ${estcustdtls.address}<br />
                        ${estcustdtls.mobilenumber}<br />                    
                        ${estcustdtls.email}<br /><input type="hidden" name="customeremail" id="customeremail" value="${estcustdtls.email}" />
                    </div>
                    <div class="box2" align="right" style="display: inline-block; float: right">
                        <strong>Estimate No</strong>&nbsp;:	${param.estid}<br />
                        <strong>Date</strong> :<fmt:formatDate type="date" value="${estcustdtls.pcldate}" /> 
                        <input type="hidden" name="custdate" id="custdate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${estcustdtls.pcldate}" />" /><br />
                        <strong>Vehicle Make &nbsp;:</strong>${estcustdtls.make} &nbsp; ${estcustdtls.carmodel}<br />
                        <strong>Vehicle No. &nbsp;:</strong>${estcustdtls.vehiclenumber}<input type="hidden" name="custvehicle" id="custvehicle" value="${estcustdtls.vehiclenumber}" /><br />

                    </div>
                    <br />
                    <br />
                    <div class="CSSTableGenerator">
                        <table cellspacing="0" cellpadding="2" style="overflow: auto; max-height: 10px; " border="1" width="100%" bordercolor="#ccc">
                            <tr>
                                <td align="left" width="6%"  class="wn1"><strong>Sr.No.</strong></td>
                                <td align="left" width="31%" class="wn1"><strong>Name</strong></td>
                                <td align="left" width="37%" class="wn1"><strong>Description</strong></td>
                                <td align="left" width="37%" class="wn1"><strong>Qty.</strong></td>
                                <td align="center" width="14%" class="wn1"><strong>per item</strong></td>
                                <td align="center" width="12%" class="wn1"><strong>Labour Rs.</strong></td>
                                <td align="center" width="12%" class="wn1"><strong>Part Rs.</strong></td>
                            </tr>
                            <c:set value="1" var="count"></c:set>
                            <c:forEach var="ob" items="${estpartdtls}">
                                <tr>
                                    <td align="center" >${count}</td>
                                    <td>${ob.partname}</td>
                                    <td>${ob.description}</td>
                                    <td align="right" class="quantity">${ob.quantity}</td>
                                    <td align="right" class="peritem">${ob.partrs}</td>
                                    <td align="right" class="labourcharges">${ob.labourrs}</td>
                                    <td align="right" class="price">${ob.totalpartrs}</td>
                                </tr>
                                <c:set value="${count+1}" var="count"></c:set>
                            </c:forEach>
                            <tr>
                                <!--<td >&nbsp;</td>-->
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td align="right"><strong>Spares total</strong></td>
                                <td>&nbsp;</td>                                
                                <td>&nbsp;</td>
                                <td align="right"><strong><label id="labourrs"></label></strong></td>
                                <td align="right"><strong><label id="partsrs"></label></strong></td>
                            </tr>
                            <tr>
                                <!--<td >&nbsp;</td>-->
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td align="right">
                                    <c:choose>
                                        <c:when test="${empty estservicedtls}">
                                            <strong>*Taxes extra as applicable.</strong>
                                        </c:when>
                                        <c:otherwise>
                                            <strong>&nbsp;</strong>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>&nbsp;</td>                                
                                <td align="center" valign="middle">
                                    <c:choose>
                                        <c:when test="${empty estservicedtls}">
                                            <strong>Grand Total</strong>
                                        </c:when>
                                        <c:otherwise>
                                            <strong>Total</strong>
                                        </c:otherwise>
                                    </c:choose>                            
                                </td>
                                <td align="right"><strong><label id="grandamount"></label></strong></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <!--<td >&nbsp;</td>-->
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td align="right">&nbsp;</td>
                                <td align="right">&nbsp;</td>
                            </tr>
                        </table>
                        <table cellspacing="0" cellpadding="2" style="overflow: auto; max-height: 10px; " border="1" width="100%" bordercolor="#ccc">
                            <c:if test="${not empty estservicedtls}">
                                <tr>
                                    <td width="6%" class="wn1"><strong><c:if test="${not empty estservicedtls}">Sr. No.</c:if>&nbsp;</strong></td>
                                    <td width="24%" class="wn1" ><strong><c:if test="${not empty estservicedtls}">Service Name</c:if>&nbsp;</strong></td>
                                    <td width="11%" class="wn1" ><strong><c:if test="${not empty estservicedtls}">Description</c:if>&nbsp;</strong></td>
                                    <td width="14%" class="wn1" align="center"><strong><c:if test="${not empty estservicedtls}">Labour Rs.</c:if>&nbsp;</strong></td>
                                        <!--<td width="16%"><strong>Total Amount</strong></td>-->
                                    </tr>
                                <c:set value="1" var="count"></c:set>
                                <c:forEach var="ob" items="${estservicedtls}">
                                    <tr>
                                        <td align="center" >${count}</td>
                                        <td>${ob.servicename}</td>
                                        <td>${ob.description}</td>
                                        <td align="right" class="labourchargesservice">${ob.labourrs}</td>
                                    </tr>
                                    <c:set value="${count+1}" var="count"></c:set>
                                </c:forEach>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td align="right"><strong>Labour Charges total</strong></td>
                                    <td align="right"><strong><label id="grandserviceamount">  </label></strong></td>
                                </tr>
                                <tr>
                                    <td style="background-color:#f4f4f4">&nbsp;</td>
                                    <td style="background-color:#f4f4f4"><strong>*Taxes extra as applicable. <label id="finalamtwords"></label> </strong></td>
                                    <td align="right" style="background-color:#f4f4f4"><strong style="float:right">Grand Total</strong></td>
                                    <td align="right" style="background-color:#f4f4f4"><strong><label id="grandpartserviceamount"></label>/-<input type="hidden" name="amttotal" id="amttotal" value="" /></strong></td>
                                </tr>                                                              
                            </c:if>
                        </table>
                        <div style="padding: 7px 7px;">
                            <div class="box3" align="left" style="display: inline-block;">
                                <strong>Invoice verified </strong><br />
                                Received all old parts. I have taken the vehicle and found satisfactory
                            </div>
                            <div class="box4" style="display: inline-block;float: right">
                                <strong style="float:right">Kar-Worx & Spa India Pvt. Ltd</strong> 
                            </div>
                            <p>
                                <br />
                                <br />
                                <br />
                                <strong>Customer's Signature </strong><br />
                                C.E.S.Tax No: AADCB0214DSD001.  VAT TIN No: 27650980309V wef 26/04/2013.   CST TIN No: 27650980309C wef 26/04/2013.  PAN No: AADCB0214D.                                    
                                <br />
                                <strong>Terms and Conditions</strong><br />
                                1. Disputes if any will be subject to MUMBAI jurisdiction <br />
                                2. Interest @ 18% would be charged on all bills unpaid after 30 days from the date of the bill <br />"I / We hereby certify that my/our R.C. under the Mah. Value Added Tax Act 2002 is in force on the data on which the sale of the goods specified in this Tax Invoice is made by me / us and that the transaction of sale covered by this invoice has been effected by me / us and it shall be accounted for in the turnover of sales while filing of return and the due tax, if any,if any payableon the sale has been paid or shall be paid" 
                            </p>

                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!--payment history dialog code begin here-->
        <div id="dialogPaymentDetail" title="View payment details">
            <table id="paymenttable" class="CSSTableGenerator">                    
                <tr>
                    <td align="left" width="10%"><strong>Date</strong></td>
                    <td align="left" width="24%"><strong>Name</strong></td>
                    <td align="left" width="10%"><strong>Mode</strong></td>
                    <td align="left" width="10%"><strong>Amount(Rs.)</strong></td>
                </tr>

            </table>
        </div>
        <!--payment history dialog code ends! here-->

        <!-- email comments dialog code begin here-->
        <div id="dialogmailDetail" title="Add Comments">
            <table border="0">                    
                <tr>
                    <td><strong>Email</strong></td>
                    <td>
                        <input type="text" name="emailList" id="emailList" value="" />
                    </td>
                </tr>
                <tr>
                    <td><strong>Comments</strong></td>
                    <td>
                        <textarea name="" id="comments" rows="7" cols="50">
                        </textarea>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <input type="button" value="Send" onclick="convertHTMLtopdf()" class="view3" id="sendcomments" style="cursor: pointer" />
                    </td>
                </tr>
            </table>
        </div>
        <!--email comments dialog code ends! here-->
    </body>
</html>
