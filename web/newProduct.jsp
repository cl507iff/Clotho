<%-- 
    Document   : newProduct
    Created on : 11 Nov, 2023, 8:52:15 PM
    Author     : prast
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Include Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-5.3.2-dist/css/bootstrap.min.css">



        <style>
            body,html{
                background-color: beige;
                padding: 0;
            }
        </style>
        <title>Add New Product</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-md sticky-top" style="background-color: rgb(19, 112, 79); padding-left: 20px">
    <div class="container-fluid">
        <a class="navbar-brand" style="color: white;" href="prodList.jsp">Clotho</a>
    </div>
</nav>
        <div class="container container-fluid bg-light" >
            <form style="width: 100%; margin-right: auto; margin-left: auto; padding: 5px; margin-top: 20px;"
                                          action="http://localhost:8080/minor_project/AddProduct" method="POST"
                                          enctype="multipart/form-data">
                                        <div class="container-fluid">
                                            
                                            <h3 style="padding-top:8px;">Add new Product</h2><br>    
                                                    <div class="form-group">
                                                        <label for="pname">Product Name</label>
                                                        <input type="text" class="form-control" id="pname"
                                                               name="pname" value=""/>
                                                    </div>
                                                
                                                <br>
                                                
                                                
                                         
                                             <div class="form-group">
                                                        <label for="price">Price</label>
                                                        <input type="number" class="form-control" id="price"
                                                               name="price" value=""/>
                                             </div><br>
                                            <div class="row">
                                                <div class="col-6">
                                                    <label for="inputState" class="form-label">Premium</label>
                                               <select id="inputState" class="form-select" name="premium">
                                                  <option selected>Choose...</option>
                                                  <option value="Y">Yes</option>
                                                  <option value="N">No</option>
                                                </select>
                                                </div>
                                                <div class="col-6">
                                                    <label for="inputState" class="form-label">Category</label>
                                               <select id="inputState" class="form-select" name="category">
                                                  <option selected>Choose...</option>
                                                  <option value="Kids">Kids</option>
                                                  <option value="Men">Men</option>
                                                  <option value="Women">Women</option>
                                                </select>
                                                </div>
                                                
                                               
                                            </div>
                                            <br>
                                            <div class="form-group">
                                                <label for="age">How old is the product?(In years)</label>
                                                <input type="number" class="form-control" id="age"
                                                       name="age" aria-describedby="emailHelp"
                                                       value=""/>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-6">
                                                    <label for="qty" class="form-label">Quantity</label><br>
                                                <input type="number" class="form-control" id="qty"
                                                       name="qty" aria-describedby="emailHelp"
                                                       value=""/>
                                                </div>
                                                <div class="col-6">
                                                     <label for="size" class="form-label">Size</label>
                                               <select id="size" class="form-select" name="size">
                                                  <option selected>Choose...</option>
                                                  <option value="XS">XS</option>
                                                  <option value="S">S</option>
                                                  <option value="M">M</option>
                                                  <option value="L">L</option>
                                                  <option value="XL">XL</option>
                                                  <option value="2XL">2XL</option>
                                                  <option value="3XL">3XL</option>
                                                  <option value="F">Free Size</option>
                                                </select>
                                                </div>
                                                
                                            </div>
                                            <br>
                                            <div class="form-group">
                                                <label for="image">Image:</label>
                                                <input type="file" name="image" id="image" accept="image/*">
                                            </div>
                                        </div>
                                        <br>
                                        <br>
                                        <div style="text-align: right;">
                                            
                                            <button type="submit" class="btn btn-outline-success">Upload
                                            </button>
                                        </div>
                                        <br>
                                            
                                        
                                    </form> 
            
        </div>
        

<!-- Include Bootstrap JS bundle (includes Popper.js) -->
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
