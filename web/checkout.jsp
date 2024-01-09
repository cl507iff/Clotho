<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<% String uid = request.getParameter("uid"); 
String pid=null;
try{
String sql1= "SELECT * FROM CART WHERE U_ID=?";
String sql2= "SELECT PNAME, PRICE FROM PRODUCTS WHERE PID=?";
PreparedStatement preparedStatement=null;
PreparedStatement preparedStatement2=null;
Class.forName("oracle.jdbc.OracleDriver");
Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
sql1 = "SELECT PID FROM CART WHERE U_ID=?";
preparedStatement = connection.prepareStatement(sql1);
preparedStatement.setString(1, uid);
ResultSet resultSet = preparedStatement.executeQuery();
ResultSet resultSet2= null;
double total = 0.0;
int c=0;
%>



<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Page Title</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
   <!-- Include Bootstrap CSS -->
        <link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">
        
    <style>
        body{
            background-color: beige;
        }
        .nav-link{
            color: white;
        }
        .box{
            margin-top: 20px;
            border: 1px solid green;
        }
        .card-details {
            display: none;
        }
        .card-details.show {
            display: block;
            
        }
        .btn{
            width: 100%;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19,112,79);">
        <div class="container justify-content-between">
            <a class="navbar-brand" style="color: white;" href="index.jsp">Clotho</a>
            <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#nav" aria-controls="nav" aria-labels="Expand Navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="nav" style="float: right;">
                <ul class="navbar-nav ">
                    
                <li class="nav-item"><a class="nav-link" href="about_us.html">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="Contactus.jsp">Contact Us</a></li>
                
                <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
            </ul>
            </div>
            
        </div>
    </nav>
    <div class="container container-fuid ">
        
        
        <form action="http://localhost:8080/minor_project/PlaceOrder?uid=<%= uid %>" class="row" method="POST">
            <div class="col-6 box p-3">
                <h2>Shipping Details</h2>
                <br>
                <div class="form-group">
                    <label for="country" class="form-label">Country:</label>
                    <input type="text" id="country" name="country" class="form-control" required>
                </div>
                <br>
                <div class="form-group">
                    <label for="state" class="form-label">State:</label>
                    <input type="text" id="state" name="state" class="form-control" required>
                </div>
                <br>
                <div class="form-group">
                    <label for="town" class="form-label">Town:</label>
                    <input type="text" id="town" name="town" class="form-control" required>
                </div>
                <br>
                <div class="form-group">
                    <label for="pincode" class="form-label">Pincode:</label>
                    <input type="text" id="pincode" name="pincode" class="form-control" required>
                </div>
                <br>
            </div>
            <div class="col-6 box p-3">
                <h2>Cart details</h2>
                <br>
                <table class="table">
                    <thead>
                        <tr style="background-color: rgb(19,112,79);" >
                            <th scope="col">Item</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Replace the following with your actual cart items -->
                        <% while(resultSet.next()){
                            c+=1;
                            pid = resultSet.getString("PID");
                            if (uid != null) {
                    
                                preparedStatement2 = connection.prepareStatement(sql2);
                                preparedStatement2.setString(1, pid); 
                                resultSet2 = preparedStatement2.executeQuery();
                                while(resultSet2.next()) {
                                    String productName = resultSet2.getString("PNAME");                                    
                                    String price = resultSet2.getString("PRICE");                                    
                                    total+= Double.parseDouble(price);%>
                        <tr>
                            <td><%= productName %></td>
                            <td>1</td>
                            <td>Rs <%= price %></td>
                        </tr>
                        <% } }} %>
                    </tbody>
                </table>
                        <p>Gross Total: Rs. <%= total %> </p>
                    <p>Shipping Charges: Rs. 50 </p>
                <p>Total: Rs. <%= total+50 %> </p>
                <h2>Payment Options</h2>
                <br>
                <label for="payment-method">Payment Method:</label>
            <select id="payment-method" name="payment-method" onchange="toggleCardDetails()">
                <option value="cod">Cash on Delivery</option>
                <option value="card">Card Payment</option>
            </select>
            <br>
            <br>
            <div class="card-details row">
                <div class="col form-group">
                    <label for="card-number" class="form-label">Card Holder's Name:</label>
                    <input type="text" id="card-number" name="card-number" class="form-control" >
                </div>
                <div class="col form-group">
                    <label for="card-number" class="form-label">Card Number:</label>
                    <input type="text" id="card-number" name="card-number" class="form-control" >
                </div>
                <div class="col form-group">
                    <label for="expiry-date" class="form-label">Expiry Date:</label>
                <input type="text" id="expiry-date" name="expiry-date" class="form-control" ><br>
                </div>
                <div class="col form-group">
                    <label for="cvv" class="form-label">CVV:</label>
                    <input type="text" id="cvv" name="cvv"  class="form-control">
                </div>
  
            </div>
            <br>
            <button class="btn btn-success" type="submit">Place Order</button>
            </div>
        </form>
        
    </div>

    <script>
         function toggleCardDetails() {
        const paymentMethod = document.getElementById('payment-method');
        const cardDetails = document.querySelector('.card-details');

        if (paymentMethod.value === 'card') {
            cardDetails.classList.add('show');
        } else {
            cardDetails.classList.remove('show');
        }
    }
    </script>
    <%
           
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        %>
        
        <!-- Include Bootstrap JS bundle (includes Popper.js) -->
        <script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>