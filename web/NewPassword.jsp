

<%@page import="oracle.jdbc.OracleConnection"%>
<%@ page import="java.sql.*" %>
<%@ page import="oracle.jdbc.OraclePreparedStatement" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Password Reset Page</title>
        <link rel="stylesheet" href="stylesheets/style_2.css">
     
        <link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">
       
    </head>
    <body style="background-color: beige">
        <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19,112,79); padding-left: 20px; height: 40px;">
            <div class="container-fluid">
                <a class="navbar-brand" style="color: white;" href="#">Clotho</a>
            </div>
        </nav>
        <%!
            String vemail, vpass;
            OracleConnection oconn;
            OraclePreparedStatement ost;
            HttpSession sess;
        %>
        <%
            sess = request.getSession(true);

            if (request.getParameter("bConfirm") != null) {
                if (request.getParameter("tpass").equals(request.getParameter("cpass"))) {
                    vpass = request.getParameter("tpass");
                    vemail = sess.getAttribute("sessemail").toString();

                    try {
                        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
                        oconn = (OracleConnection) DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
                        ost = (OraclePreparedStatement) oconn.prepareStatement("update USERS set  PASSWORD=? where EMAIL=?");
                        ost.setString(1, vpass);
                        ost.setString(2, vemail);
                        int x = ost.executeUpdate();
                        ost.close();
                        oconn.close();
        %>
                        <script>
                            alert("Your password has been changed successfully. Kindly Login again.");
                            window.location.href = "http://localhost:8080/minor_project/singin.jsp";
                        </script>
        <%
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                } else {
        %>
                    <h3 style="color:red">Password do not match!</h3>
        <%
                }%>
            } else {
                
                <h3 style="text-align: center; color: blueviolet">
                    Please verify your security credentials.
                </h3>
                <%
            }
        %>
        <div class="box" style="margin-top: 70px;">
           <h3 style="text-align: center;"> Change Password </h3>
           <br/>
        <form>
      <label for="psw">New Password:-</label>
      <input type="text" placeholder="Enter your new paswword" name="tpass" id="tpass" required>
      <label for="psw">Confirm Password:-</label>
      <input type="text" placeholder="Renter your new paswword" name="cpass" id="cpass" required>
        <button type="submit" name="bConfirm">Submit</button>
        </form>
      </div>
    <div style="text-align: center; background-color: white; height: 30px; padding: 10px;" class="fixed-bottom">
            <p>Made by team Clotho</p>
        </div>
        <!-- Include Bootstrap JS bundle (includes Popper.js) -->
        <script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>