<%-- 
    Document   : orderList
    Created on : 14 Nov, 2023, 11:46:13 PM
    Author     : prast
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orders List</title>
        <!-- Include Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">



        <style>
        body {
            background-color: beige;
            padding: 0;
            margin: 0;
        }
        .row{
            background-color: white;
            border-radius: 10px;
            padding:10px;
        }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19, 112, 79); padding-left: 20px">
        <div class="container-fluid container">
        <a class="navbar-brand" style="color: white;" href="Admin.jsp">Clotho</a>
        <a class="btn btn-outline-light" href="http://localhost:8080/minor_project/Logout">Logout</a>
        </div>
        </nav>
        <div class="container container-fluid" style=" padding:100px;">
            <% String sql = "SELECT * FROM ORDERS";
           String sql2="SELECT PNAME, IMG FROM PRODUCTS WHERE PID=?";
           Class.forName("oracle.jdbc.OracleDriver");
           Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
           PreparedStatement ps= connection.prepareStatement(sql);
           PreparedStatement ps2= null;
           ResultSet r= ps.executeQuery();
           ResultSet r2 = null; 
           while(r.next()){
               String pid = r.getString("PID");
               String uid= r.getString("U_ID");
               String oid= r.getString("OID");
               String add = r.getString("ADDRESS");
               String paymode = r.getString("PAYMODE"); 
               if (pid!= null){
                   pid = r.getString("PID").trim();
               
               ps2=connection.prepareStatement(sql2);
               ps2.setString(1, pid);
               r2 = ps2.executeQuery();
               while(r2.next()){
                   String pname=r2.getString("PNAME");
                   String img = r2.getString("IMG");
            %>
                    
                 <div class="row">
                    <div class="col-4 ">
                        <img src="images/pics/<%= img %>" alt="" class="img img-thumbnail" style="height:250px; width: 250px;">
                    </div>
                    <div class="col-8" style="padding-left: 100px;">
                        <h2><%= pname %></h2>
                        <h5>#<%= oid %></h5>
                        <p><strong>UserId: </strong>#<%= uid %></p>
                        <p><strong>Delivery Address: </strong><%= add %></p>
                        <p><strong>Payment Method:</strong> <%= paymode %></p>
                    </div>
                </div>
                <br>  
               <% }}
               
           }
           connection.close();
        %>
        </div>
        

<!-- Include Bootstrap JS bundle (includes Popper.js) -->
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
