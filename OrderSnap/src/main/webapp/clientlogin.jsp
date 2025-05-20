<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OrderSnap - Client Login</title>
    <!-- Modern CSS framework -->
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
        .login-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        input:focus {
            border-color: #ff6347;
            box-shadow: 0 0 0 3px rgba(255, 99, 71, 0.2);
        }
        .btn-primary {
            background: #ff6347;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: #e5533d;
            transform: translateY(-2px);
        }
        .btn-success {
            background: #10b981;
            transition: all 0.3s ease;
        }
        .btn-success:hover {
            background: #059669;
            transform: translateY(-2px);
        }
        .login-card {
            position: relative;
            overflow: hidden;
        }
        .login-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: linear-gradient(to bottom, #ff6347, #ff4500);
            border-top-left-radius: 0.5rem;
            border-bottom-left-radius: 0.5rem;
        }
        .password-toggle {
            cursor: pointer;
        }
        .logo-animation {
            animation: float 6s ease-in-out infinite;
        }
        @keyframes float {
            0% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-10px);
            }
            100% {
                transform: translateY(0px);
            }
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .fadeIn {
            animation: fadeIn 0.6s ease-out forwards;
        }
        .toast {
            position: fixed;
            top: 1rem;
            right: 1rem;
            z-index: 9999;
            transition: transform 0.3s ease-out, opacity 0.3s ease-out;
            transform: translateX(100%);
            opacity: 0;
        }
        .toast.show {
            transform: translateX(0);
            opacity: 1;
        }
    </style>
</head>
<body>
<% String successMessage = (String) request.getAttribute("successMessage"); %>
<% String unsuccessMessage = (String) request.getAttribute("unsuccessMessage"); %>

<!-- Modern Toast Notifications instead of alerts -->
<% if (successMessage != null) { %>
    <div id="successToast" class="toast bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded shadow-lg max-w-md">
        <div class="flex">
            <div class="flex-shrink-0">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="ml-3">
                <p class="font-medium">Success!</p>
                <p class="text-sm"><%= successMessage %></p>
            </div>
            <div class="ml-auto">
                <button onclick="closeToast('successToast')" class="text-green-500 hover:text-green-700">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </div>
    </div>
    <script>
        setTimeout(function() {
            document.getElementById('successToast').classList.add('show');
            setTimeout(function() { 
                document.getElementById('successToast').classList.remove('show');
            }, 5000);
        }, 300);
    </script>
<% } %>

<% if (unsuccessMessage != null) { %>
    <div id="errorToast" class="toast bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded shadow-lg max-w-md">
        <div class="flex">
            <div class="flex-shrink-0">
                <i class="fas fa-exclamation-circle"></i>
            </div>
            <div class="ml-3">
                <p class="font-medium">Error!</p>
                <p class="text-sm"><%= unsuccessMessage %></p>
            </div>
            <div class="ml-auto">
                <button onclick="closeToast('errorToast')" class="text-red-500 hover:text-red-700">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </div>
    </div>
    <script>
        setTimeout(function() {
            document.getElementById('errorToast').classList.add('show');
            setTimeout(function() { 
                document.getElementById('errorToast').classList.remove('show');
            }, 5000);
        }, 300);
    </script>
<% } %>

<!-- Logo Header -->
<header class="mt-10 fadeIn" style="animation-delay: 0.1s;">
    <div class="text-center">
        <div class="logo-animation">
            <img src="logo.png" alt="OrderSnap Logo" class="h-32 mx-auto">
        </div>
        <h1 class="text-3xl font-bold text-gray-800 mt-3">OrderSnap</h1>
        <p class="text-gray-600">Your Meal, Just a Click Away!</p>
    </div>
</header>

<!-- Login Container -->
<div class="login-container px-4">
    <div class="max-w-md w-full fadeIn" style="animation-delay: 0.3s;">
        <!-- Login Card -->
        <div class="bg-white rounded-lg shadow-lg overflow-hidden login-card">
            <div class="p-8">
                <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">Client Login</h2>
                
                <form action="LoginServlet" method="post" class="space-y-6">
                    <!-- Username Field -->
                    <div class="space-y-2">
                        <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-user text-gray-400"></i>
                            </div>
                            <input type="text" id="username" name="uid" required
                                   class="pl-10 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-3 px-4 border"
                                   placeholder="Enter your username">
                        </div>
                    </div>
                    
                    <!-- Password Field -->
                    <div class="space-y-2">
                        <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-lock text-gray-400"></i>
                            </div>
                            <input type="password" id="password" name="pass" required
                                   class="pl-10 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-3 px-4 border"
                                   placeholder="Enter your password">
                            <div class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                <i class="fas fa-eye password-toggle text-gray-400" onclick="togglePasswordVisibility()"></i>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Submit Button -->
                    <div>
                        <button type="submit"
                                class="btn-primary w-full py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 flex items-center justify-center">
                            <i class="fas fa-sign-in-alt mr-2"></i> Sign In
                        </button>
                    </div>
                </form>
                
                <!-- Forgot Password Link -->
                <div class="text-center mt-4">
                    <a href="#" class="text-sm text-red-600 hover:text-red-800">Forgot your password?</a>
                </div>
                
                <!-- Divider -->
                <div class="relative my-6">
                    <div class="absolute inset-0 flex items-center">
                        <div class="w-full border-t border-gray-300"></div>
                    </div>
                    <div class="relative flex justify-center text-sm">
                        <span class="px-2 bg-white text-gray-500">Or</span>
                    </div>
                </div>
                
                <!-- Create Account Button -->
                <div>
                    <a href="addnewclient.jsp" class="block w-full text-center">
                        <button type="button"
                                class="btn-success w-full py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 flex items-center justify-center">
                            <i class="fas fa-user-plus mr-2"></i> Create New Account
                        </button>
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Footer Text -->
        <div class="text-center mt-6 text-sm text-gray-600 fadeIn" style="animation-delay: 0.5s;">
            <p>© 2025 OrderSnap. All rights reserved.</p>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    // Toggle password visibility
    function togglePasswordVisibility() {
        const passwordInput = document.getElementById('password');
        const passwordToggle = document.querySelector('.password-toggle');
        
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            passwordToggle.classList.remove('fa-eye');
            passwordToggle.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            passwordToggle.classList.remove('fa-eye-slash');
            passwordToggle.classList.add('fa-eye');
        }
    }
    
    // Close toast notification
    function closeToast(id) {
        document.getElementById(id).classList.remove('show');
    }
</script>
</body>
</html>