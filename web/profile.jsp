<%-- 
    Document   : profile
    Created on : 21 Oct, 2023, 11:10:27 AM
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
        <title>Profile</title>
            <!-- Include Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">


        <style>
            * {
    box-sizing: border-box;
}

body {
    background-color: beige;
    margin: 0;
}


.outer-box-1{
            background-color: white;
            display: flex;
            margin-left:auto;
            margin-right: auto;
            width: 700px;
            margin-top: 3%;
            padding: 20px;
            box-shadow: 3px 2px 22px 1px rgba(0, 0, 0, 0.24);
            border-radius: 10px;          
            >img{
                height: 200px;
                width: 200px;
                border-radius: 50%;
            }
        }
       
        .details{
            padding-left: 20px;
        }
        .outer-box-2{
            background-color: white;
            box-shadow: 3px 2px 22px 1px rgba(0, 0, 0, 0.24);
            margin-left:auto;
            margin-right: auto;
            width: 700px;
            margin-top: 20px;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px
        }
        .row{
            box-shadow: 3px 2px 22px 1px rgba(0, 0, 0, 0.24);
            margin-bottom: 10px;  
            border-radius: 10px;          
        }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19, 112, 79); padding-left: 20px">
    <div class="container-fluid">
        <a class="navbar-brand" style="color: white;" href="index.jsp">Clotho</a>
    </div>
</nav>
        <% 
                    String uid =(String) session.getAttribute("uid");
                    String fname=(String)session.getAttribute("fname");
                    String lname=(String)session.getAttribute("lname");
                    String loc=(String)session.getAttribute("loc");
                    String phno=(String)session.getAttribute("phno");
                    String img=(String)session.getAttribute("image");
                    String email =(String) session.getAttribute("email");
        %>
        
        
       
        
    
    
    <div class="outer-box-1">
        <img src="images/<%=img%>" alt="" class="img img-thumbnail">
        <div class="details">
            <h2><%= fname %> <%= lname %></h2>
            <p><%= email %></p>
            <p><%= phno %></p>
            <p><%= loc %></p>
            <button type="button"  class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">Edit Profile</button>
             <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Edit User</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form style="width: 100%; margin-right: auto; margin-left: auto"
                                          action="http://localhost:8080/minor_project/editUser?uid=<%= uid %>&page=1" method="POST">
                                        <div class="container-fluid">
                                            
                                                     <div class="form-group">
                                                        <label for="fname">First Name</label>
                                                        <input type="text" class="form-control" id="fname"
                                                               name="fname" value="<%= fname %>"/>
                                                    </div>
                                            <br>
                                            <div class="form-group">
                                                        <label for="lname">Last Name</label>
                                                        <input type="text" class="form-control" id="lname"
                                                               name="lname" value="<%= lname %>"/>
                                            </div><br>
                                            <div class="form-group">
                                                <label for="email">Email</label>
                                                <input type="email" class="form-control" id="email"
                                                       name="email" aria-describedby="emailHelp"
                                                       value="<%= email %>"/>
                                            </div>
                                            <br>
                                            <div class="form-group">
                                                <label for="phno">Phone Number</label>
                                                <input type="number" class="form-control" id="phno"
                                                       name="phno" aria-describedby="emailHelp"
                                                       value="<%= phno %>"/>
                                            </div>
                                            <br>
                                            <div class="form-group">
                                                <label for="loc">Location (eg: kol, del, chn):</label>
                                                <input type="text" class="form-control" id="loc" name="loc"
                                                       aria-describedby="emailHelp" value="<%= loc %>"/>
                                            </div>
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
                                            <a class="btn btn-outline-danger" href="http://localhost:8080/minor_project/Logout">Logout</a>
        </div>
    </div>

    <div class="outer-box-2">
        <h2>My orders</h2>
        <br>
        <div class="container container-fluid align-items-center">
            
                <% try{
                    String sql="SELECT * FROM ORDERS WHERE U_ID=?";
                    Class.forName("oracle.jdbc.OracleDriver");
                    Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
                    PreparedStatement ps =  connection.prepareStatement(sql);
                    ps.setString(1, uid);
                    ResultSet  r= ps.executeQuery();
                    int c=0;
                    while(r.next()){
                        String pid = r.getString("PID").trim();
                        String sql2="SELECT * FROM PRODUCTS WHERE PID=?";
                        PreparedStatement ps2= connection.prepareStatement(sql2);
                        ps2.setString(1, pid);
                        ResultSet r2= ps2.executeQuery();
                        while(r2.next() && c<3){
                            c++;
                            String image = r2.getString("IMG");
                            String pname = r2.getString("PNAME");
                            String price = r2.getString("PRICE");
                %>
                <div class="row">
                        <div class="col col-2 p-2">
                            <img class="img img-thumbnail" src='images/pics/<%= image %>' alt='' style="height:100px; width:100px;">
                </div>
                <div class="col col-10" style="padding-top: 15px;">
                    <h4> <%= pname %> </h4>
                    <p>Rs. <%= price %></p>
                </div>
                </div>            
               <%         }
                    }} catch(Exception e){
                    e.printStackTrace();
}
                %>
                
                <p style="text-align: right;"><a href="allOrders.jsp" class="btn btn-outline-success">View More</a></p>      
            

</div>


</div>
        <div style="text-align: center; background-color: white; height: 40px; padding: 10px;" class="fixed-bottom">
            <p>Made by team Clotho</p>
        </div>
              
<!-- Include Bootstrap JS bundle (includes Popper.js) -->
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
