package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
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

public class ValidateEmail extends HttpServlet {
          OracleConnection oconn;
          OraclePreparedStatement ost;
          OracleResultSet ors = null;
          int votp;
          String vemail, vpass, vname;
          String vto, vfrom, vcc, vbcc, vsubject, vbody;

    int genpswd()
    {
        int max=99999999;
        int min=10000000;
        int range= max-min+1;
        int rand=(int)(Math.random()*range)+min;
        return rand;
    }      
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ValidateEmail</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("");
            vemail = request.getParameter("temail");
            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
            oconn = (OracleConnection)DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl","clotho_admin","clotho");
            ost =(OraclePreparedStatement) oconn.prepareStatement("SELECT * FROM USERS where email=?");
            ost.setString(1, vemail);
            ors = (OracleResultSet) ost.executeQuery();
            if(ors.next()) 
            {
                HttpSession sess = request.getSession(true);
                vto=vemail;
                vsubject="Forgot Password? Here is your OTP:-";
                votp=genpswd();
                sess.setAttribute("otp",votp);
                sess.setAttribute("sessemail",vto);
                vbody="Please find your One Time Password below:-";
                final String username ="clothohq@gmail.com";
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
                    message.setSubject(vsubject);
                    vbody += "\n"+"OTP="+votp;
                    message.setText(vbody);
                    Transport.send(message);
                    response.sendRedirect("http://localhost:8080/minor_project/verifyotp.jsp");
                    
            } catch (MessagingException e) {

                     out.println("<h2 style='color:red'>"+e.getMessage()+"</h2>");
            }
                
            }
            else 
            {
                out.println("Email doesn't exist");
            }
            ost.close();
            oconn.close();
            out.println("</body>");
            out.println("</html>");
            out.println("</body>");
            out.println("</html>");
        }     catch (SQLException ex) {
                  Logger.getLogger(ValidateEmail.class.getName()).log(Level.SEVERE, null, ex);
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