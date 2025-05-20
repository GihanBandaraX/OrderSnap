<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OrderSnap - Admin Dashboard</title>
    <!-- Tailwind CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
        .navbar-link {
            color: #4b5563;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
            border-bottom: 3px solid transparent;
        }
        .navbar-link:hover {
            color: #ff6347;
        }
        .navbar-link.active {
            color: #ff6347;
            border-bottom: 3px solid #ff6347;
            font-weight: 500;
        }
        .content-container {
            padding: 1.5rem;
            background-color: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            margin-top: 1rem;
        }
        .btn-primary {
            background-color: #ff6347;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #e5533d;
            transform: translateY(-2px);
        }
        .btn-secondary {
            background-color: #10b981;
            transition: all 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #059669;
            transform: translateY(-2px);
        }
        footer {
            margin-top: auto;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="bg-white shadow-sm sticky top-0 z-50">
        <div class="container mx-auto px-4 py-4 flex justify-between items-center">
            <div class="flex items-center space-x-2">
                <img src="logo.png" alt="OrderSnap Logo" class="h-12 w-12">
                <div>
                    <h1 class="text-2xl font-bold text-gray-800">OrderSnap</h1>
                    <p class="text-sm text-gray-600">Admin Dashboard</p>
                </div>
            </div>
            <div>
                <a href="LogoutServlet" class="text-red-600 hover:text-red-800 font-medium">Logout</a>
            </div>
        </div>
        
        <!-- Navigation Bar -->
        <nav class="bg-white border-t border-b border-gray-200">
            <div class="container mx-auto px-4">
                <div class="flex space-x-4">
                    <a href="ViewItemServlet" class="navbar-link ${param.page == 'items' || param.page == null ? 'active' : ''}">
                        <i class="fas fa-utensils mr-2"></i>Manage Items
                    </a>
                    <a href="ViewOrdersServlet" class="navbar-link ${param.page == 'orders' ? 'active' : ''}">
                        <i class="fas fa-clipboard-list mr-2"></i>View Orders
                    </a>
                </div>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <div class="container mx-auto px-4 py-8">
        <div class="content-container">
            <!-- Content changes based on page parameter -->
            <c:choose>
                <c:when test="${param.page == 'orders'}">
                    <!-- View Orders Content -->
                    <h2 class="text-2xl font-bold text-gray-800 mb-6">View Orders</h2>
                    <c:if test="${not empty errorMessage}">
                        <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4">
                            <p>${errorMessage}</p>
                        </div>
                    </c:if>
                    <c:choose>
                        <c:when test="${empty orders}">
                            <div class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 mb-4">
                                <p>No orders found.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table class="w-full border-collapse border border-gray-300">
                                <thead>
                                    <tr class="bg-gray-200">
                                        <th class="border border-gray-300 p-2">Order ID</th>
                                        <th class="border border-gray-300 p-2">Client ID</th>
                                        <th class="border border-gray-300 p-2">Item ID</th>
                                        <th class="border border-gray-300 p-2">Quantity</th>
                                        <th class="border border-gray-300 p-2">Total Price</th>
                                        <th class="border border-gray-300 p-2">Status</th>
                                        <th class="border border-gray-300 p-2">Order Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td class="border border-gray-300 p-2">${order.orderId}</td>
                                            <td class="border border-gray-300 p-2">${order.clientId}</td>
                                            <td class="border border-gray-300 p-2">${order.itemId}</td>
                                            <td class="border border-gray-300 p-2">${order.quantity}</td>
                                            <td class="border border-gray-300 p-2">$${order.totalPrice}</td>
                                            <td class="border border-gray-300 p-2">${order.status}</td>
                                            <td class="border border-gray-300 p-2">${order.orderDate}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <!-- Manage Items Content (Default) -->
                    <h2 class="text-2xl font-bold text-gray-800 mb-6">Manage Items</h2>

                    <!-- Add Item Form -->
                    <div class="mb-8 p-4 bg-gray-50 rounded-lg shadow-sm">
                        <h3 class="text-lg font-semibold text-gray-700 mb-4">Add New Item</h3>
                        <form action="AddItemServlet" method="post" enctype="multipart/form-data" class="space-y-4">
                            <div>
                                <label for="name" class="block text-sm font-medium text-gray-700">Item Name</label>
                                <input type="text" id="name" name="name" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-2 px-3">
                            </div>
                            <div>
                                <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                                <textarea id="description" name="description" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-2 px-3"></textarea>
                            </div>
                            <div>
                                <label for="price" class="block text-sm font-medium text-gray-700">Price ($)</label>
                                <input type="number" id="price" name="price" step="0.01" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-2 px-3">
                            </div>
                            <div>
                                <label for="isAvailable" class="block text-sm font-medium text-gray-700">Available</label>
                                <input type="checkbox" id="isAvailable" name="isAvailable" value="true" checked class="mt-1">
                            </div>
                            <div>
                                <label for="image" class="block text-sm font-medium text-gray-700">Item Image</label>
                                <input type="file" id="image" name="image" accept="image/*" required class="mt-1 block w-full">
                            </div>
                            <button type="submit" class="btn-primary text-white py-2 px-4 rounded shadow-sm">Add Item</button>
                        </form>
                    </div>

                    <!-- View Items Table -->
                    <div>
                        <h3 class="text-lg font-semibold text-gray-700 mb-4">Existing Items</h3>
                        <table class="w-full border-collapse border border-gray-300">
                            <thead>
                                <tr class="bg-gray-200">
                                    <th class="border border-gray-300 p-2">Image</th>
                                    <th class="border border-gray-300 p-2">Name</th>
                                    <th class="border border-gray-300 p-2">Description</th>
                                    <th class="border border-gray-300 p-2">Price</th>
                                    <th class="border border-gray-300 p-2">Available</th>
                                    <th class="border border-gray-300 p-2">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${items}">
                                    <tr>
                                        <td class="border border-gray-300 p-2">
                                            <img src="${item.imagePath}" alt="${item.name}" class="w-16 h-16 object-cover">
                                        </td>
                                        <td class="border border-gray-300 p-2">${item.name}</td>
                                        <td class="border border-gray-300 p-2">${item.description}</td>
                                        <td class="border border-gray-300 p-2">$${item.price}</td>
                                        <td class="border border-gray-300 p-2">${item.available ? 'Yes' : 'No'}</td>
                                        <td class="border border-gray-300 p-2">
                                            <a href="updateitem.jsp?itemId=${item.itemId}" class="bg-blue-500 text-white px-2 py-1 rounded hover:bg-blue-600">Edit</a>
                                            <form action="DeleteItemServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="itemId" value="${item.itemId}">
                                                <button type="submit" class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600" onclick="return confirm('Are you sure you want to delete this item?')">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white mt-auto">
        <div class="container mx-auto px-4 py-6 text-center">
            <p>© 2025 OrderSnap. All rights reserved.</p>
        </div>
    </footer>

    <!-- No JavaScript needed for navigation now since we're using direct links -->
</body>
</html>