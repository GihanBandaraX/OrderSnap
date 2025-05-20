package com.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDBUtil {
    private static Connection con = null;
    private static PreparedStatement pstmt = null;
    private static ResultSet rs = null;

    public static List<Order> getAllOrders() {
        ArrayList<Order> orders = new ArrayList<>();
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                System.err.println("[OrderDBUtil] Failed to establish database connection in getAllOrders.");
                return orders;
            }

            String sql = "SELECT * FROM orders";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            System.out.println("[OrderDBUtil] Executing query: " + sql);

            int count = 0;
            while (rs.next()) {
                int orderId = rs.getInt("orderId");
                int clientId = rs.getInt("clientId");
                int itemId = rs.getInt("itemId");
                int quantity = rs.getInt("quantity");
                double totalPrice = rs.getDouble("totalPrice");
                String status = rs.getString("status");
                String orderDate = rs.getString("orderDate");

                Order order = new Order(orderId, clientId, itemId, quantity, totalPrice, status, orderDate);
                orders.add(order);
                count++;
                System.out.println("[OrderDBUtil] Fetched order: " + orderId + ", Item ID: " + itemId);
            }
            System.out.println("[OrderDBUtil] Total orders fetched: " + count);
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("[OrderDBUtil] Error retrieving orders: " + e.getMessage());
        } finally {
            closeResources();
        }
        return orders;
    }

    public static boolean addOrder(int clientId, int itemId, int quantity, double totalPrice, String status, String orderDate) {
        boolean isSuccess = false;
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                System.err.println("[OrderDBUtil] Failed to establish database connection in addOrder.");
                return false;
            }

            String sql = "INSERT INTO orders (clientId, itemId, quantity, totalPrice, status, orderDate) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, clientId);
            pstmt.setInt(2, itemId);
            pstmt.setInt(3, quantity);
            pstmt.setDouble(4, totalPrice);
            pstmt.setString(5, status);
            pstmt.setString(6, orderDate);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
                System.out.println("[OrderDBUtil] Order added successfully: Client ID " + clientId + ", Item ID " + itemId);
            } else {
                System.err.println("[OrderDBUtil] No rows affected when adding order: Client ID " + clientId + ", Item ID " + itemId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("[OrderDBUtil] Error adding order: " + e.getMessage());
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    private static void closeResources() {
        try {
            if (rs != null) {
                rs.close();
                rs = null;
            }
            if (pstmt != null) {
                pstmt.close();
                pstmt = null;
            }
            if (con != null) {
                con.close();
                con = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("[OrderDBUtil] Error closing database resources: " + e.getMessage());
        }
    }
}