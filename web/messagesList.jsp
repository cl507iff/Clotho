<%-- 
    Document   : messagesList
    Created on : 24 Oct, 2023, 5:58:34 PM
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
        <title>Message List</title>
        <!-- Include Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">



        <style>
        body {
            background-color: beige;
            padding: 0;
            margin: 0;
        }
        .container{
            padding-left: 40px;
            padding: 25px;
        }
        .col{
            border: 1px solid white;
            border-radius: 10px;
            background-color: white;
            margin-right: 5px;
            box-shadow: 3px 2px 22px 1px rgba(0, 0, 0, 0.24);
        }
        .row{
            margin-bottom: 15px;
            margin-left: 50px;
            
        }
    </style>
    </head>
    <body>
        <% try {
    String sql = null;
    String name= null;
    String message = null;
    String email=null;
    PreparedStatement preparedStatement = null;
    Class.forName("oracle.jdbc.OracleDriver");
    Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
    sql = "SELECT * FROM MESSAGE";
    preparedStatement = connection.prepareStatement(sql);
    ResultSet resultSet = preparedStatement.executeQuery();
    int c=0;%>
        <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19, 112, 79); padding-left: 20px">
        <div class="container-fluid">
        <a class="navbar-brand" style="color: white;" href="Admin.jsp">Clotho</a>
        <a class="btn btn-outline-light" href="http://localhost:8080/minor_project/Logout">Logout</a>
        </div>
        </nav>
        <div class="container container-fluid justify-content-center">
            <h3 style="padding: 0;margin-left: 50px; ">Messages</h3>
            <br>
        <% while(resultSet.next()){
            c+=1;
            name = resultSet.getString("name");
            message = resultSet.getString("message");
            email = resultSet.getString("email");
            %>
        
        <div class="row">
            <div class="col col-9" style="padding-top: 15px;">
                <h5><%= name %></h5>
                <p><%= message %></p>
            </div>
            <div class="col col-2" style="text-align: center; padding-top:25px;">
                <button type="button" class="btn btn-outline-success"data-bs-toggle="modal" data-bs-target="#staticBackdrop<%= c %>">Reply</button>
                 <div class="modal fade" id="staticBackdrop<%= c %>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel<%= c %>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="staticBackdropLabel<%= c %>">Send Message</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form style="width: 100%; margin-right: auto; margin-left: auto"
                                          action="http://localhost:8080/minor_project/sendMessage?email=<%= email %>&msg=<%= message %>" method="POST">
                                        <div class="container-fluid">
                                            
                                                    <div class="form-group">
                                                        <label for="name" style="text-align: left;">Name</label>
                                                        <input type="text" class="form-control" id="name"
                                                               name="name" value="<%= name %>"/>
                                                    </div>
                                                    <br>
                                                
                                                    <div class="form-group">
                                                        <label for="message">Message</label>
                                                        <textarea class="form-control" id="message" name="message" rows="6" placeholder="Enter message"></textarea>
                                                    </div>
                                                
                                            <br>
                                            
                                            
                                           
                                        </div>
                                        <br>
                                        <br>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-outline-secondary"
                                                    data-bs-dismiss="modal">Close
                                            </button>
                                            <button type="submit" class="btn btn-outline-success">Send
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModal<%= c %>">Delete</button>
                <div class="modal fade" id="exampleModal<%= c %>" tabindex="-1" aria-labelledby="exampleModalLabel<%= c %>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel<%= c %>">Delete message</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                              </div>
                              <div class="modal-body">
                                  <form action="http://localhost:8080/minor_project/deleteMessage?msg=<%= message %>" method="POST">
                                      
                                  <p>Do you want to delete this message?</p>
                                  <br>
                                  <br>
                                  
                                  <div class="modal-footer">
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-outline-danger">Delete</button>
                              </div>
                                  </form>
                              </div>
                              
                            </div>
                          </div>
                    </div>
            </div>
        </div>
        <% }}catch(Exception e){
        e.printStackTrace();}
%>
        </div>
        
        <div style="text-align: center; background-color: white; height: 40px; padding: 10px;" class="fixed-bottom">
            <p>Made by team Clotho</p>
        </div>
       

<!-- Include Bootstrap JS bundle (includes Popper.js) -->
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
