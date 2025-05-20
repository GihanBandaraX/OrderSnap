<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div id="cart" class="bg-white rounded-xl shadow-lg p-6 mb-12">
    <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
        <i class="fas fa-shopping-cart mr-3 text-indigo-600"></i>Your Cart
    </h2>
    
    <!-- Display success or error messages -->
    <c:if test="${not empty error}">
        <div class="bg-red-50 border-l-4 border-red-400 text-red-800 p-4 mb-4 rounded-lg flex items-center">
            <i class="fas fa-exclamation-circle mr-3 text-xl"></i>
            <p>${error}</p>
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="bg-green-50 border-l-4 border-green-400 text-green-800 p-4 mb-4 rounded-lg flex items-center">
            <i class="fas fa-check-circle mr-3 text-xl"></i>
            <p>${success}</p>
        </div>
    </c:if>
    
    <c:choose>
        <c:when test="${empty cart}">
            <div class="bg-yellow-50 border-l-4 border-yellow-400 text-yellow-800 p-4 mb-4 rounded-lg flex items-center">
                <i class="fas fa-shopping-basket mr-3 text-xl"></i>
                <p>Your cart is empty. Add some delicious items to get started!</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="overflow-x-auto mb-6">
                <table class="w-full border-collapse">
                    <thead>
                        <tr class="bg-gray-50">
                            <th class="p-3 text-left text-gray-600 font-semibold">Item</th>
                            <th class="p-3 text-left text-gray-600 font-semibold">Price</th>
                            <th class="p-3 text-left text-gray-600 font-semibold">Quantity</th>
                            <th class="p-3 text-left text-gray-600 font-semibold">Subtotal</th>
                            <th class="p-3 text-gray-600 font-semibold">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cartItem" items="${cart}">
                            <tr class="border-b border-gray-200 hover:bg-gray-50 transition-colors">
                                <td class="p-3">
                                    <div class="flex items-center">
                                        <img src="${cartItem.item.imagePath}" alt="${cartItem.item.name}" class="w-12 h-12 mr-3 rounded-md object-cover">
                                        <span class="font-medium">${cartItem.item.name}</span>
                                    </div>
                                </td>
                                <td class="p-3">
                                    $<fmt:formatNumber value="${cartItem.item.price}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                </td>
                                <td class="p-3">
                                    <form action="UpdateCartServlet" method="post" class="flex items-center">
                                        <input type="hidden" name="itemId" value="${cartItem.item.itemId}">
                                        <input type="number" name="quantity" value="${cartItem.quantity}" min="0" class="w-16 px-2 py-1 border rounded-md mr-2">
                                        <button type="submit" class="text-indigo-600 hover:text-indigo-800">
                                            <i class="fas fa-sync"></i>
                                        </button>
                                    </form>
                                </td>
                                <td class="p-3 font-medium">
                                    $<fmt:formatNumber value="${cartItem.subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                </td>
                                <td class="p-3">
                                    <form action="DeleteCartItemServlet" method="post">
                                        <input type="hidden" name="itemId" value="${cartItem.item.itemId}">
                                        <button type="submit" class="text-red-500 hover:text-red-700 transition-colors">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <!-- Total Row -->
                        <tr class="bg-gray-50">
                            <td colspan="3" class="p-3 text-right font-bold">Total:</td>
                            <td class="p-3 font-bold text-indigo-600">
                                <c:set var="total" value="0" />
                                <c:forEach var="cartItem" items="${cart}">
                                    <c:set var="total" value="${total + cartItem.subtotal}" />
                                </c:forEach>
                                $<fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                            </td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Checkout Process -->
            <div class="mt-8">
                <h3 class="text-xl font-semibold text-gray-800 mb-4">Payment Information</h3>
                <form id="paymentForm" class="space-y-6" action="AddOrderServlet" method="post">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="cardName" class="block text-sm font-medium text-gray-700 mb-1">Name on Card</label>
                            <input type="text" id="cardName" name="cardName" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-colors" placeholder="John Smith" required>
                        </div>
                        <div>
                            <label for="cardNumber" class="block text-sm font-medium text-gray-700 mb-1">Card Number</label>
                            <div class="relative">
                                <input type="text" id="cardNumber" name="cardNumber" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-colors" placeholder="1234 5678 9012 3456" maxlength="19" required>
                                <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                                    <i class="fab fa-cc-visa text-gray-400 text-lg"></i>
                                </div>
                            </div>
                        </div>
                        <div>
                            <label for="expDate" class="block text-sm font-medium text-gray-700 mb-1">Expiration Date</label>
                            <input type="text" id="expDate" name="expDate" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-colors" placeholder="MM/YY" maxlength="5" required>
                        </div>
                        <div>
                            <label for="cvv" class="block text-sm font-medium text-gray-700 mb-1">CVV</label>
                            <input type="text" id="cvv" name="cvv" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-colors" placeholder="123" maxlength="3" required>
                        </div>
                    </div>
                    
                    <div>
                        <label for="address" class="block text-sm font-medium text-gray-700 mb-1">Delivery Address</label>
                        <textarea id="address" name="address" rows="2" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-colors" placeholder="Enter your full delivery address" required></textarea>
                    </div>
                    
                    <div class="flex justify-between items-center pt-4">
                        <button type="button" class="text-indigo-600 hover:text-indigo-800 font-medium flex items-center" onclick="window.location.href='items.jsp'">
                            <i class="fas fa-arrow-left mr-2"></i>Continue Shopping
                        </button>
                        <button type="submit" class="btn-primary text-white py-3 px-6 rounded-lg shadow flex items-center justify-center">
                            <i class="fas fa-lock mr-2"></i>Place Order Securely
                        </button>
                    </div>
                </form>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<div id="orderConfirmation" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
    <div class="bg-white rounded-xl p-8 max-w-md w-full">
        <div class="text-center">
            <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <i class="fas fa-check text-green-500 text-2xl"></i>
            </div>
            <h3 class="text-2xl font-bold text-gray-800 mb-2">Order Confirmed!</h3>
            <p class="text-gray-600 mb-6">Your order has been placed successfully.</p>
            <p class="text-gray-700 mb-4">Order #<span id="orderNumber"></span></p>
            <p class="text-gray-700 mb-6">Estimated delivery: <span class="font-medium">30-45 minutes</span></p>
            <button onclick="closeModal()" class="btn-primary text-white py-2 px-6 rounded-lg shadow">
                Continue
            </button>
        </div>
    </div>
</div>

<script>
    // Format card number with spaces
    document.addEventListener('DOMContentLoaded', function() {
        const cardInput = document.getElementById('cardNumber');
        if (cardInput) {
            cardInput.addEventListener('input', function(e) {
                const value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
                const formattedValue = value.replace(/\d{4}(?=.)/g, '$& ');
                e.target.value = formattedValue;
            });
        }
        
        // Format expiration date
        const expInput = document.getElementById('expDate');
        if (expInput) {
            expInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 2) {
                    value = value.substring(0, 2) + '/' + value.substring(2, 4);
                }
                e.target.value = value;
            });
        }
    });

    function closeModal() {
        document.getElementById('orderConfirmation').classList.add('hidden');
        window.location.href = "items.jsp";
    }
</script>
