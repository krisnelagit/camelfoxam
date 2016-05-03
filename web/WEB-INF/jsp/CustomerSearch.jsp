<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : CustomerSearch
    Created on : 30-Jul-2015, 11:37:29
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Search</title> 
        <link href="css/jquery-ui search mod.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>        
        <script>
            function getcustomermobile() {
                var mobileno = $("#mobileno").val();
                $.ajax({
                    url: "getcustomerdetailsearch",
                    dataType: 'json',
                    type: 'POST',
                    data: {
                        mobileno: mobileno
                    }, success: function (data) {
                        //adding the data to source array for autocomplete
                        var availableTags = [];
                        var sourced = [];
                        var mappingd = {};
                        for (var i = 0; i < data.length; i++) {
                            availableTags.push({label: data[i].mobilenumber, value: data[i].id});
                        }
                        for (var i = 0; i < availableTags.length; ++i) {
                            sourced.push(availableTags[i].label);
                            mappingd[availableTags[i].label] = availableTags[i].value;
                        }
                        //adding the data to source array for autocomplete end! here

                        //autocomplete code begin here
                        $("#mobileno").autocomplete({
                            source: sourced,
                            select: function (event, ui) {
                                var customerid = mappingd[ui.item.value];
                                location.href = "/Karworx_child_A/viewCustomerSearchLink?customerid=" + customerid;
                            },
                            change: function () {
                                var val = $(this).val();
                                var exists = $.inArray(val, sourced);
                                if (exists < 0) {
                                    $(this).val("");
                                    return false;
                                } else {

                                }
                            }
                        });
                        //autocomplete code end! here
                    },
                    error: function () {

                    }
                });
            }
        </script>
    </head>
    <body>
        <h2>Customer search</h2>
        <br />
        <div style="margin: 0 auto;text-align: center">
            <input type="text" id="mobileno" placeholder="enter mobile number.." name="customermobilenumber" style="width: 600px;height: 30px;"  onkeypress="getcustomermobile()" value="" />
        </div>
    </body>
</html>
