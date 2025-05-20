<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OrderSnap - User Dashboard</title>
    <!-- Tailwind CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .btn-primary {
            background-color: #4f46e5;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #4338ca;
            transform: translateY(-2px);
        }
        .product-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        .cart-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: #ef4444;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
        }
        footer {
            margin-top: auto;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp" />

    <!-- Main Content -->
    <div class="container mx-auto px-4 py-8">
        <!-- Messages -->
        <jsp:include page="messages.jsp" />

        <!-- Hero Section -->
        <div class="bg-gradient-to-r from-indigo-600 to-blue-500 rounded-lg shadow-lg p-8 mb-12 text-white">
            <div class="flex flex-col md:flex-row items-center justify-between">
                <div class="mb-6 md:mb-0 md:w-1/2">
                    <h1 class="text-3xl md:text-4xl font-bold mb-4">Welcome to OrderSnap</h1>
                    <p class="text-lg mb-6">Your Meal, Just a Click Away! Explore our delicious menu and enjoy fast delivery to your doorstep.</p>
                    <a href="#products" class="btn-primary text-white py-3 px-6 rounded-lg shadow-md inline-block font-medium">
                        <i class="fas fa-utensils mr-2"></i>Browse Menu
                    </a>
                </div>
                <div class="md:w-1/2 flex justify-end">
                    <img src="fooddel.jpg" alt="Food Delivery" class="h-64 w-auto rounded-lg shadow-lg">
                </div>
            </div>
        </div>

        <!-- Product Catalog -->
        <div class="mb-12" id="products">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-800">Product Catalog</h2>
                <div class="flex space-x-4">
                    <button class="bg-white text-gray-700 py-2 px-4 rounded-lg shadow hover:bg-gray-100 transition-all">
                        <i class="fas fa-filter mr-2"></i>Filter
                    </button>
                    <button class="bg-white text-gray-700 py-2 px-4 rounded-lg shadow hover:bg-gray-100 transition-all">
                        <i class="fas fa-sort mr-2"></i>Sort
                    </button>
                </div>
            </div>
            
            <c:choose>
                <c:when test="${empty items}">
                    <div class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 mb-4 rounded-lg">
                        <p class="flex items-center"><i class="fas fa-exclamation-triangle mr-2"></i>No items available.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                        <c:forEach var="item" items="${items}">
                            <div class="bg-white p-6 rounded-xl shadow-md product-card">
                                <div class="relative mb-4 overflow-hidden rounded-lg">
                                    <img src="${item.imagePath}" alt="${item.name}" class="w-full h-56 object-cover transition-transform duration-300 hover:scale-105">
                                    <span class="absolute top-2 right-2 bg-indigo-600 text-white px-2 py-1 rounded-md text-sm font-medium">$${item.price}</span>
                                </div>
                                <h3 class="text-xl font-semibold text-gray-800 mb-2">${item.name}</h3>
                                <p class="text-gray-600 mb-4">${item.description}</p>
                                <div class="flex justify-between items-center">
                                    <form action="AddToCartServlet" method="post" class="flex items-center space-x-2 w-full">
                                        <input type="hidden" name="itemId" value="${item.itemId}">
                                        <div class="flex items-center border border-gray-300 rounded-lg overflow-hidden">
                                            <button type="button" class="px-3 py-2 bg-gray-100 hover:bg-gray-200 transition-colors" onclick="decrementQuantity(this)">
                                                <i class="fas fa-minus"></i>
                                            </button>
                                            <input type="number" name="quantity" value="1" min="1" class="w-12 text-center border-none focus:outline-none py-2" readonly>
                                            <button type="button" class="px-3 py-2 bg-gray-100 hover:bg-gray-200 transition-colors" onclick="incrementQuantity(this)">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </div>
                                        <button type="submit" class="btn-primary text-white py-2 px-4 rounded-lg shadow flex-grow flex items-center justify-center">
                                            <i class="fas fa-cart-plus mr-2"></i>Add
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Cart Summary -->
        <jsp:include page="cart.jsp" />
    </div>

    <!-- Footer -->
    <jsp:include page="footer.jsp" />

    <script>
        function incrementQuantity(button) {
            const input = button.parentNode.querySelector('input[type="number"]');
            input.value = parseInt(input.value) + 1;
        }
        
        function decrementQuantity(button) {
            const input = button.parentNode.querySelector('input[type="number"]');
            if (parseInt(input.value) > 1) {
                input.value = parseInt(input.value) - 1;
            }
        }
    </script>
</body>
</html>