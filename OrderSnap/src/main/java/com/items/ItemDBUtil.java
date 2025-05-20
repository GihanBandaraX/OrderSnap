package com.items;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import com.order.DBConnection;

public class ItemDBUtil {
    private static boolean isSuccess;
    private static Connection con = null;
    private static PreparedStatement pstmt = null;
    private static ResultSet rs = null;

    // Method to add a new item with image
    public static boolean addItem(String name, String description, double price, boolean isAvailable, String imageBase64) {
        isSuccess = false;
        String savePath = saveImageToFolder(imageBase64);

        try {
            con = DBConnection.getConnection();
            String sql = "INSERT INTO items (name, description, price, isAvailable, imagePath) VALUES (?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.setDouble(3, price);
            pstmt.setBoolean(4, isAvailable);
            pstmt.setString(5, savePath != null ? savePath : "default.jpg");
            int rs = pstmt.executeUpdate();
            if (rs > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error adding item: " + e.getMessage());
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Method to save image to local folder
    private static String saveImageToFolder(String base64Image) {
        if (base64Image == null || base64Image.trim().isEmpty()) {
            System.out.println("No image provided, using default image path.");
            return null;
        }

        try {
            String uploadDir = "C:/webapp/images/items/";
            File directory = new File(uploadDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            String fileName = System.currentTimeMillis() + ".jpg";
            Path filePath = Paths.get(uploadDir + fileName);

            byte[] imageBytes = java.util.Base64.getDecoder().decode(base64Image);
            Files.write(filePath, imageBytes);

            System.out.println("Image saved successfully at: " + filePath);
            return "C:/webapp/images/items" + fileName;
        } catch (IOException | IllegalArgumentException e) {
            e.printStackTrace();
            System.err.println("Error saving image: " + e.getMessage());
            return null;
        }
    }

    // Method to get all items
    public static List<Item> getAllItems() {
        ArrayList<Item> items = new ArrayList<>();
        try {
            con = DBConnection.getConnection();
            String sql = "SELECT * FROM items";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int itemId = rs.getInt("itemId");
                String name = rs.getString("name");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                boolean isAvailable = rs.getBoolean("isAvailable");
                String imagePath = rs.getString("imagePath");

                Item item = new Item(itemId, name, description, price, isAvailable, imagePath);
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving items: " + e.getMessage());
        } finally {
            closeResources();
        }
        return items;
    }

    // Method to update an item (including image)
    public static boolean updateItem(int itemId, String name, String description, double price, boolean isAvailable, String imageBase64) {
        isSuccess = false;
        String savePath = saveImageToFolder(imageBase64);

        try {
            con = DBConnection.getConnection();

            // Fetch the current item to get the existing image path
            String currentImagePath = "default.jpg";
            Item currentItem = getItemById(itemId);
            if (currentItem != null) {
                currentImagePath = currentItem.getImagePath();
            }

            // Use the new image path if provided, otherwise keep the existing one
            String imagePathToUse = (savePath != null) ? savePath : currentImagePath;

            String sql = "UPDATE items SET name = ?, description = ?, price = ?, isAvailable = ?, imagePath = ? WHERE itemId = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.setDouble(3, price);
            pstmt.setBoolean(4, isAvailable);
            pstmt.setString(5, imagePathToUse);
            pstmt.setInt(6, itemId);
            int rs = pstmt.executeUpdate();
            if (rs > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating item: " + e.getMessage());
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Method to delete an item
    public static boolean deleteItem(int itemId) {
        isSuccess = false;
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = DBConnection.getConnection();
            // Start a transaction to ensure atomicity
            con.setAutoCommit(false);

            // Step 1: Delete related orders from the orders table
            String deleteOrdersSql = "DELETE FROM orders WHERE itemId = ?";
            pstmt = con.prepareStatement(deleteOrdersSql);
            pstmt.setInt(1, itemId);
            pstmt.executeUpdate();
            pstmt.close();

            // Step 2: Delete the item from the items table
            String deleteItemSql = "DELETE FROM items WHERE itemId = ?";
            pstmt = con.prepareStatement(deleteItemSql);
            pstmt.setInt(1, itemId);
            int rs = pstmt.executeUpdate();

            if (rs > 0) {
                isSuccess = true;
            }

            // Commit the transaction
            con.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error deleting item: " + e.getMessage());
            try {
                if (con != null) {
                    con.rollback(); // Rollback on error
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return isSuccess;
    }

    // Method to get item by ID
    public static Item getItemById(int itemId) {
        Item item = null;
        try {
            con = DBConnection.getConnection();
            String sql = "SELECT * FROM items WHERE itemId = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, itemId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                boolean isAvailable = rs.getBoolean("isAvailable");
                String imagePath = rs.getString("imagePath");
                item = new Item(itemId, name, description, price, isAvailable, imagePath);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving item: " + e.getMessage());
        } finally {
            closeResources();
        }
        return item;
    }

    private static void closeResources() {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error closing resources: " + e.getMessage());
        }
    }
}