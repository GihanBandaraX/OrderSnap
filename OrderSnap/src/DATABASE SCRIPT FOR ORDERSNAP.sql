
--DATABASE SCRIPT FOR ORDERSNAP

-- Create the database
CREATE DATABASE ordersnap_db;
USE ordersnap_db;

-- Create the clientdata table to store user information
CREATE TABLE clientdata (
    cid INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    gender VARCHAR(10),
    dob VARCHAR(10),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255) NOT NULL,
    userType VARCHAR(10) DEFAULT 'user',
    CONSTRAINT chk_userType CHECK (userType IN ('user', 'admin'))
);

-- Insert sample client data
INSERT INTO clientdata (name, gender, dob, email, phone, address, username, password, userType) VALUES
    ('Gihan-User', 'Male', '1999-05-27', 'gihan_user@gmail.com', '+94761235478', 'Malabe, Colombo', 'Gihan-user', 'Gihan-user123', 'user'),
    ('Gihan-admin', 'Male', '1999-05-27', 'gihan_admin@gmail.com', '+94761235478', 'Malabe, Colombo', 'Gihan-admin', 'Gihan-admin123', 'admin');
    ('John Doe', 'Male', '1990-05-15', 'john.doe@email.com', '123-456-7890', '123 Main St, City', 'johndoe123', 'johndoe@123', 'admin'),
    ('Jane Smith', 'Female', '1985-08-25', 'jane.smith@email.com', '987-654-3210', '456 Elm St, Town', 'janesmith456', 'janesmith@456', 'user'),
    ('Bob Johnson', 'Male', '1982-03-10', 'bob.johnson@email.com', '555-123-7890', '789 Oak St, Village', 'bobjohnson789', 'bobjohnson@789', 'user');

-- Create the items table to store food and drink items
CREATE TABLE items (
    itemId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    isAvailable BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(255),
    CONSTRAINT chk_price CHECK (price >= 0)
);

-- Insert sample item data (three foods, three drinks)
INSERT INTO items (name, description, price, isAvailable, imagePath) VALUES
    ('Margherita Pizza', 'Classic Italian pizza with fresh mozzarella, ripe tomatoes, and basil leaves on a thin, crispy crust, baked to perfection.', 12.99, TRUE, '/images/items/margherita_pizza.jpg'),
    ('Chicken Alfredo Pasta', 'Creamy Alfredo sauce tossed with fettuccine pasta, topped with grilled chicken breast and a sprinkle of Parmesan cheese.', 14.50, TRUE, '/images/items/chicken_alfredo.jpg'),
    ('Veggie Burger', 'A hearty veggie patty made with black beans and quinoa, served with lettuce, tomato, avocado, and a spicy mayo on a whole-grain bun.', 9.99, TRUE, '/images/items/veggie_burger.jpg'),
    ('Mango Lassi', 'A refreshing Indian yogurt-based drink blended with sweet mango puree, a hint of cardamom, and served chilled.', 4.50, TRUE, '/images/items/mango_lassi.jpg'),
    ('Iced Mocha Latte', 'A chilled blend of espresso, rich chocolate syrup, and creamy milk, topped with whipped cream and a drizzle of chocolate.', 5.25, TRUE, '/images/items/iced_mocha.jpg'),
    ('Virgin Mojito', 'A refreshing non-alcoholic mocktail with fresh mint leaves, lime juice, sugar syrup, and sparkling soda water, served over crushed ice.', 4.75, TRUE, '/images/items/virgin_mojito.jpg');

-- Create the orders table to store order details
CREATE TABLE orders (
    orderId INT AUTO_INCREMENT PRIMARY KEY,
    clientId INT NOT NULL,
    itemId INT NOT NULL,
    quantity INT NOT NULL,
    totalPrice DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    orderDate VARCHAR(50) NOT NULL,
    FOREIGN KEY (clientId) REFERENCES clientdata(cid) ON DELETE CASCADE,
    FOREIGN KEY (itemId) REFERENCES items(itemId) ON DELETE CASCADE,
    CONSTRAINT chk_quantity CHECK (quantity > 0),
    CONSTRAINT chk_totalPrice CHECK (totalPrice >= 0)
);

-- Insert sample order data
INSERT INTO orders (clientId, itemId, quantity, totalPrice, status, orderDate) VALUES
    (1, 1, 2, 25.98, 'Pending', '2025-05-15 20:22:00'),
    (2, 4, 1, 4.50, 'Delivered', '2025-05-14 14:30:00'),
    (1, 6, 3, 14.25, 'Processing', '2025-05-15 09:15:00'),
    (3, 2, 1, 14.50, 'Pending', '2025-05-16 10:00:00'),
    (2, 5, 2, 10.50, 'Delivered', '2025-05-15 12:45:00');