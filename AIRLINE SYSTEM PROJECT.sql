-- CREATING DATABASE NAMED "AIRLINE_SYSTEM" & USING IT
create database AIRLINE_SYSTEM;
use AIRLINE_SYSTEM;


-- TABLE-1 : FLIGHTS
-- CREATING TABLE-1 NAMED "FLIGHTS"
create table FLIGHTS (
flight_id int primary key not null,
flight_no varchar (10),
source_city varchar (30),
destination varchar (30)
);

-- INSERTING VALUES IN TABLE-1 (FLIGHTS)
insert into FLIGHTS (flight_id, flight_no, source_city, destination)
values
(1,'A1','mumbai','delhi'),
(2,'A2','delhi','chennai'),
(3,'A3','banglore','mumbai'),
(4,'A4','chennai','pune'),
(5,'A5','mumbai','banglore'),
(6,'A6','hyderabad','pune');

-- VIEWING TABLE-1 (FLIGHTS)
select * from FLIGHTS;


-- TABLE 2 : PASSENGERS
-- CREATING TABLE-2 NAMED "PASSENGERS"
create table PASSENGERS (
passenger_id int primary key not null,
name varchar (30),
age int,
city varchar (30)
);

-- INSERTING VALUES IN TABLE-2 (PASSENGERS)
insert into PASSENGERS (passenger_id, name, age, city)
values
(1,'safiya','40','mumbai'),
(2,'zoya','35','delhi'),
(3,'hajera','50','banglore'),
(4,'ayesha','25','chennai'),
(5,'azlaan','18','pune');

-- VIEWING TABLE-2 (PASSENGERS)
select * from PASSENGERS;


--TABLE 3 : BOOKINGS
-- CREATING TABLE-3 NAMED "BOOKINGS"
create table BOOKINGS (
booking_id int primary key not null,
passenger_id int,
foreign key (passenger_id) references passengers (passenger_id),
flight_id int,
foreign key (flight_id) references flights (flight_id),
ticket_price int,
travel_date date 
);

-- INSERTING VALUES IN TABLE-3 (BOOKINGS)
insert into BOOKINGS (booking_id, passenger_id, flight_id, ticket_price, travel_date)
values
(1, 1, 1, 50000, '2025-10-12'),
(2, 2, 2, 48000, '2025-10-13'),
(3, 3, 2, 55000, '2025-10-14'),
(4, 4, 3, 61000, '2025-10-15'),
(5, 5, 4, 45000, '2025-10-16'),
(6, 1, 5, 71000, '2025-10-12'),
(7, 2, 5, 40000, '2025-10-18'),
(8, 2, 6, 60000, '2025-10-12'),
(9, 3, 1, 50000, '2025-10-20'),
(10, 4, 4, 47000, '2025-10-21');

-- VIEWING TABLE-3 (BOOKINGS)
select * from BOOKINGS;


-- Task 1: Show all passengers with their flight details
select p.name, f.flight_no, f.source_city, f.destination, b.ticket_price, b.travel_date
from passengers p
join bookings b on p.passenger_id = b.passenger_id
join flights f on b.flight_id = f.flight_id;


-- Task 2: List all flights that depart (leave) from Mumbai
select * from flights where source_city = 'mumbai';


-- Task 3: Find average ticket price for each flight route(source → destination)
select flight_id, avg(ticket_price)
from bookings 
group by flight_id;


-- Task 4: Show passengers who booked tickets costing more than 6000 rupees
SELECT p.name, b.ticket_price
FROM BOOKINGS b
JOIN PASSENGERS p ON b.passenger_id = p.passenger_id
WHERE b.ticket_price > 6000;


-- Task 5: Find the most expensive flight booked
select flight_id, ticket_price 
from bookings 
order by ticket_price desc limit 1;


-- Task 6: Categorize passengers based on ticket price using case
SELECT p.name, b.ticket_price,
CASE
    WHEN b.ticket_price >= 60000 THEN 'Premium'
    WHEN b.ticket_price BETWEEN 45000 AND 59999 THEN 'Standard'
    ELSE 'Economy'
END AS category
FROM PASSENGERS p
JOIN BOOKINGS b ON p.passenger_id = b.passenger_id;


-- Task 7: Find passengers who paid above the average ticket price  
-- avg(ticket_price)----> 52700
SELECT p.name, b.ticket_price
FROM BOOKINGS b
JOIN PASSENGERS p ON b.passenger_id = p.passenger_id
WHERE b.ticket_price > (SELECT AVG(ticket_price) FROM BOOKINGS);


-- Task 8 : List all passengers who are from Delhi or Mumbai  
select name,city from passengers where city = 'delhi' or city = 'mumbai';


-- Task 9: Show bookings made between '2025-10-09' and '2025-10-12'
select booking_id,travel_date from bookings where  travel_date between '2025-10-09' and '2025-10-12';


-- Task 10 : Show total ticket revenue (total income) for each destination 
SELECT f.destination, SUM(b.ticket_price) AS total_revenue
FROM BOOKINGS b
JOIN FLIGHTS f ON b.flight_id = f.flight_id
GROUP BY f.destination;


-- Task 11 : Find average ticket price paid by each passenger 
SELECT p.name, AVG(b.ticket_price) AS avg_ticket_price
FROM BOOKINGS b
JOIN PASSENGERS p ON b.passenger_id = p.passenger_id
GROUP BY p.name;


-- Task 12 : Show passenger name, flight number, and travel date
SELECT p.name, f.flight_no, b.travel_date
FROM BOOKINGS b
JOIN PASSENGERS p ON b.passenger_id = p.passenger_id
JOIN FLIGHTS f ON b.flight_id = f.flight_id;


-- Task 13 : Find which cities passengers are traveling to
select destination from flights;


-- Task 14 : Show all passengers with their booked flight numbers
SELECT p.name, f.flight_no
FROM PASSENGERS p
JOIN BOOKINGS b ON p.passenger_id = b.passenger_id
JOIN FLIGHTS f ON b.flight_id = f.flight_id;


-- Task 15 : Show passenger names with their travel route (source → destination)
SELECT 
    p.name AS passenger_name,
    f.source_city,
    f.destination
FROM bookings b
JOIN passengers p ON b.passenger_id = p.passenger_id
JOIN flights f ON b.flight_id = f.flight_id;


-- Task 16 : Show total amount spent by each passenger
SELECT p.name, SUM(b.ticket_price) AS total_amount_spent
FROM PASSENGERS p
JOIN BOOKINGS b ON p.passenger_id = b.passenger_id
GROUP BY p.name;