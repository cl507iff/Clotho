<%-- 
    Document   : userList
    Created on : 13 Oct, 2023, 1:43:08 PM
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
        <title>Users</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <style>

        body{
                background-color: beige;
                padding:0;
                margin: 0;
                }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19,112,79); padding-left: 20px">
            <div class="container-fluid">
                <a class="navbar-brand" style="color: white;" href="Admin.jsp">Clotho</a>
            </div>
        </nav>
        
        <%
            try{
                String sql=null;
                PreparedStatement preparedStatement=null;
                Class.forName("oracle.jdbc.OracleDriver");
                Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-2KQAITLT:1522:orcl", "clotho_admin", "clotho");
                sql="SELECT * FROM USERS WHERE ADMIN='N'";
                preparedStatement = connection.prepareStatement(sql);
                ResultSet resultSet = preparedStatement.executeQuery();%>
         
        <div class="container-fluid" style="height: auto; min-height: 90vh; padding: 30px">
            <h1 class="display-6">Users</h1>
            <div class="container ">
                <div class="row">
                    <% while(resultSet.next()) {
                        String uid = resultSet.getString("u_id");
                        String fName = resultSet.getString("f_name");
                        String lName = resultSet.getString("l_name");
                        String image = "images/" + resultSet.getString("img");
                        String phno = resultSet.getString("ph_no");
                        String email = resultSet.getString("email");
                        String loc = resultSet.getString("location");
                    %>
                    <div class="col-md-6">
                        <div class="card mb-3" style="max-width: 540px;">
                    <div class="row g-0">
                        <div class="col-md-4" style="padding: 10px;">
                            <img src="<%= image %>" class="object-fit-cover  rounded-start" alt="..." style="max-height: auto;max-width: 100%;">
                        </div>
                        <div class="col-md-8">
                        <div class="card-body">
                            <h5 class="card-title"><%= fName %><span> </span><%= lName %></h5>
                            <p class="card-text"><small class="text-body-secondary"><%= uid %></small></p>
                            <p class="card-text">Location: <%= loc %></p>
                            <p class="card-text">Phone: <%= phno %></p>
                            <p class="card-text">Email: <%= email %></p>
                            <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">Edit</button>
                            <!-- Modal -->
                            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                              <div class="modal-dialog">
                                <div class="modal-content">
                                  <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Edit User</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                              <div class="modal-body">
                                <form style="width: 100%; margin-right: auto; margin-left: auto;" action="http://localhost:8080/minor_project/Message" method="POST">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                <label for="fname" >First Name</label>
                                                <input type="text" class="form-control" id="fname" name="fname" placeholder=" <%= fName %> "/>
                                            </div>
                                        </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                   <label for="lname" >Last Name</label>
                                                   <input type="text" class="form-control" id="lname" name="lname" placeholder=" <%= lName %> "/>
                                                </div>
                                           </div>
                                        </div>
                                        <br>
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder=" <%= email %> "/>
                                    </div>
                                    <br>
                                    <div class="form-group">
                                        <label for="phno">Phone Number</label>
                                        <input type="number" class="form-control" id="phno" name="phno" aria-describedby="emailHelp" placeholder=" <%= phno %> "/>
                                </div>
                                <br>
                                <div class="form-group">
                                    <label for="loc">Location (eg: kol, del, chn):</label>
                                    <input type="text" class="form-control" id="loc" name="loc" aria-describedby="emailHelp" placeholder=" <%= loc %> "/>
                                </div>
                
                
                            </div>
                            <br>
                            <br> 
                                 <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                      </div>
                                    </form>
                                 </div>
      
                                </div>
                              </div>
                            </div>
                            
                            <button type="button" class="btn btn-outline-danger">Delete</button>

                            
                        </div>
                        </div>
                    </div>
                </div>
                    </div>
                    <%}
                    resultSet.close();
                    preparedStatement.close();
                    connection.close();%>
                </div>
                
            </div>
            
        </div>
                
         <%  }catch(Exception e){
                out.println("something went wrong");
            }
            
           
         %>
        
                
        <div style="text-align: center; background-color: white; height: 40px; padding: 10px;">
            <p>Made by team Clotho</p>
        </div>
            
    </body>
</html>
