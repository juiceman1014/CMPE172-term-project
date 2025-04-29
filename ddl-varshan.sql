-- basic commands

-- 1. Suppliers who delivered on or after 15-Jan-2025
SELECT Name AS SupplierName, PhoneNumber
FROM Supplier
WHERE DateLastSupplied >= '2025-01-15';

-- 2. Current restaurant staff who are servers
SELECT Name, Salary
FROM Worker
WHERE Role = 'Server';

-- 3. Menu items priced above $17
SELECT Name AS MenuItem, Price
FROM Menu
WHERE Price > 17.00;



-- advanced commands

/* 1 ▸  Total units of ingredients supplied by each supplier */
SELECT S.Name AS SupplierName,
       SUM(I.Amount) AS TotalUnitsSupplied
FROM   Supplier  AS S
JOIN   Inventory AS I  ON S.SupplierID = I.SupplierID
GROUP  BY S.Name
ORDER  BY TotalUnitsSupplied DESC;

/* 2 ▸  How many menu items were in every customer order */
SELECT CO.OrderID,
       C.Name               AS CustomerName,
       CO.DateDined,
       SUM(OI.Quantity)     AS ItemsInOrder
FROM   CustomerOrder CO
JOIN   Customer      C  ON CO.CustomerID = C.CustomerID
JOIN   OrderItem     OI ON CO.OrderID    = OI.OrderID
GROUP  BY CO.OrderID, C.Name, CO.DateDined
ORDER  BY CO.DateDined DESC;

/* 3 ▸  Total expense dollars handled by each manager */
SELECT M.Name AS ManagerName,
       SUM(E.Amount) AS TotalExpenses
FROM   Management M
JOIN   Expense    E ON M.ManagerID = E.ManagerID
GROUP  BY M.Name
ORDER  BY TotalExpenses DESC;




-- advanced commands

/* 1 ▸  Customers whose total spending is above the overall customer-average */
SELECT hs.CustomerID,
       hs.Name,
       hs.TotalSpent,
       c.TimesDined
FROM (
        SELECT c.CustomerID,
               c.Name,
               SUM(co.Total) AS TotalSpent
        FROM   Customer      c
        JOIN   CustomerOrder co ON c.CustomerID = co.CustomerID
        GROUP  BY c.CustomerID, c.Name
     ) AS hs  
JOIN  Customer c  ON c.CustomerID = hs.CustomerID
WHERE hs.TotalSpent >
      ( 
        SELECT AVG(ct.TotalSpent)
        FROM (
                SELECT SUM(co2.Total) AS TotalSpent
                FROM   CustomerOrder co2
                GROUP  BY co2.CustomerID
             ) AS ct
      )
ORDER BY hs.TotalSpent DESC;


/* 2 ▸  Menu items whose revenue (price × qty sold) beats the overall-average item revenue */
SELECT m.Name            AS MenuItem,
       m.Price,
       s.TotalQty,
       m.Price * s.TotalQty AS Revenue
FROM   Menu  m
JOIN (
        SELECT MenuItemID,
               SUM(Quantity) AS TotalQty
        FROM   OrderItem
        GROUP  BY MenuItemID
     ) AS s
     ON m.MenuItemID = s.MenuItemID
WHERE m.Price * s.TotalQty >
      (
        SELECT AVG(ir.Revenue) 
        FROM (
                SELECT m2.MenuItemID,
                       m2.Price * SUM(o2.Quantity) AS Revenue
                FROM   Menu      m2
                JOIN   OrderItem o2 ON m2.MenuItemID = o2.MenuItemID
                GROUP  BY m2.MenuItemID, m2.Price
             ) AS ir
      )
ORDER BY Revenue DESC
LIMIT 5;


/* 3 ▸  Cities whose average order total is above the restaurant-wide average */
SELECT cs.City,
       cs.AvgOrderTotal
FROM (
        SELECT c.CityOfResidence AS City,
               AVG(co.Total)      AS AvgOrderTotal
        FROM   Customer      c
        JOIN   CustomerOrder co ON c.CustomerID = co.CustomerID
        GROUP  BY c.CityOfResidence
     ) AS cs
WHERE cs.AvgOrderTotal >
      ( SELECT AVG(Total) FROM CustomerOrder )
ORDER BY cs.AvgOrderTotal DESC;
