<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewSparePartDetails
    Created on : 29-May-2015, 13:56:53
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Car Parts</title>
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
            <!--<a href="spareparts" class="view">Back</a>-->
            <h2>Car Parts Details</h2>
            <br />

            <table width="100%" cellpadding="5">

                <tr>
                    <td align="left" valign="top">Item name</td>
                    <td align="left" valign="top">${getparts.name}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Category name</td>
                    <td align="left" valign="top">
                            <c:forEach var="ob" items="${catdtls}">
                                <c:choose>
                                    <c:when test="${getparts.categoryid==ob.id}">
                                        ${ob.name}
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                    </td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type A cost: </td>
                    <td align="left" valign="top">${getparts.a}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type B cost: </td>
                    <td align="left" valign="top">${getparts.b}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type C cost: </td>
                    <td align="left" valign="top">${getparts.c}</td>
                </tr>
                <tr>
                    <td align="left" valign="top">Type D cost: </td>
                    <td align="left" valign="top">${getparts.d}</td>
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
