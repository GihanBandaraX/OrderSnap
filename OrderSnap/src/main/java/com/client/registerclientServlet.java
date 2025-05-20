package com.client;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/registerclientServlet")
public class registerclientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType"); // New parameter

        boolean isTrue = ClientDBUtil.registerclient(name, gender, dob, email, phone, address, username, password, userType);

        if (isTrue) {
            String successMessage = "Registered Successfully.";
            request.setAttribute("successMessage", successMessage);
            RequestDispatcher dis = request.getRequestDispatcher("clientlogin.jsp");
            dis.forward(request, response);
        } else {
            out.println("<script type='text/javascript'>");
            out.println("alert('Registration Unsuccessful. Please try again');");
            out.println("location='clientlogin.jsp'");
            out.println("</script>");
        }
    }
}