-- Drop existing tables to prevent duplication (run only once)
DROP TABLE IF EXISTS Inst_damages, Inst_amenities, Employee, Booking, Renting, Checked_In, Customer, Room, Hotel, Hotel_Chain CASCADE;

-- Hotel Chain Table
CREATE TABLE Hotel_Chain (
    chain_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    num_hotels INT DEFAULT 0
);

-- Hotel Table with added category
CREATE TABLE Hotel (
    hotel_id SERIAL PRIMARY KEY,
    chain_id INT REFERENCES Hotel_Chain(chain_id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    rating DECIMAL(2,1) CHECK (rating >= 0 AND rating <= 5),
    num_rooms INT NOT NULL,
    category VARCHAR(50) CHECK (category IN ('Budget', 'Premium', 'Luxury'))
);

-- Room Table
CREATE TABLE Room (
    room_id SERIAL PRIMARY KEY,
    hotel_id INT REFERENCES Hotel(hotel_id) ON DELETE CASCADE,
    room_number VARCHAR(10) NOT NULL,
    type VARCHAR(50) CHECK (type IN ('Single', 'Double', 'Suite')),
    price_per_night DECIMAL(10,2) NOT NULL
);

-- Customer Table with phone number
CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    f_name VARCHAR(100),
    l_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(15) UNIQUE
);

-- Table for tracking room damages
CREATE TABLE Inst_damages (
    damage_id SERIAL PRIMARY KEY,
    room_id INT REFERENCES Room(room_id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    repair_cost DECIMAL(10,2) NOT NULL
);

-- Table for room amenities
CREATE TABLE Inst_amenities (
    amenity_id SERIAL PRIMARY KEY,
    room_id INT REFERENCES Room(room_id) ON DELETE CASCADE,
    amenity VARCHAR(100) NOT NULL
);

-- Employee Table with phone number
CREATE TABLE Employee (
    employee_id SERIAL PRIMARY KEY,
    hotel_id INT REFERENCES Hotel(hotel_id) ON DELETE CASCADE,
    f_name VARCHAR(100),
    m_name VARCHAR(100),
    l_name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10,2),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(15) UNIQUE
);

-- Booking Table (for customer reservations)
CREATE TABLE Booking (
    booking_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customer(customer_id) ON DELETE CASCADE,
    room_id INT REFERENCES Room(room_id) ON DELETE CASCADE,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status VARCHAR(50) CHECK (status IN ('Pending', 'Confirmed', 'Cancelled'))
);

-- Renting Table (for checking in guests)
CREATE TABLE Renting (
    rent_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customer(customer_id) ON DELETE CASCADE,
    room_id INT REFERENCES Room(room_id) ON DELETE CASCADE,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    payment_status VARCHAR(50) CHECK (payment_status IN ('Paid', 'Pending'))
);

-- Checked-In Table (to link bookings to actual stays)
CREATE TABLE Checked_In (
    checkin_id SERIAL PRIMARY KEY,
    booking_id INT REFERENCES Booking(booking_id) ON DELETE CASCADE,
    rent_id INT REFERENCES Renting(rent_id) ON DELETE CASCADE
);

-- Insert Hotel Chains
INSERT INTO Hotel_Chain (name, num_hotels) VALUES
('Hilton', 8),
('Marriott', 8),
('Hyatt', 0),
('Accor', 0),
('Wyndham', 0);

-- Insert Hotels (8 per chain, different cities, ratings, and categories)
INSERT INTO Hotel (chain_id, name, city, address, rating, num_rooms, category) VALUES
-- Hilton Hotels
(1, 'Hilton Downtown', 'Toronto', '123 Main St, Toronto', 4.5, 10, 'Luxury'),
(1, 'Hilton Airport', 'Toronto', '456 Airport Rd, Toronto', 4.0, 15, 'Premium'),
(1, 'Hilton Garden', 'Montreal', '789 Maple Ave, Montreal', 3.8, 12, 'Budget'),
(1, 'Hilton Bayfront', 'Vancouver', '321 Ocean Dr, Vancouver', 4.7, 20, 'Luxury'),
(1, 'Hilton Grand', 'Calgary', '555 Mountain Rd, Calgary', 4.3, 18, 'Premium'),
(1, 'Hilton Express', 'Ottawa', '111 Parliament St, Ottawa', 3.9, 10, 'Budget'),
(1, 'Hilton Suites', 'Edmonton', '222 Jasper Ave, Edmonton', 4.2, 15, 'Luxury'),
(1, 'Hilton Luxury', 'Quebec City', '333 River Rd, Quebec City', 4.8, 22, 'Luxury'),

-- Marriott Hotels
(2, 'Marriott Downtown', 'Toronto', '777 Queen St, Toronto', 4.6, 14, 'Premium'),
(2, 'Marriott Airport', 'Montreal', '888 Airport Rd, Montreal', 4.1, 12, 'Premium'),
(2, 'Marriott Grand', 'Vancouver', '999 West St, Vancouver', 4.7, 18, 'Luxury'),
(2, 'Marriott Express', 'Calgary', '1010 South Ave, Calgary', 3.9, 15, 'Budget'),
(2, 'Marriott Elite', 'Edmonton', '1111 Jasper St, Edmonton', 4.5, 17, 'Luxury'),
(2, 'Marriott Suites', 'Ottawa', '1212 Bank St, Ottawa', 4.3, 12, 'Premium'),
(2, 'Marriott Palace', 'Quebec City', '1313 Chateau Dr, Quebec City', 4.9, 25, 'Luxury'),
(2, 'Marriott Beachfront', 'Halifax', '1414 Ocean Rd, Halifax', 4.8, 20, 'Luxury'),

-- Hyatt Hotels
(3, 'Hyatt Regency', 'Toronto', '555 Bay St, Toronto', 4.3, 16, 'Premium'),
(3, 'Hyatt Place', 'Montreal', '666 Saint-Catherine St, Montreal', 4.1, 14, 'Budget'),
(3, 'Hyatt Grand', 'Vancouver', '777 Georgia St, Vancouver', 4.6, 20, 'Luxury'),
(3, 'Hyatt Beach', 'Calgary', '888 Sunset Blvd, Calgary', 4.0, 12, 'Premium'),
(3, 'Hyatt Regency', 'Ottawa', '999 Rideau St, Ottawa', 4.4, 18, 'Luxury'),
(3, 'Hyatt House', 'Edmonton', '1010 Kingsway Ave, Edmonton', 3.8, 15, 'Budget'),
(3, 'Hyatt Centric', 'Quebec City', '1111 Old Quebec Rd, Quebec City', 4.2, 17, 'Premium'),
(3, 'Hyatt Grand', 'Halifax', '1212 Harbour Blvd, Halifax', 4.5, 22, 'Luxury'),

-- Accor Hotels
(4, 'Ibis Styles', 'Toronto', '555 Front St, Toronto', 3.7, 10, 'Budget'),
(4, 'Mercure', 'Montreal', '666 St-Denis St, Montreal', 4.0, 12, 'Premium'),
(4, 'Novotel', 'Vancouver', '777 Robson St, Vancouver', 4.1, 14, 'Luxury'),
(4, 'Sofitel', 'Calgary', '888 Centre St, Calgary', 4.5, 18, 'Luxury'),
(4, 'Ibis', 'Ottawa', '999 Wellington St, Ottawa', 3.5, 11, 'Budget'),
(4, 'Mercure', 'Edmonton', '1111 Jasper Ave, Edmonton', 4.2, 16, 'Premium'),
(4, 'Novotel', 'Quebec City', '1212 Grande Allée, Quebec City', 4.3, 15, 'Luxury'),
(4, 'Sofitel', 'Halifax', '1313 Barrington St, Halifax', 4.7, 20, 'Premium'),

-- Wyndham Hotels
(5, 'Wyndham Downtown', 'Toronto', '222 Yonge St, Toronto', 4.2, 14, 'Premium'),
(5, 'Wyndham Garden', 'Montreal', '333 Peel St, Montreal', 4.0, 12, 'Budget'),
(5, 'Wyndham Grand', 'Vancouver', '444 Main St, Vancouver', 4.5, 18, 'Luxury'),
(5, 'Wyndham Suites', 'Calgary', '555 17th Ave, Calgary', 4.3, 16, 'Premium'),
(5, 'Wyndham Express', 'Ottawa', '666 Elgin St, Ottawa', 3.8, 14, 'Budget'),
(5, 'Wyndham Luxury', 'Edmonton', '777 104th St, Edmonton', 4.6, 20, 'Luxury'),
(5, 'Wyndham Beachfront', 'Quebec City', '888 Sainte-Anne St, Quebec City', 4.7, 22, 'Luxury'),
(5, 'Wyndham Plaza', 'Halifax', '999 Prince St, Halifax', 4.4, 18, 'Premium');



-- Insert Rooms (each hotel gets 5 rooms with different prices)
INSERT INTO Room (hotel_id, room_number, type, price_per_night) VALUES
-- Hilton Downtown
(1, '101', 'Single', 120.00),
(1, '102', 'Double', 150.00),
(1, '103', 'Suite', 200.00),
(1, '104', 'Single', 110.00),
(1, '105', 'Double', 140.00),

-- Hilton Airport
(2, '201', 'Single', 130.00),
(2, '202', 'Double', 160.00),
(2, '203', 'Suite', 220.00),
(2, '204', 'Single', 115.00),
(2, '205', 'Double', 145.00),

-- Marriott Downtown
(9, '301', 'Single', 125.00),
(9, '302', 'Double', 155.00),
(9, '303', 'Suite', 210.00),
(9, '304', 'Single', 120.00),
(9, '305', 'Double', 150.00);

-- Insert Customers
INSERT INTO Customer (f_name, l_name, email, phone) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321'),
('Robert', 'Brown', 'robert.brown@example.com', '1112223333'),
('Emily', 'Johnson', 'emily.johnson@example.com', '4445556666'),
('Michael', 'Davis', 'michael.davis@example.com', '7778889999');

-- Insert Employees
INSERT INTO Employee (hotel_id, f_name, m_name, l_name, position, salary, email, phone) VALUES
(1, 'Alice', 'Marie', 'White', 'Manager', 60000.00, 'alice.white@hilton.com', '9876543210'),
(2, 'David', 'Lee', 'Anderson', 'Receptionist', 35000.00, 'david.anderson@hilton.com', '1239874560'),
(9, 'Sarah', 'Jane', 'Miller', 'Manager', 62000.00, 'sarah.miller@marriott.com', '5556667777'),
(10, 'Brian', 'Mark', 'Wilson', 'Housekeeping', 30000.00, 'brian.wilson@marriott.com', '3334445555');

-- Insert Amenities
INSERT INTO Inst_amenities (room_id, amenity) VALUES
(1, 'Wi-Fi'),
(1, 'TV'),
(1, 'Mini Bar'),
(2, 'Wi-Fi'),
(2, 'Air Conditioning'),
(3, 'Jacuzzi'),
(3, 'Wi-Fi'),
(3, 'Smart TV');

-- Insert Bookings
INSERT INTO Booking (customer_id, room_id, check_in, check_out, status) VALUES
(1, 1, '2025-04-10', '2025-04-15', 'Confirmed'),
(2, 2, '2025-05-05', '2025-05-10', 'Pending'),
(3, 3, '2025-06-01', '2025-06-07', 'Cancelled'),
(4, 4, '2025-07-15', '2025-07-20', 'Confirmed'),
(5, 5, '2025-08-01', '2025-08-05', 'Confirmed');

-- Insert Renting (checked-in guests)
INSERT INTO Renting (customer_id, room_id, check_in, check_out, payment_status) VALUES
(1, 1, '2025-04-10', '2025-04-15', 'Paid'),
(4, 4, '2025-07-15', '2025-07-20', 'Pending');

-- Insert Checked-In
INSERT INTO Checked_In (booking_id, rent_id) VALUES
(1, 1),
(4, 2);
