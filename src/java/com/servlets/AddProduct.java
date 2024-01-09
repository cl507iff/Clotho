/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author prast
 */

@WebServlet("/upload")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50      // 50MB
)
public class AddProduct extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           String pname= request.getParameter("pname");
           
           String premium= request.getParameter("premium");
           String price= request.getParameter("price");
           String cat= request.getParameter("category");
           String age= request.getParameter("age");
           String psize= request.getParameter("size");
           String qty= request.getParameter("qty");
           
           Part part = (Part) request.getPart("image");
           String path1=null;
           path1+=part;
          try{
           
           //adding pic to folder
            //find out path to upload photo
            String path = request.getRealPath("images")+ File.separator + "pics"+File.separator+part.getSubmittedFileName();
            out.print(path1);
            
            
           
            InputStream is;
            
             String sql = null;
            PreparedStatement preparedStatement = null;
            Class.forName("oracle.jdbc.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
            String productId = generateProductId(connection);
            sql = "INSERT INTO PRODUCTS VALUES(?,?,?,?,?,?,?,?,?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, productId);
            preparedStatement.setString(2, pname);
            preparedStatement.setString(3, premium);
            preparedStatement.setString(4, price);
            preparedStatement.setString(5, cat);
            preparedStatement.setString(6, age);
            preparedStatement.setString(7, psize);
            preparedStatement.setString(8, qty);
            preparedStatement.setString(9, part.getSubmittedFileName());
            
            int rowsInserted= preparedStatement.executeUpdate();
            if(rowsInserted>0){
            
            try ( //uploading code...
                    FileOutputStream fos = new FileOutputStream(path)) {
                is = part.getInputStream();
                //reading data..
                byte []data=new byte[is.available()];
                is.read(data);
                //writing the data..
                fos.write(data);
                fos.close();
            is.close();
            }catch(Exception e){
                e.printStackTrace();
            }response.sendRedirect("prodList.jsp");}
            else{
                out.print("Something went wrong");
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
    }}
    
    
    private static String generateProductId(Connection connection) throws SQLException {
        String productId;
        do {
            // Generate a product ID starting with 'P' followed by 4 digits
            productId = "P" + String.format("%04d", (int) (Math.random() * 10000));

            // Check if the generated product ID already exists in the table
        } while (productIdExists(connection, productId));

        return productId;
    }
    
    private static boolean productIdExists(Connection connection, String productId) throws SQLException {
        String query = "SELECT COUNT(*) FROM PRODUCTS WHERE PID = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, productId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                resultSet.next();
                int count = resultSet.getInt(1);
                return count > 0; // Returns true if the product ID already exists
            }
        }
    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
