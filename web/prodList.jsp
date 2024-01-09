<%-- 
    Document   : prodList
    Created on : 8 Nov, 2023, 9:48:08 PM
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
        <title>Product List</title>
         
<link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">



        <style>
            body{
                background-color: beige;
                padding:0;
                margin: 0;
            }
            .nav-link{
                color: white
            }
            .cutom-card{
                min-height: 270px;
            }
            img{
                max-width: 473px;
                max-height: 593px;
            }
    
            .custom-container {
                margin-top: 20px; /* Adjust this value as needed */
            }
        </style>
    </head>
    <body>
       <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19,112,79);">
            <div class="container justify-content-between">
                <a class="navbar-brand" style="color: white;" href="Admin.jsp">Clotho</a>
                <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#nav" aria-controls="nav" aria-labels="Expand Navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="nav" style="float: right;">
                    <ul class="navbar-nav ">
                        <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#menu" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Categories
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown" id="menu">
                        <a class="dropdown-item" href="prodList.jsp?category=all">All</a>
                        <a class="dropdown-item" href="prodList.jsp?category=Men">Men</a>
                        <a class="dropdown-item" href="prodList.jsp?category=Women">Women</a>
                        <a class="dropdown-item" href="prodList.jsp?category=Kids">Kids</a>
                    </div>
                </li>
                    <li class="nav-item"><a class="nav-link" href="newProduct.jsp">Add new product</button></a>
                    <li class="nav-item"><a class="btn btn-outline-light" href="http://localhost:8080/minor_project/Logout">Logout</a></li>
                    
                </ul>
                </div>
                
            </div>
        </nav>
        <div class="container container-fluid custom-container">
     
     
    <div class="row">
        <%
        try {
            
            String cat=request.getParameter("category");
            String sql=null;
            PreparedStatement preparedStatement=null;
            Class.forName("oracle.jdbc.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
              if (cat != null && !cat.isEmpty()) {
                // Category is provided, so proceed with the specified query
                if(cat.equals("all")){
                    sql = "SELECT * FROM products";
                    preparedStatement = connection.prepareStatement(sql);
                }
                else{
                    sql = "SELECT * FROM products WHERE CATEGORY = ?";
                    preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setString(1, cat);
                }   
            } else {
                // Category is not provided, show all products
                sql = "SELECT * FROM products";
                preparedStatement = connection.prepareStatement(sql);
            }
            
            ResultSet resultSet = preparedStatement.executeQuery();
            
            while(resultSet.next()) {
                String productName = resultSet.getString("pname");
                String image = "images/pics/" + resultSet.getString("img");
                String price = resultSet.getString("price");
                String pid = resultSet.getString("pid");
                
        %>
        <div class="col-md-3"> <!-- Use the col class to create columns -->
            <div class="custom-card card mb-4 box-shadow ">
                <img src="<%= image %>" class="card-img-top" alt="Product Image">
                <div class="card-body">
                    <h6 class="card-title"><%= productName %></h6>
                    <p class="card-text">Price: &#8377;<%= price %></p>
                    
                    <div class="d-flex justify-content-between align-items-center">
                        <div >
                            <a href="#" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop<%= pid %>">Edit</a>
                             <div class="modal fade" id="staticBackdrop<%= pid %>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel<%= pid %>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="staticBackdropLabel<%= pid %>">Edit product</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form style="width: 100%; margin-right: auto; margin-left: auto"
                                          action="http://localhost:8080/minor_project/editProduct?pid=<%= pid %>" method="POST">
                                        <div class="container-fluid">
                                            
                                                    <div class="form-group">
                                                        <label for="pname">Product name</label>
                                                        <input type="text" class="form-control" id="pname"
                                                               name="pname" value="<%= productName %>"/>
                                                    </div>
                                                    <br>
                                                
                                                    
                                                
                                            <br>
                                            <div class="form-group">
                                                <label for="price">Price</label>
                                                <input type="price" class="form-control" id="price"
                                                       name="price" aria-describedby="price"
                                                       value="<%= price %>"/>
                                            </div>
                                            <br>
                                           
                                        </div>
                                        <br>
                                        <br>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-outline-secondary"
                                                    data-bs-dismiss="modal">Close
                                            </button>
                                            <button type="submit" class="btn btn-outline-primary">Save
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                            <a href="#" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModal<%= pid %>">Delete</a>
                             <div class="modal fade" id="exampleModal<%= pid %>" tabindex="-1" aria-labelledby="exampleModalLabel<%= pid %>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel<%= pid %>">Delete product</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                              </div>
                              <div class="modal-body">
                                  <form action="http://localhost:8080/minor_project/deleteProduct?pid=<%= pid %>" method="POST">
                                      
                                  <p>Do you want to delete this product?</p>
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
                </div>
            </div>
        </div>
        <%
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (ClassNotFoundException e) {
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
