<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Orders Management Tab -->
<div id="orders-tab" class="tab-content active">
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-bold text-gray-800">Order Management</h2>
        <div class="flex space-x-3">
            <div class="relative">
                <input type="text" id="searchOrders" placeholder="Search orders..." class="pl-8 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none">
                <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
            </div>
            <select id="filterOrders" class="border border-gray-300 rounded-lg px-3 py-2 focus:outline-none">
                <option value="all">All Orders</option>
                <option value="pending">Pending</option>
                <option value="processing">Processing</option>
                <option value="delivered">Delivered</option>
                <option value="cancelled">Cancelled</option>
            </select>
        </div>
    </div>

    <!-- Orders Statistics Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
        <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200 flex items-center">
            <div class="bg-indigo-100 p-3 rounded-full mr-4">
                <i class="fas fa-shopping-bag text-indigo-600 text-xl"></i>
            </div>
            <div>
                <p class="text-sm text-gray-600">Total Orders</p>
                <h3 class="text-xl font-bold text-gray-800">
                    <c:set var="totalOrders" value="0" />
                    <c:forEach var="order" items="${orders}">
                        <c:set var="totalOrders" value="${totalOrders + 1}" />
                    </c:forEach>
                    ${totalOrders}
                </h3>
            </div>
        </div>
        
        <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200 flex items-center">
            <div class="bg-yellow-100 p-3 rounded-full mr-4">
                <i class="fas fa-clock text-yellow-600 text-xl"></i>
            </div>
            <div>
                <p class="text-sm text-gray-600">Pending</p>
                <h3 class="text-xl font-bold text-gray-800">
                    <c:set var="pendingOrders" value="0" />
                    <c:forEach var="order" items="${orders}">
                        <c:if test="${order.status == 'Pending'}">
                            <c:set var="pendingOrders" value="${pendingOrders + 1}" />
                        </c:if>
                    </c:forEach>
                    ${pendingOrders}
                </h3>
            </div>
        </div>
        
        <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200 flex items-center">
            <div class="bg-green-100 p-3 rounded-full mr-4">
                <i class="fas fa-check-circle text-green-600 text-xl"></i>
            </div>
            <div>
                <p class="text-sm text-gray-600">Delivered</p>
                <h3 class="text-xl font-bold text-gray-800">
                    <c:set var="deliveredOrders" value="0" />
                    <c:forEach var="order" items="${orders}">
                        <c:if test="${order.status == 'Delivered'}">
                            <c:set var="deliveredOrders" value="${deliveredOrders + 1}" />
                        </c:if>
                    </c:forEach>
                    ${deliveredOrders}
                </h3>
            </div>
        </div>
        
        <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200 flex items-center">
            <div class="bg-blue-100 p-3 rounded-full mr-4">
                <i class="fas fa-dollar-sign text-blue-600 text-xl"></i>
            </div>
            <div>
                <p class="text-sm text-gray-600">Total Revenue</p>
                <h3 class="text-xl font-bold text-gray-800">
                    <c:set var="totalRevenue" value="0" />
                    <c:forEach var="order" items="${orders}">
                        <c:set var="totalRevenue" value="${totalRevenue + order.totalPrice}" />
                    </c:forEach>
                    $${totalRevenue}
                </h3>
            </div>
        </div>
    </div>

    <!-- Orders Table -->
    <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
        <div class="p-4 border-b border-gray-200 bg-gray-50">
            <h3 class="font-semibold text-gray-800">Recent Orders</h3>
        </div>
        
        <c:choose>
            <c:when test="${empty orders}">
                <div class="p-6 text-center">
                    <div class="inline-flex items-center justify-center w-16 h-16 bg-yellow-100 rounded-full mb-4">
                        <i class="fas fa-inbox text-yellow-600 text-2xl"></i>
                    </div>
                    <h3 class="text-lg font-semibold text-gray-800 mb-2">No Orders Found</h3>
                    <p class="text-gray-600">There are no orders in the system yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="overflow-x-auto">
                    <table class="w-full orders-table">
                        <thead>
                            <tr class="bg-gray-50">
                                <th class="p-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Order ID</th>
                                <th class="p-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Client</th>
                                <th class="p-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Item</th>
                                <th class="p-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Quantity</th>
                                <th class="p-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Total</th>
                                <th class="p-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Status</th>
                                <th class="p-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Date</th>
                                <th class="p-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <c:forEach var="order" items="${orders}">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="p-3 text-sm">#${order.orderId}</td>
                                    <td class="p-3 text-sm font-medium">${order.clientId}</td>
                                    <td class="p-3 text-sm">${order.itemId}</td>
                                    <td class="p-3 text-sm">${order.quantity}</td>
                                    <td class="p-3 text-sm font-medium">$${order.totalPrice}</td>
                                    <td class="p-3">
                                        <span class="px-2 py-1 text-xs font-medium rounded-full
                                            ${order.status == 'Pending' ? 'bg-yellow-100 text-yellow-800' : ''}
                                            ${order.status == 'Processing' ? 'bg-blue-100 text-blue-800' : ''}
                                            ${order.status == 'Delivered' ? 'bg-green-100 text-green-800' : ''}
                                            ${order.status == 'Cancelled' ? 'bg-red-100 text-red-800' : ''}">
                                            ${order.status}
                                        </span>
                                    </td>
                                    <td class="p-3 text-sm text-gray-600">${order.orderDate}</td>
                                    <td class="p-3">
                                        <div class="flex space-x-1">
                                            <button class="view-order-btn bg-indigo-600 text-white p-1.5 rounded hover:bg-indigo-700 transition-colors" data-order-id="${order.orderId}">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <div class="relative status-dropdown">
                                                <button class="bg-gray-200 text-gray-700 p-1.5 rounded hover:bg-gray-300 transition-colors">
                                                    <i class="fas fa-ellipsis-v"></i>
                                                </button>
                                                <div class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 hidden">
                                                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-indigo-50 hover:text-indigo-700" onclick="updateOrderStatus(${order.orderId}, 'Processing')">
                                                        <i class="fas fa-hourglass-half mr-2 text-blue-500"></i>Mark as Processing
                                                    </a>
                                                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-indigo-50 hover:text-indigo-700" onclick="updateOrderStatus(${order.orderId}, 'Delivered')">
                                                        <i class="fas fa-check-circle mr-2 text-green-500"></i>Mark as Delivered
                                                    </a>
                                                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-indigo-50 hover:text-indigo-700" onclick="updateOrderStatus(${order.orderId}, 'Cancelled')">
                                                        <i class="fas fa-times-circle mr-2 text-red-500"></i>Cancel Order
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <div class="px-6 py-4 bg-gray-50 border-t border-gray-200 flex items-center justify-between">
                    <p class="text-sm text-gray-600">
                        Showing <span class="font-medium">1</span> to <span class="font-medium">${totalOrders > 10 ? 10 : totalOrders}</span> of <span class="font-medium">${totalOrders}</span> orders
                    </p>
                    <div class="flex space-x-1">
                        <button class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-100">
                            Previous
                        </button>
                        <button class="px-3 py-1 rounded bg-indigo-600 text-white hover:bg-indigo-700">
                            1
                        </button>
                        <button class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-100">
                            2
                        </button>
                        <button class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-100">
                            Next
                        </button>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Order Detail Modal -->
<div id="orderDetailModal" class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center hidden">
    <div class="bg-white rounded-xl p-6 max-w-2xl w-full">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-lg font-bold text-gray-800">Order Details <span id="modalOrderId"></span></h3>
            <button id="closeOrderModal" class="text-gray-500 hover:text-gray-700">
                <i class="fas fa-times"></i>
            </button>
        </div>
        
        <div class="border-t border-b border-gray-200 py-4 mb-4">
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <p class="text-sm text-gray-600">Client</p>
                    <p class="font-medium" id="modalClientId"></p>
                </div>
                <div>
                    <p class="text-sm text-gray-600">Order Date</p>
                    <p class="font-medium" id="modalOrderDate"></p>
                </div>
                <div>
                    <p class="text-sm text-gray-600">Status</p>
                    <p class="font-medium" id="modalStatus"></p>
                </div>
                <div>
                    <p class="text-sm text-gray-600">Total</p>
                    <p class="font-medium" id="modalTotal"></p>
                </div>
            </div>
        </div>
        
        <h4 class="font-medium text-gray-800 mb-3">Order Items</h4>
        <div class="max-h-64 overflow-y-auto mb-4">
            <table class="w-full">
                <thead>
                    <tr class="bg-gray-50">
                        <th class="p-2 text-left text-xs font-medium text-gray-600">Item</th>
                        <th class="p-2 text-left text-xs font-medium text-gray-600">Price</th>
                        <th class="p-2 text-left text-xs font-medium text-gray-600">Quantity</th>
                        <th class="p-2 text-right text-xs font-medium text-gray-600">Subtotal</th>
                    </tr>
                </thead>
                <tbody id="modalOrderItems">
                    <!-- Order items will be inserted here -->
                </tbody>
            </table>
        </div>
        
        <div class="flex justify-end space-x-2 pt-4 border-t border-gray-200">
            <button class="px-4 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-100" id="closeModalButton">
                Close
            </button>
            <div class="relative" id="modalStatusDropdown">
                <button class="btn-primary text-white py-2 px-4 rounded-lg shadow flex items-center">
                    <i class="fas fa-cog mr-2"></i>Update Status
                    <i class="fas fa-chevron-down ml-2"></i>
                </button>
                <div class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 hidden">
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-indigo-50" id="setProcessing">
                        <i class="fas fa-hourglass-half mr-2 text-blue-500"></i>Processing
                    </a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-indigo-50" id="setDelivered">
                        <i class="fas fa-check-circle mr-2 text-green-500"></i>Delivered
                    </a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-indigo-50" id="setCancelled">
                        <i class="fas fa-times-circle mr-2 text-red-500"></i>Cancelled
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Event delegation for view order buttons
        var ordersTable = document.querySelector('.orders-table');
        if (ordersTable) {
            ordersTable.addEventListener('click', function(e) {
                var button = e.target.closest('.view-order-btn');
                if (button) {
                    var orderId = button.getAttribute('data-order-id');
                    if (!orderId) {
                        console.error('[Orders] No order ID found on button');
                        return;
                    }
                    console.log('[Orders] View button clicked for order: ' + orderId);
                    openOrderModal(orderId);
                }
            });
        } else {
            console.error('[Orders] Orders table not found in DOM');
        }

        // Toggle status dropdown
        var statusDropdowns = document.querySelectorAll('.status-dropdown button');
        statusDropdowns.forEach(function(dropdown) {
            dropdown.addEventListener('click', function(e) {
                e.stopPropagation();
                var menu = this.nextElementSibling;
                if (menu) {
                    menu.classList.toggle('hidden');
                    console.log('[Orders] Status dropdown toggled');
                }
            });
        });

        // Close dropdowns when clicking outside
        document.addEventListener('click', function() {
            document.querySelectorAll('.status-dropdown div').forEach(function(menu) {
                menu.classList.add('hidden');
            });
        });

        // Close order detail modal
        var closeButtons = document.querySelectorAll('#closeOrderModal, #closeModalButton');
        closeButtons.forEach(function(button) {
            button.addEventListener('click', function() {
                var modal = document.getElementById('orderDetailModal');
                if (modal) {
                    modal.classList.add('hidden');
                    modal.style.display = 'none';
                    console.log('[Orders] Modal closed');
                } else {
                    console.error('[Orders] Modal element not found on close');
                }
            });
        });

        // Modal status dropdown
        var modalStatusButton = document.querySelector('#modalStatusDropdown > button');
        if (modalStatusButton) {
            modalStatusButton.addEventListener('click', function(e) {
                e.stopPropagation();
                var menu = this.nextElementSibling;
                if (menu) {
                    menu.classList.toggle('hidden');
                    console.log('[Orders] Modal status dropdown toggled');
                }
            });

            // Status update buttons in modal
            var statusLinks = {
                'setProcessing': 'Processing',
                'setDelivered': 'Delivered',
                'setCancelled': 'Cancelled'
            };
            Object.keys(statusLinks).forEach(function(id) {
                var link = document.getElementById(id);
                if (link) {
                    link.addEventListener('click', function(e) {
                        e.preventDefault();
                        updateOrderStatusFromModal(statusLinks[id]);
                        console.log('[Orders] Modal status updated to: ' + statusLinks[id]);
                    });
                }
            });
        } else {
            console.error('[Orders] Modal status button not found');
        }

        // Search functionality
        var searchInput = document.getElementById('searchOrders');
        if (searchInput) {
            searchInput.addEventListener('input', function() {
                var searchTerm = this.value.toLowerCase();
                var rows = document.querySelectorAll('tbody tr');
                
                rows.forEach(function(row) {
                    var orderId = row.cells[0] ? row.cells[0].textContent.toLowerCase() : '';
                    var clientId = row.cells[1] ? row.cells[1].textContent.toLowerCase() : '';
                    var status = row.cells[5] && row.cells[5].querySelector('span') ? row.cells[5].querySelector('span').textContent.toLowerCase() : '';
                    
                    if (orderId.indexOf(searchTerm) !== -1 || clientId.indexOf(searchTerm) !== -1 || status.indexOf(searchTerm) !== -1) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
                console.log('[Orders] Search applied with term: ' + searchTerm);
            });
        }

        // Filter functionality
        var filterSelect = document.getElementById('filterOrders');
        if (filterSelect) {
            filterSelect.addEventListener('change', function() {
                var filterValue = this.value.toLowerCase();
                var rows = document.querySelectorAll('tbody tr');
                
                rows.forEach(function(row) {
                    var status = row.cells[5] && row.cells[5].querySelector('span') ? row.cells[5].querySelector('span').textContent.toLowerCase() : '';
                    
                    if (filterValue === 'all' || status === filterValue) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
                console.log('[Orders] Filter applied with value: ' + filterValue);
            });
        }
    });

    function openOrderModal(orderId) {
        try {
            // Find the table row for the given order ID
            var button = document.querySelector('.view-order-btn[data-order-id="' + orderId + '"]');
            var orderRow = button ? button.closest('tr') : null;
            if (!orderRow) {
                console.error('[Orders] Order row not found for order ID: ' + orderId);
                alert('Order not found.');
                return;
            }

            // Verify the modal exists
            var modal = document.getElementById('orderDetailModal');
            if (!modal) {
                console.error('[Orders] Modal element not found');
                alert('Modal not found.');
                return;
            }

            // Verify all required modal elements
            var modalElements = {
                modalOrderId: document.getElementById('modalOrderId'),
                modalClientId: document.getElementById('modalClientId'),
                modalOrderDate: document.getElementById('modalOrderDate'),
                modalStatus: document.getElementById('modalStatus'),
                modalTotal: document.getElementById('modalTotal'),
                modalOrderItems: document.getElementById('modalOrderItems')
            };
            for (var key in modalElements) {
                if (!modalElements[key]) {
                    console.error('[Orders] Modal element not found: ' + key);
                    alert('Modal configuration error.');
                    return;
                }
            }

            // Populate modal with order details
            modalElements.modalOrderId.textContent = '#' + orderId;
            modalElements.modalClientId.textContent = orderRow.cells[1] ? orderRow.cells[1].textContent : 'N/A';
            modalElements.modalOrderDate.textContent = orderRow.cells[6] ? orderRow.cells[6].textContent : 'N/A';
            modalElements.modalStatus.textContent = orderRow.cells[5] && orderRow.cells[5].querySelector('span') ? orderRow.cells[5].querySelector('span').textContent : 'N/A';
            modalElements.modalTotal.textContent = orderRow.cells[4] ? orderRow.cells[4].textContent : '$0.00';

            // Calculate unit price and populate order items
            var totalPriceText = orderRow.cells[4] ? orderRow.cells[4].textContent.replace('$', '') : '0';
            var totalPrice = parseFloat(totalPriceText) || 0;
            var quantityText = orderRow.cells[3] ? orderRow.cells[3].textContent : '1';
            var quantity = parseInt(quantityText) || 1;
            var unitPrice = quantity > 0 ? (totalPrice / quantity).toFixed(2) : '0.00';
            var orderItemsHtml = '<tr>' +
                '<td class="p-2">' + (orderRow.cells[2] ? orderRow.cells[2].textContent : 'N/A') + '</td>' +
                '<td class="p-2">$' + unitPrice + '</td>' +
                '<td class="p-2">' + (orderRow.cells[3] ? orderRow.cells[3].textContent : '1') + '</td>' +
                '<td class="p-2 text-right">' + (orderRow.cells[4] ? orderRow.cells[4].textContent : '$0.00') + '</td>' +
                '</tr>';
            modalElements.modalOrderItems.innerHTML = orderItemsHtml;

            // Ensure modal is visible
            modal.classList.remove('hidden');
            modal.style.display = 'flex';
            console.log('[Orders] Modal opened for order: ' + orderId);
        } catch (error) {
            console.error('[Orders] Error in openOrderModal: ' + error.message);
            alert('Failed to open order details. Please try again.');
        }
    }

    function updateOrderStatus(orderId, status) {
        // Placeholder for AJAX request to update status
        console.log('[Orders] Updating order #' + orderId + ' status to ' + status);
        alert('Order #' + orderId + ' status updated to ' + status);
        // Reload the page or update the UI
        location.reload();
    }

    function updateOrderStatusFromModal(status) {
        try {
            var orderId = document.getElementById('modalOrderId').textContent.replace('#', '') || '';
            if (!orderId) {
                console.error('[Orders] No order ID found in modal');
                return;
            }
            updateOrderStatus(orderId, status);
            var modal = document.getElementById('orderDetailModal');
            if (modal) {
                modal.classList.add('hidden');
                modal.style.display = 'none';
                console.log('[Orders] Modal closed after status update');
            }
        } catch (error) {
            console.error('[Orders] Error in updateOrderStatusFromModal: ' + error.message);
            alert('Failed to update order status.');
        }
    }
</script>