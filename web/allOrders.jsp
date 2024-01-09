<%-- 
    Document   : allOrders
    Created on : 15 Nov, 2023, 2:12:59 AM
    Author     : prast
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Orders</title>
            
        <link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">
        
        <style>
            * {
            box-sizing: border-box;
        }
        

        body {
            background-color: beige;
            margin: 0;
        }
        .row{
                    box-shadow: 3px 2px 22px 1px rgba(0, 0, 0, 0.24);
                    margin-bottom: 10px;  
                    border-radius: 10px; 
                    background-color: white;
                }
        </style>
    </head>
    <body>
          <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19, 112, 79); padding-left: 20px">
        <div class="container-fluid container">
        <a class="navbar-brand" style="color: white;" href="index.jsp">Clotho</a>
        <a class="btn btn-outline-light" href="http://localhost:8080/minor_project/Logout">Logout</a>
        </div>
        </nav>
        <div class="container container-fluid mt-2">
    <h2>My orders</h2>
    <br>
    <div class="container container-fluid align-items-center">
        
            <% try{
                String uid=(String) session.getAttribute("uid");
                String sql="SELECT * FROM ORDERS WHERE U_ID=?";
                Class.forName("oracle.jdbc.OracleDriver");
                Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
                PreparedStatement ps =  connection.prepareStatement(sql);
                ps.setString(1, uid);
                ResultSet  r= ps.executeQuery();
                
                while(r.next()){
                    String pid = r.getString("PID").trim();
                    String sql2="SELECT * FROM PRODUCTS WHERE PID=?";
                    PreparedStatement ps2= connection.prepareStatement(sql2);
                    ps2.setString(1, pid);
                    ResultSet r2= ps2.executeQuery();
                    while(r2.next()){
                        
                        String image = r2.getString("IMG");
                        String pname = r2.getString("PNAME");
                        String price = r2.getString("PRICE");
            %>
            <div class="row">
                    <div class="col col-2 p-2">
                        <img class="img img-thumbnail" src='images/pics/<%= image %>' alt='' style="height:100px; width:100px;">
            </div>
            <div class="col col-10" style="padding-top: 15px;">
                <h4> <%= pname %> </h4>
                <p>Rs. <%= price %></p>
            </div>
            </div>            
           <%         }
                }} catch(Exception e){
                e.printStackTrace();
}
            %>
            
                
        
</div>
            <div style="text-align: center; background-color: white; height: 40px; padding: 10px;" class="fixed-bottom">
            <p>Made by team Clotho</p>
            </div>
           
        <!-- Include Bootstrap JS bundle (includes Popper.js) -->
        <script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
