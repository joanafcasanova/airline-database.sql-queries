-- filepath: /airline-database/airline-database/queries/airplanes_queries.sql
--1. What is the build date of the airplanes that have flown in 2014?
SELECT DISTINCT T.AIRCRAFT_ID, A.BUILD_DATE FROM TICKETS T, AIRPLANES A
WHERE T.AIRCRAFT_ID = A.AIRCRAFT_REGISTRATION AND YEAR(T.FLIGHT_DATE) = 2014;

--2. How many passengers born in the 70’s that have flown to Paris?
SELECT COUNT(DISTINCT P.ID) AS PASS_70_Paris FROM ROUTES R, TICKETS T, PASSENGERS P
WHERE R.ROUTE_CODE = T.ROUTE_CODE AND T.PASSENGER_ID = P.ID
AND UPPER(R.DESTINATION) = 'PARIS' AND YEAR(P.BIRTH_DATE) BETWEEN 1970 AND 1979;

--3. Telephone number of the oldest passenger.
SELECT NAME, TELEPHONE, BIRTH_DATE FROM PASSENGERS
WHERE BIRTH_DATE = (SELECT MIN(BIRTH_DATE) FROM PASSENGERS);

--4. How many airplanes have more than 300 seats and tickets more expensive than 1000€.
SELECT COUNT(DISTINCT T.AIRCRAFT_ID) AS N_PLANES_300s_1000eur FROM ROUTES R, TICKETS T, AIRPLANES A
WHERE R.ROUTE_CODE = T.ROUTE_CODE AND T.AIRCRAFT_ID = A.AIRCRAFT_REGISTRATION
AND A.SEATS > 300 AND R.PRICE > 1000;

--5. Find the tickets of all the flights to Toronto in planes built before 2010 for passengers born after 2000.
SELECT DISTINCT T.TICKET_ID FROM ROUTES R, TICKETS T, AIRPLANES A, PASSENGERS P
WHERE R.ROUTE_CODE = T.ROUTE_CODE AND T.AIRCRAFT_ID = A.AIRCRAFT_REGISTRATION 
AND P.ID = T.PASSENGER_ID AND UPPER(R.DESTINATION) = 'TORONTO' 
AND YEAR(A.BUILD_DATE) < 2010 AND YEAR(P.BIRTH_DATE) > 2000;

--6. Obtain all the routes that have a price lower than the average price of the route which destination is Madrid, London or Paris.
SELECT ROUTE_CODE, ORIGIN, DESTINATION FROM ROUTES
WHERE PRICE < (SELECT AVG(PRICE) FROM ROUTES WHERE UPPER(DESTINATION) IN ('MADRID', 'PARIS', 'LONDON'));

--7. For each origin how many tickets have been sold only for the tickets more expensive than 300€.
SELECT R.ORIGIN, COUNT(T.TICKET_ID) AS N_TICKETS FROM ROUTES R, TICKETS T
WHERE R.ROUTE_CODE = T.ROUTE_CODE AND R.PRICE > 300
GROUP BY R.ORIGIN;

--8. How much money has the company earned selling tickets?
SELECT SUM(R.PRICE) AS M_company_earned FROM TICKETS T, ROUTES R
WHERE T.ROUTE_CODE = R.ROUTE_CODE;

--9. List the price of each ticket ordered by price appearing first the more expensive.
SELECT T.TICKET_ID, R.PRICE FROM TICKETS T, ROUTES R
WHERE T.ROUTE_CODE = R.ROUTE_CODE
ORDER BY R.PRICE DESC;

--10. Obtain the name and telephone of the passenger that flew the route R7203 on 12/28/2005 in planes with more than 300 seats.
SELECT P.NAME, P.TELEPHONE FROM PASSENGERS P, TICKETS T, AIRPLANES A
WHERE P.ID = T.PASSENGER_ID AND A.AIRCRAFT_REGISTRATION = T.AIRCRAFT_ID
AND T.ROUTE_CODE = 'R7203' AND T.FLIGHT_DATE = '2005-12-28' AND A.SEATS > 300;

--11. How many tickets were sold for each route and each day, for the routes sold in the last 30 days from the current day.
SELECT T.ROUTE_CODE, T.FLIGHT_DATE, COUNT(T.TICKET_ID) AS N_TICKETS_SOLD
FROM TICKETS T
WHERE T.FLIGHT_DATE > CURRENT_DATE - INTERVAL '30 DAYS'
GROUP BY T.ROUTE_CODE, T.FLIGHT_DATE;

--12. Obtain the route and day with the highest number of tickets sold.
SELECT T.ROUTE_CODE, T.FLIGHT_DATE, COUNT(T.TICKET_ID) AS N_TICKETS_SOLD
FROM TICKETS T
GROUP BY T.ROUTE_CODE, T.FLIGHT_DATE
HAVING COUNT(T.TICKET_ID) >= ALL (SELECT COUNT(T.TICKET_ID) FROM TICKETS T2
GROUP BY T2.ROUTE_CODE, T2.FLIGHT_DATE);