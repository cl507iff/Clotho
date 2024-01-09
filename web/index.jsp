


<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clotho: Homepage</title>
    
<link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">



        <style>
            body{
                background-color: beige;
                padding:0;
                margin: 0;
            }
            .nav-link{
                color: white;
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
            img
        </style>
    </head>
    <body>
        <% String n = (String) session.getAttribute("uid"); 
           String fname = (String) session.getAttribute("fname"); %>
        <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19,112,79);">
            <div class="container justify-content-between">
                <a class="navbar-brand" style="color: white;" href="index.jsp">Clotho</a>
                
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
                        <a class="dropdown-item" href="index.jsp?category=all">All</a>
                        <a class="dropdown-item" href="index.jsp?category=Men">Men</a>
                        <a class="dropdown-item" href="index.jsp?category=Women">Women</a>
                        <a class="dropdown-item" href="index.jsp?category=Kids">Kids</a>
                    </div>
                </li>
                    <li class="nav-item"><a class="nav-link" href="about_us.html">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact">Contact Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
                    <li class="nav-item"> <a class="nav-link" href="http://localhost:8080/minor_project/Logout">Logout</a></li>
                </ul>
                </div>
                
            </div>
        </nav>
        
    
 <div class="container container-fluid custom-container">
     
     <p>Welcome <%= fname %></p>
     
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
                            <a href="http://localhost:8080/minor_project/AddtoCart?pid=<%= pid %>&uid=<%= n %>" class="btn btn-sm btn-outline-primary">Add to cart</a>
                            
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
    
    
</div>


            <div style="background-color: rgb(19,112,79); padding: 30px;" id="contact">
                <h2  style="padding-left: 60px; color: white; font-weight: lighter;">Complaints and Queries</h2>
                <br>
                
                <form style="width: 30%; margin-right: auto; margin-left: auto;" action="http://localhost:8080/minor_project/Message" method="POST">
                    <div class="form-group">
                        <label for="choice" style="color:white;">Purpose</label>
                    <input type="text" class="form-control" id="choice" name="choice" placeholder="Please state your purpose for sending this message"/>
                    <br>
                        <label for="name" style="color:white;">Enter your name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Enter your Name"/>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="email" style="color:white;">Enter your email</label>
                        <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Enter your Email"/>
                        <small id="emailHelp" class="form-text text-muted " style="color:white;">We will never share your email with anyone</small>
                    </div>
                    <br>
                    <div class="form-group">
                        <label for="message" style="color:white;">Enter your message</label>
                        <textarea class="form-control" id="message" name="message" rows="3" placeholder="Enter your Message"></textarea>
                    </div>
                    <br>
                    <button type="Submit" class="btn btn-outline-light">Submit</button>
                </form>

                <br>
                <br>
                <h4 style="padding-left: 60px; color: white; font-weight: lighter;">
                        Connect with us on:    <span><a href="#"><img src="assets/facebook.png"></a></span>
                        <span><a href="#"><img src="assets/instagram.png"></a></span>
                        <span><a href="#"><img src="assets/twitter.png"></a></span>
                </h4>
            </div>
    
        <div style="text-align: center; background-color: white; height: 40px; padding: 10px;">
            <p>Made by team Clotho</p>
        </div>


<!-- Include Bootstrap JS bundle (includes Popper.js) -->
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
