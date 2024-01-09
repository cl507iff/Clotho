/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import oracle.jdbc.OracleResultSet;

/**
 *
 * @author prast
 */
public class sendMessage extends HttpServlet {

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
            throws ServletException, IOException, AddressException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String email = request.getParameter("email");
            String msg = request.getParameter("message");
            String cmsg = request.getParameter("msg");
            String name = request.getParameter("name");
            out.print(cmsg);
            out.print(msg);
            
            //sending response to the user
            String vto = email;
            String vsub= "Thank you for contacting Clotho";
            String vbody = "Dear "+name+','+'\n'+msg;
            final String username = "clothohq@gmail.com";
            final String password = "jlewemfbzokrlidm";
            Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");
                
            Session session;
                session = Session.getInstance(props,
                        new javax.mail.Authenticator() {
                            @Override
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(username, password);
                            }
                        });
             try {

                    Message message = new MimeMessage(session);
                    message.setFrom(new InternetAddress(username));
                    message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(vto));
                    message.setSubject(vsub);
                    message.setText(vbody);
                    Transport.send(message);
                    //deleting the message
                    try{
                        String sql = null;
                        PreparedStatement preparedStatement = null;
                        Class.forName("oracle.jdbc.OracleDriver");
                        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
            
                        //creating and executing queries
                        sql = "DELETE FROM MESSAGE WHERE MESSAGE=?";
                        preparedStatement = connection.prepareStatement(sql);
                        preparedStatement.setString(1, cmsg);

                         int rowsDeleted = preparedStatement.executeUpdate();
                         if (rowsDeleted > 0) {
                         response.sendRedirect("contactSuccess.jsp");
                         } else {
                            System.out.println("No records deleted.");
                         }

                    }catch(Exception e){
                        e.printStackTrace();
                    }
                    
                    
                    
        }   catch (MessagingException ex) {
                out.println("<h2 style='color:red'>"+ex.getMessage()+"</h2>");
            }
            
    
        }}

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
        } catch (AddressException ex) {
            Logger.getLogger(sendMessage.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (AddressException ex) {
            Logger.getLogger(sendMessage.class.getName()).log(Level.SEVERE, null, ex);
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
