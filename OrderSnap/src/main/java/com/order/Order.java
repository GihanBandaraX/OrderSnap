package com.order;



public class Order {
    private int orderId;
    private int clientId;
    private int itemId;
    private int quantity;
    private double totalPrice;
    private String status;
    private String orderDate;

    public Order(int orderId, int clientId, int itemId, int quantity, double totalPrice, String status, String orderDate) {
        this.orderId = orderId;
        this.clientId = clientId;
        this.itemId = itemId;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.status = status;
        this.orderDate = orderDate;
    }

    // Getters
    public int getOrderId() {
        return orderId;
    }

    public int getClientId() {
        return clientId;
    }

    public int getItemId() {
        return itemId;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public String getOrderDate() {
        return orderDate;
    }

    // Setters
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }
}