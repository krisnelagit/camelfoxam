<!doctype html>
<!--[if lt IE 7]> <html class="ie6 oldie"> <![endif]-->
<!--[if IE 7]>    <html class="ie7 oldie"> <![endif]-->
<!--[if IE 8]>    <html class="ie8 oldie"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="">
    <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login</title>
        <link href="css/login_style.css" rel="stylesheet" type="text/css">
        <style>
            html{
                background:#f4f4f4;	
            }
        </style>
    </head>
    <body>
        <form action="verifylogin" method="POST">

            <div class="clearfix">
                <div id="LayoutDiv1">
                    <div class="container">
                        <center><img src="images/karlogo_login.jpg" class="logo2"></center>

                        <div class="login">


                            <input type="text" class="username" name="username" placeholder="Username" required=""  style="width:100%"><br>
                            <br>
                            <input type="password" class="password" name="password" placeholder="Password" required="" style="width:100%"><br>
                            <br>
                            <input type="submit" value="Login" class="btn3" /> <a href="#" style="float:right;display: none" class="forgot">Forgot your password?</a>
                        </div>

                        <center><font color="red">${errmsg}</font></center>
                        <center><b>powered by</b><br/> <img src="images/krisnela_logo.png" class="logo2" style="width: 160px;height: 30px"></center>

                    </div>

                </div>
            </div><br>
            <br>
            <br>
            <br>
        </form>
    </body>
</html>