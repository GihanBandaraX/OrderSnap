<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Items Management Tab -->
<div id="items-tab" class="tab-content active">
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-bold text-gray-800">Manage Items</h2>
        <div class="flex space-x-2">
            <button id="viewItemsBtn" class="bg-indigo-600 text-white px-4 py-2 rounded-lg shadow-sm hover:bg-indigo-700 transition-colors">
                <i class="fas fa-list mr-2"></i>View Items
            </button>
            <button id="addItemBtn" class="bg-green-600 text-white px-4 py-2 rounded-lg shadow-sm hover:bg-green-700 transition-colors">
                <i class="fas fa-plus mr-2"></i>Add Item
            </button>
        </div>
    </div>

    <!-- Add Item Form -->
    <div id="addItemForm" class="mb-8 p-6 bg-gray-50 rounded-xl shadow-sm border border-gray-200">
        <div class="flex justify-between items-center mb-6">
            <h3 class="text-xl font-semibold text-gray-800">Add New Item</h3>
            <button type="button" id="closeAddForm" class="text-gray-500 hover:text-gray-700">
                <i class="fas fa-times"></i>
            </button>
        </div>
        
        <form action="AddItemServlet" method="post" enctype="multipart/form-data" class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-4 md:col-span-1">
                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Item Name</label>
                    <input type="text" id="name" name="name" required class="form-input" placeholder="Enter item name">
                </div>
                <div>
                    <label for="price" class="block text-sm font-medium text-gray-700 mb-1">Price ($)</label>
                    <input type="number" id="price" name="price" step="0.01" required class="form-input" placeholder="0.00">
                </div>
                <div>
                    <label for="isAvailable" class="block text-sm font-medium text-gray-700 mb-1">Available</label>
                    <div class="flex items-center">
                        <input type="checkbox" id="isAvailable" name="isAvailable" value="true" checked class="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded">
                        <span class="ml-2 text-sm text-gray-600">Make this item available for ordering</span>
                    </div>
                </div>
            </div>
            
            <div class="space-y-4 md:col-span-1">
                <div>
                    <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                    <textarea id="description" name="description" required class="form-input" rows="4" placeholder="Enter item description"></textarea>
                </div>
                <div>
                    <label for="image" class="block text-sm font-medium text-gray-700 mb-1">Item Image</label>
                    <div class="flex items-center space-x-4">
                        <div class="flex-1">
                            <input type="file" id="image" name="image" accept="image/*" required class="form-input" onchange="previewImage(this)">
                        </div>
                        <div class="w-24 h-24 bg-gray-200 rounded-lg flex items-center justify-center overflow-hidden">
                            <img id="imagePreview" src="#" alt="Preview" class="w-full h-full object-cover hidden">
                            <i class="fas fa-image text-gray-400 text-2xl" id="placeholderIcon"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="md:col-span-2 flex justify-end space-x-3 pt-4 border-t border-gray-200">
                <button type="button" id="cancelAdd" class="px-4 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    <i class="fas fa-times mr-2"></i>Cancel
                </button>
                <button type="submit" class="btn-primary text-white py-2 px-4 rounded-lg shadow-sm">
                    <i class="fas fa-plus mr-2"></i>Add Item
                </button>
            </div>
        </form>
    </div>

    <!-- View Items Table -->
    <div id="viewItemsTable">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-xl font-semibold text-gray-800">Item Catalog</h3>
            <div class="flex items-center space-x-2">
                <div class="relative">
                    <input type="text" id="searchItems" placeholder="Search items..." class="pl-8 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none">
                    <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                </div>
                <select id="filterItems" class="border border-gray-300 rounded-lg px-3 py-2 focus:outline-none">
                    <option value="all">All Items</option>
                    <option value="available">Available Only</option>
                    <option value="unavailable">Unavailable Only</option>
                </select>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${empty items}">
                <div class="bg-yellow-50 border-l-4 border-yellow-400 text-yellow-800 p-4 rounded-lg">
                    <div class="flex">
                        <i class="fas fa-exclamation-triangle flex-shrink-0 mr-3"></i>
                        <p>No items found. Add your first item using the form above.</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="overflow-x-auto">
                    <table class="w-full border-collapse">
                        <thead>
                            <tr class="bg-gray-50">
                                <th class="p-3 text-left text-gray-600 font-semibold">Image</th>
                                <th class="p-3 text-left text-gray-600 font-semibold">Name</th>
                                <th class="p-3 text-left text-gray-600 font-semibold">Description</th>
                                <th class="p-3 text-left text-gray-600 font-semibold">Price</th>
                                <th class="p-3 text-left text-gray-600 font-semibold">Status</th>
                                <th class="p-3 text-left text-gray-600 font-semibold">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${items}" varStatus="status">
                                <!-- View Mode Row -->
                                <tr id="item-${item.itemId}" class="border-b border-gray-200 hover:bg-gray-50 transition-colors item-card">
                                    <td class="p-3">
                                        <img src="${item.imagePath}" alt="${item.name}" class="w-16 h-16 object-cover rounded-lg">
                                    </td>
                                    <td class="p-3 font-medium">${item.name}</td>
                                    <td class="p-3 text-gray-600">
                                        <div class="max-w-xs overflow-hidden text-ellipsis">${item.description}</div>
                                    </td>
                                    <td class="p-3">$${item.price}</td>
                                    <td class="p-3">
                                        <span class="px-2 py-1 rounded-full text-xs font-medium ${item.available ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                            ${item.available ? 'Available' : 'Unavailable'}
                                        </span>
                                    </td>
                                    <td class="p-3">
                                        <div class="flex space-x-1">
                                            <button onclick="toggleEditForm(${item.itemId})" class="bg-indigo-600 text-white p-2 rounded hover:bg-indigo-700 transition-colors">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <form action="DeleteItemServlet" method="post" class="inline">
                                                <input type="hidden" name="itemId" value="${item.itemId}">
                                                <button type="submit" class="bg-red-600 text-white p-2 rounded hover:bg-red-700 transition-colors" onclick="return confirm('Are you sure you want to delete this item?')">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                
                                <!-- Edit Mode Row (Hidden by default) -->
                                <tr id="edit-${item.itemId}" class="border-b border-gray-200 bg-indigo-50 hidden">
                                    <td colspan="6" class="p-4">
                                        <form action="UpdateItemServlet" method="post" enctype="multipart/form-data" class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                            <input type="hidden" name="itemId" value="${item.itemId}">
                                            
                                            <div class="space-y-3">
                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">Item Name</label>
                                                    <input type="text" name="name" value="${item.name}" required class="form-input text-sm">
                                                </div>
                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">Price ($)</label>
                                                    <input type="number" name="price" value="${item.price}" step="0.01" required class="form-input text-sm">
                                                </div>
                                            </div>
                                            
                                            <div class="space-y-3">
                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">Description</label>
                                                    <textarea name="description" required class="form-input text-sm" rows="3">${item.description}</textarea>
                                                </div>
                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">Available</label>
                                                    <div class="flex items-center">
                                                        <input type="checkbox" name="isAvailable" value="true" ${item.available ? 'checked' : ''} class="h-4 w-4 text-indigo-600">
                                                        <span class="ml-2 text-xs text-gray-600">Make this item available</span>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="space-y-3">
                                                <div>
                                                    <label class="block text-xs font-medium text-gray-700 mb-1">Item Image</label>
                                                    <div class="flex items-center space-x-2">
                                                        <input type="file" name="image" accept="image/*" class="form-input text-sm">
                                                        <img src="${item.imagePath}" alt="${item.name}" class="w-10 h-10 object-cover rounded">
                                                    </div>
                                                    <p class="text-xs text-gray-500 mt-1">Leave empty to keep current image</p>
                                                </div>
                                                <div class="flex justify-end space-x-2 pt-2">
                                                    <button type="button" onclick="cancelEdit(${item.itemId})" class="px-3 py-1 border border-gray-300 rounded text-sm text-gray-700 hover:bg-gray-100">
                                                        Cancel
                                                    </button>
                                                    <button type="submit" class="px-3 py-1 bg-indigo-600 text-white rounded text-sm hover:bg-indigo-700">
                                                        Save Changes
                                                    </button>
                                                </div>
                                            </div>
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

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const addItemForm = document.getElementById('addItemForm');
        const viewItemsTable = document.getElementById('viewItemsTable');
        const addItemBtn = document.getElementById('addItemBtn');
        const viewItemsBtn = document.getElementById('viewItemsBtn');
        const closeAddForm = document.getElementById('closeAddForm');
        const cancelAdd = document.getElementById('cancelAdd');
        
        // Initially hide the add form if there are items
        if (document.querySelectorAll('tbody tr').length > 0) {
            addItemForm.style.display = 'none';
        }
        
        // Show add item form
        addItemBtn.addEventListener('click', function() {
            addItemForm.style.display = 'block';
            viewItemsTable.style.display = 'none';
            addItemBtn.classList.add('bg-green-700');
            viewItemsBtn.classList.remove('bg-indigo-700');
        });
        
        // Show items table
        viewItemsBtn.addEventListener('click', function() {
            addItemForm.style.display = 'none';
            viewItemsTable.style.display = 'block';
            addItemBtn.classList.remove('bg-green-700');
            viewItemsBtn.classList.add('bg-indigo-700');
        });
        
        // Close add form
        closeAddForm.addEventListener('click', function() {
            addItemForm.style.display = 'none';
            viewItemsTable.style.display = 'block';
            addItemBtn.classList.remove('bg-green-700');
            viewItemsBtn.classList.add('bg-indigo-700');
        });
        
        // Cancel add
        if (cancelAdd) {
            cancelAdd.addEventListener('click', function() {
                addItemForm.style.display = 'none';
                viewItemsTable.style.display = 'block';
                addItemBtn.classList.remove('bg-green-700');
                viewItemsBtn.classList.add('bg-indigo-700');
            });
        }
        
        // Search functionality
        const searchInput = document.getElementById('searchItems');
        if (searchInput) {
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                const rows = document.querySelectorAll('tbody tr:not([id^="edit-"])');
                
                rows.forEach(row => {
                    const name = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
                    const description = row.querySelector('td:nth-child(3)').textContent.toLowerCase();
                    
                    if (name.includes(searchTerm) || description.includes(searchTerm)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        }
        
        // Filter functionality
        const filterSelect = document.getElementById('filterItems');
        if (filterSelect) {
            filterSelect.addEventListener('change', function() {
                const filterValue = this.value;
                const rows = document.querySelectorAll('tbody tr:not([id^="edit-"])');
                
                rows.forEach(row => {
                    const status = row.querySelector('td:nth-child(5) span').textContent.trim();
                    
                    if (filterValue === 'all' || 
                        (filterValue === 'available' && status === 'Available') ||
                        (filterValue === 'unavailable' && status === 'Unavailable')) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        }
    });
</script>