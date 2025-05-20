<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>About Us - OrderSnap</title>

    <!-- Tailwind CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .nav-link {
            position: relative;
        }
        .nav-link:after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            background: #4f46e5;
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
        .social-icon {
            transition: transform 0.3s ease;
        }
        .social-icon:hover {
            transform: translateY(-3px);
        }

        /* Custom styles for the About Us content container */
        .about-container {
            max-width: 900px;
            margin: 40px auto;
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .about-header {
            color: #ff6f00;
            margin-bottom: 1rem;
        }
        .about-section h2 {
            color: #ff6f00;
            margin-top: 2rem;
            margin-bottom: 0.5rem;
        }
        .about-section p {
            line-height: 1.8;
        }
        /* Override default h1 style for about page header */
        .about-main-header {
            background-color: #ff6f00;
            padding: 20px;
            text-align: center;
            color: white;
            margin-bottom: 0;
            font-weight: 700;
            font-size: 2rem;
            border-radius: 0 0 12px 12px;
        }
    </style>
</head>
<body>

<!-- Header -->
<header class="bg-white shadow-sm sticky top-0 z-50">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center py-4">
            <div class="flex items-center space-x-2">
                <a href="UserDashboardServlet" class="flex items-center">
                    <img src="logo.png" alt="OrderSnap Logo" class="h-12 w-12" />
                    <div class="ml-2">
                        <h1 class="text-2xl font-bold text-gray-800">OrderSnap</h1>
                        <p class="text-sm text-gray-600">Smart ordering made easy</p>
                    </div>
                </a>
            </div>

            <!-- Navigation -->
            <nav class="hidden md:flex items-center space-x-8">
                <a href="UserDashboardServlet" class="nav-link active text-gray-800 font-medium">Home</a>
                <a href="#" class="nav-link text-gray-800 font-medium">Menu</a>
                <a href="#" class="nav-link text-gray-800 font-medium">About</a>
                <a href="contact.jsp" class="nav-link text-gray-800 font-medium">Contact Us</a>

            </nav>

            <!-- User Area -->
            <div class="flex items-center space-x-6">
                <a href="login.jsp" class="text-indigo-600 hover:text-indigo-800 font-medium text-sm">Login / Sign Up</a>
                <div class="h-8 w-8 bg-gray-200 rounded-full flex items-center justify-center">
                    <i class="fas fa-user text-gray-500"></i>
                </div>
                <button class="md:hidden text-gray-700">
                    <i class="fas fa-bars text-xl"></i>
                </button>
            </div>
        </div>
    </div>
</header>

<!-- Main About Us Content -->
<!-- About Us Content -->
<section class="max-w-6xl mx-auto my-16 px-6">
  <h1 class="text-4xl font-extrabold text-orange-600 mb-12 text-center font-sans">About OrderSnap</h1>

  <div class="flex flex-col md:flex-row gap-8">

    <!-- Who We Are -->
    <div class="flex-1 bg-white p-8 rounded-xl shadow-lg transition-transform transform hover:-translate-y-2 hover:shadow-2xl cursor-default font-sans">
      <h2 class="text-2xl font-bold text-gray-800 mb-4">Who We Are</h2>
      <p class="text-gray-700 leading-relaxed">
        OrderSnap is a <strong>modern web-based food ordering system</strong> designed to streamline the dining experience for customers and improve efficiency for restaurants. Our mission is to make food ordering <strong>fast, intuitive, and enjoyable.</strong>
      </p>
    </div>

    <!-- What We Offer -->
    <div class="flex-1 bg-white p-8 rounded-xl shadow-lg transition-transform transform hover:-translate-y-2 hover:shadow-2xl cursor-default font-sans">
      <h2 class="text-2xl font-bold text-gray-800 mb-4">What We Offer</h2>
      <p class="text-gray-700 leading-relaxed">
        Customers can <strong>browse menus, place orders, customize meals, and track order history</strong>—all from a single, user-friendly interface. Restaurants benefit from a <strong>digital ordering system</strong> that simplifies operations and boosts engagement.
      </p>
    </div>

    <!-- Technology Behind OrderSnap -->
    <div class="flex-1 bg-white p-8 rounded-xl shadow-lg transition-transform transform hover:-translate-y-2 hover:shadow-2xl cursor-default font-sans">
      <h2 class="text-2xl font-bold text-gray-800 mb-4">Technology Behind OrderSnap</h2>
      <p class="text-gray-700 leading-relaxed">
        Built using <strong>Java Servlets, JSP, MySQL</strong>, and a responsive frontend with HTML, CSS, and JavaScript, OrderSnap ensures a <strong>scalable and secure experience.</strong> We follow the MVC pattern and apply object-oriented design principles for clean, adaptable code.
      </p>
    </div>

  </div>
</section>


<!-- Footer -->
<footer class="bg-gray-900 text-white pt-16 pb-6">
    <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-8">
            <!-- Brand Column -->
            <div class="lg:col-span-2">
                <div class="flex items-center mb-4">
                    <img src="logo.png" alt="OrderSnap Logo" class="h-16 w-16" />
                    <h3 class="text-xl font-bold ml-2">OrderSnap</h3>
                </div>
                <p class="text-gray-400 mb-6">Streamlining restaurant ordering and management with modern tools.</p>
                <div class="flex space-x-4">
                    <a href="#" class="social-icon text-gray-400 hover:text-white"><i class="fab fa-facebook-f text-xl"></i></a>
                    <a href="#" class="social-icon text-gray-400 hover:text-white"><i class="fab fa-instagram text-xl"></i></a>
                    <a href="#" class="social-icon text-gray-400 hover:text-white"><i class="fab fa-twitter text-xl"></i></a>
                </div>
            </div>

            <!-- Footer Links -->
            <div>
                <h4 class="text-lg font-semibold mb-4">Dashboard</h4>
                <ul class="space-y-3">
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Orders</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Menu</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Customers</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Reports</a></li>
                </ul>
            </div>

            <div>
                <h4 class="text-lg font-semibold mb-4">Support</h4>
                <ul class="space-y-3">
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Help Center</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Contact Us</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Feedback</a></li>
                </ul>
            </div>

            <div>
                <h4 class="text-lg font-semibold mb-4">Company</h4>
                <ul class="space-y-3">
                    <li><a href="#" class="text-gray-400 hover:text-white transition">About Us</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Careers</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition">Privacy Policy</a></li>
                </ul>
            </div>
        </div>

        <!-- Copyright -->
        <div class="border-t border-gray-800 mt-12 pt-8 text-center">
            <p>© 2025 OrderSnap. All rights reserved.</p>
        </div>
    </div>
</footer>

</body>
</html>
