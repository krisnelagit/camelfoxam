<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : AddCar
    Created on : 16-Mar-2015, 17:03:46
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="js/jquery-1.10.2.min.js"></script>
        <%-- add and delete for Add User --%>
        <script>

            function addRow(tableID) {

                $('#' + tableID + '').append('<tr> <td width="34%" align="left" valign="top">Car Name</td><td width="34%" align="left" valign="top"><input type="text" required name="carname" id="textfield2" /></td><td align="left" valign="top"><select name="labourChargeTypes"><option>a</option><option>b</option><option>c</option><option>d</option></select></td><td align="left" valign="top"><span class="delete1" style="cursor: pointer;"><img src="images/delete.png" alt="Delete" height="20" width="20" ></span></td></tr>')
            }

            $(document).on('click', 'span.delete1', function () {
                var result = confirm("Are you sure to delete?");
                if (result == true) {
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
        <h2>Car Create</h2>
        <br />
        <form action="addCar" method="POST">        
            <table width="100%" cellpadding="5">
                <tr>
                    <td width="34%" align="left" valign="top">Brand Name </td>
                    <td width="66%" align="left" valign="top">
                        <select required name="brandid" id="allevent">
                            <c:forEach var="ob" items="${branddt}"> 

                                <c:choose>
                                    <c:when test="${param.id==ob.id}">
                                        <option value="${ob.id}" selected="">${ob.name}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${ob.id}">${ob.name}</option>
                                    </c:otherwise>
                                </c:choose>

                            </c:forEach>
                        </select> 
                    </td>
                </tr>
            </table>
            <br>
            <a onclick="addRow('table_id')" href="#" title="Add car name"><img src="images/addh.png" alt="Add" height="13" width="13" >Add</a>
            <table class="display" id="table_id">
                <tr id="tmp">
                    <td width="34%" align="left" valign="top">Car Name</td>
                <td width="34%" align="left" valign="top"><input type="text" required name="carname" id="textfield2" /></td>
                <td align="left" valign="top">
                    <select name="labourChargeTypes">
                        <option>a</option>
                        <option>b</option>
                        <option>c</option>
                        <option>d</option>
                    </select>
                </td>
                <td align="left" valign="top">
                    <span class="delete1" style="cursor: pointer;"><img src="images/delete.png" alt="Delete" height="20" width="20" ></span>
                </td>
                </tr>  
            </table>
            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td><input type="submit" value="Save" class="view3" style="cursor: pointer" />&nbsp;&nbsp;&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </form>
    </body>
</html>
