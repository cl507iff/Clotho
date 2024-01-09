<%-- 
    Document   : test
    Created on : 21 Oct, 2023, 1:44:05 PM
    Author     : prast
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        
    </head>
    <body>
       <!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
  Launch static backdrop modal
</button>

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
                        <input type="text" class="form-control" id="fname" name="fname" placeholder="First Name"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                        <label for="lname" >Last Name</label>
                        <input type="text" class="form-control" id="lname" name="lname" placeholder="Last Name"/>
                        </div>
                    </div>
                </div>
                <br>
                <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Email"/>
                </div>
                <br>
                <div class="form-group">
                        <label for="phno">Phone Number</label>
                        <input type="number" class="form-control" id="phno" name="phno" aria-describedby="emailHelp" placeholder="Phone number"/>
                </div>
                <br>
                <div class="form-group">
                        <label for="loc">Location (eg: kol, del, chn):</label>
                        <input type="text" class="form-control" id="loc" name="loc" aria-describedby="emailHelp" placeholder="LOC"/>
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

    </body>
</html>


might need later:

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