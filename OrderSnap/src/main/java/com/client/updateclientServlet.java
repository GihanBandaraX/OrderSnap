package com.client;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateclientServlet")
public class updateclientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        boolean isTrue = ClientDBUtil.updateclient(id, name, gender, dob, email, phone, address, username, password, userType);

        if (isTrue) {
            List<Client> clientDetails = ClientDBUtil.getClientDetails(id);
            request.setAttribute("clientDetails", clientDetails);
            String successMessage = "Client details updated successfully.";
            request.setAttribute("successMessage", successMessage);
            RequestDispatcher dis1 = request.getRequestDispatcher("useraccount.jsp");
            dis1.forward(request, response);
        } else {
            List<Client> clientDetails = ClientDBUtil.getClientDetails(id);
            request.setAttribute("clientDetails", clientDetails);
            String unsuccessMessage = "Error, Client details update failed.";
            request.setAttribute("unsuccessMessage", unsuccessMessage);
            RequestDispatcher dis1 = request.getRequestDispatcher("useraccount.jsp");
            dis1.forward(request, response);
        }
    }
}