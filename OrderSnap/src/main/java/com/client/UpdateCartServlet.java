package com.client;

import com.items.Item;
import com.items.ItemDBUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
        
        // Initialize cart if null
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // Get parameters
        String itemIdStr = request.getParameter("itemId");
        String quantityStr = request.getParameter("quantity");

        try {
            int itemId = Integer.parseInt(itemIdStr);
            int quantity = Integer.parseInt(quantityStr);

            // Validate item exists in database
            Item item = ItemDBUtil.getItemById(itemId);
            if (item == null) {
                request.setAttribute("error", "Item not found");
                request.getRequestDispatcher("UserDashboardServlet").forward(request, response);
                return;
            }

            // Find and update the cart item
            boolean itemFound = false;
            for (CartItem cartItem : cart) {
                if (cartItem.getItem().getItemId() == itemId) {
                    if (quantity <= 0) {
                        cart.remove(cartItem);
                    } else {
                        cartItem.setQuantity(quantity);
                    }
                    itemFound = true;
                    break;
                }
            }

            // If item not in cart but quantity > 0, add new cart item
            if (!itemFound && quantity > 0) {
                cart.add(new CartItem(item, quantity));
            }

            session.setAttribute("cart", cart);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid item ID or quantity");
            request.getRequestDispatcher("UserDashboardServlet").forward(request, response);
            return;
        }

        // Redirect back to cart page
        response.sendRedirect("UserDashboardServlet");
    }
}