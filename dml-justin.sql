-- basic query 1
-- Find suppliers that have been supplying since 2022.
SELECT Name AS SupplierName
FROM Supplier
WHERE DateStartedSupplying <= '2022-12-31';

-- basic query 2
-- Find out which advertisements brought in each customer.
SELECT C.name AS CustomerName, A.description AS AdvertisingDescription
FROM Customer C, Advertising A
WHERE C.AdvertisingID = A.AdvertisingID;

-- intermediate query 1
-- Find every customer that left a review
SELECT C.Name, R.DateOfReview, R.Description, R.Stars
FROM Customer C
LEFT JOIN Review R ON C.CustomerID=R.CustomerID
ORDER BY R.Stars DESC;

-- intermediate query 2
-- Find the amount of times each menu item has been sold
SELECT M.Name, SUM(O.Quantity) AS TimesSold
FROM Menu M
INNER JOIN OrderItem O ON M.MenuItemID=O.MenuItemID
GROUP BY M.name
ORDER BY TimesSold DESC;

-- advanced query 1


-- advanced query 2