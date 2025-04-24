--basic query 1
SELECT Name AS SupplierName
FROM Supplier
WHERE DateStartedSupplying <= '2022-12-31';

--basic query 2
SELECT C.name AS CustomerName, A.description AS AdvertisingDescription
FROM Customer C, Advertising A
WHERE C.AdvertisingID = A.AdvertisingID;

--intermediate query 1

--intermediate query 2

--advanced query 1

--advanced query 2