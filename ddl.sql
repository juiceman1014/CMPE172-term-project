-- drop database restaurant_test;
-- create database restaurant_test;
-- use restaurant_test;

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
	CustomerID INT,
	AdvertisingID INT,
	Name VARCHAR(255),
	CityOfResidence VARCHAR(255),
	TimesDined INT,
	PRIMARY KEY(CustomerID, AdvertisingID),
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
	Amount DECIMAL(10,2),
	ExpirationDate DATE,
	PRIMARY KEY(IngredientID, SupplierID),
	FOREIGN KEY(SupplierID) REFERENCES Supplier(SupplierID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Menu(
	MenuItemID INT PRIMARY KEY,
	Name VARCHAR(255),
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








