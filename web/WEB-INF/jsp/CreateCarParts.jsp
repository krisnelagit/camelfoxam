<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : CreateCarParts
    Created on : 16 Mar, 2015, 6:38:01 PM
    Author     : pc2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Car Parts</title>
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
                                    $('#vehicle').append('<option value="'+data[i].id+'">' + data[i].name + '</option>');
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
        <form action="insertcarparts" method="post">
        <a href="spareparts" class="view">Back</a>
        <h2>Car Parts</h2>
        <br />

        <table width="100%" cellpadding="5">
            
            <tr>
                <td align="left" valign="top">Item name</td>
                <td align="left" valign="top"><input type="text" name="itemname" id="textfield5" /></td>
            </tr>
            <tr>
                <td align="left" valign="top">Category name</td>
                <td align="left" valign="top">                
                    <select name="category" required="">
                        <option value="">--select--</option>
                        <c:forEach var="ob" items="${catdtls}">
                            <option value="${ob.id}">${ob.name}</option>
                        </c:forEach>                        
                    </select>
                </td>
            </tr>
            <tr>
                <td>Brand</td>
                <td><label for="select"></label>
                    <select name="brand" id="brand" required="">
                        <option selected="selected" value="">--select--</option>
                        <c:forEach var="ob" items="${branddtls}">
                            <option value="${ob.id}">${ob.name}</option>
                        </c:forEach>
                        
                    </select></td>
            </tr>
            <tr>
                <td>Vehicle</td>
                <td><select name="vehicle" id="vehicle" required="">
                        <option value="">--select--</option>
                    </select></td>
            </tr>
            <tr>
                <td>Model</td>
                <td><input type="text" name="model" id="textfield9" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td> <input type="submit" value="Save" class="view3" /> &nbsp;&nbsp;&nbsp;<input type="reset" value="Reset" class="view3" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        </form>
    </body>
</html>
