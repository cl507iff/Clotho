<%-- 
    Document   : orderSummary
    Created on : 14 Nov, 2023, 12:47:51 PM
    Author     : prast
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String uid = (String) session.getAttribute("uid");
   String add =(String) session.getAttribute("address");
   String fname = (String) session.getAttribute("fname");
   String lname = (String) session.getAttribute("lname");
   String pid = null;
   String payment =(String) session.getAttribute("paymode");
   double total = 0.0;
   
   try{
   String sql="SELECT * FROM CART WHERE U_ID=?";
   PreparedStatement preparedStatement = null;
   Class.forName("oracle.jdbc.OracleDriver");
   Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
   preparedStatement = connection.prepareStatement(sql);
   preparedStatement.setString(1, uid);
   ResultSet result1= preparedStatement.executeQuery();

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Summary</title>
       <!-- Include Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">



        <style>
            body{
                background-color: beige;
                padding:0;
                margin: 0;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19,112,79);">
            <div class="container-fluid">
                <a class="navbar-brand" style="color: white;" href="index.jsp">Clotho</a>
            </div>
        </nav>
        
        <div class="container container-fluid"style="height:90vh; padding-top: 80px;">
            
            <div class="row justify-content-center align-items-center">
                <div class="col-md-6">
                    <div class="card mt-4">
                        <div class="card-header">
                            <h3 class="card-title">Order Placed Successfully</h3>
                        </div>
                        <div class="card-body">
                            <!-- Card content goes here -->
                            <h5><%= fname %> <%=lname %></h5>
                            <p><%= add %></p>
                            <br/>
                            <h5>Order Summary</h5>
                            <hr>
                             <table class="table">
                    <thead>
                        <tr style="background-color: rgb(19,112,79);" >
                            <th scope="col">Item</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%while(result1.next()){
                            pid=result1.getString("PID");
                            String sql2="SELECT PNAME,QTY, PRICE FROM PRODUCTS WHERE PID=?";
                            preparedStatement= connection.prepareStatement(sql2);
                            preparedStatement.setString(1, pid);
                            ResultSet result2= preparedStatement.executeQuery();
                            while(result2.next()){
                                String name=result2.getString("PNAME");
                                String qty = result2.getString("QTY");
                                String price =result2.getString("PRICE");
                                total += Double.parseDouble(price);
                        %>
                        <tr>
                            <td><%= name %></td>
                            <td><%= qty %></td>
                            <td><%= price %></td>
                        </tr>    
                        <%    }}
                        %>
                    
                   </tbody>
                             </table>
                        <p>Gross amount: <%= total %></p>
                    <p>Delivery charge: 50.00</p>
                    <p>Net Total: <%= total+50 %></p> 
                    <h6>Mode of Payment: <%= payment %></h6>
                        </div>
                        <div class="card-footer">
                            <a href="index.jsp" class="btn btn-success"><span>&#10003;</span>OK</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                    <% String sql3 = "DELETE FROM CART WHERE U_ID=?";
                       preparedStatement= connection.prepareStatement(sql3);
                       preparedStatement.setString(1, uid);
                       int rowsDeleted = preparedStatement.executeUpdate();
                        connection.close(); }

catch(Exception e){
                       e.printStackTrace();
}

                 %>
                 

<!-- Include Bootstrap JS bundle (includes Popper.js) -->
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>

