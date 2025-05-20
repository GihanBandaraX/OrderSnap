package com.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClientDBUtil {
    private static Connection con = null;
    private static PreparedStatement pstmt = null;
    private static ResultSet rs = null;

    public static boolean validate(String userName, String password) {
        boolean isSuccess = false;

        try {
            con = DBConnection.getConnection();
            if (con == null) {
                System.err.println("Failed to establish database connection in validate.");
                return false;
            }

            String sql = "SELECT * FROM clientdata WHERE username = ? AND password = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userName);
            pstmt.setString(2, password); // In production, use hashed passwords (e.g., BCrypt)
            rs = pstmt.executeQuery();

            if (rs.next()) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Validation failed: " + e.getMessage());
        } finally {
            closeResources();
        }

        return isSuccess;
    }

    public static List<Client> getClient(String username) {
        ArrayList<Client> client = new ArrayList<>();

        try {
            con = DBConnection.getConnection();
            if (con == null) {
                System.err.println("Failed to establish database connection in getClient.");
                return client;
            }

            String sql = "SELECT * FROM clientdata WHERE username = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String gender = rs.getString("gender");
                String dob = rs.getString("dob");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String userU = rs.getString("username");
                String passU = rs.getString("password");
                String userType = rs.getString("userType");

                Client c = new Client(cid, name, gender, dob, email, phone, address, userU, passU, userType);
                client.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving client: " + e.getMessage());
        } finally {
            closeResources();
        }

        return client;
    }

    public static String checkExisting(String email, String username) {
        String result = null;
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                System.err.println("Failed to establish database connection in checkExisting.");
                return result;
            }

            String sql = "SELECT email, username FROM clientdata WHERE email = ? OR username = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                if (email.equals(rs.getString("email"))) {
                    result = "Email already exists.";
                } else if (username.equals(rs.getString("username"))) {
                    result = "Username already exists.";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error checking existing user: " + e.getMessage());
        } finally {
            closeResources();
        }
        return result;
    }

    public static boolean registerclient(String name, String gender, String dob, String email, String phone,
                                         String address, String username, String password, String userType) {
        boolean isSuccess = false;

        try {
            con = DBConnection.getConnection();
            if (con == null) {
                System.err.println("Failed to establish database connection in registerclient.");
                return false;
            }

            String sql = "INSERT INTO clientdata (name, gender, dob, email, phone, address, username, password, userType) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, gender);
            pstmt.setString(3, dob);
            pstmt.setString(4, email);
            pstmt.setString(5, phone);
            pstmt.setString(6, address);
            pstmt.setString(7, username);
            pstmt.setString(8, password);
            pstmt.setString(9, userType);

            int rs = pstmt.executeUpdate();
            if (rs > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error during registration: " + e.getMessage());
        } finally {
            closeResources();
        }

        return isSuccess;
    }

    public static boolean updateclient(String id, String name, String gender, String dob, String email, String phone,
                                       String address, String username, String password, String userType) {
        boolean isSuccess = false;

        try {
            con = DBConnection.getConnection();
            if (con == null) {
                System.err.println("Failed to establish database connection in updateclient.");
                return false;
            }

            String sql = "UPDATE clientdata SET name = ?, gender = ?, dob = ?, email = ?, phone = ?, " +
                         "address = ?, username = ?, password = ?, userType = ? WHERE cid = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, gender);
            pstmt.setString(3, dob);
            pstmt.setString(4, email);
            pstmt.setString(5, phone);
            pstmt.setString(6, address);
            pstmt.setString(7, username);
            pstmt.setString(8, password);
            pstmt.setString(9, userType);
            pstmt.setInt(10, Integer.parseInt(id));

            int rs = pstmt.executeUpdate();
            if (rs > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating client: " + e.getMessage());
        } finally {
            closeResources();
        }

        return isSuccess;
    }

    public static List<Client> getClientDetails(String id) {
        ArrayList<Client> client = new ArrayList<>();

        try {
            con = DBConnection.getConnection();
            if (con == null) {
                System.err.println("Failed to establish database connection in getClientDetails.");
                return client;
            }

            String sql = "SELECT * FROM clientdata WHERE cid = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String gender = rs.getString("gender");
                String dob = rs.getString("dob");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String userU = rs.getString("username");
                String passU = rs.getString("password");
                String userType = rs.getString("userType");

                Client c = new Client(cid, name, gender, dob, email, phone, address, userU, passU, userType);
                client.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving client details: " + e.getMessage());
        } finally {
            closeResources();
        }

        return client;
    }

    public static boolean deleteclient(String id) {
        boolean isSuccess = false;

        try {
            con = DBConnection.getConnection();
            if (con == null) {
                System.err.println("Failed to establish database connection in deleteclient.");
                return false;
            }

            String sql = "DELETE FROM clientdata WHERE cid = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            int rs = pstmt.executeUpdate();

            if (rs > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error deleting client: " + e.getMessage());
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
            System.err.println("Error closing database resources: " + e.getMessage());
        }
    }
}