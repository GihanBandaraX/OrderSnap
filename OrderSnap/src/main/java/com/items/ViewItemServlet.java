package com.items;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewItemServlet")
public class ViewItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Item> items = ItemDBUtil.getAllItems();
            request.setAttribute("items", items);

            // Pass success or error messages from URL parameters
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            String message = request.getParameter("message");

            if ("true".equals(success)) {
                request.setAttribute("successMessage", message != null ? message.replace("+", " ") : "Operation successful");
            } else if ("true".equals(error)) {
                request.setAttribute("errorMessage", message != null ? message.replace("+", " ") : "Operation failed");
            }

            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving items: " + e.getMessage());
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        }
    }
}