<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OrderSnap - User Dashboard</title>
    <!-- Updated to latest Tailwind CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/3.3.3/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
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
        .btn-secondary {
            background-color: #6b7280;
            transition: all 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #4b5563;
        }
        .btn-danger {
            background-color: #ef4444;
            transition: all 0.3s ease;
        }
        .btn-danger:hover {
            background-color: #dc2626;
        }
        footer {
            margin-top: auto;
        }
        .alert {
            border-radius: 0.375rem;
            padding: 1rem;
            margin-bottom: 1rem;
            animation: fadeIn 0.5s;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .card-hover {
            transition: all 0.3s ease;
        }
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        .tab-active {
            border-bottom: 2px solid #4f46e5;
            color: #4f46e5;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="bg-white shadow-sm sticky top-0 z-50">
        <div class="container mx-auto px-4 py-4 flex justify-between items-center">
            <div class="flex items-center space-x-3">
                <img src="/api/placeholder/48/48" alt="OrderSnap Logo" class="h-12 w-12">
                <div>
                    <h1 class="text-2xl font-bold text-gray-800">OrderSnap</h1>
                    <p class="text-sm text-gray-600">Your Meal, Just a Click Away!</p>
                </div>
            </div>
            <div class="hidden md:flex items-center space-x-6">
                <a href="#" class="text-gray-600 hover:text-gray-800 flex items-center space-x-1" id="account-btn">
                    <i class="fas fa-user"></i>
                    <span>${user.fullName}</span>
                </a>
                <a href="#" class="text-gray-600 hover:text-gray-800 flex items-center space-x-1" id="orders-btn">
                    <i class="fas fa-clipboard-list"></i>
                    <span>Orders</span>
                </a>
                <a href="#" class="text-gray-600 hover:text-gray-800 flex items-center space-x-1 relative" id="cart-btn">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Cart</span>
                    <c:if test="${not empty cart && cart.size() > 0}">
                        <span class="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">${cart.size()}</span>
                    </c:if>
                </a>
                <a href="LogoutServlet" class="text-red-600 hover:text-red-800 font-medium flex items-center space-x-1">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </div>
            <div class="md:hidden">
                <button class="text-gray-600" id="mobile-menu-button">
                    <i class="fas fa-bars text-2xl"></i>
                </button>
            </div>
        </div>
        <!-- Mobile Menu -->
        <div class="md:hidden hidden bg-white border-t" id="mobile-menu">
            <div class="container mx-auto px-4 py-2 flex flex-col">
                <a href="#" class="py-2 px-4 text-gray-600 hover:bg-gray-100 flex items-center space-x-2">
                    <i class="fas fa-user w-6"></i>
                    <span>${user.fullName}</span>
                </a>
                <a href="#" class="py-2 px-4 text-gray-600 hover:bg-gray-100 flex items-center space-x-2">
                    <i class="fas fa-clipboard-list w-6"></i>
                    <span>Orders</span>
                </a>
                <a href="#" class="py-2 px-4 text-gray-600 hover:bg-gray-100 flex items-center space-x-2">
                    <i class="fas fa-shopping-cart w-6"></i>
                    <span>Cart</span>
                    <c:if test="${not empty cart && cart.size() > 0}">
                        <span class="bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">${cart.size()}</span>
                    </c:if>
                </a>
                <a href="LogoutServlet" class="py-2 px-4 text-red-600 hover:bg-red-100 flex items-center space-x-2">
                    <i class="fas fa-sign-out-alt w-6"></i>
                    <span>Logout</span>
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="container mx-auto px-4 py-8">
        <!-- Alerts -->
        <div id="alerts-container">
            <c:if test="${param.success == 'true'}">
                <div class="alert bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4 flex justify-between items-center">
                    <p>${param.message}</p>
                    <button class="text-green-700 hover:text-green-900 alert-close">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </c:if>
            <c:if test="${param.error == 'true'}">
                <div class="alert bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4 flex justify-between items-center">
                    <p>${param.message}</p>
                    <button class="text-red-700 hover:text-red-900 alert-close">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4 flex justify-between items-center">
                    <p>${errorMessage}</p>
                    <button class="text-red-700 hover:text-red-900 alert-close">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </c:if>
        </div>

        <!-- Search and Category Filter -->
        <div class="mb-8">
            <div class="flex flex-col md:flex-row gap-4">
                <div class="flex-1">
                    <form action="SearchServlet" method="get" class="flex">
                        <input type="text" name="query" placeholder="Search for items..." class="w-full rounded-l-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                        <button type="submit" class="btn-primary text-white py-2 px-4 rounded-r-md shadow-sm">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
                <div>
                    <select name="category" id="category-filter" class="rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                        <option value="">All Categories</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>

        <!-- Tabs -->
        <div class="mb-6 border-b border-gray-200">
            <div class="flex space-x-8">
                <button class="py-2 px-1 tab-active" id="catalog-tab">
                    <i class="fas fa-th-large mr-2"></i>Product Catalog
                </button>
                <button class="py-2 px-1 text-gray-500 hover:text-gray-700" id="cart-tab">
                    <i class="fas fa-shopping-cart mr-2"></i>Your Cart
                    <c:if test="${not empty cart && cart.size() > 0}">
                        <span class="ml-1 bg-red-500 text-white text-xs rounded-full h-5 w-5 inline-flex items-center justify-center">${cart.size()}</span>
                    </c:if>
                </button>
                <button class="py-2 px-1 text-gray-500 hover:text-gray-700" id="orders-tab">
                    <i class="fas fa-clipboard-list mr-2"></i>Order History
                </button>
                <button class="py-2 px-1 text-gray-500 hover:text-gray-700" id="account-tab">
                    <i class="fas fa-user mr-2"></i>Account
                </button>
            </div>
        </div>

        <!-- Product Catalog Tab -->
        <div id="catalog-section" class="mb-12">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-800">Product Catalog</h2>
                <div class="flex items-center space-x-4">
                    <button class="text-gray-600 view-toggle" data-view="grid"><i class="fas fa-th-large"></i></button>
                    <button class="text-gray-400 view-toggle" data-view="list"><i class="fas fa-list"></i></button>
                </div>
            </div>
            
            <c:choose>
                <c:when test="${empty items}">
                    <div class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 mb-4 rounded">
                        <p>No items available at the moment. Please check back later!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6" id="products-grid">
                        <c:forEach var="item" items="${items}">
                            <div class="bg-white p-6 rounded-lg shadow-md card-hover" data-category="${item.categoryId}">
                                <div class="relative">
                                    <img src="${empty item.imagePath ? '/api/placeholder/400/250' : item.imagePath}" alt="${item.name}" class="w-full h-48 object-cover rounded-md mb-4">
                                    <c:if test="${item.isNew}">
                                        <span class="absolute top-2 right-2 bg-green-500 text-white text-xs px-2 py-1 rounded">NEW</span>
                                    </c:if>
                                </div>
                                <h3 class="text-lg font-semibold text-gray-800">${item.name}</h3>
                                <p class="text-gray-600 mb-2 h-12 overflow-hidden">${item.description}</p>
                                <div class="flex justify-between items-center mb-4">
                                    <p class="text-gray-800 font-medium">$${item.price}</p>
                                    <div class="flex items-center">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fas fa-star ${i <= item.rating ? 'text-yellow-400' : 'text-gray-300'}"></i>
                                        </c:forEach>
                                    </div>
                                </div>
                                <form action="AddToCartServlet" method="post" class="flex items-center space-x-2">
                                    <input type="hidden" name="itemId" value="${item.itemId}">
                                    <input type="number" name="quantity" value="1" min="1" class="w-16 rounded-md border-gray-300 shadow-sm focus:outline-none py-1 px-2">
                                    <button type="submit" class="btn-primary text-white py-2 px-4 rounded shadow-sm flex-1">
                                        <i class="fas fa-cart-plus mr-2"></i>Add to Cart
                                    </button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="hidden flex flex-col space-y-4" id="products-list">
                        <c:forEach var="item" items="${items}">
                            <div class="bg-white p-4 rounded-lg shadow-md flex flex-col md:flex-row card-hover" data-category="${item.categoryId}">
                                <img src="${empty item.imagePath ? '/api/placeholder/200/150' : item.imagePath}" alt="${item.name}" class="w-full md:w-48 h-48 md:h-32 object-cover rounded-md mb-4 md:mb-0 md:mr-4">
                                <div class="flex-1">
                                    <div class="flex justify-between">
                                        <h3 class="text-lg font-semibold text-gray-800">${item.name}</h3>
                                        <p class="text-gray-800 font-medium">$${item.price}</p>
                                    </div>
                                    <p class="text-gray-600 mb-2">${item.description}</p>
                                    <div class="flex items-center mb-2">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fas fa-star ${i <= item.rating ? 'text-yellow-400' : 'text-gray-300'}"></i>
                                        </c:forEach>
                                        <span class="text-gray-500 ml-2">(${item.reviewCount} reviews)</span>
                                    </div>
                                    <form action="AddToCartServlet" method="post" class="flex items-center space-x-2">
                                        <input type="hidden" name="itemId" value="${item.itemId}">
                                        <input type="number" name="quantity" value="1" min="1" class="w-16 rounded-md border-gray-300 shadow-sm focus:outline-none py-1 px-2">
                                        <button type="submit" class="btn-primary text-white py-2 px-4 rounded shadow-sm">
                                            <i class="fas fa-cart-plus mr-2"></i>Add to Cart
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Cart Tab -->
        <div id="cart-section" class="mb-12 hidden">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">Your Cart</h2>
            <c:choose>
                <c:when test="${empty cart}">
                    <div class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 mb-4 rounded">
                        <p>Your cart is empty. Add some delicious items to get started!</p>
                    </div>
                    <a href="#" class="btn-primary inline-block text-white py-2 px-6 rounded shadow-sm" id="browse-products">
                        <i class="fas fa-arrow-left mr-2"></i>Browse Products
                    </a>
                </c:when>
                <c:otherwise>
                    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                        <div class="overflow-x-auto">
                            <table class="w-full border-collapse">
                                <thead>
                                    <tr class="border-b-2 border-gray-200">
                                        <th class="text-left py-3 px-2">Item</th>
                                        <th class="text-left py-3 px-2">Price</th>
                                        <th class="text-left py-3 px-2">Quantity</th>
                                        <th class="text-left py-3 px-2">Subtotal</th>
                                        <th class="text-left py-3 px-2">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cartItem" items="${cart}">
                                        <tr class="border-b border-gray-200">
                                            <td class="py-3 px-2">
                                                <div class="flex items-center space-x-3">
                                                    <img src="${empty cartItem.item.imagePath ? '/api/placeholder/50/50' : cartItem.item.imagePath}" alt="${cartItem.item.name}" class="w-12 h-12 object-cover rounded">
                                                    <span class="font-medium">${cartItem.item.name}</span>
                                                </div>
                                            </td>
                                            <td class="py-3 px-2">$${cartItem.item.price}</td>
                                            <td class="py-3 px-2">
                                                <form action="UpdateCartServlet" method="post" class="flex items-center space-x-1">
                                                    <input type="hidden" name="itemId" value="${cartItem.item.itemId}">
                                                    <button type="submit" name="action" value="decrease" class="bg-gray-200 text-gray-700 w-6 h-6 rounded-full flex items-center justify-center">
                                                        <i class="fas fa-minus text-xs"></i>
                                                    </button>
                                                    <input type="number" name="quantity" value="${cartItem.quantity}" min="1" class="w-12 text-center border-gray-300 rounded py-1">
                                                    <button type="submit" name="action" value="increase" class="bg-gray-200 text-gray-700 w-6 h-6 rounded-full flex items-center justify-center">
                                                        <i class="fas fa-plus text-xs"></i>
                                                    </button>
                                                </form>
                                            </td>
                                            <td class="py-3 px-2 font-medium">$${cartItem.subtotal}</td>
                                            <td class="py-3 px-2">
                                                <form action="UpdateCartServlet" method="post">
                                                    <input type="hidden" name="itemId" value="${cartItem.item.itemId}">
                                                    <input type="hidden" name="action" value="remove">
                                                    <button type="submit" class="text-red-500 hover:text-red-700">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="mt-6 flex flex-col md:flex-row justify-between items-start md:items-center">
                            <div class="mb-4 md:mb-0">
        <p class="text-gray-600">Total Items: <span class="font-medium">${totalItems}</span></p>
        <p class="text-gray-600">Total: <span class="font-medium text-xl">$<fmt:formatNumber value="${totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" /></span></p>
    </div>
                            <div class="flex space-x-4">
                                <a href="#" class="btn-secondary text-white py-2 px-4 rounded shadow-sm" id="continue-shopping">
                                    <i class="fas fa-arrow-left mr-2"></i>Continue Shopping
                                </a>
                                <form action="ClearCartServlet" method="post" class="inline">
                                    <button type="submit" class="btn-danger text-white py-2 px-4 rounded shadow-sm">
                                        <i class="fas fa-trash-alt mr-2"></i>Clear Cart
                                    </button>
                                </form>
                                <form action="PlaceOrderServlet" method="post" class="inline">
                                    <button type="submit" class="btn-primary text-white py-2 px-4 rounded shadow-sm">
                                        <i class="fas fa-shopping-bag mr-2"></i>Place Order
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Order History Tab -->
        <div id="orders-section" class="mb-12 hidden">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">Order History</h2>
            <c:choose>
                <c:when test="${empty orders}">
                    <div class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 mb-4 rounded">
                        <p>You haven't placed any orders yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="space-y-4">
                        <c:forEach var="order" items="${orders}">
                            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                                <div class="p-4 bg-gray-50 border-b border-gray-200 flex justify-between">
                                    <div>
                                        <p class="text-sm text-gray-600">Order #${order.orderId}</p>
                                        <p class="text-sm text-gray-600">Placed on: ${order.orderDate}</p>
                                    </div>
                                    <div>
                                        <span class="px-3 py-1 rounded-full text-sm font-medium 
                                            ${order.status == 'Completed' ? 'bg-green-100 text-green-800' : 
                                              order.status == 'Processing' ? 'bg-blue-100 text-blue-800' : 
                                              order.status == 'Shipped' ? 'bg-purple-100 text-purple-800' : 
                                              'bg-yellow-100 text-yellow-800'}">
                                            ${order.status}
                                        </span>
                                    </div>
                                </div>
                                <div class="p-4">
                                    <div class="space-y-3">
                                        <c:forEach var="item" items="${order.items}">
                                            <div class="flex justify-between">
                                                <div class="flex items-center space-x-3">
                                                    <img src="${empty item.imagePath ? '/api/placeholder/40/40' : item.imagePath}" alt="${item.name}" class="w-10 h-10 object-cover rounded">
                                                    <span>${item.quantity} × ${item.name}</span>
                                                </div>
                                                <span>$${item.subtotal}</span>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div class="mt-4 pt-3 border-t border-gray-100 flex justify-between">
                                        <span class="font-medium">Total:</span>
                                        <span class="font-medium">$${order.total}</span>
                                    </div>
                                </div>
                                <div class="p-4 bg-gray-50 border-t border-gray-200 flex justify-between items-center">
                                    <div>
                                        <p class="text-sm text-gray-600">Delivery Address: ${order.address}</p>
                                    </div>
                                    <c:if test="${order.canReorder}">
                                        <form action="ReorderServlet" method="post">
                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                            <button type="submit" class="btn-primary text-white py-1 px-3 rounded text-sm">
                                                <i class="fas fa-redo mr-1"></i>Reorder
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Account Tab -->
        <div id="account-section" class="mb-12 hidden">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">Account Settings</h2>
            
            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <h3 class="text-xl font-medium text-gray-800 mb-4">Profile Information</h3>
                <form action="UpdateProfileServlet" method="post" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                            <input type="text" id="fullName" name="fullName" value="${user.fullName}" class="w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                        </div>
                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                            <input type="email" id="email" name="email" value="${user.email}" class="w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                        </div>
                        <div>
                            <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
                            <input type="tel" id="phone" name="phone" value="${user.phone}" class="w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                        </div>
                    </div>
                    <button type="submit" class="btn-primary text-white py-2 px-4 rounded shadow-sm">
                        <i class="fas fa-save mr-2"></i>Update Profile
                    </button>
                </form>
            </div>
            
            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <h3 class="text-xl font-medium text-gray-800 mb-4">Delivery Addresses</h3>
                <c:if test="${not empty addresses}">
                    <div class="space-y-4 mb-6">
                        <c:forEach var="address" items="${addresses}" varStatus="status">
                            <div class="border border-gray-200 rounded-md p-3 flex justify-between items-center">
                                <div>
                                    <p class="font-medium">${address.addressLine1}</p>
                                    <p class="text-gray-600">${address.addressLine2}</p>
                                    <p class="text-gray-600">${address.city}, ${address.state} ${address.zipCode}</p>
                                    <p class="text-sm text-gray-500">${address.isDefault ? 'Default Address' : ''}</p>
                                </div>
                                <div class="flex space-x-2">
                                    <a href="EditAddressServlet?id=${address.id}" class="text-indigo-600 hover:text-indigo-800">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <c:if test="${!address.isDefault}">
                                        <form action="DeleteAddressServlet" method="post" class="inline">
                                            <input type="hidden" name="addressId" value="${address.id}">
                                            <button type="submit" class="text-red-500 hover:text-red-700">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                
                <button id="add-address-btn" class="btn-secondary text-white py-2 px-4 rounded shadow-sm mb-4">
                    <i class="fas fa-plus mr-2"></i>Add New Address
                </button>
                
                <div id="address-form" class="${empty addressFormVisible ? 'hidden' : ''}">
                    <form action="AddAddressServlet" method="post" class="space-y-4 border border-gray-200 rounded-md p-4">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="addressLine1" class="block text-sm font-medium text-gray-700 mb-1">Address Line 1</label>
                                <input type="text" id="addressLine1" name="addressLine1" class="w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                            </div>
                            <div>
                                <label for="addressLine2" class="block text-sm font-medium text-gray-700 mb-1">Address Line 2 (Optional)</label>
                                <input type="text" id="addressLine2" name="addressLine2" class="w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                            </div>
                            <div>
                                <label for="city" class="block text-sm font-medium text-gray-700 mb-1">City</label>
                                <input type="text" id="city" name="city" class="w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                            </div>
                            <div>
                                <label for="state" class="block text-sm font-medium text-gray-700 mb-1">State</label>
                                <input type="text" id="state" name="state" class="w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                            </div>
                            <div>
                                <label for="zipCode" class="block text-sm font-medium text-gray-700 mb-1">ZIP Code</label>
                                <input type="text" id="zipCode" name="zipCode" class="w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                            </div>
                            <div class="flex items-center">
                                <input type="checkbox" id="isDefault" name="isDefault" class="rounded border-gray-300 text-indigo-600 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 h-4 w-4">
                                <label for="isDefault" class="ml-2 block text-sm text-gray-700">Set as default address</label>
                            </div>
                        </div>
                        <div class="flex space-x-4">
                            <button type="submit" class="btn-primary text-white py-2 px-4 rounded shadow-sm">
                                <i class="fas fa-save mr-2"></i>Save Address
                            </button>
                            <button type="button" id="cancel-address" class="btn-secondary text-white py-2 px-4 rounded shadow-sm">
                                <i class="fas fa-times mr-2"></i>Cancel
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="bg-white rounded-lg shadow-md p-6">
                <h3 class="text-xl font-medium text-gray-800 mb-4">Change Password</h3>
                <form action="ChangePasswordServlet" method="post" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="currentPassword" class="block text-sm font-medium text-gray-700 mb-1">Current Password</label>
                            <input type="password" id="currentPassword" name="currentPassword" class="w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                        </div>
                        <div></div>
                        <div>
                            <label for="newPassword" class="block text-sm font-medium text-gray-700 mb-1">New Password</label>
                            <input type="password" id="newPassword" name="newPassword" class="w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                        </div>
                        <div>
                            <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1">Confirm New Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50 focus:border-indigo-300 p-2">
                        </div>
                    </div>
                    <button type="submit" class="btn-primary text-white py-2 px-4 rounded shadow-sm">
                        <i class="fas fa-key mr-2"></i>Change Password
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white mt-auto">
        <div class="container mx-auto px-4 py-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div>
                    <div class="flex items-center space-x-2 mb-4">
                        <img src="/api/placeholder/32/32" alt="OrderSnap Logo" class="h-8 w-8">
                        <h3 class="text-xl font-bold">OrderSnap</h3>
                    </div>
                    <p class="text-gray-400">Your Meal, Just a Click Away!</p>
                    <div class="mt-4 flex space-x-4">
                        <a href="#" class="text-gray-400 hover:text-white">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white">
                            <i class="fab fa-instagram"></i>
                        </a>
                    </div>
                </div>
                <div>
                    <h3 class="text-lg font-semibold mb-4">Quick Links</h3>
                    <ul class="space-y-2">
                        <li>
                            <a href="#" class="text-gray-400 hover:text-white">Home</a>
                        </li>
                        <li>
                            <a href="#" class="text-gray-400 hover:text-white">About Us</a>
                        </li>
                        <li>
                            <a href="#" class="text-gray-400 hover:text-white">Help & Support</a>
                        </li>
                        <li>
                            <a href="#" class="text-gray-400 hover:text-white">Contact Us</a>
                        </li>
                    </ul>
                </div>
                <div>
                    <h3 class="text-lg font-semibold mb-4">Contact Info</h3>
                    <ul class="space-y-2 text-gray-400">
                        <li class="flex items-start space-x-2">
                            <i class="fas fa-map-marker-alt mt-1"></i>
                            <span>123 Main Street, City, Country</span>
                        </li>
                        <li class="flex items-start space-x-2">
                            <i class="fas fa-phone mt-1"></i>
                            <span>+1 234 567 890</span>
                        </li>
                        <li class="flex items-start space-x-2">
                            <i class="fas fa-envelope mt-1"></i>
                            <span>support@ordersnap.com</span>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="border-t border-gray-800 mt-8 pt-6 text-center text-gray-400">
                <p>© 2025 OrderSnap. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- JavaScript -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Mobile menu toggle
            const mobileMenuButton = document.getElementById('mobile-menu-button');
            const mobileMenu = document.getElementById('mobile-menu');
            
            mobileMenuButton.addEventListener('click', function() {
                mobileMenu.classList.toggle('hidden');
            });
            
            // Close alerts
            const alertCloseButtons = document.querySelectorAll('.alert-close');
            alertCloseButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const alert = this.closest('.alert');
                    alert.style.opacity = '0';
                    setTimeout(() => {
                        alert.remove();
                    }, 300);
                });
            });
            
            // Tab switching
            const tabs = {
                'catalog-tab': 'catalog-section',
                'cart-tab': 'cart-section',
                'orders-tab': 'orders-section',
                'account-tab': 'account-section'
            };
            
            Object.keys(tabs).forEach(tabId => {
                const tab = document.getElementById(tabId);
                if (tab) {
                    tab.addEventListener('click', function() {
                        // Hide all sections
                        Object.values(tabs).forEach(sectionId => {
                            const section = document.getElementById(sectionId);
                            if (section) section.classList.add('hidden');
                        });
                        
                        // Show selected section
                        const section = document.getElementById(tabs[tabId]);
                        if (section) section.classList.remove('hidden');
                        
                        // Update tab styles
                        Object.keys(tabs).forEach(id => {
                            const t = document.getElementById(id);
                            if (t) {
                                t.classList.remove('tab-active');
                                t.classList.add('text-gray-500');
                                t.classList.add('hover:text-gray-700');
                            }
                        });
                        
                        this.classList.remove('text-gray-500');
                        this.classList.remove('hover:text-gray-700');
                        this.classList.add('tab-active');
                    });
                }
            });
            
            // View toggle (Grid/List)
            const viewToggles = document.querySelectorAll('.view-toggle');
            const productsGrid = document.getElementById('products-grid');
            const productsList = document.getElementById('products-list');
            
            viewToggles.forEach(toggle => {
                toggle.addEventListener('click', function() {
                    const view = this.getAttribute('data-view');
                    
                    viewToggles.forEach(t => {
                        t.classList.add('text-gray-400');
                        t.classList.remove('text-gray-600');
                    });
                    
                    this.classList.remove('text-gray-400');
                    this.classList.add('text-gray-600');
                    
                    if (view === 'grid') {
                        productsGrid.classList.remove('hidden');
                        productsList.classList.add('hidden');
                    } else {
                        productsGrid.classList.add('hidden');
                        productsList.classList.remove('hidden');
                    }
                });
            });
            
            // Category filter
            const categoryFilter = document.getElementById('category-filter');
            if (categoryFilter) {
                categoryFilter.addEventListener('change', function() {
                    const categoryId = this.value;
                    const products = document.querySelectorAll('[data-category]');
                    
                    products.forEach(product => {
                        if (categoryId === '' || product.getAttribute('data-category') === categoryId) {
                            product.classList.remove('hidden');
                        } else {
                            product.classList.add('hidden');
                        }
                    });
                });
            }
            
            // Address form toggle
            const addAddressBtn = document.getElementById('add-address-btn');
            const addressForm = document.getElementById('address-form');
            const cancelAddress = document.getElementById('cancel-address');
            
            if (addAddressBtn && addressForm) {
                addAddressBtn.addEventListener('click', function() {
                    addressForm.classList.remove('hidden');
                    this.classList.add('hidden');
                });
            }
            
            if (cancelAddress && addressForm && addAddressBtn) {
                cancelAddress.addEventListener('click', function() {
                    addressForm.classList.add('hidden');
                    addAddressBtn.classList.remove('hidden');
                });
            }
            
            // Navigation from cart
            const continueShoppingBtn = document.getElementById('continue-shopping');
            const browseProductsBtn = document.getElementById('browse-products');
            const catalogTab = document.getElementById('catalog-tab');
            
            if (continueShoppingBtn && catalogTab) {
                continueShoppingBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    catalogTab.click();
                });
            }
            
            if (browseProductsBtn && catalogTab) {
                browseProductsBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    catalogTab.click();
                });
            }
            
            // Header navigation buttons
            const cartBtn = document.getElementById('cart-btn');
            const cartTab = document.getElementById('cart-tab');
            const ordersBtn = document.getElementById('orders-btn');
            const ordersTab = document.getElementById('orders-tab');
            const accountBtn = document.getElementById('account-btn');
            const accountTab = document.getElementById('account-tab');
            
            if (cartBtn && cartTab) {
                cartBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    cartTab.click();
                });
            }
            
            if (ordersBtn && ordersTab) {
                ordersBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    ordersTab.click();
                });
            }
            
            if (accountBtn && accountTab) {
                accountBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    accountTab.click();
                });
            }
        });
    </script>
</body>
</html>