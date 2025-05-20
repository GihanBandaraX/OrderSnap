package com.items;


import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.FileItem;
import java.util.Base64;

@WebServlet("/UpdateItemServlet")
public class UpdateItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!ServletFileUpload.isMultipartContent(request)) {
            response.sendRedirect("ViewItemServlet?error=true&message=Form+must+be+multipart");
            return;
        }

        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(request);

            int itemId = 0;
            String name = null;
            String description = null;
            double price = 0.0;
            boolean isAvailable = false; // Default to false, will be set to true if checkbox is checked
            String imageBase64 = null;

            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String value = item.getString();
                    System.out.println("Field: " + fieldName + ", Value: " + value); // Debug log
                    if ("itemId".equals(fieldName)) {
                        itemId = Integer.parseInt(value);
                    } else if ("name".equals(fieldName)) {
                        name = value;
                    } else if ("description".equals(fieldName)) {
                        description = value;
                    } else if ("price".equals(fieldName)) {
                        price = Double.parseDouble(value);
                    } else if ("isAvailable".equals(fieldName)) {
                        isAvailable = Boolean.parseBoolean(value);
                    }
                } else {
                    // Handle image file
                    byte[] imageBytes = item.get();
                    if (imageBytes != null && imageBytes.length > 0) {
                        imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                        System.out.println("Image uploaded, Base64 length: " + imageBase64.length());
                    } else {
                        System.out.println("No new image uploaded.");
                    }
                }
            }

            // Validate required fields
            if (itemId <= 0 || name == null || name.trim().isEmpty() || description == null || description.trim().isEmpty()) {
                response.sendRedirect("ViewItemServlet?error=true&message=Missing+required+fields");
                return;
            }

            // Call ItemDBUtil to update the item
            boolean isUpdated = ItemDBUtil.updateItem(itemId, name, description, price, isAvailable, imageBase64);
            if (isUpdated) {
                response.sendRedirect("ViewItemServlet?success=true&message=Item+updated+successfully");
            } else {
                response.sendRedirect("ViewItemServlet?error=true&message=Failed+to+update+item+check+logs");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.err.println("Error in UpdateItemServlet: Invalid number format - " + e.getMessage());
            response.sendRedirect("ViewItemServlet?error=true&message=Invalid+number+format");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error in UpdateItemServlet: " + e.getMessage());
            response.sendRedirect("ViewItemServlet?error=true&message=Server+error+check+logs");
        }
    }
}