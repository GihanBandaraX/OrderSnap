package com.items;

public class Item {
    private int itemId;
    private String name;
    private String description;
    private double price;
    private boolean isAvailable;
    private String imagePath;

    public Item(int itemId, String name, String description, double price, boolean isAvailable, String imagePath) {
        this.itemId = itemId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.isAvailable = isAvailable;
        this.imagePath = imagePath;
    }

    // Getters
    public int getItemId() {
        return itemId;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public String getImagePath() {
        return imagePath;
    }

    // Setters
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}