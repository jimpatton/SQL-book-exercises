--CHAPTER 5 Exercises
--EXERCISE 1-  return VendorID, PaymentSum (sum of paymentTotal column) from Invoices
--sort by VendorID
SELECT VendorID, SUM(PaymentTotal) AS PaymentSum
  FROM Invoices
  GROUP BY VendorID;

--EXERCISE 2 - return VendorID, PaymentSum (sum of paymentTotal column) from Invoices
-- 10 vendors paid the most sort by Vendor ID
SELECT TOP 10 VendorName, SUM(PaymentTotal) AS PaymentSum
  FROM Invoices I
  JOIN Vendors V ON i.VendorID = v.VendorID
  GROUP BY VendorName;

--EXERCISE 3 - return VendorName, InvoiceCount, InvoiceSum 
--group by vendor, sort by sum descending
SELECT VendorName, COUNT(*) as InvoiceCount, Sum(InvoiceTotal) AS InvoiceSum
  FROM Vendors V
  JOIN Invoices I ON V.VendorID = I.VendorID
  GROUP BY VendorName
  ORDER BY InvoiceSum DESC;
  
--EXERCISE 4 - return AccountDescription, LintItemCount, LineItemSum
-- include LineItem count>1 - group by accountdescription - sort by line item cound DESC
SELECT AccountDescription, 
       COUNT(*) as LineItemCount, 
	   SUM(InvoiceLineItemAmount) AS LineItemSUM
  FROM InvoiceLineItems I
  JOIN GLAccounts G ON I.AccountNo = G.AccountNo
  GROUP BY AccountDescription
  HAVING COUNT(*) >1
  Order by COUNT(*) DESC;
  
--EXERCISE 5 - Modify the solution to exercise 4 to filter for invoices 
--dated from October 1, 2022 to December 31, 2022.
SELECT AccountDescription,  
       COUNT(*) as LineItemCount, 
	   SUM(InvoiceLineItemAmount) AS LineItemSUM
  FROM InvoiceLineItems IL
  JOIN GLAccounts G ON IL.AccountNo = G.AccountNo
  JOIN Invoices I on IL.InvoiceID = I.InvoiceID
  WHERE I.InvoiceDate BETWEEN '2022-10-01' AND '2022-12-31'
  GROUP BY AccountDescription
  HAVING COUNT(*) >1 
  ORDER BY COUNT(*) DESC;

--EXERCISE 6 -  What is the total amount invoiced for each AccountNo? 
--Use the ROLLUP operator to include a row that gives the grand total.
SELECT AccountNo, SUM(InvoiceLineItemAmount) AS InvSum
  FROM InvoiceLineItems
  GROUP BY ROLLUP (AccountNo);

--EXERCISE 7 - returns four columns: VendorName, Account-Description, LineItemCount, and LineItemSum.
--For each vendor and account, return the number and sum of line items, 
--sorted first by vendor, then by account description.
SELECT VendorName, AccountDescription, 
       COUNT(*) AS LineItemCount,
	   SUM(InvoiceLineItemAmount) AS LineItemSum
  FROM Vendors V
  JOIN Invoices I on V.VendorID = I.VendorID
  JOIN InvoiceLineItems LI ON I.InvoiceID = LI.InvoiceID
  JOIN GLAccounts GL ON LI.AccountNo = GL.AccountNo
  GROUP BY VendorName, AccountDescription
  ORDER BY VendorName, AccountDescription;

--EXERCISE 8 - Which vendors are being paid from more than one account?
--Return two columns: the vendor name 
--and the total number of accounts that apply to that vendor’s invoices
SELECT VendorName, Count(DISTINCT LI.AccountNo) AS TotalAccounts
  FROM Invoices I
  JOIN Vendors v ON V.VendorID = I.VendorID
  JOIN InvoiceLineItems LI ON I.InvoiceID = LI.InvoiceID
  GROUP BY VendorName
  HAVING Count(DISTINCT LI.AccountNo) > 1
  ORDER BY VendorName;

  --EXERCISE 9 - return VendorID, InvoiceDate, InvoiceTotal, VendorTotal, VendorCount, VendorAvg
  --The result set should include the individual invoices for each vendor
SELECT VendorID, InvoiceDate, InvoiceTotal, 
       SUM(InvoiceTotal) OVER (PARTITION BY VendorID) AS VendorTotal,
	   Count(InvoiceTotal) OVER (PARTITION BY VendorID) AS VendorCount,
	   AVG(InvoiceTotal) OVER (PARTITION BY VendorID) AS VendorAvg
  FROM Invoices I
  