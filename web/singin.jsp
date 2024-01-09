

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="stylesheets/style_2.css">
     <!-- Include Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">



</head>        
    
<body style="background-color: beige;">
 
    <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19,112,79); padding-left: 20px; height: 40px;">
            <div class="container-fluid">
                <a class="navbar-brand" style="color: white;" href="#">Clotho</a>
            </div>
        </nav>
    
    
    <div class="box" style="margin-top: 70px;">
           <h3> Sign In </h3>
           <br/>
        <form action="http://localhost:8080/minor_project/Login" method="post">
      
        <label for="email">Email</label>
      <input type="text" placeholder="Enter Your Email" name="email" id="email" required>
  
      <label for="psw">Password</label>
      <input type="password" placeholder="Enter Password" name="password" required id="psw"><br>
        <button type="submit">Login</button>
        
        <a href="validateemail.html">Forgot/Want to Change password?</a>
        <a href="register.jsp">New User?</a>
    </form>
      </div>
    <div style="text-align: center; background-color: white; height: 30px; padding: 10px;" class="fixed-bottom">
            <p>Made by team Clotho</p>
        </div>
   
<!-- Include Bootstrap JS bundle (includes Popper.js) -->
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>