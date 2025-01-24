-- EXERSIE 1 - Join all columns of 2 tables
SELECT *
  FROM Vendors V
  JOIN Invoices I ON V.VendorID = I.VendorID;

-- EXERCISE 2 - return VendorName, InvoiceNumber, InvoiceDate, Balance sort by VendorName in ascending order
SELECT VendorName, InvoiceNumber, InvoiceDate, (InvoiceTotal - PaymentTotal - CreditTotal) AS Balance
    FROM Invoices I
	JOIN Vendors V ON I.VendorID = v.VendorID
	WHERE (InvoiceTotal - PaymentTotal - CreditTotal) > 0
	ORDER BY VendorName;

-- EXERCISE 3 - return VendorName, DefautAccountNo, AccountDiscription sort by AccountDescription, VendorName
SELECT VendorName, DefaultAccountNo, AccountDescription
  FROM Vendors V
  JOIN GLAccounts GL ON GL.AccountNo = V.DefaultAccountNo
  ORDER BY AccountDescription, VendorName;

-- EXCERSISE 4 (misread) - same result as 3, but use implicit join syntax
SELECT VendorName, DefaultAccountNo, AccountDescription
  FROM Vendors V, GLAccounts GL
  WHERE V.DefaultAccountNo = GL.AccountNo
  ORDER BY AccountDescription, VendorName;

-- EXERCISE 4(actual) - same result as 2, but use implicit join syntax
SELECT VendorName, InvoiceNumber, InvoiceDate, (InvoiceTotal - PaymentTotal - CreditTotal) AS Balance
    FROM Invoices I, Vendors V
	WHERE I.VendorID = v.VendorID AND (InvoiceTotal - PaymentTotal - CreditTotal) > 0
	ORDER BY VendorName;

-- EXERCISE 5 - join 3 return VendorName as Vendor, InvoiceDate as Date, InvoiceNumber as Number, InvoiceSequence as #, InvoiceLineItemAmount as LineItem
-- sort by Vendor, Date Number, #
SELECT VendorName AS Vendor, InvoiceDate AS Date, InvoiceNumber as Number, InvoiceSequence AS [#], InvoiceLineItemAmount AS LineItem
  From Vendors V
  JOIN Invoices I ON i.VendorID = v.VendorID
  JOIN InvoiceLineItems LI on LI.InvoiceID = I.InvoiceID
  ORDER BY Vendor, Date, Number, [#];

-- EXERCISE 6 - return Vendor ID, VendorName, Name (VendorContactFName + VendorContact L name with a space) sort by name - HINT use a self-join
SELECT DISTINCT v1.VendorID, v1.VendorName,(v1.VendorContactFName + ' ' + v1.VendorContactLName) AS Name
  FROM Vendors v1
  JOIN Vendors v2 ON v1.VendorID <> v2.VendorID AND v1.VendorContactFName = v2.VendorContactFName
  ORDER BY Name;
