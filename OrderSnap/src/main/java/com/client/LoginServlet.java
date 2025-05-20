package com.client;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        String username = request.getParameter("uid");
        String password = request.getParameter("pass");

        boolean isTrue = ClientDBUtil.validate(username, password);

        if (isTrue) {
            List<Client> clientDetails = ClientDBUtil.getClient(username);
            Client client = clientDetails.get(0); // Assuming one client per username

            // Set session attributes
            HttpSession session = request.getSession();
            session.setAttribute("clientId", client.getId());
            session.setAttribute("username", username);

            // Redirect based on userType
            String userType = client.getUserType();
            if ("admin".equalsIgnoreCase(userType)) {
                response.sendRedirect("AdminDashboardServlet");
            } else {
                response.sendRedirect("UserDashboardServlet");
            }
        } else {
            out.println("<script type='text/javascript'>");
            out.println("alert('Your Username or Password is incorrect. Please try again');");
            out.println("location='clientlogin.jsp'");
            out.println("</script>");
        }
    }
}