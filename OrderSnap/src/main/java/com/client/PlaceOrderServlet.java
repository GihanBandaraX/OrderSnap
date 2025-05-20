package com.client;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.items.Item;
import com.order.OrderDBUtil;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
                response.sendRedirect("UserDashboardServlet?error=true&message=Cart+is+empty");
                return;
            }

            // Assuming clientId is stored in session after login
            Integer clientId = (Integer) session.getAttribute("clientId");
            if (clientId == null) {
                response.sendRedirect("login.jsp?error=true&message=Please+login+to+place+order");
                return;
            }

            // Process each cart item as a separate order (simplified for demo)
            boolean allOrdersPlaced = true;
            for (CartItem cartItem : cart) {
                Item item = cartItem.getItem();
                int quantity = cartItem.getQuantity();
                double totalPrice = cartItem.getSubtotal();

                // Create order
                String orderDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                boolean isAdded = OrderDBUtil.addOrder(clientId, item.getItemId(), quantity, totalPrice, "Pending", orderDate);
                if (!isAdded) {
                    allOrdersPlaced = false;
                }
            }

            if (allOrdersPlaced) {
                // Clear cart after successful order
                cart.clear();
                session.setAttribute("cart", cart);
                response.sendRedirect("UserDashboardServlet?success=true&message=Order+placed+successfully");
            } else {
                response.sendRedirect("UserDashboardServlet?error=true&message=Failed+to+place+order");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UserDashboardServlet?error=true&message=Error+placing+order");
        }
    }
}