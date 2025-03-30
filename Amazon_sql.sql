-- 2.1           Add a new column named timeofday to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
-- select `Invoice ID` , Branch, City, `Customer type`, Gender, `Product line`, `Unit price`, Quantity, `Tax 5%`, Total, Date, Time, Payment, cogs, `gross margin percentage`, `gross income`, Rating,
-- case 
-- 	when Time between '00:00:00' and '11:59:59' then "Morning"
--     when Time between '12:00:00' and '17:59:59' then "Afternoon"
--     when TIme between '18:00:00' and '23:59:59' then "Evening"
-- End as Timeofday
-- from amazon

-- set SQL_SAFE_UPDATES = 0
-- update amazon
-- set Timeofday = 
-- 	Case 
-- 		when Time between '00:00:00' and '11:59:59' then "Morning"
--         when Time between '12:00:00' and '17:59:59' then "Afternoon"
--         when TIme between '18:00:00' and '23:59:59' then "Evening"
-- 	End
-- select Timeofday
-- from amazon

-- alter table amazon
-- add column Timeofday varchar(20);

-- 2.2 Add a new column named dayname that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.    
-- select `Invoice ID` , Branch, City, `Customer type`, Gender, `Product line`, `Unit price`, Quantity, `Tax 5%`, Total, Date, Time, Payment, cogs, `gross margin percentage`, `gross income`, Rating,
-- case 
-- 	when dayname(Date) = 0 then "Monday"
--     when dayname(Date) = 1 then "Tuesday"
--     when dayname(Date) = 2 then "Wednesday"
--     when dayname(Date) = 3 then "Thursday"
--     when dayname(Date) = 4 then "Friday"
--     when dayname(Date) = 5 then "Saturday"
--     when dayname(Date) = 6 then "Sunday"
-- End as dayname 
-- from amazon

-- update amazon
-- set dayname = 
-- case 
-- 	when dayname(Date) = 0 then "Monday"
--     when dayname(Date) = 1 then "Tuesday"
--     when dayname(Date) = 2 then "Wednesday"
--     when dayname(Date) = 3 then "Thursday"
--     when dayname(Date) = 4 then "Friday"
--     when dayname(Date) = 5 then "Saturday"
--     when dayname(Date) = 6 then "Sunday"
-- End 
-- alter table amazon
-- add column dayname varchar(20);

-- select dayname from amazon

-- 2.3        Add a new column named monthname that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.
-- select `Invoice ID` , Branch, City, `Customer type`, Gender, `Product line`, `Unit price`, Quantity, `Tax 5%`, Total, Date, Time, Payment, cogs, `gross margin percentage`, `gross income`, Rating,
-- case 
-- 	when monthname(Date) = "January" then "January" 
--     when monthname(Date) = "February" then "February" 
--     when monthname(Date) = "March" then "March" 
--     when monthname(Date) = "April" then "April" 
--     when monthname(Date) = "May" then "May" 
--     when monthname(Date) = "June" then "June" 
--     when monthname(Date) = "July" then "July" 
-- 	when monthname(Date) = "August" then "August"
-- 	when monthname(Date) = "September" then "September"
-- 	when monthname(Date) = "October" then "October"
-- 	when monthname(Date) = "November" then "November"
-- 	when monthname(Date) = "December" then "December"
-- End as monthname
-- from amazon


-- alter table amazon
-- add column monthname varchar(20)

-- update amazon 
-- set monthname = 
-- case 
-- 	when monthname(Date) = "January" then "January" 
--     when monthname(Date) = "February" then "February" 
--     when monthname(Date) = "March" then "March" 
--     when monthname(Date) = "April" then "April" 
--     when monthname(Date) = "May" then "May" 
--     when monthname(Date) = "June" then "June" 
--     when monthname(Date) = "July" then "July" 
-- 	when monthname(Date) = "August" then "August"
-- 	when monthname(Date) = "September" then "September"
-- 	when monthname(Date) = "October" then "October"
-- 	when monthname(Date) = "November" then "November"
-- 	when monthname(Date) = "December" then "December"
-- End 

-- select monthname from amazon




-- 1. What is the count of distinct cities in the dataset?
-- select count(distinct City) as city
-- from amazon

-- 2. For each branch, what is the corresponding city?
-- select distinct(branch),city 
-- from amazon

-- # 3. What is the count of distinct product lines in the dataset.
-- select count(distinct `Product line`) as distinct_productLine
-- from amazon 

-- 4. Which payment method occurs most frequently?
-- select Payment , count(Payment) as total_Payment
-- from amazon
-- group by Payment
-- order by total_Payment desc limit 1

-- 5. Which product line has the highest sales?
-- select `Product line` , sum(Total) as highest_sales
-- from amazon
-- group by `Product line`
-- order by highest_sales desc limit 1

-- 6. How much revenue is generated each month?
-- select monthname(Date), sum(Total)
-- from amazon
-- group by monthname(Date)
-- order by sum(Total) desc

-- 7.In which month did the cost of goods sold reach its peak?
-- select monthname , sum(total) as total
-- from amazon 
-- group by monthname
-- order by total desc limit 1

-- 8. Which product line generated the highest revenue?
select `Product line` , sum(Total) as highest
from amazon
group by `Product line`
order by highest desc limit 1 

-- 9. In which city was the highest revenue recorded?
-- select city, sum(Total) as total
-- from amazon
-- group by city 
-- order by total desc limit 1

-- 10. Which product line incurred the highest Value Added Tax?
-- select `Product line`, sum(`Tax 5%`) as tax
-- from amazon 
-- group by `Product line`
-- order by tax desc limit 1

-- 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
-- with sales as (
-- select `Product line`, Total , 
-- avg(Total) over(partition by `Product line`) as avg_total ,
-- CASE  
-- 	when Total > avg(total) over(partition by `Product line`) THEN "Good"
--     else "Bad"
-- End as category
-- from amazon )

-- select * from sales 


-- 12. Identify the branch that exceeded the average number of products sold.
-- select Branch , sum(Quantity) as total
-- from amazon
-- group by Branch
-- having sum(Quantity) > (select avg(Quantity) from amazon)


-- 13. Which product line is most frequently associated with each gender?
-- select f.`Product line`, f.s, f.r
-- from 
-- (select `Product line` , count(Gender) as s,
-- rank() over (partition by `Product line` order by count(Gender) desc ) as r
-- from amazon	
-- group by `Product line`, Gender) as f
-- where f.r = 1

-- 14. Calculate the average rating for each product line.
-- select `Product line`, avg(rating) as avg_rating
-- from amazon
-- group by `Product line`



-- 15. Count the sales occurrences for each time of day on every weekday.
-- select Timeofday, dayname , count(*) as sales 
-- from amazon
-- group by Timeofday, dayname


-- 16. Identify the customer type contributing the highest revenue.
-- select `Customer type`, sum(Total) as Total
-- from amazon
-- group by `Customer type`
-- order by Total desc limit 1

-- 17. Determine the city with the highest VAT percentage.
-- select City, sum((`Tax 5%`/Total)*100) as VAT
-- from amazon
-- group by City
-- order by VAT desc limit 1

-- 18. Identify the customer type with the highest VAT payments.
-- select `Customer type` , sum(`Tax 5%`)
-- from amazon
-- group by  `Customer type`
-- order by sum(`Tax 5%`) desc limit 1

-- 19.What is the count of distinct customer types in the dataset?
-- select count(distinct `Customer type`) as distinct_customer
-- from amazon

-- 20. What is the count of distinct payment methods in the dataset?
-- select count(distinct Payment) as distinct_Payment 
-- from amazon

-- 21. Which customer type occurs most frequently?
-- select `Customer type`, count(`Customer type`) as count_of_Customertype
-- from amazon
-- group by `Customer type`
-- order by count(`Customer type`) desc limit 1 

-- 22. Identify the customer type with the highest purchase frequency.
-- select `Customer type`, count(Payment) as highest_purchase
-- from amazon
-- group by `Customer type`
-- order by count(Payment) desc limit 1

-- 23. Determine the predominant gender among customers.
-- select Gender, count(Gender) as Customer
-- from amazon 
-- group by Gender
-- order by count(Gender) desc limit 1

-- 24. Examine the distribution of genders within each branch.
-- select Gender, Branch, count(*) as distribution_gender
-- from amazon
-- group by Gender, Branch

-- 25. Identify the time of day when customers provide the most ratings.
-- select Timeofday , sum(Rating) as highest_rating
-- from amazon
-- group by Timeofday
-- order by highest_rating desc limit 1


-- 26. Determine the time of day with the highest customer ratings for each branch.
-- with sales as (select Timeofday, sum(Rating) as Rating , Branch,
-- rank() over(partition by Branch order by sum(Rating) desc) as rank_branch 
-- from amazon 
-- group by Timeofday, Branch) 

-- select Timeofday,Rating,Branch
-- from sales
-- where rank_branch = 1




-- 27.Identify the day of the week with the highest average ratings.
-- select dayname, avg(Rating) as avg_rating
-- from amazon
-- group by dayname
-- order by sum(Rating) desc limit 1

-- 28. Determine the day of the week with the highest average ratings for each branch.
select dayname, avg(Rating) as avg_rating, Branch
from amazon
group by dayname, Branch
order by sum(Rating) desc limit 1


