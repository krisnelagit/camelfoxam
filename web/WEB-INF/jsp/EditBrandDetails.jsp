<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 
    Document   : EditBrandDetails
    Created on : 16-Mar-2015, 17:03:46
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Brand Details</title>
        <script src="js/jquery-1.10.2.min.js"></script>
        <%-- add and delete for Add User --%>
        <script>

            function addRow(tableID) {

                $('#' + tableID + '').append('<tr> <td width="34%" align="left" valign="top">Car Name</td><td width="34%" align="left" valign="top"><input type="text" required name="newcarname" id="textfield2" /></td><td align="left" valign="top"><label for="textfield"></label></td><td align="left" valign="top"><span class="delete1" style="cursor: pointer;"><img src="images/delete.png" alt="Delete" height="20" width="20" ></span></td></tr>')
            }

            $(document).on('click', 'span.delete1', function () {
                var curr = $(this);
                var result = confirm("Are you sure to delete?");
                if (result == true) {

                    var deletedids = $('#deletedbdid');
                    deletedids.val(deletedids.val() + curr.closest('tr').find('#detailids').val() + ',');

                    var table = document.getElementById('table_id');
                    var rowCount = table.rows.length;
                    if (rowCount <= 1) {
                        alert("Cannot delete all the rows."); // break;
                    } else {
                        $(this).closest('tr').find('td').fadeOut(600,
                                function () {
                                    $(this).parents('tr:first').remove();
                                });
                    }
                    return false;
                }
            });
        </script>
    </head>
    <body>
        <a href="brandMasterLink" class="view">Back</a>
        <h2>Car Edit</h2>
        <br />
        <form action="updateCar" method="POST">     
            <input type="hidden" name="deletedbranddetails" id="deletedbdid" value="" />
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Brand Name </td>
                    <td width="66%" align="left" valign="top">
                        <input type="hidden" name="brandname" value="${param.brandid}" />
                            <c:forEach var="ob" items="${branddt}"> 
                                <c:choose>
                                    <c:when test="${param.brandid==ob.id}">
                                        ${ob.name}
                                    </c:when>
                                </c:choose>                                       
                            </c:forEach>
                    </td>
                </tr>
            </table>
            <br>
            <!--<a onclick="addRow('table_id')">Add</a>-->
            <table class="display" id="table_id">
                <c:forEach var="ob" items="${carDt}">

                    <tr id="tmp">
                        <td width="34%" align="left" valign="top">Car Name</td>
                        <td width="34%" align="left" valign="top"><input type="text" required name="carname" id="textfield2" value="${ob.vehiclename}" /> <input type="hidden" name="detailid" id="detailids" value="${ob.id}" /> </td>
                        <td align="left" valign="top">                           
                            <select name="labourChargeTypes">
                                <c:choose>
                                    <c:when test="${ob.labourChargeType=='a'}">
                                        <option selected="">a</option>
                                        <option>b</option>
                                        <option>c</option>
                                        <option>d</option>
                                    </c:when>
                                    <c:when test="${ob.labourChargeType=='b'}">
                                        <option>a</option>
                                        <option selected="">b</option>
                                        <option>c</option>
                                        <option>d</option>
                                    </c:when>
                                    <c:when test="${ob.labourChargeType=='c'}">
                                        <option>a</option>
                                        <option>b</option>
                                        <option selected="">c</option>
                                        <option>d</option>
                                    </c:when>
                                    <c:when test="${ob.labourChargeType=='d'}">
                                        <option>a</option>
                                        <option>b</option>
                                        <option>c</option>
                                        <option selected="">d</option>
                                    </c:when>
                                </c:choose>
                            </select>
                        </td>
                        <td align="left" valign="top">
                            <span class="delete1" style="cursor: pointer;"><img src="images/delete.png" alt="Delete" height="20" width="20" ></span>
                        </td>
                    </tr>  
                </c:forEach>
            </table>
            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <c:choose>
                            <c:when test="${fn:length(carDt) gt 0}">
                                <input type="submit" value="Update" class="view3" style="cursor: pointer" />
                            </c:when>
                            <c:otherwise>
                                No cars are added yet. To add <a href="carMasterCreateLink?id=${param.brandid}">click here </a>.
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </form>
    </body>
</html>
