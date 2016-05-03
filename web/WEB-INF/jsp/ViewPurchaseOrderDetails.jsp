<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : ViewPurchaseOrderDetails
    Created on : 26-May-2015, 19:12:29
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Purchase Order</title>
        <link rel="stylesheet" href="css/tablegrid.css" />
        <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
        <script type="text/javascript" src="js/jspdf.debug.js"></script>
        <script>
            $(document).ready(function () {
                $("#send").hide();
                $("#senturmail").hide();
                $("#sendError").hide();
            });

            //calls print function
            function CallPrint(strid) {
//                $("#divPrint11").html('');
//                $("#divPrint11").append($("#table_id").eq(0).clone()).html();

                var prtContent = document.getElementById(strid);
                var WinPrint = window.open('', '', 'letf=0,top=0,width=1500,height=400,toolbar=0,scrollbars=0,sta­tus=0');
                WinPrint.document.write('<link rel="stylesheet" href="css/tablegrid.css" />');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
                prtContent.innerHTML = strOldOne;
            }
            
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
                $("#senturmail").hide();
                $("#sendError").hide();
                $("#send").show();
                var pdf = new jsPDF('p', 'pt', 'a4');
                source = $('#testcase')[0];
                specialElementHandlers = {
                    // element with id of "bypass" - jQuery style selector
                    '#bypassme': function (element, renderer) {
                        // true = "handled elsewhere, bypass text extraction"
                        return true
                    }
                };
                margins = {
                    top: 60,
                    bottom: 60,
                    left: 40,
                    width: 522
                };
                pdf.fromHTML(
                        source, // HTML string or DOM elem ref.
                        margins.left, // x coord
                        margins.top, {// y coord
                            'width': margins.width, // max width of content on PDF
                            'elementHandlers': specialElementHandlers
                        },
                function (dispose) {
                    // dispose: object with X, Y of the last line add to the PDF 
                    //          this allow the insertion of new lines after html
                    // Making Data URI
                    var out = pdf.output('datauristring');
                    //ajax call to send mail begin here
                    var customerName = $("#customername").val();
                    var customerEmail = $("#customeremail").val();
                    $.ajax({
                        url: "sendmailpoinfo",
                        type: 'POST',
                        data: {
                            customerName: customerName,
                            customerEmail: customerEmail,
                            mypdfbase: out
                        },
                        cache: false,
                        success: function (data) {
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
                    //ajax call to send mail ends!! here
                }, margins);
            }
            //mod send mail function to test written on 06-11-2015 ends!! here
        </script>
    </head>
    <body>
        <!--<a href="#" onclick="javascript:convertHTMLtopdf()" class="view button-001">Send Mail</a>-->  
        <a href="viewvendormail?poid=${param.poid}" class="view button-001">Goto Send Mail</a> 
        <a href="PurchaseOrderGridLink" class="view button-001">Back</a><a href="#" class="view button-001" onclick="printContent('printdiv')">Print</a>
        <c:choose>
            <c:when test="${purchasedetailsdt.isreceived=='Not received'}">
                <a href="editPurchaseOrderLink?poid=${param.poid}" class="view button-001">Edit</a>
            </c:when>
        </c:choose>

        <%--<c:if test="${purchasedetailsdt.status=='Pending'}"><a href="editPurchaseOrderLink?poid=${param.poid}" class="view button-001">Edit</a></c:if>--%>
        <label id="send"><h2>Sending mail <img src="images/ajax-loader.gif" alt="loader View"></h2></label><label id="senturmail"><h2>Mail sent successfully <img src="images/MB__mail_icon.png" alt="loader View"></h2></label><label id="sendError"><h2>Please Check Your Connectivity</h2></label>
        <h2>Purchase Order</h2>
        <div id="testcase">
            <br />
            <div id="printdiv">
                <div>
                    <div  align="center">
                        <div style="display: inline-block;width: 165px; padding-left: 20px">
                            <img src="images/karworx logo.png" />
                        </div>
                        <div style="display: inline-block;width: auto; text-align: left">
                            <strong style="font-size:18px">Kar-Worx & Spa India Pvt. Ltd</strong><br>
                            <p>Arch No. 25/26, Below Mahalaxmi Bridge,<br /> OFF DR. E. Moses RD, Mahalaxmi (W). Mumbai -400 034<br />
                                <strong>Telphone:</strong> 40028004/5&nbsp; <br /><strong>Fax No Email: </strong>customer.first@karworx.com<br /><br />
                            </p>
                        </div>
                    </div>
                    <br>
                    <div align="center"><strong style="font-size:18px">TAX INVOICE</strong></div>                    
                </div>
                <div class="box1" align="left" style="display: inline-block;">
                    <strong>Vendor Name:<br>${purchasedetailsdt.vendorname}</strong><input type="hidden" id="customername" name="customername" value="${customerinvoiceDt.name}" />
                    <input type="hidden" name="" id="jspdfdata" value="" /> 
                    <br />
                    ${purchasedetailsdt.address}<br />
                    ${purchasedetailsdt.mobilenumber}<br />                    
                    ${purchasedetailsdt.email}<br /><input type="hidden" name="customeremail" id="customeremail" value="${purchasedetailsdt.email}" />
                </div>
                <div class="box2" align="right" style="display: inline-block; float: right">
                    <strong>Order No</strong>&nbsp;:	${param.poid}<br />
                    <strong>Date</strong> :	<fmt:formatDate type="date" value="${purchasedetailsdt.modifydate}" /><br />
                </div>
                <br />
                <br />
                <div class="CSSTableGenerator"  >

                    <table style="overflow: auto; max-height: 10px; border-bottom: thin #f4f4f4 solid">
                        <tr>
                            <td width="6%" class="wn1"><strong>
                                    Sr. No.</strong></td>
                            <td width="18%" class="wn1"><strong>Vehicle name</strong></td>
                            <td width="18%" class="wn1"><strong>Part name</strong></td>
                            <td width="25%" class="wn1"><strong>Manufacturer</strong></td>
                            <td width="12%" class="wn1" align="center">Cost Rs.</td>
                            <td width="10%" class="wn1" align="center"><strong>Qty.</strong></td>
                            <td width="11%" class="wn1"><strong>Amt.</strong></td>
                        </tr>
                        <c:set value="1" var="count"></c:set>
                        <c:forEach var="ob" items="${purchaseorderdetailsdt}">
                            <tr>
                                <td align="center" >${count}</td>
                                <td>${ob.vehiclename}</td>
                                <td>${ob.partname}</td>
                                <td>${ob.mfgname}</td>
                                <td>${ob.costprice}</td>
                                <td>${ob.partQuantity}</td>
                                <td align="right">${ob.itemtotal}</td>
                                <!--<td align="right">120.00</td>-->
                            </tr>
                            <c:set value="${count+1}" var="count"></c:set>
                        </c:forEach>
                        <tr>
                            <!--<td >&nbsp;</td>-->
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td align="right"><strong>Add VAT @ ${purchasedetailsdt.tax}%</strong></td>
                            <td align="right"><strong>${purchasedetailsdt.taxamount}</strong></td>
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
                        <tr>
                            <td style="background-color:#f4f4f4">&nbsp;</td>
                            <td style="background-color:#f4f4f4">&nbsp;</td>
                            <td style="background-color:#f4f4f4">&nbsp;</td>
                            <td style="background-color:#f4f4f4">&nbsp;</td>
                            <td style="background-color:#f4f4f4"><strong> <label id="finalamtwords"></label> </strong></td>
                            <td align="right" style="background-color:#f4f4f4"><strong style="float:right">Grand Total</strong></td>
                            <td align="right" style="background-color:#f4f4f4"><strong>${purchasedetailsdt.finaltotal}<input type="hidden" name="amttotal" id="amttotal" value="${invoiceDt.amountTotal}" /></strong></td>
                        </tr>
                    </table>
                    <div style="padding: 7px 7px;">
                        <div class="box3" align="left" style="display: inline-block;">
                            <strong>&nbsp; </strong><br />
                            &nbsp;
                        </div>
                        <div class="box4" style="display: inline-block;float: right">
                            <strong style="float:right">Kar-Worx & Spa India Pvt. Ltd</strong> 
                        </div>
                        <p>
                            <br />
                            <br />
                            <br />
                            <strong>Customer's Signature </strong><br />
                            C.E.S.Tax No. AADCB0214DSD001<br />
                            VAT TIN No. 27650980309V wef 26/04/2013 <br />
                            CST TIN No 27650980309C wef 26/04/2013 <br />
                            PAN No. AADCB0214D 
                            <br />
                            <br />
                            <strong>Terms and Conditions</strong><br />
                            1. Disputes if any will be subject to MUMBAI jurisdiction <br />
                            2. Interest @ 18% would be charged on all bills unpaid after 30 days from the date of the bill <br />"I / We hereby certify that my/our R.C. under the Mah. Value Added Tax Act 2002 is in force on the data on which the sale of the goods specified in this Tax Invoice is made by me / us and that the transaction of sale covered by this invoice has been effected by me / us and it shall be accounted for in the turnover of sales while filing of return and the due tax, if any,if any payableon the sale has been paid or shall be paid" 
                        </p>

                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
