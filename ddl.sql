-- drop database restaurant_test;
-- create database restaurant_test;
-- use restaurant_test;

-- Create Table Statements

CREATE TABLE Restaurant(
	RestaurantID INT PRIMARY KEY,
	Name VARCHAR(255),
	Address VARCHAR(255),
	PhoneNumber VARCHAR(255)
);

CREATE TABLE Advertising(
	AdvertisingID INT PRIMARY KEY,
	Cost DECIMAL(10,2),
	Description VARCHAR(255),
	DatePublished DATE
);	

CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY,
	AdvertisingID INT,
	Name VARCHAR(255),
	CityOfResidence VARCHAR(255),
	TimesDined INT,
	FOREIGN KEY(AdvertisingID) REFERENCES Advertising(AdvertisingID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Worker(
	WorkerID INT PRIMARY KEY,
	Name VARCHAR(255),
	Address VARCHAR(255),
	PhoneNumber VARCHAR(255),
	Salary INT,
	Role VARCHAR(255)
);

CREATE TABLE Management(
	ManagerID INT PRIMARY KEY,
	Name VARCHAR(255),
	Address VARCHAR(255),
	PhoneNumber VARCHAR(255),
	Salary DECIMAL(10,2),
	Role VARCHAR(255)
);

CREATE TABLE Expense(
	ExpenseID INT,
	ManagerID INT,
	Category VARCHAR(255),
	Amount DECIMAL(10,2),
	DatePaid DATE,
	PRIMARY KEY (ExpenseID, ManagerID),
	FOREIGN KEY(ManagerID) REFERENCES Management(ManagerID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Supplier(
	SupplierID INT PRIMARY KEY,
	Name VARCHAR(255),
	Address VARCHAR(255),
	PhoneNumber VARCHAR(255),
	DateStartedSupplying DATE,
	DateLastSupplied DATE
);

CREATE TABLE Inventory(
	IngredientID INT,
	SupplierID INT,
	Name VARCHAR(255),
	Amount DECIMAL(10,2),
	ExpirationDate DATE,
	PRIMARY KEY(IngredientID, SupplierID),
	FOREIGN KEY(SupplierID) REFERENCES Supplier(SupplierID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Menu(
	MenuItemID INT PRIMARY KEY,
	Name VARCHAR(255),
	Price DECIMAL(10,2),
	Description VARCHAR(255),
	DatePlacedOnMenu DATE,
	TimesPurchased INT
);

CREATE TABLE CustomerOrder(
	OrderID INT PRIMARY KEY,
	CustomerID INT,
	Total DECIMAL(10,2),
	DateDined DATE,
	FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE OrderItem(
	OrderID INT,
	MenuItemID INT,
	Quantity INT,
	PRIMARY KEY(OrderID, MenuItemID),
	FOREIGN KEY(OrderID) REFERENCES CustomerOrder(OrderID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(MenuItemID) REFERENCES Menu(MenuItemID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Review(
	ReviewID INT PRIMARY KEY,
	CustomerID INT ,
	Description VARCHAR(255),
	Stars INT CHECK (Stars BETWEEN 1 AND 5),
	DateOfReview DATE,
	FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE
);


-- Insert Value Statements

INSERT INTO Restaurant(RestaurantID, Name, Address, PhoneNumber) VALUES
	(1, 'Pasta Pomodoro', '4898 San Felipe Rd, San Jose, CA', '(408) 532-0271');

INSERT INTO Advertising(AdvertisingID, Cost, Description, DatePublished) VALUES
	(1, 200.00, 'Instagram Ad', '2025-01-19'),
	(2, 200.00, 'Facebook Ad', '2025-02-03'),
	(3, 50.00, 'Poster', '2025-02-03'),
	(4, 300.00, 'Google Ad', '2025-02-10'),
	(5, 100.00, 'Flyers', '2025-03-05');

INSERT INTO Customer(CustomerID, AdvertisingID, Name, CityOfResidence, TimesDined) VALUES
	(1, 4, 'LeBron James', 'San Jose', 1),
	(2, 4, 'Kyrie Irving', 'San Jose', 1),
	(3, 4, 'Stephen Curry', 'San Jose', 1),
	(4, 1, 'Ja Morant', 'Cupertino', 3),
	(5, 1, 'Drake Ovo', 'Cupertino', 2),
	(6, 1, 'Nav Singh', 'Cupertino', 7),
	(7, 2, 'Kevin Durant', 'Cupertino', 3),
	(8, 5, 'Gordon Hayward', 'Milpitas', 3),
	(9, 5, 'Shaq Neal', 'Milpitas', 2),
	(10, 5, 'Luka Doncic', 'San Jose', 2),
	(11, 5, 'LaMelo Ball', 'San Jose', 1),
	(12, 3, 'Chris Paul', 'San Jose', 1),
	(13, 3, 'Brock Purdy', 'San Jose', 1),
	(14, NULL, 'Steve Jobs', 'Santa Clara', 2),
	(15, NULL, 'Jensen Huang', 'Santa Clara', 3),
	(16, 2, 'Aiden Smith', 'San Jose', 3),
	(17, 1, 'Maya Patel', 'Santa Clara', 5),
	(18, 3, 'Kenji Tanaka', 'Cupertino', 2),
	(19, NULL, 'Isabella Rossi', 'Sunnyvale', 1),
	(20, NULL, 'Jamal Carter', 'Milpitas', 4),
	(21, 1, 'Yuna Kim', 'Fremont', 2),
	(22, 3, 'Sven Bergstrom', 'San Jose', 3),
	(23, 4, 'Mei Lin', 'Mountain View', 1),
	(24, 5, 'Liam O''Connor', 'San Jose', 6),
	(25, 5, 'Fatima Al-Fulan', 'Santa Clara', 2);

INSERT INTO Worker(WorkerID, Name, Address, PhoneNumber, Salary, Role) VALUES
	(1, 'Antonio Russo', '123 Olive St, San Jose, CA', '(408) 555-1001', 35000, 'Server'),
	(2, 'Elena Kim', '456 Basil Ave, Santa Clara, CA', '(408) 555-1002', 37000, 'Cook'),
	(3, 'Nikhil Shah', '789 Tomato Blvd, Cupertino, CA', '(408) 555-1003', 33000, 'Dishwasher'),
	(4, 'Grace Chen', '321 Sage Ct, Milpitas, CA', '(408) 555-1004', 36000, 'Host'),
	(5, 'Liam Johnson', '654 Pepper Way, Sunnyvale, CA', '(408) 555-1005', 39000, 'Server'),
	(6, 'Fatima Malik', '111 Parsley Rd, San Jose, CA', '(408) 555-1006', 37000, 'Cook'),
	(7, 'Carlos Rivera', '222 Thyme Dr, Fremont, CA', '(408) 555-1007', 32000, 'Busser'),
	(8, 'Yuki Nakamura', '333 Cilantro Ln, Santa Clara, CA', '(408) 555-1008', 34000, 'Server'),
	(9, 'Stefan Petrov', '444 Garlic Ct, San Jose, CA', '(408) 555-1009', 35500, 'Prep Cook'),
	(10, 'James Lee', '555 Rosemary St, Mountain View, CA', '(408) 555-1010', 38000, 'Host');

INSERT INTO Management(ManagerID, Name, Address, PhoneNumber, Salary, Role) VALUES
	(1, 'Laura Neri', '101 Pine St, San Jose, CA', '(408) 555-2001', 65000.00, 'General Manager'),
	(2, 'David Thompson', '202 Oak Ave, Santa Clara, CA', '(408) 555-2002', 60000.00, 'Assistant Manager'),
	(3, 'Neha Kapoor', '303 Maple Dr, Cupertino, CA', '(408) 555-2003', 62000.00, 'Floor Manager'),
	(4, 'Santiago Ruiz', '404 Elm Ct, Milpitas, CA', '(408) 555-2004', 58000.00, 'Operations Manager'),
	(5, 'Sophie Dubois', '505 Cedar Rd, Sunnyvale, CA', '(408) 555-2005', 61000.00, 'Kitchen Manager');

INSERT INTO Expense(ExpenseID, ManagerID, Category, Amount, DatePaid) VALUES
	(1, 1, 'Rent', 3000.00, '2025-01-01'),
	(2, 1, 'Utilities', 850.50, '2025-01-05'),
	(3, 2, 'Food Supplies', 1250.75, '2025-01-07'),
	(4, 2, 'Marketing', 500.00, '2025-01-10'),
	(5, 3, 'Maintenance', 300.00, '2025-01-12'),
	(6, 3, 'Training', 200.00, '2025-01-15'),
	(7, 4, 'Cleaning Services', 400.00, '2025-01-18'),
	(8, 4, 'WiFi', 600.00, '2025-01-20'),
	(9, 5, 'Uniforms', 250.00, '2025-01-21'),
	(10, 5, 'Kitchen Equipment', 950.00, '2025-01-25'),
	(11, 1, 'Insurance', 600.00, '2025-01-30');

INSERT INTO Supplier(SupplierID, Name, Address, PhoneNumber, DateStartedSupplying, DateLastSupplied) VALUES
	(1, 'Fresh Farms Produce', '100 Orchard Ln, Gilroy, CA', '(408) 555-3001', '2023-03-01', '2025-01-05'),
	(2, 'Olive Oil Co.', '245 Tuscany Way, San Jose, CA', '(408) 555-3002', '2022-07-15', '2025-01-10'),
	(3, 'Golden Grains Distributors', '789 Wheat Rd, Santa Clara, CA', '(408) 555-3003', '2023-01-10', '2025-01-12'),
	(4, 'Dairy Delight', '456 Creamery Blvd, Milpitas, CA', '(408) 555-3004', '2023-05-20', '2025-01-15'),
	(5, 'Meat and Seafood Select', '321 Harbor Dr, San Francisco, CA', '(408) 555-3005', '2022-11-01', '2025-01-18');

INSERT INTO Inventory(IngredientID, SupplierID, Name, Amount, ExpirationDate) VALUES
	(1, 1, 'Tomato Sauce', 11.6, '2025-07-08'),
	(2, 4, 'Mozzarella Cheese', 16.72, '2025-05-04'),
	(3, 4, 'Parmesan Cheese', 15.58, '2025-06-05'),
	(4, 1, 'Basil', 43.67, '2025-06-16'),
	(5, 1, 'Garlic', 18.57, '2025-05-15'),
	(6, 2, 'Olive Oil', 29.15, '2025-07-04'),
	(7, 3, 'Fettuccine Pasta', 41.33, '2025-06-13'),
	(8, 3, 'Spaghetti Pasta', 26.7, '2025-07-17'),
	(9, 3, 'Penne Pasta', 25.51, '2025-05-14'),
	(10, 4, 'Heavy Cream', 10.28, '2025-06-29'),
	(11, 4, 'Ricotta Cheese', 19.68, '2025-06-28'),
	(12, 5, 'Ground Beef', 27.65, '2025-06-17'),
	(13, 5, 'Italian Sausage', 34.0, '2025-06-06'),
	(14, 1, 'Mushrooms', 22.81, '2025-05-22'),
	(15, 1, 'Bell Peppers', 13.83, '2025-05-03'),
	(16, 1, 'Onions', 26.99, '2025-06-19'),
	(17, 1, 'Spinach', 46.42, '2025-05-04'),
	(18, 3, 'Flour', 20.86, '2025-06-18'),
	(19, 3, 'Yeast', 8.91, '2025-06-18'),
	(20, 3, 'Bread Crumbs', 46.11, '2025-06-26'),
	(21, 5, 'Shrimp', 50.29, '2025-05-15'),
	(22, 1, 'Eggplants', 23.81, '2025-05-23');

INSERT INTO Menu(MenuItemID, Name, Price, Description, DatePlacedOnMenu, TimesPurchased) VALUES
	(1, 'Margherita Pizza', 13.99, 'Tomato sauce, mozzarella cheese, and fresh basil', '2025-01-01', 58),
	(2, 'Fettuccine Alfredo', 15.49, 'Fettuccine pasta with heavy cream, garlic, and parmesan cheese', '2025-01-01', 74),
	(3, 'Spaghetti Bolognese', 16.99, 'Spaghetti pasta with tomato sauce, ground beef, garlic, and onions', '2025-01-01', 65),
	(4, 'Lasagna', 17.49, 'Layers of ricotta, ground beef, parmesan, mozzarella, and tomato sauce', '2025-01-01', 49),
	(5, 'Eggplant Parmesan', 14.99, 'Breaded eggplant with tomato sauce, mozzarella, and parmesan cheese', '2025-01-01', 32),
	(6, 'Italian Sausage Penne', 16.49, 'Penne pasta with Italian sausage, bell peppers, and olive oil', '2025-01-05', 41),
	(7, 'Stuffed Mushrooms', 9.99, 'Mushrooms stuffed with breadcrumbs, garlic, and ricotta cheese', '2025-01-05', 28),
	(8, 'Seafood Risotto', 19.99, 'Risotto with shrimp, garlic, onions, and olive oil', '2025-01-05', 36);

INSERT INTO CustomerOrder(OrderID, CustomerID, Total, DateDined) VALUES
	(1, 24, 102.43, '2025-03-21'),
	(2, 11, 103.44, '2025-01-24'),
	(3, 24, 17.49, '2025-01-26'),
	(4, 18, 92.93, '2025-01-20'),
	(5, 19, 79.45, '2025-01-03'),
	(6, 10, 47.47, '2025-03-10'),
	(7, 10, 59.97, '2025-01-22'),
	(8, 18, 29.97, '2025-03-13'),
	(9, 11, 29.98, '2025-02-04'),
	(10, 4, 123.42, '2025-02-09'),
	(11, 9, 71.95, '2025-01-11'),
	(12, 22, 63.45, '2025-02-19'),
	(13, 20, 96.94, '2025-02-03'),
	(14, 24, 39.98, '2025-01-11'),
	(15, 8, 108.93, '2025-03-16'),
	(16, 3, 9.99, '2025-02-03'),
	(17, 16, 27.98, '2025-03-24'),
	(18, 19, 33.98, '2025-02-14'),
	(19, 21, 112.44, '2025-03-09'),
	(20, 4, 33.98, '2025-02-20'),
	(21, 6, 17.49, '2025-02-22'),
	(22, 2, 96.43, '2025-01-07'),
	(23, 7, 43.96, '2025-01-22'),
	(24, 22, 103.43, '2025-01-13'),
	(25, 24, 71.94, '2025-01-11');

INSERT INTO OrderItem(OrderID, MenuItemID, Quantity) VALUES
	(1, 4, 3),
	(1, 5, 2),
	(1, 7, 2),
	(2, 3, 1),
	(2, 8, 2),
	(2, 2, 3),
	(3, 4, 1),
	(4, 7, 3),
	(4, 5, 2),
	(4, 6, 2),
	(5, 6, 3),
	(5, 5, 2),
	(6, 4, 1),
	(6, 5, 2),
	(7, 8, 3),
	(8, 7, 3),
	(9, 5, 2),
	(10, 7, 2),
	(10, 4, 3),
	(10, 3, 3),
	(11, 3, 2),
	(11, 1, 2),
	(11, 7, 1),
	(12, 3, 1),
	(12, 6, 1),
	(12, 7, 3),
	(13, 8, 3),
	(13, 3, 1),
	(13, 7, 2),
	(14, 8, 2),
	(15, 6, 2),
	(15, 5, 3),
	(15, 2, 2),
	(16, 7, 1),
	(17, 1, 2),
	(18, 4, 1),
	(18, 6, 1),
	(19, 4, 3),
	(19, 8, 3),
	(20, 8, 1),
	(20, 1, 1),
	(21, 4, 1),
	(22, 1, 1),
	(22, 4, 3),
	(22, 7, 3),
	(23, 1, 1),
	(23, 7, 3),
	(24, 1, 3),
	(24, 5, 3),
	(24, 6, 1),
	(25, 1, 3),
	(25, 7, 3);

INSERT INTO Review(ReviewID, CustomerID, Description, Stars, DateOfReview) VALUES
	(1, 3, 'The lasagna was delicious and the service was quick!', 5, '2025-01-14'),
	(2, 7, 'Pizza was great but the place was a bit noisy.', 4, '2025-01-22'),
	(3, 12, 'The Alfredo sauce was bland. Not what I expected.', 2, '2025-02-05'),
	(4, 9, 'Amazing food and cozy atmosphere. Will come again!', 5, '2025-02-18'),
	(5, 14, 'Wait time was too long even with a reservation.', 3, '2025-03-01'),
	(6, 21, 'Loved the mushrooms! Best I’ve had in a while.', 5, '2025-03-11');

	

