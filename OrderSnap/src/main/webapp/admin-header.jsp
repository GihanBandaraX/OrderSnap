<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="bg-white shadow-md sticky top-0 z-50">
    <div class="container mx-auto px-4 py-4 flex justify-between items-center">
        <div class="flex items-center space-x-3">
            <img src="logo.png" alt="OrderSnap Logo" class="h-14 w-auto">
            <div>
                <h1 class="text-2xl font-bold text-indigo-600">OrderSnap</h1>
                <p class="text-sm text-gray-600">Admin Dashboard</p>
            </div>
        </div>
        
        <div class="flex items-center space-x-4">
            <span class="text-gray-600">
                <i class="fas fa-user-shield mr-2"></i>Admin
            </span>
            <a href="LogoutServlet" class="text-indigo-600 hover:text-indigo-800 font-medium flex items-center">
                <i class="fas fa-sign-out-alt mr-2"></i>Logout
            </a>
        </div>
    </div>
    
    <!-- Navigation Bar -->
    <nav class="bg-white border-t border-b border-gray-200 shadow-sm">
        <div class="container mx-auto px-4">
            <div class="flex space-x-1">
                <a href="ViewItemServlet" class="navbar-link ${param.page == 'items' || param.page == null ? 'active' : ''} flex items-center">
                    <i class="fas fa-utensils mr-2"></i>Manage Items
                </a>
                <a href="ViewOrdersServlet" class="navbar-link ${param.page == 'orders' ? 'active' : ''} flex items-center">
                    <i class="fas fa-clipboard-list mr-2"></i>View Orders
                </a>
                <a href="#" class="navbar-link flex items-center">
                    <i class="fas fa-chart-bar mr-2"></i>Analytics
                </a>
                <a href="#" class="navbar-link flex items-center">
                    <i class="fas fa-cog mr-2"></i>Settings
                </a>
            </div>
        </div>
    </nav>
    
    <!-- Admin Breadcrumb -->
    <div class="container mx-auto px-4 py-2 text-sm text-gray-600">
        <div class="flex items-center space-x-2">
            <a href="admin-dashboard.jsp" class="hover:text-indigo-600 transition-colors">Dashboard</a>
            <i class="fas fa-chevron-right text-xs"></i>
            <c:choose>
                <c:when test="${param.page == 'orders'}">
                    <span class="text-indigo-600 font-medium">Orders</span>
                </c:when>
                <c:otherwise>
                    <span class="text-indigo-600 font-medium">Items</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>