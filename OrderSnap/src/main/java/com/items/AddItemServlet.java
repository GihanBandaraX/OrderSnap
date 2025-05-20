package com.items;

import java.io.File;
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

@WebServlet("/AddItemServlet")
public class AddItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "images";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!ServletFileUpload.isMultipartContent(request)) {
            response.sendRedirect("admin-dashboard.jsp?error=true&message=Form+must+be+multipart");
            return;
        }

        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(request);

            String name = null;
            String description = null;
            double price = 0.0;
            boolean isAvailable = false;
            String imagePath = null;

            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String value = item.getString();
                    System.out.println("Field: " + fieldName + ", Value: " + value);
                    if ("name".equals(fieldName)) {
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
                    String fileName = item.getName();
                    if (fileName != null && !fileName.isEmpty()) {
                        // Validate image type
                        String contentType = item.getContentType();
                        if (!contentType.startsWith("image/")) {
                            response.sendRedirect("admin-dashboard.jsp?error=true&message=Invalid+image+format");
                            return;
                        }
                        // Save file
                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        String filePath = uploadPath + File.separator + fileName;
                        item.write(new File(filePath));
                        imagePath = "/" + UPLOAD_DIR + "/" + fileName;
                        System.out.println("Image saved to: " + filePath + ", DB Path: " + imagePath);
                    }
                }
            }

            // Validate required fields
            if (name == null || name.trim().isEmpty() || description == null || description.trim().isEmpty() || imagePath == null) {
                response.sendRedirect("admin-dashboard.jsp?error=true&message=Missing+required+fields");
                return;
            }

            // Add item to database
            boolean isAdded = ItemDBUtil.addItem(name, description, price, isAvailable, imagePath);
            if (isAdded) {
                response.sendRedirect("ViewItemServlet?success=true&message=Item+added+successfully");
            } else {
                response.sendRedirect("admin-dashboard.jsp?error=true&message=Failed+to+add+item+to+database");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error in AddItemServlet: " + e.getMessage());
            response.sendRedirect("admin-dashboard.jsp?error=true&message=Server+error:+check+logs");
        }
    }
}