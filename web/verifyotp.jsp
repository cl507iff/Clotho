



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OTP</title>
        <link rel="stylesheet" href="stylesheets/style_2.css">
       <!-- Include Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">



    </head>
    <body style="background-color: beige">
        <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19,112,79); padding-left: 20px; height: 40px;">
            <div class="container-fluid">
                <a class="navbar-brand" style="color: white;" href="#">Clotho</a>
            </div>
        </nav>
         <%!
            String  votp;
            %>
        <%
            HttpSession sess = request.getSession(true);
            try
            {
                if(sess!=null) 
                {
                    votp = sess.getAttribute("otp").toString();
                }
            }
            catch(Exception ex)
            {
                %>
                <script>
                    alert("Session was not created!");
                </script>
                <%  
            }
            if(request.getParameter("bVerify")!=null)
            {
                if(request.getParameter("tbOTP").equals(votp))
                {
                %>
                <script>
                    alert("OTP verified");
                    location.href="http://localhost:8080/minor_project/NewPassword.jsp";
                </script>
                <%
                }
                else
                {
                       %> 
<!--                       <h3 style="text-align: center">The OTP you have entered is incorrect</h3>                 -->
                            <script>
                                alert("The OTP is incorrect");
                            </script>
                        <%
                }
            }
           %>   
    <div class="box" style="margin-top: 70px;">
           <h3 style="text-align: center;"> OTP Verification Form </h3>
           <br/>
        <form name="frmOTP" action="http://localhost:8080/minor_project/verifyotp.jsp" method="post">
  
      <label for="psw">Enter Your One Time Password</label>
      <input type="password" placeholder="Enter OTP" name="tbOTP" required><br>
        <button type="submit" name="bVerify">Verify</button>
    </form>
      </div>
    <div style="text-align: center; background-color: white; height: 30px; padding: 10px;" class="fixed-bottom">
            <p>Made by team Clotho</p>
        </div>
   
<!-- Include Bootstrap JS bundle (includes Popper.js) -->
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>