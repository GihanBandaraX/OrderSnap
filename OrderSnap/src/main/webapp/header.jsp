<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="bg-white shadow-sm sticky top-0 z-50">
    <div class="container mx-auto px-4 py-4">
        <div class="flex justify-between items-center">
            <div class="flex items-center space-x-3">
                <img src="logo.png" alt="OrderSnap Logo" class="h-14 w-auto">
                <div>
                    <h1 class="text-2xl font-bold text-indigo-600">OrderSnap</h1>
                    <p class="text-sm text-gray-600">Your Meal, Just a Click Away!</p>
                </div>
            </div>
            
            <div class="hidden md:flex items-center space-x-6">
                <a href="#" class="text-gray-700 hover:text-indigo-600 transition-colors">Home</a>
                <a href="#" class="text-gray-700 hover:text-indigo-600 transition-colors">Menu</a>
                <a href="about.jsp" class="text-gray-700 hover:text-indigo-600 transition-colors">About</a>
                <a href="contact.jsp" class="text-gray-700 hover:text-indigo-600 transition-colors">Contact</a>
            </div>
            
            <div class="flex items-center space-x-4">
                <div class="relative">
                    <a href="#cart" class="text-gray-700 hover:text-indigo-600 transition-colors">
                        <i class="fas fa-shopping-cart text-xl"></i>
                        <c:if test="${not empty cart && cart.size() > 0}">
                            <span class="cart-badge">${cart.size()}</span>
                        </c:if>
                    </a>
                </div>
                <a href="LogoutServlet" class="text-indigo-600 hover:text-indigo-800 font-medium flex items-center">
                    <i class="fas fa-sign-out-alt mr-2"></i>Logout
                </a>
            </div>
        </div>
    </div>
</header>