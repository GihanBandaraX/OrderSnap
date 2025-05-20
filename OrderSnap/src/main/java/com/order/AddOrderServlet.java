package com.order;

import com.client.CartItem;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddOrderServlet")
public class AddOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");

        // Validate cart
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("error", "Cart is empty");
            response.sendRedirect("UserDashboardServlet");
            return;
        }

        // Get client ID from session (assume logged-in user)
        Integer clientId = (Integer) session.getAttribute("clientId");
        if (clientId == null) {
            session.setAttribute("error", "User not logged in");
            response.sendRedirect("UserDashboardServlet");
            return;
        }

        // Get payment details
        String cardName = request.getParameter("cardName");
        String cardNumber = request.getParameter("cardNumber");
        String expDate = request.getParameter("expDate");
        String cvv = request.getParameter("cvv");
        String address = request.getParameter("address");

        // Validate payment details (basic validation)
        if (!isValidPayment(cardName, cardNumber, expDate, cvv, address)) {
            session.setAttribute("error", "Invalid payment details");
            response.sendRedirect("UserDashboardServlet");
            return;
        }

        // Current date and time
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String orderDate = sdf.format(new Date());

        // Process each cart item as a separate order (for simplicity)
        boolean allOrdersSuccess = true;
        for (CartItem cartItem : cart) {
            int itemId = cartItem.getItem().getItemId();
            int quantity = cartItem.getQuantity();
            double totalPrice = cartItem.getSubtotal();
            String status = "Pending";

            if (!OrderDBUtil.addOrder(clientId, itemId, quantity, totalPrice, status, orderDate)) {
                allOrdersSuccess = false;
                System.err.println("[AddOrderServlet] Failed to add order for Item ID: " + itemId);
            }
        }

        if (allOrdersSuccess) {
            // Clear cart after successful order
            session.removeAttribute("cart");
            session.setAttribute("success", "Order placed successfully");
            response.sendRedirect("UserDashboardServlet");
        } else {
            session.setAttribute("error", "Some orders failed to process");
            response.sendRedirect("UserDashboardServlet");
        }
    }

    private boolean isValidPayment(String cardName, String cardNumber, String expDate, String cvv, String address) {
        // Basic validation (can be enhanced)
        return cardName != null && !cardName.trim().isEmpty() &&
               cardNumber != null && cardNumber.trim().replaceAll("\\s+", "").length() == 16 &&
               expDate != null && expDate.matches("\\d{2}/\\d{2}") &&
               cvv != null && cvv.length() == 3 &&
               address != null && !address.trim().isEmpty();
    }
}