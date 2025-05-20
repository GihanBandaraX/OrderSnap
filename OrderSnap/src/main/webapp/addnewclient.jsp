<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OrderSnap - Client Registration</title>
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
        }
        .nav-link {
            position: relative;
        }
        .nav-link:after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            background: #ff6347; /* Tomato color for OrderSnap theme */
            bottom: -4px;
            left: 0;
            transition: width 0.3s ease;
        }
        .nav-link:hover:after, .active:after {
            width: 100%;
        }
        .dropdown-menu {
            display: none;
            position: absolute;
            background: white;
            min-width: 180px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            border-radius: 0.5rem;
            padding: 0.5rem 0;
            z-index: 100;
        }
        .dropdown:hover .dropdown-menu {
            display: block;
        }
        input:focus, select:focus {
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
        .btn-primary:disabled {
            background: #9ca3af;
            cursor: not-allowed;
            transform: none;
        }
        .social-icon {
            transition: transform 0.3s ease;
        }
        .social-icon:hover {
            transform: translateY(-3px);
        }
        .form-section {
            position: relative;
            overflow: hidden;
        }
        .form-section::before {
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
        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.6;
            }
        }
        .terms-pulse {
            animation: pulse 2s infinite;
        }
    </style>
</head>
<body>
<!-- Header -->
<header class="bg-white shadow-sm sticky top-0 z-50">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center py-4">
            <!-- Logo -->
            <div class="flex items-center space-x-2">
                <a href="/" class="flex items-center">
                    <img src="logo.png" alt="OrderSnap Logo" class="h-12 w-12">
                    <div class="ml-2">
                        <h1 class="text-2xl font-bold text-gray-800">OrderSnap</h1>
                        <p class="text-sm text-gray-600">Your Meal, Just a Click Away!</p>
                    </div>
                </a>
            </div>
            
            <!-- Navigation -->
            <nav class="hidden md:flex items-center space-x-8">
                <a href="/" class="nav-link active text-gray-800 font-medium">Home</a>
                <div class="dropdown relative">
                    <a href="#" class="nav-link text-gray-800 font-medium flex items-center">
                        Menu <i class="fas fa-chevron-down ml-1 text-xs"></i>
                    </a>
                    <div class="dropdown-menu">
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Breakfast</a>
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Lunch</a>
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Dinner</a>
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Desserts</a>
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Beverages</a>
                    </div>
                </div>
                <a href="/orders" class="nav-link text-gray-800 font-medium">My Orders</a>
                <a href="/contact" class="nav-link text-gray-800 font-medium">Contact Us</a>
                <a href="/about" class="nav-link text-gray-800 font-medium">About Us</a>
            </nav>
            
            <!-- Search & User -->
            <div class="flex items-center space-x-6">
                <!-- Search -->
                <div class="hidden md:flex items-center relative bg-gray-100 rounded-full px-3 py-1">
                    <input type="text" placeholder="Search menu..." class="bg-transparent border-none focus:outline-none text-sm w-40">
                    <button class="ml-2 text-gray-500">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                
                <!-- User -->
                <div class="flex items-center space-x-2">
                    <a href="/login" class="text-red-600 hover:text-red-800 font-medium text-sm">Login / Sign Up</a>
                    <div class="h-8 w-8 bg-gray-200 rounded-full flex items-center justify-center">
                        <i class="fas fa-user text-gray-500"></i>
                    </div>
                </div>
                
                <!-- Mobile Menu Button -->
                <button class="md:hidden text-gray-700">
                    <i class="fas fa-bars text-xl"></i>
                </button>
            </div>
        </div>
    </div>
</header>

<!-- Main Content -->
<main class="container mx-auto px-4 py-10">
    <div class="max-w-3xl mx-auto">
        <!-- Page Title -->
        <div class="text-center mb-8">
            <h1 class="text-3xl font-bold text-gray-800">Create Your Account</h1>
            <p class="text-gray-600 mt-2">Join OrderSnap to start ordering your favorite meals</p>
        </div>
        
        <!-- Registration Form Card -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden form-section">
            <div class="p-8">
                <form action="registerclientServlet" method="post" class="space-y-6">
                    <!-- Personal Information Section -->
                    <div class="space-y-6">
                        <h3 class="text-lg font-semibold text-gray-800 pb-2 border-b border-gray-200">Personal Information</h3>
                        
                        <!-- Full Name Field -->
                        <div class="space-y-2">
                            <label for="name" class="block text-sm font-medium text-gray-700">Full Name</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-user text-gray-400"></i>
                                </div>
                                <input type="text" id="name" name="name" required
                                       class="pl-10 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-3 px-4 border"
                                       placeholder="Enter your full name">
                            </div>
                        </div>
                        
                        <!-- Gender Field -->
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-gray-700">Gender</label>
                            <div class="flex space-x-6 mt-1">
                                <div class="flex items-center">
                                    <input type="radio" id="genderMale" name="gender" value="Male" required
                                           class="h-4 w-4 text-red-600 border-gray-300 focus:ring-red-500">
                                    <label for="genderMale" class="ml-2 block text-sm text-gray-700">Male</label>
                                </div>
                                <div class="flex items-center">
                                    <input type="radio" id="genderFemale" name="gender" value="Female" required
                                           class="h-4 w-4 text-red-600 border-gray-300 focus:ring-red-500">
                                    <label for="genderFemale" class="ml-2 block text-sm text-gray-700">Female</label>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Date of Birth Field -->
                        <div class="space-y-2">
                            <label for="dob" class="block text-sm font-medium text-gray-700">Date of Birth</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-calendar-alt text-gray-400"></i>
                                </div>
                                <input type="date" id="dob" name="dob" required
                                       class="pl-10 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-3 px-4 border"
                                       pattern="\d{4}-\d{2}-\d{2}" placeholder="YYYY-MM-DD"
                                       max="<%=java.time.LocalDate.now().minusYears(18)%>">
                            </div>
                            <p class="text-xs text-gray-500">You must be at least 18 years old to register</p>
                        </div>
                    </div>
                    
                    <!-- Contact Information Section -->
                    <div class="space-y-6 pt-4">
                        <h3 class="text-lg font-semibold text-gray-800 pb-2 border-b border-gray-200">Contact Information</h3>
                        
                        <!-- Email Field -->
                        <div class="space-y-2">
                            <label for="email" class="block text-sm font-medium text-gray-700">Email Address</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-envelope text-gray-400"></i>
                                </div>
                                <input type="email" id="email" name="email" required
                                       class="pl-10 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-3 px-4 border"
                                       placeholder="your.email@example.com">
                            </div>
                            <p class="text-xs text-gray-500">We'll send order confirmations to this email</p>
                        </div>
                        
                        <!-- Phone Field -->
                        <div class="space-y-2">
                            <label for="phone" class="block text-sm font-medium text-gray-700">Phone Number</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-phone-alt text-gray-400"></i>
                                </div>
                                <input type="tel" id="phone" name="phone" required
                                       class="pl-10 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-3 px-4 border"
                                       placeholder="+94 7X XXX XXXX">
                            </div>
                        </div>
                        
                        <!-- Address Field -->
                        <div class="space-y-2">
                            <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-home text-gray-400"></i>
                                </div>
                                <input type="text" id="address" name="address" required
                                       class="pl-10 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-3 px-4 border"
                                       placeholder="Enter your full address">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Account Information Section -->
                    <div class="space-y-6 pt-4">
                        <h3 class="text-lg font-semibold text-gray-800 pb-2 border-b border-gray-200">Account Information</h3>
                        
                        <!-- Username Field -->
                        <div class="space-y-2">
                            <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-user-circle text-gray-400"></i>
                                </div>
                                <input type="text" id="username" name="username" required
                                       class="pl-10 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-3 px-4 border"
                                       placeholder="Choose a unique username">
                            </div>
                            <p class="text-xs text-gray-500">Username must be unique and contain only letters, numbers, and underscores</p>
                        </div>
                        
                        <!-- Password Field -->
                        <div class="space-y-2">
                            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-lock text-gray-400"></i>
                                </div>
                                <input type="password" id="password" name="password" required
                                       class="pl-10 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-3 px-4 border"
                                       placeholder="Choose a strong password">
                                <div class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                    <i class="fas fa-eye password-toggle text-gray-400" onclick="togglePasswordVisibility()"></i>
                                </div>
                            </div>
                            <div class="text-xs text-gray-500 space-y-1 mt-2">
                                <p>Password must:</p>
                                <ul class="list-disc pl-5 space-y-1">
                                    <li>Be at least 8 characters long</li>
                                    <li>Include at least one uppercase letter</li>
                                    <li>Include at least one number</li>
                                </ul>
                            </div>
                        </div>

                        <!-- User Type Field -->
                        <div class="space-y-2">
                            <label for="userType" class="block text-sm font-medium text-gray-700">Account Type</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-users text-gray-400"></i>
                                </div>
                                <select id="userType" name="userType" required
                                        class="pl-10 block w-full rounded-md border-gray-300 shadow-sm focus:outline-none py-3 px-4 border">
                                    <option value="" disabled selected>Select account type</option>
                                    <option value="user">User</option>
                                    <option value="admin">Admin</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Terms and Conditions Checkbox -->
                    <div class="pt-4">
                        <div class="flex items-start">
                            <div class="flex items-center h-5">
                                <input type="checkbox" class="h-4 w-4 text-red-600 border-gray-300 rounded focus:ring-red-500" 
                                       id="terms_conditions" name="terms_conditions" required onchange="toggleSubmit()">
                            </div>
                            <div class="ml-3 text-sm">
                                <label for="terms_conditions" class="font-medium text-gray-700">
                                    I agree to the <a href="terms.jsp" target="_blank" class="text-red-600 hover:text-red-800">Terms and Conditions</a>
                                </label>
                                <p class="text-gray-500">By creating an account, you agree to our terms of service and privacy policy.</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Submit Button -->
                    <div class="pt-5">
                        <button type="submit" id="register" disabled
                                class="btn-primary w-full py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 flex items-center justify-center">
                            <i class="fas fa-user-plus mr-2"></i> Create Account
                        </button>
                    </div>
                    
                    <!-- Login Link -->
                    <div class="text-center mt-6">
                        <p class="text-sm text-gray-600">
                            Already have an account? <a href="clientlogin.jsp" class="text-red-600 hover:text-red-800 font-medium">Sign in</a>
                        </p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<!-- Footer -->
<footer class="bg-gray-900 text-white mt-16">
    <div class="container mx-auto px-4 py-12">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-8">
            <!-- Brand Column -->
            <div class="lg:col-span-2">
                <div class="flex items-center mb-4">
                    <img src="logo.png" alt="OrderSnap Logo" class="h-16 w-16">
                    <h3 class="text-xl font-bold ml-2">OrderSnap</h3>
                </div>
                <p class="text-gray-400 mb-6">Order your favorite meals with ease and enjoy quick delivery.</p>
                <div class="flex space-x-4">
                    <a href="#" class="social-icon text-gray-400 hover:text-white">
                        <i class="fab fa-facebook-f text-xl"></i>
                    </a>
                    <a href="#" class="social-icon text-gray-400 hover:text-white">
                        <i class="fab fa-instagram text-xl"></i>
                    </a>
                    <a href="#" class="social-icon text-gray-400 hover:text-white">
                        <i class="fab fa-twitter text-xl"></i>
                    </a>
                </div>
            </div>
            
            <!-- For Customers -->
            <div>
                <h4 class="text-lg font-semibold mb-4">For Customers</h4>
                <ul class="space-y-3">
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Menu</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Order History</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Promotions</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Support</a></li>
                </ul>
            </div>
            
            <!-- For Restaurants -->
            <div>
                <h4 class="text-lg font-semibold mb-4">For Restaurants</h4>
                <ul class="space-y-3">
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Join Us</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Manage Orders</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Partner Benefits</a></li>
                </ul>
            </div>
            
            <!-- About -->
            <div>
                <h4 class="text-lg font-semibold mb-4">About</h4>
                <ul class="space-y-3">
                    <li><a href="#" class="text-gray-400 hover:text-white transition">About Us</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Contact Us</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">FAQs</a></li>
                </ul>
                
                <div class="mt-8">
                    <h4 class="text-lg font-semibold mb-4">Get in Touch</h4>
                    <button class="bg-red-600 hover:bg-red-700 py-2 px-4 rounded-md transition transform hover:-translate-y-1">
                        CONTACT SUPPORT
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Copyright -->
        <div class="border-t border-gray-800 mt-12 pt-8 text-center">
            <p>© 2025 OrderSnap. All rights reserved.</p>
        </div>
    </div>
</footer>

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
    
    // Toggle submit button based on terms checkbox
    function toggleSubmit() {
        const registerButton = document.getElementById('register');
        const termsCheckbox = document.getElementById('terms_conditions');
        
        if (termsCheckbox.checked) {
            registerButton.disabled = false;
            registerButton.classList.remove('terms-pulse');
        } else {
            registerButton.disabled = true;
            registerButton.classList.add('terms-pulse');
        }
    }
    
    // Set maximum date for date of birth (18 years ago)
    document.addEventListener('DOMContentLoaded', function() {
        // Set password validation
        const passwordInput = document.getElementById('password');
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            const hasUppercase = /[A-Z]/.test(password);
            const hasNumber = /[0-9]/.test(password);
            const isLongEnough = password.length >= 8;
            
            // Add visual feedback for password requirements
            const passwordRequirements = document.querySelectorAll('.text-gray-500 ul li');
            
            if (passwordRequirements.length >= 3) {
                passwordRequirements[0].classList.toggle('text-green-600', isLongEnough);
                passwordRequirements[1].classList.toggle('text-green-600', hasUppercase);
                passwordRequirements[2].classList.toggle('text-green-600', hasNumber);
            }
        });
    });
</script>
</body>
</html>