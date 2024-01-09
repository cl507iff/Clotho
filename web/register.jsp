<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head> 
    <meta charset="UTF-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <title>Registration Form</title> 
     <!-- Include Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">


  
    <link rel="stylesheet" href="stylesheets/style_2.css"> 
</head>
<body> 
     <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19,112,79); padding-left: 20px; height: 40px;">
            <div class="container-fluid">
                <a class="navbar-brand" style="color: white;" href="singin.jsp">Clotho</a>
            </div>
        </nav>
    <div style="height: 90vh;">
         <div class="box"> 
             <form action="http://localhost:8080/minor_project/Register" method="POST" enctype="multipart/form-data"> 
            <p class="register"><b>Registration Form</b></p> 
            
            <div class="sidebyside">
                <label for="f_name"><b>First Name</b></label> 
                <input type="text" placeholder="Enter first name" name="f_name" id="f_name" required/> 
                <label for="l_name"><b>Last Name</b></label> 
                <input type="text" placeholder="Enter last name" name="l_name" id="l_name" required/>
           </div> 
            
           <div class="sidebyside"> 
                <label for="location"><b>Location</b></label> 
                <input class="adjustloc" type="text" placeholder="Enter location" name="location" id="location" required/>  
                <label class="adjustphno" for="phone_no"><b>Ph. Number</b></label> 
                <input type="number" placeholder="Enter phone number" name="phone_no" id="phone_no" required/> 
            </div>
            
            <label for="email"><b>Email</b></label> 
            <input type="text" placeholder="Enter Email" name="email" id="email" required /> 
            <label for="pwd"> <b>Password</b></label> 
            <input type="password" placeholder="Enter Password" name="pwd" id="pwd" required />
            <label for="pwd"> <b>Confirm Password</b></label> 
            <input type="password" placeholder="Re-enter Password" name="cpwd" id="cpwd" required />
             <div class="form-group">
                    <label for="image">Image:</label>
                    <input type="file" name="image" id="image" accept="image/*">
            </div>
            <button type="submit">Register</button> 
            <p style="font-family: sans-serif;">Already have an account? <a href="singin.jsp" style="font-family: sans-serif;">Log in</a>.</p> 
        </form> 
    </div>
    </div>
   
    <div style="text-align: center; background-color: white; height: 30px; padding: 10px;" class="fixed-bottom">
            <p>Made by team Clotho</p>
        </div>
    
<!-- Include Bootstrap JS bundle (includes Popper.js) -->
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>

</body> 
</html>
