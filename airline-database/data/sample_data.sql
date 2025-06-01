-- This file contains SQL statements to insert sample data into the airline database.
-- It provides example records for testing and development purposes.

INSERT INTO AIRPLANES (AIRCRAFT_REGISTRATION, BUILD_DATE, SEATS) VALUES
('A123', '2010-05-15', 150),
('B456', '2015-08-20', 300),
('C789', '2005-03-10', 200),
('D012', '2018-11-30', 400);

INSERT INTO PASSENGERS (ID, NAME, BIRTH_DATE, TELEPHONE) VALUES
(1, 'John Doe', '1975-06-15', '123-456-7890'),
(2, 'Jane Smith', '1985-09-25', '098-765-4321'),
(3, 'Alice Johnson', '2001-12-05', '555-123-4567'),
(4, 'Bob Brown', '1990-01-20', '444-987-6543');

INSERT INTO ROUTES (ROUTE_CODE, ORIGIN, DESTINATION, PRICE) VALUES
('R7203', 'New York', 'Toronto', 500),
('R7204', 'Los Angeles', 'Paris', 1200),
('R7205', 'Chicago', 'London', 800),
('R7206', 'Miami', 'Madrid', 600);

INSERT INTO TICKETS (TICKET_ID, PASSENGER_ID, ROUTE_CODE, AIRCRAFT_ID, FLIGHT_DATE) VALUES
(1, 1, 'R7203', 'A123', '2023-01-15'),
(2, 2, 'R7204', 'B456', '2023-02-20'),
(3, 3, 'R7205', 'C789', '2023-03-25'),
(4, 4, 'R7206', 'D012', '2023-04-30');