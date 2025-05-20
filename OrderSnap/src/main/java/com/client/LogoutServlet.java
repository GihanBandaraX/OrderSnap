package com.client;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get the session and invalidate it
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
                System.out.println("Session invalidated at " + new java.util.Date());
            }

            // Redirect to login page with a success message
            response.sendRedirect("clientlogin.jsp?success=true&message=You+have+been+logged+out+successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("clientlogin.jsp?error=true&message=Error+during+logout");
        }
    }
}