<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.items.Item" %>
<%@ page import="com.items.ItemDBUtil" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OrderSnap - Update Item</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-8">Update Item</h1>

        <%
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            Item item = ItemDBUtil.getItemById(itemId);
            if (item == null) {
                response.sendRedirect("adminDashboard.jsp?error=true&message=Item+not+found");
                return;
            }
            request.setAttribute("item", item);
        %>

        <form action="UpdateItemServlet" method="post" enctype="multipart/form-data" class="max-w-lg mx-auto bg-white p-6 rounded-lg shadow-md space-y-4">
            <input type="hidden" name="itemId" value="${item.itemId}">
            <div>
                <label for="name" class="block text-sm font-medium text-gray-700">Item Name</label>
                <input type="text" id="name" name="name" value="${item.name}" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-2 px-3">
            </div>
            <div>
                <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                <textarea id="description" name="description" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-2 px-3">${item.description}</textarea>
            </div>
            <div>
                <label for="price" class="block text-sm font-medium text-gray-700">Price ($)</label>
                <input type="number" id="price" name="price" step="0.01" value="${item.price}" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-2 px-3">
            </div>
            <div>
                <label for="isAvailable" class="block text-sm font-medium text-gray-700">Available</label>
                <input type="checkbox" id="isAvailable" name="isAvailable" value="true" ${item.available ? 'checked' : ''} class="mt-1">
            </div>
            <div>
                <label for="image" class="block text-sm font-medium text-gray-700">Item Image (Leave blank to keep current)</label>
                <img src="${item.imagePath}" alt="${item.name}" class="w-32 h-32 object-cover mb-2">
                <input type="file" id="image" name="image" accept="image/*" class="mt-1 block w-full">
            </div>
            <button type="submit" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">Update Item</button>
        </form>
    </div>
</body>
</html>