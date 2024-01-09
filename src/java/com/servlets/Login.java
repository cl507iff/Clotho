package com.servlets;

import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author prast
 */
public class Login extends HttpServlet {

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
         String email = request.getParameter("email");
         String password = request.getParameter("password");
         String admin=null;
         String uid=null;
         String fname = null;
         String lname = null;
         String loc = null;
         String phno = null;
         String image = null;
         
         HttpSession session = request.getSession();
        try{
            /* TODO output your page here. You may use following sample code. */
            Class.forName("oracle.jdbc.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");

            String sql = "SELECT * FROM USERS WHERE EMAIL=? AND PASSWORD=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            int count=0;
            ResultSet result=preparedStatement.executeQuery();
            while(result.next()){
                count ++; //user not existing condition
                uid= result.getString("u_id");
                admin = result.getString("admin");
                fname= result.getString("f_name");
                lname=result.getString("l_name");
                loc = result.getString("location");
                phno = result.getString("ph_no");
                image = result.getString("img");
            }
            if(count == 1){
                if(admin.equalsIgnoreCase("Y")){
                   session.setAttribute("uid", uid);
                    session.setAttribute("userType","admin" );
                    response.sendRedirect("Admin.jsp");
                }else{
                    session.setAttribute("email",email);
                    session.setAttribute("uid", uid);
                    session.setAttribute("userType","normal" );
                    session.setAttribute("fname", fname);
                    session.setAttribute("lname", lname);
                    session.setAttribute("loc", loc);
                    session.setAttribute("phno", phno);
                    session.setAttribute("image", image);
                    response.sendRedirect("index.jsp");
                    
                }
            }
            else{
                response.sendRedirect("signin.jsp");
            }
        }catch(Exception e){
            response.sendRedirect("signin.jsp");
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
