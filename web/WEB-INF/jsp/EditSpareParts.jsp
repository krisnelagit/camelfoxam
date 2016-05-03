<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : EditParts
    Created on : 17 Mar, 2015, 11:50:05 AM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Car Parts</title>
        <script>
            $(document).ready(function () {
                $('#brand').change(function () {
                    var name = $('option:selected', $(this)).val();
                    $('#vehicle').find('option').remove();
                    $.ajax({
                        type: "post",
                        url: "getbranddetails",
                        dataType: "json",
                        data: {brandid: name
                        },
                        success: function (data) {
                            if (data) {
                                $('#vehicle').append('<option value="">--select--</option>');

                                for (var i = 0; i < data.length; i++) {
                                    //                                       alert(data[i].a);
                                    $('#vehicle').append('<option value="' + data[i].id + '">' + data[i].name + '</option>');
                                }

                            }
                        },
                        error: function () {
                            alert('No data found');
                        }

                    });
                });



            });
        </script>
    </head>
    <body>
        <form action="updatecarparts" method="post">
            <a href="viewCarVaultLink" class="view">Back</a>
            <h2>Edit Car Parts</h2>
            <br />

            <table width="100%" cellpadding="5">

                <tr>
                    <td align="left" valign="top">Part name</td>
                    <td align="left" valign="top"><input type="text" required="" name="name" id="textfield5" value="${getparts.name}" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Category name</td>
                    <td align="left" valign="top">

                        <select name="categoryid" required="">
                            <option value="">--select--</option>
                            <c:forEach var="ob" items="${catdtls}">
                                <c:choose>
                                    <c:when test="${getparts.categoryid==ob.id}">
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
                <tr>
                    <td align="left" valign="top">Type A cost: </td>
                    <td align="left" valign="top"><input type="text" required="" value="${getparts.a}" name="a" id="textfield5" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type B cost: </td>
                    <td align="left" valign="top"><input type="text" required="" value="${getparts.b}" name="b" id="textfield5" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type C cost: </td>
                    <td align="left" valign="top"><input type="text" required="" value="${getparts.c}" name="c" id="textfield5" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type D cost: </td>
                    <td align="left" valign="top"><input type="text" required="" value="${getparts.d}" name="d" id="textfield5" /></td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type: </td>
                    <td align="left" valign="top">
                        <select required="" name="itemtype">
                            <c:choose>
                                <c:when test="${getparts.itemtype=='part'}">
                                    <option value="part" selected="">part</option>
                                    <option value="consumable">consumable</option>
                                </c:when>
                                <c:when test="${getparts.itemtype=='consumable'}">
                                    <option value="part">part</option>
                                    <option value="consumable" selected="">consumable</option>
                                </c:when>
                            </c:choose>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td> <input type="submit" value="Update" class="view3" /> &nbsp;&nbsp;&nbsp;<input type="reset" value="Reset" class="view3" /></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>

            <input type="hidden" name="id" value="${getparts.id}" />
        </form>
    </body>
</html>
