<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% String user = (String)session.getAttribute("userType");
   if(user == null){%>
      <h2>User not found</h2>
  <% }
else if(user != "admin"){%>
    <h2> you are not admin </h2>
<%}
else{%>
   
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
         
        <link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">
        
        <style>
            body{
                background-color: beige;
                padding:0;
                margin: 0;
            }
            .card{
                padding:5px;
            }
            .link{
                color: white;
          
            }
            .display-6{
                color: black;
            }
            .display-6:hover{
                color: gray;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19,112,79); padding-left: 20px; padding-right: 20px;">
            <div class="container container-fluid justify-content-between">
                <a class="navbar-brand" style="color: white;" href="#">Clotho</a>
                 <a class="btn btn-outline-light" href="http://localhost:8080/minor_project/Logout">Logout</a>
            </div>
        </nav>
        
        <%
            try {
            
            String cat=request.getParameter("category");
            String sql1=null;
            String sql2=null;
            String sql3=null;
            String sql4=null;
            PreparedStatement preparedStatement=null;
            Class.forName("oracle.jdbc.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
            sql1="SELECT COUNT(*) FROM USERS WHERE ADMIN='N'";
            sql2="SELECT COUNT(*) FROM PRODUCTS";
            sql3="SELECT COUNT(*) FROM ORDERS";
            sql4="SELECT COUNT(*) FROM MESSAGE";
        %>
        
        <div class="container container-fluid" style="height: auto; min-height: 90vh; padding: 30px;">
            <h1 class="display-6">Welcome Admin</h1>
            <div class="container" style="height: 60vh; padding-top: 8%;">
                <div class="row">
                    <div class="col-md-3">
                        
                        <div class="card mb-2">
                            <div class="card-body text-center">
                                <div class="container">
                                    <img src="assets/users.png" alt="user_icon" class="img-fluid" style="max-width:100px; max-height: 100px;"/>
                                </div>
                                <%  preparedStatement = connection.prepareStatement(sql1);
                                    ResultSet result = preparedStatement.executeQuery();
                                if (result.next()) {
                                    int count = result.getInt(1);
                                %><h1 class="display-6"><%= count %></h1><%}%>
                                <a class="nav-link" href="userList.jsp"><h1 class="display-6">Users</h1></a>
                                
                            </div>
                        </div>
                        
                    </div>
                    <div class="col-md-3">
                                                
                        <div class="card mb-2">
                            <div class="card-body text-center">
                                <div class="container">
                                    <img src="assets/products.png" alt="product_icon" class="img-fluid" style="max-width:100px; max-height: 100px;"/>
                                </div>
                                <%  preparedStatement = connection.prepareStatement(sql2);
                                    result = preparedStatement.executeQuery();
                                if (result.next()) {
                                    int count = result.getInt(1);
                                %><h1 class="display-6"><%= count %></h1><%}%>
                                <a class="nav-link" href="prodList.jsp"><h1 class="display-6">Products</h1></a>
                                
                            </div>
                        </div>
                        
                    </div>
                    <div class="col-md-3">
                                                
                        <div class="card mb-2">
                            <div class="card-body text-center">
                                <div class="container">
                                    <img src="assets/orders.png" alt="order_icon" class="img-fluid" style="max-width:100px; max-height: 100px;"/>
                                </div>
                                <%  preparedStatement = connection.prepareStatement(sql3);
                                    result = preparedStatement.executeQuery();
                                if (result.next()) {
                                    int count = result.getInt(1);
                                %><h1 class="display-6"><%= count %></h1><%}%>
                                <a class="nav-link" href="orderList.jsp"><h1 class="display-6">Orders</h1></a>
                                
                            </div>
                        </div>
                        
                    </div>
                    <div class="col-md-3">
                                                
                        <div class="card mb-2">
                            <div class="card-body text-center">
                                <div class="container">
                                    <img src="assets/messages.png" alt="message_icon" class="img-fluid" style="max-width:100px; max-height: 100px;"/>
                                </div>
                                <%  preparedStatement = connection.prepareStatement(sql4);
                                    result = preparedStatement.executeQuery();
                                if (result.next()) {
                                    int count = result.getInt(1);
                                %><h1 class="display-6"><%= count %></h1><%}%>
                                <a class="nav-link" href="messagesList.jsp"><h1 class="display-6">Messages</h1></a>
                                
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>

            
        </div>
        <%}
            catch(Exception e){
            out.print("something went wrong");
}
        %>
        <div style="text-align: center; background-color: white; height: 40px; padding: 10px;" class="fixed-bottom">
            <p>Made by team Clotho</p>
        </div>
        <!-- Include Bootstrap JS bundle (includes Popper.js) -->
        <script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
<%
} %>

