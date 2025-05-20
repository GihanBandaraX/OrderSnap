package com.client;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.items.Item;
import com.items.ItemDBUtil;
import com.order.Order;
import com.order.OrderDBUtil;



@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Fetch items
            List<Item> items = ItemDBUtil.getAllItems();
            System.out.println("Items retrieved in AdminDashboardServlet: " + items.size());
            request.setAttribute("items", items);

            // Fetch orders
            List<Order> orders = OrderDBUtil.getAllOrders();
            System.out.println("Orders retrieved in AdminDashboardServlet: " + orders.size());
            request.setAttribute("orders", orders);

            // Forward to adminDashboard.jsp
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error in AdminDashboardServlet: " + e.getMessage());
            request.setAttribute("errorMessage", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        }
    }
}