package com.order;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static String url="jdbc:mysql://localhost:3306/ordersnap_db";
	public static String user="root";
	public static String pass="gihanX123";
	private static Connection con;
	
	public static Connection getConnection() {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection(url, user, pass);
			
			
		} catch (Exception e) {
			System.out.println("Database connection is unsuccesful!!!");
		}
		
		
		
		
		return con;
		
		
	}

	public static void close(Connection con2) {
	    if (con2 != null) {
	        try {
	            con2.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	            // Handle the exception or log it
	        }
	    }
	}




	


}
