package com.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/register")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50      // 50MB
)
public class Register extends HttpServlet {

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
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            /* TODO output your page here. You may use following sample code. */
            String fname = request.getParameter("f_name");
            String lname = request.getParameter("l_name");
            String loc = request.getParameter("location");
            String phno =request.getParameter("phone_no");
            String email = request.getParameter("email");
            String pwd = request.getParameter("pwd");
            String cpwd = request.getParameter("cpwd");
            Part part = (Part) request.getPart("image");
            
            //adding image to the folder
            InputStream is;
            String path = request.getRealPath("images")+File.separator+part.getSubmittedFileName();
            
            //database connection
            
            String sql = null;
            PreparedStatement preparedStatement = null;
            Class.forName("oracle.jdbc.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");
            
            
            sql = "SELECT * FROM USERS";
            preparedStatement = connection.prepareStatement(sql);
            int c=0; //counts number of users
            ResultSet result = preparedStatement.executeQuery(sql);
            while(result.next()){
                c++;
                String mail=result.getString("email");
                String phone = result.getString("ph_no");
                if(email.equals(mail) && phno.equals(phone) ){
                    out.print("account already exists");
                }
            }
            if(pwd.equals(cpwd)){
                sql = "INSERT INTO CLOTHO_ADMIN.USERS (U_ID, EMAIL, PASSWORD, F_NAME, L_NAME, LOCATION, PH_NO, ADMIN , IMG) VALUES ((SELECT MAX(U_ID)+1 FROM USERS), ?, ?, ?, ?, ?, ?, ?,?)";
                preparedStatement = connection.prepareStatement(sql);
                
                preparedStatement.setString(1,email);
                preparedStatement.setString(2, pwd); 
                preparedStatement.setString(3, fname);
                preparedStatement.setString(4, lname);
                preparedStatement.setString(5, loc.toUpperCase().substring(0,3));
                preparedStatement.setString(6,phno);
                preparedStatement.setString(7,"N");
                preparedStatement.setString(8,part.getSubmittedFileName());
                
                int rowsInserted = preparedStatement.executeUpdate();
                if (rowsInserted > 0) {
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
                }
                    response.sendRedirect("singin.jsp");
                } else {
                    System.out.println("No data inserted.");
                }
            }
            else{
                out.println("passwords don't match");
            }
        }
        catch(Exception e){
            out.print(e);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
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
