<%-- 
    Document   : ViewSynchronization
    Created on : 15 Mar, 2016, 12:40:31 PM
    Author     : manish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Synchronization</title>
        <script src="js/jquery-1.8.3.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                console.log("ready!");
                $('#modps').removeClass().addClass('psbox');
            });
        </script>
        <style>
            .psbox {
                position: relative;
                margin: 0 auto;
                width: 960px;
                height: auto;
                padding: 20px;
                top: 30px;
                /* border-radius: 5px; */
                /* background-color: #fff; */
                -moz-box-shadow: 1px 1px 5px #CCCCCC;
                /* -webkit-box-shadow: 1px 1px 5px #CCCCCC; */
                /* box-shadow: 1px 1px 5px #CCCCCC; */
            }
        </style>

        <style>
            /*@charset "utf-8";*/

            /* CSS Document */
            .cf:before, .cf:after {
                content:"";
                display:table;
            }
            .cf:after {
                clear:both;
            }
            /* Normal styles for the modal */
            #modal {
                left:70%;
                margin:-250px 0 0 -40%;
                opacity: 0;
                position:fixed;
                top:0%;
                visibility: hidden;
                width:30%;
                box-shadow:0 3px 7px rgba(0, 0, 0, .25);
                box-sizing:border-box;
                transition: all 0.4s ease-in-out;
                -moz-transition: all 0.4s ease-in-out;
                -webkit-transition: all 0.4s ease-in-out;
                z-index: 800;
            }
            /* Make the modal appear when targeted */
            #modal:target {
                opacity: 1;
                top:60%;
                visibility: visible;
            }
            #modal .header, #modal .footer {
                border-bottom: 1px solid #e7e7e7;
                border-radius: 5px 5px 0 0;
            }
            #modal .footer {
                border:none;
                border-top: 1px solid #e7e7e7;
                border-radius: 0 0 5px 5px;
            }
            #modal h2 {
                margin:0;
            }
            #modal .btn {
                float:right;
            }
            #modal .copy, #modal .header, #modal .footer {
                padding:15px;
            }
            .modal-content {
                background: #f7f7f7;
                position: relative;
                z-index: 20;
                border-radius:5px;
            }
            #modal .copy {
                background: #fff;
            }
            #modal .overlay {
                background-color: #000;
                background: rgba(0, 0, 0, .5);
                height: 100%;
                left: 0;
                position: fixed;
                top: 0;
                width: 100%;
            }
            #modal1 {
                left:70%;
                margin:-250px 0 0 -40%;
                opacity: 0;
                position:fixed;
                top:0%;
                visibility: hidden;
                width:40%;
                box-shadow:0 3px 7px rgba(0, 0, 0, .25);
                box-sizing:border-box;
                transition: all 0.4s ease-in-out;
                -moz-transition: all 0.4s ease-in-out;
                -webkit-transition: all 0.4s ease-in-out;
            }
            /* Make the modal appear when targeted */
            #modal1:target {
                opacity: 1;
                top:60%;
                visibility: visible;
            }
            #modal1 .header, #modal .footer {
                border-bottom: 1px solid #e7e7e7;
                border-radius: 5px 5px 0 0;
            }
            #modal1 .footer {
                border:none;
                border-top: 1px solid #e7e7e7;
                border-radius: 0 0 5px 5px;
            }
            #modal1 h2 {
                margin:0;
            }
            #modal1 .btn {
                float:right;
            }
            #modal1 .copy, #modal1 .header, #modal1 .footer {
                padding:15px;
            }
            .modal1-content {
                background: #f7f7f7;
                position: relative;
                z-index: 20;
                border-radius:5px;
            }
            #modal1 .copy {
                background: #fff;
            }
            #modal1 .overlay {
                background-color: #000;
                background: rgba(0, 0, 0, .5);
                height: 100%;
                left: 0;
                position: fixed;
                top: 0;
                width: 100%;
            }

        </style>
    </head>
    <body>
        <!--Sync box begins here-->
        <div id="modal">
            <div class="modal-content">
                <div class="header">
                    <h2>Please wait</h2>
                </div>
                <div class="copy">
                    <img src="images/syncc.gif"/>
                </div>
                <div class="cf footer">	
                </div>
            </div>
            <div class="overlay"></div>
        </div>
        <!--Sync box ends here-->
        <div class="box"> 
            <a href="startSyncLink" onclick="document.getElementById('showblack').click()" >
                <div class="box02" style="margin: 0px;width: 158px">
                    <div class="img02">
                        <img src="images/computer.png" height="70" width="70">
                    </div>
                    <div class="text03">System sync</div>
                </div>
            </a> 
        </div>
        <div class="box"> 
            <a href="startPartSyncLink" onclick="document.getElementById('showblack').click()" >
                <div class="box02" style="margin: 0px;width: 158px">
                    <div class="img02">
                        <img src="images/cogwheel.png" height="70" width="70">
                    </div>
                    <div class="text03">Part sync</div>
                </div>
            </a> 
        </div>
        <a href="#modal" id="showblack" ></a>
    </body>
</html>
