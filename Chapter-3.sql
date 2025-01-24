-- SELECT * FROM Invoices;
-- SELECT * from Invoices;
SELECT *
  FROM Invoices;

--GET Vendor ID, InvoiceNumber, InvoiceTotal
SELECT VendorID, InvoiceNumber, InvoiceTotal
  FROM Invoices
-- WHERE clause - where invoiceTotal > 1000
SELECT VendorID, InvoiceNumber, InvoiceTotal
  FROM Invoices
  WHERE InvoiceTotal >= 2000
-- Calculated Value - Total Credits
SELECT PaymentTotal, CreditTotal, PaymentTotal + CreditTotal AS TotalCredits
  FROM Invoices
SELECT PaymentTotal, CreditTotal, (PaymentTotal + CreditTotal) TotalCredits
  FROM Invoices
-- order by total credits, add InoiceDate
SELECT InvoiceDate, PaymentTotal, CreditTotal, (PaymentTotal + CreditTotal) TotalCredits
  FROM Invoices
  ORDER BY TotalCredits DESC;
-- return between 1/1/23 and 3/31/23
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal 
  FROM Invoices
  WHERE InvoiceDate BETWEEN '2023-01-01' and '2023-03-31'
  ORDER BY InvoiceDate;

-- EXERCISE 1
SELECT VendorContactLName, VendorContactFName, VendorName
  FROM Vendors;
-- EXERCISE 1 - as presented
SELECT VendorContactFName, VendorContactLName, VendorName
  FROM Vendors
  ORDER BY VendorContactLName, VendorContactFName;
-- EXERCISE 2 
SELECT InvoiceNumber AS number, InvoiceTotal AS TOTAL, (PaymentTotal + CreditTotal) AS Credits, InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
  FROM Invoices;
--Exercise 3
SELECT VendorContactLName + ',' + VendorContactFName AS FullName
  FROM Vendors 
  ORDER BY VendorContactLName, VendorContactFName;
-- EXERCISE 4
SELECT InvoiceTotal, (InvoiceTotal / 10 ) AS [10%], InvoiceTotal + (InvoiceTotal / 10) AS [Plus 10%]
  FROM Invoices
  WHERE InvoiceTotal - (PaymentTotal + CreditTotal) >1000;
--EXERCISE 5
SELECT InvoiceNumber AS number, InvoiceTotal AS TOTAL, (PaymentTotal + CreditTotal) AS Credits, InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
  FROM Invoices
  WHERE InvoiceTotal BETWEEN  500 AND 10000;
 --EXERCISE 6
 SELECT VendorContactLName + ',' + VendorContactFName AS FullName
   FROM Vendors
   WHERE VendorContactLName LIKE '[A,B,C,E]%'
   ORDER BY VendorContactLName, VendorContactFName
-- EXERCISE 7
SELECT PaymentDate
  FROM Invoices
  WHERE ((InvoiceTotal- PaymentTotal-CreditTotal <=0) AND PaymentDate IS NULL) OR ((InvoiceTotal - PaymentTotal - CreditTotal >0) AND PaymentDate IS NOT NULL)