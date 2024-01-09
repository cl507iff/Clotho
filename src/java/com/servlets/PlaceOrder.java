/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author prast
 */
public class PlaceOrder extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     * @throws java.text.ParseException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String uid = request.getParameter("uid");
            String country = request.getParameter("country");
            String state = request.getParameter("state");
            String town = request.getParameter("town");
            String pin = request.getParameter("pincode");
            String paymode = request.getParameter("payment-method");
            out.print(uid+' '+country+' '+state+' '+town+' '+pin);
            String add = town+','+state+','+country+"PIN: "+pin;
            HttpSession session= request.getSession(false);
           
            int count=0;
            
            String sql1 = "SELECT * FROM CART WHERE U_ID=?";
            String sql2 = "SELECT PRICE FROM PRODUCTS WHERE PID=?";
            String sql3 = "INSERT INTO ORDERS VALUES((SELECT MAX(OID)+1 FROM ORDERS),?,?,?,?,?,?,?)";
            String sql5 = "SELECT MAX(OID) FROM ORDERS";
            
            Class.forName("oracle.jdbc.OracleDriver");
            ResultSet result;
            try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho")) {
               
                LocalDate currentDate = LocalDate.now();
                // Define the desired date format
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                // Format the current date using the formatter
                String Date = currentDate.format(formatter);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dt = (Date) sdf.parse(Date);
                SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MMM-yyyy");
                String vDate = sdf1.format(dt);
                PreparedStatement preparedStatement = connection.prepareStatement(sql1);
                preparedStatement.setString(1, uid);
                result = preparedStatement.executeQuery();
                while(result.next()){
                    
                    String pid= result.getString("PID");
                    preparedStatement = connection.prepareStatement(sql2);
                    preparedStatement.setString(1, pid);
                    ResultSet result2 = preparedStatement.executeQuery();
                    while(result2.next()){
                         preparedStatement = connection.prepareStatement(sql5);
                ResultSet r= preparedStatement.executeQuery();
                while(r.next()){ String flag= r.getString("MAX(OID)");
                    if(flag==null){
                        sql3="INSERT INTO ORDERS VALUES(1,?,?,?,?,?,?,?)";
                        
                    }
                    else{
                        sql3 = "INSERT INTO ORDERS VALUES((SELECT MAX(OID)+1 FROM ORDERS),?,?,?,?,?,?,?)";
                    }
                }
                        
                        String price = result2.getString("PRICE");
                        
                        preparedStatement = connection.prepareStatement(sql3);
                        
                        preparedStatement.setString(1, uid);
                        preparedStatement.setString(2, vDate);
                        preparedStatement.setString(3, price);
                        preparedStatement.setString(4, add);
                        preparedStatement.setString(5, "1");
                        preparedStatement.setString(6, paymode);
                        preparedStatement.setString(7, pid);
                        
                        int rowsAdded = preparedStatement.executeUpdate();
                        if(rowsAdded <=0 ){
                           
                        break;
                    }
                }}
                
                session.setAttribute("address", add);
                session.setAttribute("paymode", paymode);
                response.sendRedirect("orderSummary.jsp");
                connection.close();
            } 
            result.close();
            
        } catch(Exception e){
            e.printStackTrace();
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException | ParseException ex) {
            Logger.getLogger(PlaceOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException | ParseException ex) {
            Logger.getLogger(PlaceOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
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
