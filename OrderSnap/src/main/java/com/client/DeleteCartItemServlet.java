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

@WebServlet("/DeleteCartItemServlet")
public class DeleteCartItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");

        // Get parameter
        String itemIdStr = request.getParameter("itemId");

        try {
            int itemId = Integer.parseInt(itemIdStr);

            // Validate item exists in database
            Item item = ItemDBUtil.getItemById(itemId);
            if (item == null) {
                request.setAttribute("error", "Item not found");
                request.getRequestDispatcher("UserDashboardServlet").forward(request, response);
                return;
            }

            if (cart != null) {
                // Remove the cart item
                cart.removeIf(cartItem -> cartItem.getItem().getItemId() == itemId);
                session.setAttribute("cart", cart);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid item ID");
            request.getRequestDispatcher("UserDashboardServlet").forward(request, response);
            return;
        }

        // Redirect back to cart page
        response.sendRedirect("UserDashboardServlet");
    }
}