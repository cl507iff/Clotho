<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact Successful</title>
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
        
        <div class="container container-fluid"style="height:90vh; padding-top: 15%;">
            
            <div class="row justify-content-center align-items-center">
                <div class="col-md-6">
                    <div class="card mt-6">
                        
                        <div class="card-body">
                            <!-- Card content goes here -->
                            <h5 class="card-title">Message Sent Successfully</h5>
                            <p>We'll soon get in touch with you</p>
                            <% String user = (String)session.getAttribute("userType");
                            if(user.equals("admin")){ %>
                            <a href="messagesList.jsp" class="btn btn-success"><span>&#10003;</span>OK</a> <%} else{ %>
                            <a href="index.jsp" class="btn btn-success"><span>&#10003;</span>OK</a> <%} %>
                        </div>
                       
                    </div>
                </div>
            </div>
        </div>
                       

<!-- Include Bootstrap JS bundle (includes Popper.js) -->
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
