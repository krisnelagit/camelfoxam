<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : CleaningList
    Created on : 16-May-2015, 18:58:00
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cleaning List</title>
        <link href="css/jquery-ui_1.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-ui.js"></script>
        <script>
            $(function () {
                //popup for Edit followup details
                $("#dialognkEditDetail").hide();
                //on click of edit
                $(".edit_cleaning_link").click(function (e) {
                    e.preventDefault();
                    var jsid = $(this).attr('href');
                    $.ajax({
                        url: "editCleaningLink",
                        datatype: 'json',
                        type: 'POST',
                        data: {
                            jsid: jsid
                        },
                        cache: false,
                        success: function (data) {
                            //set user data
                            $('input:radio[name="cleaning"][value="'+ data[0].cleaning +'"]').attr('checked', true);

                            $("#jobsheetid").val(data[0].id);
                            //our edit dialog
                            $("#dialognkEditDetail").dialog({
                                modal: true,
                                effect: 'drop',
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
            });//END FUNCTION
        </script>
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">        
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
        </script>
    </head>
    <body>
        <h2>Cleaning List</h2>

        <br />
        <table class="display tablestyle" id="table_id">
            <thead>
                <tr>
                    <td>Sr. No.</td>
                    <td >Date</td>
                    <td >Customer Name</td>
                    <td>Brand</td>
                    <td>Model </td>
                    <td>Vehicle N0. </td>
                    <td>VIN  No.</td>
                    <td>Status </td>
                </tr>
            </thead>
            <tbody>
                <c:set value="1" var="count"></c:set>
                <c:forEach var="ob" items="${cleaningListDt}">
                    <tr>
                        <td align="left">${count}</td>
                        <td align="left">${ob.date}</td>
                        <td align="left">${ob.custname}</td>
                        <td align="left">${ob.carbrand}</td>
                        <td align="left">${ob.carmodel}</td>
                        <td align="left">${ob.vehiclenumber}</td>
                        <td align="left">${ob.vinnumber}</td>
                        <td align="left"> <a href="${ob.jsid}" class="edit_cleaning_link">&nbsp;&nbsp;${ob.cleaning} </a></td>
                    </tr>
                    <c:set value="${count+1}" var="count"></c:set>
                </c:forEach> 
            </tbody>
        </table>
        <!--edit cleaning detail dialog begin here-->
        <div id="dialognkEditDetail" title="Cleaning detail">
            <form method="POST" action="updateCleaning">                
                <input type="hidden" name="id" id="jobsheetid" />
                <table cellpadding="5" width="100%">
                    <tbody>
                        <tr>
                            <td align="left" valign="top" width="40%">Cleaning</td>
                            <td align="left" valign="top" width="60%">
                                <input type="radio" name="cleaning" class="cleaning" value="done">done<br>
                                <input type="radio" name="cleaning" class="cleaning" value="not done">not done
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" width="40%">&nbsp;</td>
                            <td align="left" valign="top" width="60%"><input type="submit" class="view3" value="Save" style="cursor: pointer" /></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <!--edit cleaning detail dialog end here!-->
    </body>
</html>
