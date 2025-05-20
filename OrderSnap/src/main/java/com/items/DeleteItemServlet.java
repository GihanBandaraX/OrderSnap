package com.items;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteItemServlet")
public class DeleteItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemIdStr = request.getParameter("itemId");

        try {
            int itemId = Integer.parseInt(itemIdStr);
            boolean isDeleted = ItemDBUtil.deleteItem(itemId);

            if (isDeleted) {
                response.sendRedirect("ViewItemServlet?success=true&message=Item+deleted+successfully");
            } else {
                response.sendRedirect("ViewItemServlet?error=true&message=Failed+to+delete+item");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("ViewItemServlet?error=true&message=Invalid+item+ID");
        }
    }
}