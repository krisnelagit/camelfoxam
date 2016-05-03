<%-- 
    Document   : Testpage
    Created on : 7 Jan, 2015, 12:47:24 PM
    Author     : krisnela
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="css/tabs.css">
        <script src="js/jquery-1.10.2.min.js"></script>
        <script src="js/jquery.dataTables.js"></script>

        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
            $(document).ready(function () {
                $('#table_id2').DataTable();
            });
        </script>
    </head>
    <body>
        <a href="inventory-spares.html" class="view">Back</a>
        <h2>Inventory Quantity</h2>
        <br />

        <table width="100%" cellpadding="5">
            <tr>
                <td width="34%" align="left" valign="top">Date</td>
                <td width="66%" align="left" valign="top"><label for="textfield"></label>
                    01-01-2015</td>
            </tr>
            <tr>
                <td align="left" valign="top">Brand</td>
                <td align="left" valign="top"><select name="select" id="select">
                        <option selected="selected">Maruti</option>
                        <option>Hyundai</option>
                        <option>Honda</option>
                        <option>Mahindra</option>
                        <option>Mitsubishi</option>
                        <option>Renault</option>
                        <option>Skoda</option>
                        <option>Toyota</option>
                        <option>Daewoo</option>
                        <option>Fiat</option>
                        <option>Ford</option>
                        <option>TATA</option>
                        <option>Chevrolette</option>
                        <option>Mercedes</option>
                        <option>VolksWagon</option>
                        <option>BMW</option>
                        <option>Audi</option>
                        <option>Porschue</option>
                        <option>Range Rover</option>
                        <option>Jaguar</option>
                    </select></td>
            </tr>
            <tr>
                <td align="left" valign="top">Vendor Name</td>
                <td align="left" valign="top"><select name="select2" id="select2">
                        <option selected="selected">Shakti Auto</option>
                        <option>Sai Service</option>
                    </select></td>
            </tr>
            <tr>
                <td>Quantity</td>
                <td><label for="textfield2"></label>
                    <input type="text" name="textfield" id="textfield2" /></td>
            </tr>
            <tr>
                <td>Cost Price</td>
                <td><input type="text" name="textfield2" id="textfield" /></td>
            </tr>
            <tr>
                <td>Selling Price</td>
                <td><input type="text" name="textfield3" id="textfield3" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><a href="#" class="view2">Save</a>&nbsp;&nbsp;&nbsp;<a href="#" class="view2">Cancel</a></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>





        <ul id="tabs">
            <li><a href="#" name="#tab1">Inward</a></li>
            <li><a href="#" name="#tab2">Outward</a></li> 
        </ul>  

        <div id="content">
            <div id="tab1">

                <table class="display tablestyle" id="table_id">
                    <thead>
                        <tr>
                            <th align="left">Date</th>
                            <th align="left">Brand</th>
                            <th align="left">Vendor Name</th>
                            <th align="left">Cost Price</th>
                            <th align="left">Selling Price</th>
                            <th align="left">Qty</th>
                            <th align="left">&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>22/01/15</td>
                            <td>Maruti</td>
                            <td>Shakti Auto</td>
                            <td>400</td>
                            <td>600</td>
                            <td>10</td>
                            <td><img src="images/edit.png" width="16" height="15" />&nbsp;&nbsp;<img src="images/delete.png" width="16" height="17" /></td>
                        </tr>
                        <tr>
                            <td height="19">22/01/15</td>
                            <td>OZ</td>
                            <td>Sai Maruti</td>
                            <td>400</td>
                            <td>600</td>
                            <td>20</td>
                            <td><img src="images/edit.png" width="16" height="15" />&nbsp;&nbsp;<img src="images/delete.png" width="16" height="17" /></td>
                        </tr>
                    </tbody>
                </table> 
            </div>
            <div id="tab2">

                <table class="display tablestyle" id="table_id2">
                    <thead>
                        <tr>
                            <th align="left">Date</th>
                            <th align="left">Brand</th>
                            <th align="left">Vendor Name</th>
                            <th align="left">Cost Price</th>
                            <th align="left">Selling Price</th>
                            <th align="left">Qty</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>22/01/15</td>
                            <td>Maruti</td>
                            <td>Shakti Auto</td>
                            <td>400</td>
                            <td>600</td>
                            <td>10</td>
                        </tr>
                        <tr>
                            <td height="19">22/01/15</td>
                            <td>OZ</td>
                            <td>Sai Maruti</td>
                            <td>400</td>
                            <td>600</td>
                            <td>20</td>
                        </tr>
                    </tbody>
                </table>

                <script>

                    function resetTabs() {

                        $("#content > div").hide(); //Hide all content

                        $("#tabs a").attr("id", ""); //Reset id's      

                    }



                    var myUrl = window.location.href; //get URL

                    var myUrlTab = myUrl.substring(myUrl.indexOf("#")); // For localhost/tabs.html#tab2, myUrlTab = #tab2     

                    var myUrlTabName = myUrlTab.substring(0, 4); // For the above example, myUrlTabName = #tab



                    (function () {

                        $("#content > div").hide(); // Initially hide all content

                        $("#tabs li:first a").attr("id", "current"); // Activate first tab

                        $("#content > div:first").fadeIn(); // Show first tab content



                        $("#tabs a").on("click", function (e) {

                            e.preventDefault();

                            if ($(this).attr("id") == "current") { //detection for current tab

                                return

                            }

                            else {

                                resetTabs();

                                $(this).attr("id", "current"); // Activate this

                                $($(this).attr('name')).fadeIn(); // Show content for current tab

                            }

                        });



                        for (i = 1; i <= $("#tabs li").length; i++) {

                            if (myUrlTab == myUrlTabName + i) {

                                resetTabs();

                                $("a[name='" + myUrlTab + "']").attr("id", "current"); // Activate url tab

                                $(myUrlTab).fadeIn(); // Show url tab content        

                            }

                        }

                    })()

                </script>  
                </body>
                </html>
