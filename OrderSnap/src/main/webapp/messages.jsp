<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Success Message -->
<c:if test="${param.success}">
    <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6 rounded-lg fade-out">
        <div class="flex items-center">
            <i class="fas fa-check-circle text-xl mr-3"></i>
            <p>${param.message}</p>
        </div>
    </div>
</c:if>

<!-- Error Message -->
<c:if test="${param.error}">
    <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6 rounded-lg fade-out">
        <div class="flex items-center">
            <i class="fas fa-exclamation-circle text-xl mr-3"></i>
            <p>${param.message}</p>
        </div>
    </div>
</c:if>

<!-- General Error Message -->
<c:if test="${not empty errorMessage}">
    <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6 rounded-lg fade-out">
        <div class="flex items-center">
            <i class="fas fa-exclamation-circle text-xl mr-3"></i>
            <p>${errorMessage}</p>
        </div>
    </div>
</c:if>

<script>
    // Auto-hide messages after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(function() {
            const messages = document.querySelectorAll('.fade-out');
            messages.forEach(function(message) {
                message.style.opacity = '0';
                message.style.transition = 'opacity 1s ease';
                setTimeout(function() {
                    message.style.display = 'none';
                }, 1000);
            });
        }, 5000);
    });
</script>