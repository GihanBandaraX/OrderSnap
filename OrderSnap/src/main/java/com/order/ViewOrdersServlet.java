package com.order;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewOrdersServlet")
public class ViewOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Order> orders = OrderDBUtil.getAllOrders();
            System.out.println("[ViewOrdersServlet] Orders retrieved: " + orders.size());
            if (orders.isEmpty()) {
                System.out.println("[ViewOrdersServlet] Warning: No orders found to display");
            }
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("admin-orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("[ViewOrdersServlet] Error: " + e.getMessage());
            request.setAttribute("errorMessage", "Error retrieving orders: " + e.getMessage());
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        }
    }
}