/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class Message extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        // Retrieve user registration data from the form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // Insert user data into the database
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-29HBTHPT:1521:orcl", "clotho_admin", "clotho");

            String sql = "INSERT INTO message VALUES (?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, message);

            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted > 0) {
                // Registration successful, redirect to a success page
                response.sendRedirect("contactSuccess.jsp");
            } else {
                response.getWriter().println("User registration failed.");
            }

            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred during registration.");
        }
    }
}
