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
            background-color: #f0f2f5;
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
            color: #4f46e5;
        }
        .navbar-link.active {
            color: #4f46e5;
            border-bottom: 3px solid #4f46e5;
            font-weight: 500;
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
            background-color: #10b981;
            transition: all 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #059669;
            transform: translateY(-2px);
        }
        .item-card {
            transition: all 0.3s ease;
        }
        .item-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }
        footer {
            margin-top: auto;
        }
        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.2);
        }
        .form-input {
            border: 1px solid #e5e7eb;
            border-radius: 0.375rem;
            padding: 0.5rem 0.75rem;
            width: 100%;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="admin-header.jsp" />

    <!-- Main Content -->
    <div class="container mx-auto px-4 py-8">
        <!-- Success/Error Messages -->
        <jsp:include page="messages.jsp" />
        
        <div class="bg-white rounded-xl shadow-lg p-6 mb-12">
            <!-- Content changes based on page parameter -->
            <c:choose>
                <c:when test="${param.page == 'orders'}">
                    <!-- View Orders Content -->
                    <jsp:include page="admin-orders.jsp" />
                </c:when>
                <c:otherwise>
                    <!-- Manage Items Content (Default) -->
                    <jsp:include page="admin-items.jsp" />
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="footer.jsp" />

    <script>
        // Preview image before upload
        function previewImage(input) {
            const preview = document.getElementById('imagePreview');
            const file = input.files[0];
            const reader = new FileReader();
            
            reader.onloadend = function() {
                preview.src = reader.result;
                preview.classList.remove('hidden');
            }
            
            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.src = '';
                preview.classList.add('hidden');
            }
        }
        
        // Toggle edit form
        function toggleEditForm(itemId) {
            const viewRow = document.getElementById(`item-${itemId}`);
            const editRow = document.getElementById(`edit-${itemId}`);
            
            if (viewRow.classList.contains('hidden')) {
                viewRow.classList.remove('hidden');
                editRow.classList.add('hidden');
            } else {
                viewRow.classList.add('hidden');
                editRow.classList.remove('hidden');
            }
        }
        
        // Cancel edit
        function cancelEdit(itemId) {
            toggleEditForm(itemId);
            // Reset form fields if needed
        }
    </script>
</body>
</html>