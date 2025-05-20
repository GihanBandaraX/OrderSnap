package com.client;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.items.Item;
import com.items.ItemDBUtil;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Fetch the item
            Item item = ItemDBUtil.getItemById(itemId);
            if (item == null || !item.isAvailable()) {
                response.sendRedirect("UserDashboardServlet?error=true&message=Item+not+available");
                return;
            }

            // Get or create cart in session
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            // Check if item already exists in cart
            boolean itemExists = false;
            for (CartItem cartItem : cart) {
                if (cartItem.getItem().getItemId() == itemId) {
                    cartItem.setQuantity(cartItem.getQuantity() + quantity);
                    itemExists = true;
                    break;
                }
            }

            // If item doesn't exist, add it
            if (!itemExists) {
                cart.add(new CartItem(item, quantity));
            }

            // Update cart in session
            session.setAttribute("cart", cart);
            response.sendRedirect("UserDashboardServlet?success=true&message=Item+added+to+cart");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UserDashboardServlet?error=true&message=Error+adding+to+cart");
        }
    }
}