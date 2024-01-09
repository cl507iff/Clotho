<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link rel="stylesheet" type="text/css" href="stylesheets/cart.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" integrity="sha512-PgQMlq+nqFLV4ylk1gwUOgm6CtIIXkKwaIHp/PAIWHzig/lKZSEGKEysh0TCVbHJXCLN7WetD8TFecIky75ZfQ==" crossorigin="anonymous" />
        <!-- Include Bootstrap CSS -->
        <link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">
       
    </head>
    <body style="background-color: beige;">
        <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19,112,79);">
            <div class="container justify-content-between">
                <a class="navbar-brand" style="color: white;" href="index.jsp">Clotho</a>
            </div>
        </nav>
        <% String n = (String) session.getAttribute("uid"); 
           String fname = (String) session.getAttribute("fname"); %>
    
 <div class="container container-fluid" style="background-color: beige;">
     
     
     <h3 class="py-4 font-weight-bold"><%= fname %>'s Cart</h3>
     
     <div class="row" >
         <!-- left side div -->
         <div class="col-8">
             
              <%
        try {
            String user= n;
            
            String sql1=null;
            String sql2=null;
            String pid = null;
            PreparedStatement preparedStatement=null;
            PreparedStatement preparedStatement2=null;
            Class.forName("oracle.jdbc.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
            sql1 = "SELECT PID FROM CART WHERE U_ID=?";
            preparedStatement = connection.prepareStatement(sql1);
            preparedStatement.setString(1, user);
            ResultSet resultSet = preparedStatement.executeQuery();
            ResultSet resultSet2= null;
            double total = 0.0;
            int c=0;
            int delivery=0;
            
             while(resultSet.next()){
                 c+=1;
                pid = resultSet.getString("PID");
              if (user != null) {
                    sql2 = "SELECT PNAME,IMG,PRICE,PSIZE FROM PRODUCTS WHERE PID=?";
                    preparedStatement2 = connection.prepareStatement(sql2);
                    preparedStatement2.setString(1, pid); 
                    resultSet2 = preparedStatement2.executeQuery();
              
                while(resultSet2.next()) {
                    String productName = resultSet2.getString("PNAME");
                    String image = "images/pics/" + resultSet2.getString("IMG");
                    String price = resultSet2.getString("PRICE");
                    String size = resultSet2.getString("PSIZE");
                    total+= Double.parseDouble(price);
                    
                    
        %>
        <div class="col-md-12 col-lg-8 col-11 mx-auto main_cart mb-lg-0 mb-5 shadow">
            <div class="card p-4">    
         <div class="row">
         <!-- cart images div -->
         <div class="col-md-4 col-11 mx-auto bg-light d-flex justify-content-center align-items-center shadow product_img">
         <img src="<%= image %>" class="img-fluid" alt="cart img">
         </div>
         <!-- cart product details -->
         <div class="col-md-7 col-11 mx-auto px-4 mt-2">
             <div class="row">
             <!-- product name  -->
             <div class="col card-title">
             <h5 class="mb-4 product_name"><%= productName %></h5>
             <p class="mb-2">SIZE: <%= size %></p>
             </div>
             <!-- quantity inc dec -->
             
             </div>
             <br>
             <!-- //remover move and price -->
             <div class="row">
             <div class="col-8 d-flex justify-content-between remove_wish removewishlist">
                 <a class="btn btn-outline-danger"  href="http://localhost:8080/minor_project/DeleteItem?pid=<%= pid %>&uid=<%= user %>"> <i class="fas fa-trash-alt"></i> Remove</a>
             </div>
             <div class="col-4 d-flex justify-content-end price_money">
             <h5>Rs.<span id="itemval"><%= price %> </span></h5>
             </div>
             </div>
             </div>
             </div>
             </div>
             <hr/>
    </div>
    <% } }} %>
         </div>
         
         
         <div class="col-4">
              <!-- right side div -->
    <div class="sticky">
    <div class="right_side p-3 shadow bg-white">
    <h2 class="product_name mb-5">Cart Details</h2>
    <div class="price_indiv d-flex justify-content-between">
    <p>Gross amount</p>
    <p>Rs.<span id="product_total_amt"><%= total %></span></p>
    </div>
    <div class="price_indiv d-flex justify-content-between">
    <p>Shipping Charge</p>
    <p>Rs.<span id="shipping_charge"><% if(c > 0){ delivery=50; %> <%= delivery %> <% }else{ %> <%= delivery %> <% } %></span></p>
    </div>
    <hr />
    <div class="total-amt d-flex justify-content-between font-weight-bold">
    <p>Total </p>
    <p>Rs.<span id="total_cart_amt"><%= total + delivery %></span></p>
    </div>
    <% if(c > 0){ %>
    <a href="http://localhost:8080/minor_project/checkout.jsp?uid=<%= n %>" class="btn btn-success"  role="button" >Checkout</a>
    <% } else{ %>
    <a href="#" class="btn btn-success disabled " tabindex="-1" role="button" aria-disabled="true">Checkout</a>
    <% } %>
    </div>
 
<div class="mt-3 shadow p-3 bg-white">
    <div class="pt-4">
    <h5 class="mb-4">Expected delivery date</h5>
    <p>July 27th 2023 - July 29th 2023</p>
    </div>
    </div>
    </div>
    </div>
    
    

        <%
           
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        %>

         </div>
     </div>
   
    
</div>

<br>
<div style="text-align: center; background-color: white; height: 40px; padding: 10px;" class='fixed-bottom'>
    <p>Made by team Clotho</p>
</div>


        <!-- Include Bootstrap JS bundle (includes Popper.js) -->
        <script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>