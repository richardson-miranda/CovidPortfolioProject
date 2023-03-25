
Select * 
From Walmart$

--Which week had the highest sales?
Select date, MAX(Weekly_Sales) as WeeklySales
From Walmart$
Group by date
Order by MAX(Weekly_Sales) DESC
-- OUTPUT: 24-12-2010 | 3818686.45


--How was the weather during the week of highest sales?
Select date, Temperature, Weekly_Sales
From Walmart$
Order by Weekly_Sales DESC
-- OUTPUT: 30.59

--What was the weather during the lowest weekly sales?
Select Temperature, Weekly_Sales
From Walmart$
Order by Weekly_Sales 
-- OUTPUT: 52.82

--What was the weekly sales at the lowest temperature?
Select Temperature, Weekly_Sales
From Walmart$
Order by Temperature ASC
-- OUTPUT: -2.06 | 558027.77


--Conclude whether the weather has an essential impact on sales.
	-- Many top sales weeks are in the months of November and December,
	-- indicating that the holiday season has an impact on sales
