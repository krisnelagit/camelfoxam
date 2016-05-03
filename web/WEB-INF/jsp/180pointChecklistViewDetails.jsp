<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : 180pointChecklistViewDetails
    Created on : 25-Apr-2015, 11:59:36
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>180point Checklist View Details</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <link href="css/other_style.css" rel="stylesheet" type="text/css" />
        <script>
            function printContent(el) {
                var restorepage = document.body.innerHTML;
                var printcontent = document.getElementById(el).innerHTML;
                document.body.innerHTML = printcontent;
                window.print();
                document.body.innerHTML = restorepage;
            }
        </script>
        <style type="text/css">
            @media print{
                #printdiv *
                {
                    font-size: 6px !important;
                }
            }  
        </style>
    </head>
    <body>
        <a href="180pointchecklistgridlink" class="view">Back</a><a href="#" class="view button-001" onclick="printContent('printdiv')">Print</a>
        <h2>180 Point Check-List</h2>
        <div id="printdiv">

        <br />

        <table width="100%" cellpadding="5">

            <tr>
                <td align="left" valign="top">Date
                </td>
                <td align="left" valign="top">
                    ${pcldt.pcldate}
                </td>
            </tr>

            <tr>
                <td align="left" valign="top">Service Checklist No.</td>
                <td align="left" valign="top">${pcldt.servicechecklistid}</td>
            </tr>

            <tr>
                <td align="left" valign="top"> Model</td>
                <td align="left" valign="top">${pcldt.carmodel}</td>
            </tr>

            <tr>
                <td align="left" valign="top">Vehicle No.</td>
                <td align="left" valign="top">${pcldt.vehiclenumber}</td>
            </tr>

                <tr>
                    <td width="31%" align="left" valign="top">KM. in</td>
                    <td width="69%" align="left" valign="top">
                        <label for="textfield">${pcldt.km_in}</label>
                    </td>
                </tr>

                <tr>
                    <td width="31%" align="left" valign="top">Fuel Level</td>
                    <td width="69%" align="left" valign="top">
                        <label for="textfield">${pcldt.fuellevel}</label>
                    </td>
                </tr>

                <tr>
                    <td width="31%" align="left" valign="top">Additional Work(comments).</td>
                    <td width="69%" align="left" valign="top">
                        <label for="textfield">${pcldt.additionalwork}</label>
                    </td>
                </tr>

            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>

        <TABLE id="dataTable" border="0" class="CSSTableGenerator">
            <TR>
                <TD width="47%" align="left"><strong>Service List</strong></TD>
                <td width="53%" align="center"><strong>Categories</strong></td>
            </TR>
            <c:forEach var="ni" items="${partandcategoriesdt}">
            <tr>
                <td align="left" valign="top">
                    <span class="current">${ni.categoryname}</span>
                </td>
                <td align="left" valign="top">
                    <c:forEach var="nii" items="${ni.partlistdt}">
                    <div class="category-spacing">${nii.name}</div>
                    </c:forEach>
                </td>
            </tr>
            </c:forEach>
        </TABLE>
        <br />
        <c:if test="${!sessionScope.USERTYPE.equals('spares') && !sessionScope.USERTYPE.equals('crm')}">
            <c:if test="${!pcldt.isestimate.equals('Yes')}"> 
    <center>
        <a href="edit180pointchecklist?id=${pcldt.id}&brandid=${pcldt.branddetailid}"><INPUT type="button" value="Edit" class="save_butn"/></a>&nbsp;&nbsp;&nbsp;
        <!--<a href="addEstimatePage?pclid="><INPUT type="button" value="Create Estimate" class="save_butn"/></a>-->
    </center>   
        </c:if>
        </c:if>
        </div>
</body>
</html>
 