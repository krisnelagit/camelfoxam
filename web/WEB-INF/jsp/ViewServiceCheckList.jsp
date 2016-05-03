<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : ViewServiceCheckList
    Created on : 04-May-2015, 10:44:10
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Service CheckList</title>
        <link href="css/csstable.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <link href="css/other_style.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-1.8.3.js" type="text/javascript"></script>
        <!--<script src="js/jquery.tools.min.js"></script>-->
        <script src="js/jquery-ui.js" type="text/javascript"></script>

        <!--<link rel="stylesheet" type="text/css" href="css/tabs-accordion.css"/>-->
        <link rel="stylesheet" href="css/jquery-ui_1.css" />
        <script>
            $(document).ready(function () {
                
                $("input[type='checkbox']").prop({
                    disabled: true
                });

                $("input[type='text']").prop({
                    disabled: true
                });

            });
        </script>
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
                    font-size: 1px !important;
                }
            }  
        </style>
    </head>
    <body>
        <input type="hidden" name="existing" id="existing" value="no" />
        <input type="hidden" name="vid" id="vid" value="no" />

        <a href="service_checklist_grid.html" class="view">Back</a> &nbsp;<a href="#" class="view button-001" onclick="printContent('printdiv')">Print</a>
        <c:if test="${!sessionScope.USERTYPE.equals('spares')}">
            <c:choose>
                <c:when test="${servicedtls.is180ready=='No'}">
                    <a href="EditServiceCheckList.html?id=${servicedtls.cvid}&bdid=${servicedtls.brandid}" class="view">Edit</a>
                </c:when>
            </c:choose>
        </c:if>
        <h2>Service Check List</h2>
        <div id="printdiv">
        <table width="100%" cellpadding="5">

            <tr>
                <td align="left" valign="top">Date</td>
                <td align="left" valign="top">
                    ${servicedtls.date}
                </td>
                <td align="left" valign="top">Customer mobile no.</td>
                <td align="left" valign="top">
                    ${servicedtls.cusmobile}
                </td>
            </tr>


            <tr>
                <td align="left" valign="top">Customer Name</td>
                <td align="left" valign="top">${servicedtls.custname}</td>


                <td width="13%" align="left" valign="top">Vehicle No.(eg: DL 01 C AA 1155)</td>
                <td width="26%" align="left" valign="top">
                    <label for="textfield"></label>
                    ${servicedtls.vehiclenumber}
                </td>
            </tr>

            <tr>
                <td width="13%" align="left" valign="top">Car brand</td>
                <td width="26%" align="left" valign="top"><label for="textfield"></label>
                    ${servicedtls.carbrand}
                </td>
                <td width="23%" align="left" valign="top">Vehicle Model</td>
                <td width="38%" align="left" valign="top">
                    ${servicedtls.carmodel}
                </td>
            </tr>

            <tr><td width="13%" align="left" valign="top">KM. in</td>
                <td width="26%" align="left" valign="top">
                    <label for="textfield"></label>
                    ${servicedtls.km_in}
                </td>
                <td width="23%" align="left" valign="top">VIN No.</td>
                <td width="38%" align="left" valign="top">${servicedtls.vinnumber}</td>
            </tr>

            <tr>
                <td width="13%" align="left" valign="top">Service Booklet</td>
                <td width="26%" align="left" valign="top">
                    <label for="textfield"></label>
                    <input type="checkbox" disabled="" name="servicebooklet" value="checked" ${servicedtls.servicebooklet}/>
                </td>
                <td width="23%" align="left" valign="top">Documents Reg Paper</td>
                <td width="38%" align="left" valign="top">
                    <input type="checkbox" disabled="" name="docregpaper" value="checked" ${servicedtls.docregpaper}/>
                </td>
            </tr>

            <tr>
                <td width="13%" align="left" valign="top">Rim Lock</td>
                <td width="26%" align="left" valign="top">
                    <label for="textfield"></label>
                    <input type="checkbox" disabled="" name="rimlock" value="checked" ${servicedtls.rimlock}/>
                </td>
                <td width="23%" align="left" valign="top">Tool Kit</td>
                <td width="38%" align="left" valign="top">
                    <input type="checkbox" disabled="" name="toolkit" value="checked" ${servicedtls.toolkit}/>
                </td>
            </tr>

            <tr>
                <td width="13%" align="left" valign="top">Old Parts Request</td>
                <td width="26%" align="left" valign="top">
                    <label for="textfield"></label>
                    <input type="checkbox" name="oldpartsrequest" disabled="" value="checked" ${servicedtls.oldpartsrequest}/>
                </td>
                <td width="23%" align="left" valign="top">Fuel Level</td>
                <td width="38%" align="left" valign="top">
                    <select disabled="" name="fuellevel">
                        <c:choose>
                            <c:when test="${servicedtls.fuellevel=='Res'}">
                                <option selected="">Res</option>
                                <option>1/4</option>
                                <option>1/2</option>
                                <option>3/4</option>
                                <option>Full</option>
                            </c:when>
                            <c:when test="${servicedtls.fuellevel=='1/4'}">
                                <option >Res</option>
                                <option selected="">1/4</option>
                                <option>1/2</option>
                                <option>3/4</option>
                                <option>Full</option>
                            </c:when>
                            <c:when test="${servicedtls.fuellevel=='1/2'}">
                                <option>Res</option>
                                <option>1/4</option>
                                <option selected="">1/2</option>
                                <option>3/4</option>
                                <option>Full</option>
                            </c:when>
                            <c:when test="${servicedtls.fuellevel=='3/4'}">
                                <option >Res</option>
                                <option>1/4</option>
                                <option>1/2</option>
                                <option selected=""> 3/4</option>
                                <option>Full</option>
                            </c:when>
                            <c:when test="${servicedtls.fuellevel=='Full'}">
                                <option >Res</option>
                                <option>1/4</option>
                                <option>1/2</option>
                                <option>3/4</option>
                                <option selected="">Full</option>
                            </c:when>
                        </c:choose>
                    </select>
                </td>
            </tr>

            <tr>
                <td width="13%" align="left" valign="top">Driver name</td>
                <td width="26%" align="left" valign="top">
                    <label for="textfield"></label>    
                    ${servicedtls.drivername}
                </td>
                <td width="23%" align="left" valign="top">Driver number</td>
                <td width="38%" align="left" valign="top">
                    <label for="textfield"></label>
                    ${servicedtls.drivernumber}
                </td>
            </tr>

            <!--                <tr>
                                
                                <td align="left" valign="top">Licence No.</td>
                                <td align="left" valign="top"><input type="text" pattern="^[a-zA-Z0-9]*$" title="Please enter a valid Licence No." maxlength="17" name="licensenumber" id="licensenumber" /></td>
                                <td width="23%" align="left" valign="top">&nbsp;</td>
                                <td width="38%" align="left" valign="top">&nbsp;</td>
                            </tr>-->
        </table>
        <!--till nitz-->
        <!--new view of service checklist begins! here-->
        <TABLE id="dataTable" border="0" class="CSSTableGenerator">
            <TR>
                <TD width="20%" align="left"><strong>Categories</strong></TD>
                <td width="80%" align="center"><strong>List</strong></td>
            </TR>
            <tr>
                <td align="left" valign="top">
                    <span class="current">Inside Check</span>
                </td>
                <td align="left" valign="top">
                    <div class="category-spacing">No Micro Filter &nbsp; <input class="" type="checkbox" name="nomicrofilter" value="checked" ${servicedtls.nomicrofilter}/></div>
                    <div class="category-spacing">Instrument Lighting  &nbsp; <input type="checkbox" name="instrumentlighting" value="checked" ${servicedtls.instrumentlighting} /></div>
                    <div class="category-spacing">Steering &nbsp; <input type="checkbox" name="steering" value="checked" ${servicedtls.steering}/></div>
                    <div class="category-spacing">Micro Filter &nbsp; <input type="checkbox" name="microfilter" value="checked" ${servicedtls.microfilter}/></div>
                    <div class="category-spacing">Handbrake &nbsp; <input type="checkbox" name="handbrake" value="checked" ${servicedtls.handbrake}/></div>
                    <div class="category-spacing">Pedal-noise  &nbsp; <input type="checkbox" name="pedalnoise" value="checked"  ${servicedtls.pedalnoise} /></div>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <span class="current">Engine Check</span>
                </td>
                <td align="left" valign="top">
                    <div class="category-spacing">Cooling System   &nbsp; <input type="checkbox" name="coolingsystem" value="checked" ${servicedtls.coolingsystem}/></div>
                    <div class="category-spacing">Brake Fluid &nbsp; <input type="checkbox" name="brakefluid" value="checked" ${servicedtls.brakefluid}/></div>
                    <div class="category-spacing">Steering Fluid &nbsp; <input type="checkbox" name="steeringfluid" value="checked" ${servicedtls.steeringfluid}/></div>
                    <div class="category-spacing">V-belt / Poly V-belt  &nbsp; <input type="checkbox" name="vbelt" value="checked" ${servicedtls.vbelt}/></div>
                    <div class="category-spacing">Last Inspection  &nbsp; ${servicedtls.lastinspection} KM.</div>
                    <div class="category-spacing">Cleanwise  &nbsp; ${servicedtls.cleanwise}</div>
                    <div class="category-spacing">Noticeable Leaks &nbsp; <input type="checkbox" name="noticableleaks" value="checked" ${servicedtls.noticableleaks}/></div>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <span class="current">Vehicle Check</span>
                </td>
                <td align="left" valign="top">
                    <div class="category-spacing">Cooling System &nbsp; <input type="checkbox" name="Vcoolingsystem" value="checked" ${servicedtls.Vcoolingsystem} /></div>
                    <div class="category-spacing">Wiper Blades &nbsp; <input type="checkbox" name="wiperblades" value="checked" ${servicedtls.wiperblades}/></div>
                    <div class="category-spacing">Window Glass &nbsp; <input type="checkbox" name="windowglass" value="checked" ${servicedtls.windowglass}/></div>
                    <div class="category-spacing">Body &nbsp; <input type="checkbox" name="body" value="checked" ${servicedtls.body}/></div>

                </td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <span class="current">Vehicle Check (Half Raised)</span>
                </td>
                <td align="left" valign="top">
                    <div class="category-spacing">Rear lights / Headlights  &nbsp; <input type="checkbox" name="headlights" value="checked" ${servicedtls.headlights}/></div>
                    <div class="category-spacing">Shockabsorber &nbsp; <input type="checkbox" name="shockabsorber" value="checked"  ${servicedtls.shockabsorber}/></div>
                    <div class="category-spacing">Tyre Tread &nbsp; <input type="checkbox" name="tyretread" value="checked"  ${servicedtls.tyretread}/></div>
                    <div class="category-spacing">Front Brake pads / Discs &nbsp; <input type="checkbox" name="frontbrake" value="checked"  ${servicedtls.frontbrake}/></div>
                    <div class="category-spacing">Brake Lines / Hoses &nbsp; <input type="checkbox" name="hoses" value="checked" ${servicedtls.hoses}/></div>
                    <div class="category-spacing">Rear Brake Pads / Discs &nbsp; <input type="checkbox" name="rearbrake" value="checked" ${servicedtls.rearbrake}/>   </div>                 
                </td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <span class="current">Vehicle Check (Fully  Raised)</span>
                </td>
                <td align="left" valign="top">
                    <div class="category-spacing">Exhaust System &nbsp; <input type="checkbox" name="exhaustsystem" value="checked" ${servicedtls.exhaustsystem}/></div>
                    <div class="category-spacing">Rear Axle &nbsp; <input type="checkbox" name="rearaxle" value="checked" ${servicedtls.rearaxle}/></div>
                    <div class="category-spacing">Gear Box / Leaking  &nbsp; <input type="checkbox" name="gearbox" value="checked" ${servicedtls.gearbox}/></div>
                    <div class="category-spacing">Fuel Tank / Lines  &nbsp; <input type="checkbox" name="fueltank" value="checked" ${servicedtls.fueltank}/></div>
                    <div class="category-spacing">Cooling System &nbsp; <input type="checkbox" name="Vfullyraisedcoolingsystem" value="checked" ${servicedtls.Vfullyraisedcoolingsystem}/></div>
                    <div class="category-spacing">Final Drive / Leaking &nbsp; <input type="checkbox" name="finaldrive" value="checked" ${servicedtls.finaldrive}/></div>
                    <div class="category-spacing">Front Axle  &nbsp; <input type="checkbox" name="frontaxle" value="checked" ${servicedtls.frontaxle}/></div>
                    <div class="category-spacing">Engine Leaks &nbsp; <input type="checkbox" name="engineleaks" value="checked" ${servicedtls.engineleaks}/></div>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <span class="current">Car Wash</span>
                </td>
                <td align="left" valign="top">
                    <div class="category-spacing">Cooling System &nbsp; <input type="checkbox" name="carwashcoolingsystem" value="checked" ${servicedtls.carwashcoolingsystem}/></div>
                    <div class="category-spacing">Exterior Polish  &nbsp; <input type="checkbox" name="exteriorpolish" value="checked" ${servicedtls.exteriorpolish}/></div>
                    <div class="category-spacing">Interior Cleaning &nbsp; <input type="checkbox" name="interiorcleaning" value="checked" ${servicedtls.interiorcleaning}/></div>
                    <div class="category-spacing">Wheel Rim Cleaning &nbsp; <input type="checkbox" name="wheelrimcleaning" value="checked" ${servicedtls.wheelrimcleaning}/></div>
                    <div class="category-spacing">Body Protection &nbsp; <input type="checkbox" name="bodyprotection" value="checked" ${servicedtls.bodyprotection}/></div>
                    <div class="category-spacing">Anti-Rust Treatment  &nbsp; <input type="checkbox" name="antirust" value="checked" ${servicedtls.antirust}/></div>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <span class="current">Additional Work</span>
                </td>
                <td align="left" valign="top">
                    <div class="category-spacing">Comment the addition task done:</div>
                    <div class="category-spacing">${servicedtls.additionalwork}</div>
                </td>
            </tr>
        </TABLE>
        <!--new view of service checklist ends here-->

        <br />
    <center>

    </center> 
    <input type="hidden" name="id" value="${servicedtls.cvid}" />
    <input type="hidden" name="cvdid" value="${servicedtls.cvdid}" />
    <input type="hidden" name="brandid" id="brandid" value="${servicedtls.brandid}" />
    <input type="hidden" name="branddetailid" id="branddetailid" value="${servicedtls.branddetailid}" />
    </div>
</body>
</html>
