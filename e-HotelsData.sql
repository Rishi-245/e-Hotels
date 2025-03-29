SET search_path = "e-HotelsSchema";

-- Inserting Hotel Chains
INSERT INTO Hotel_Chain (chain_id, name, central_office_address, num_hotels) VALUES
(1, 'Hilton', '777 Hilton St, Chicago, IL, USA', 8),
(2, 'Marriott', '800 Marriott Dr, Bethesda, MD, USA', 8),
(3, 'Hyatt', '900 Hyatt Blvd, Chicago, IL, USA', 8),
(4, 'Accor', '101 Accor Plaza, Paris, France', 8),
(5, 'Wyndham', '105 Wyndham Rd, Parsippany, NJ, USA', 8);

-- Inserting contact phone numbers for hotel chains
INSERT INTO Inst_phone_chain (chain_id, contact_phone) VALUES
(1, '800-555-1234'),
(1, '800-555-5678'),
(2, '800-555-9101'),
(2, '800-555-1122'),
(3, '800-555-3344'),
(3, '800-555-5566'),
(4, '800-555-7788'),
(4, '800-555-9900'),
(5, '800-555-2233'),
(5, '800-555-4455');

-- Inserting contact emails for hotel chains
INSERT INTO Inst_email_chain (chain_id, contact_email) VALUES
(1, 'info@hilton.com'),
(1, 'support@hilton.com'),
(2, 'info@marriott.com'),
(2, 'support@marriott.com'),
(3, 'info@hyatt.com'),
(3, 'support@hyatt.com'),
(4, 'info@accor.com'),
(4, 'support@accor.com'),
(5, 'info@wyndham.com'),
(5, 'support@wyndham.com');

-- Inserting Hotels
-- Chain 1: Hilton
INSERT INTO Hotel (chain_id, hotel_id, category, num_rooms, hotel_address, hotel_email) VALUES
(1, 1, '5', 10, '123 Main St, Toronto', 'hilton.downtown@hilton.com'),
(1, 2, '4', 8, '456 Airport Rd, Toronto', 'hilton.airport@hilton.com'),
(1, 3, '3', 12, '789 Maple Ave, Montreal', 'hilton.garden@hilton.com'),
(1, 4, '5', 7, '321 Ocean Dr, Vancouver', 'hilton.bayfront@hilton.com'),
(1, 5, '4', 9, '555 Mountain Rd, Calgary', 'hilton.grand@hilton.com'),
(1, 6, '2', 10, '111 Parliament St, Ottawa', 'hilton.express@hilton.com'),
(1, 7, '1', 15, '222 Jasper Ave, Edmonton', 'hilton.suites@hilton.com'),
(1, 8, '3', 13, '333 River Rd, Quebec City', 'hilton.luxury@hilton.com');

-- Chain 2: Marriott
INSERT INTO Hotel (chain_id, hotel_id, category, num_rooms, hotel_address, hotel_email) VALUES
(2, 9, '4', 14, '777 Queen St, Toronto', 'marriott.downtown@marriott.com'),
(2, 10, '3', 12, '888 Airport Rd, Montreal', 'marriott.airport@marriott.com'),
(2, 11, '1', 8, '999 West St, Vancouver', 'marriott.grand@marriott.com'),
(2, 12, '2', 11, '1010 South Ave, Calgary', 'marriott.express@marriott.com'),
(2, 13, '5', 7, '1111 Jasper St, Edmonton', 'marriott.elite@marriott.com'),
(2, 14, '4', 9, '1212 Bank St, Ottawa', 'marriott.suites@marriott.com'),
(2, 15, '5', 11, '1313 Chateau Dr, Quebec City', 'marriott.palace@marriott.com'),
(2, 16, '4', 10, '1414 Ocean Rd, Halifax', 'marriott.beachfront@marriott.com');

-- Chain 3: Hyatt
INSERT INTO Hotel (chain_id, hotel_id, category, num_rooms, hotel_address, hotel_email) VALUES
(3, 17, '4', 6, '555 Bay St, Toronto', 'hyatt.regency@hyatt.com'),
(3, 18, '2', 7, '666 Saint-Catherine St, Montreal', 'hyatt.place@hyatt.com'),
(3, 19, '5', 15, '777 Georgia St, Vancouver', 'hyatt.grand@hyatt.com'),
(3, 20, '1', 12, '888 Sunset Blvd, Calgary', 'hyatt.beach@hyatt.com'),
(3, 21, '5', 8, '999 Rideau St, Ottawa', 'hyatt.regency@hyatt.com'),
(3, 22, '3', 15, '1010 Kingsway Ave, Edmonton', 'hyatt.house@hyatt.com'),
(3, 23, '4', 7, '1111 Old Quebec Rd, Quebec City', 'hyatt.centric@hyatt.com'),
(3, 24, '5', 11, '1212 Harbour Blvd, Halifax', 'hyatt.grand@hyatt.com');

-- Chain 4: Accor
INSERT INTO Hotel (chain_id, hotel_id, category, num_rooms, hotel_address, hotel_email) VALUES
(4, 25, '2', 10, '555 Front St, Toronto', 'ibis.styles@accor.com'),
(4, 26, '4', 12, '666 St-Denis St, Montreal', 'mercure@accor.com'),
(4, 27, '5', 14, '777 Robson St, Vancouver', 'novotel@accor.com'),
(4, 28, '5', 8, '888 Centre St, Calgary', 'sofitel@accor.com'),
(4, 29, '2', 11, '999 Wellington St, Ottawa', 'ibis@accor.com'),
(4, 30, '3', 16, '1111 Jasper Ave, Edmonton', 'mercure@accor.com'),
(4, 31, '5', 15, '1212 Grande Allée, Quebec City', 'novotel@accor.com'),
(4, 32, '4', 9, '1313 Barrington St, Halifax', 'sofitel@accor.com');

-- Chain 5: Wyndham
INSERT INTO Hotel (chain_id, hotel_id, category, num_rooms, hotel_address, hotel_email) VALUES
(5, 33, '4', 14, '222 Yonge St, Toronto', 'wyndham.downtown@wyndham.com'),
(5, 34, '2', 12, '333 Peel St, Montreal', 'wyndham.garden@wyndham.com'),
(5, 35, '5', 8, '444 Main St, Vancouver', 'wyndham.grand@wyndham.com'),
(5, 36, '3', 11, '555 17th Ave, Calgary', 'wyndham.suites@wyndham.com'),
(5, 37, '2', 14, '666 Elgin St, Ottawa', 'wyndham.express@wyndham.com'),
(5, 38, '1', 9, '777 104th St, Edmonton', 'wyndham.luxury@wyndham.com'),
(5, 39, '5', 7, '888 Sainte-Anne St, Quebec City', 'wyndham.beachfront@wyndham.com'),
(5, 40, '4', 15, '999 Prince St, Halifax', 'wyndham.plaza@wyndham.com');

-- Inserting Room Data for Hilton Hotel Chain
-- Hotel 1: Hilton Downtown
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(1, 101, TRUE, 200.00, 2, 'Sea View'),
(1, 102, FALSE, 150.00, 1, 'Mountain View'),
(1, 103, TRUE, 250.00, 3, 'Sea View'),
(1, 104, FALSE, 180.00, 2, 'Mountain View'),
(1, 105, TRUE, 220.00, 4, 'Sea View');

-- Hotel 2: Hilton Beachside
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(2, 201, TRUE, 210.00, 2, 'Sea View'),
(2, 202, FALSE, 160.00, 1, 'Mountain View'),
(2, 203, TRUE, 240.00, 3, 'Sea View'),
(2, 204, FALSE, 190.00, 2, 'Mountain View'),
(2, 205, TRUE, 230.00, 4, 'Sea View');

-- Hotel 3: Hilton Riverside
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(3, 301, TRUE, 220.00, 2, 'Sea View'),
(3, 302, FALSE, 170.00, 1, 'Mountain View'),
(3, 303, TRUE, 260.00, 3, 'Sea View'),
(3, 304, FALSE, 200.00, 2, 'Mountain View'),
(3, 305, TRUE, 240.00, 4, 'Sea View');

-- Hotel 4: Hilton Midtown
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(4, 401, TRUE, 230.00, 2, 'Sea View'),
(4, 402, FALSE, 180.00, 1, 'Mountain View'),
(4, 403, TRUE, 270.00, 3, 'Sea View'),
(4, 404, FALSE, 210.00, 2, 'Mountain View'),
(4, 405, TRUE, 250.00, 4, 'Sea View');

-- Hotel 5: Hilton Garden Inn
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(5, 501, TRUE, 210.00, 2, 'Sea View'),
(5, 502, FALSE, 160.00, 1, 'Mountain View'),
(5, 503, TRUE, 240.00, 3, 'Sea View'),
(5, 504, FALSE, 190.00, 2, 'Mountain View'),
(5, 505, TRUE, 230.00, 4, 'Sea View');

-- Hotel 6: Hilton Plaza
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(6, 601, TRUE, 220.00, 2, 'Sea View'),
(6, 602, FALSE, 170.00, 1, 'Mountain View'),
(6, 603, TRUE, 260.00, 3, 'Sea View'),
(6, 604, FALSE, 200.00, 2, 'Mountain View'),
(6, 605, TRUE, 240.00, 4, 'Sea View');

-- Hotel 7: Hilton Lakeside
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(7, 701, TRUE, 230.00, 2, 'Sea View'),
(7, 702, FALSE, 180.00, 1, 'Mountain View'),
(7, 703, TRUE, 270.00, 3, 'Sea View'),
(7, 704, FALSE, 210.00, 2, 'Mountain View'),
(7, 705, TRUE, 250.00, 4, 'Sea View');

-- Hotel 8: Hilton Oceanfront
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(8, 801, TRUE, 210.00, 2, 'Sea View'),
(8, 802, FALSE, 160.00, 1, 'Mountain View'),
(8, 803, TRUE, 240.00, 3, 'Sea View'),
(8, 804, FALSE, 190.00, 2, 'Mountain View'),
(8, 805, TRUE, 230.00, 4, 'Sea View');


-- Inserting Room Data for Marriott Hotel Chain
-- Hotel 1: Marriott Grand
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(9, 101, TRUE, 220.00, 2, 'Sea View'),
(9, 102, FALSE, 170.00, 1, 'Mountain View'),
(9, 103, TRUE, 250.00, 3, 'Sea View'),
(9, 104, FALSE, 200.00, 2, 'Mountain View'),
(9, 105, TRUE, 240.00, 4, 'Sea View');

-- Hotel 2: Marriott Bayview
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(10, 201, TRUE, 230.00, 2, 'Sea View'),
(10, 202, FALSE, 180.00, 1, 'Mountain View'),
(10, 203, TRUE, 260.00, 3, 'Sea View'),
(10, 204, FALSE, 210.00, 2, 'Mountain View'),
(10, 205, TRUE, 250.00, 4, 'Sea View');

-- Hotel 3: Marriott Lakeside
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(11, 301, TRUE, 240.00, 2, 'Sea View'),
(11, 302, FALSE, 190.00, 1, 'Mountain View'),
(11, 303, TRUE, 270.00, 3, 'Sea View'),
(11, 304, FALSE, 220.00, 2, 'Mountain View'),
(11, 305, TRUE, 260.00, 4, 'Sea View');

-- Hotel 4: Marriott Oceanfront
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(12, 401, TRUE, 250.00, 2, 'Sea View'),
(12, 402, FALSE, 200.00, 1, 'Mountain View'),
(12, 403, TRUE, 280.00, 3, 'Sea View'),
(12, 404, FALSE, 230.00, 2, 'Mountain View'),
(12, 405, TRUE, 270.00, 4, 'Sea View');

-- Hotel 5: Marriott Resort
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(13, 501, TRUE, 240.00, 2, 'Sea View'),
(13, 502, FALSE, 190.00, 1, 'Mountain View'),
(13, 503, TRUE, 270.00, 3, 'Sea View'),
(13, 504, FALSE, 220.00, 2, 'Mountain View'),
(13, 505, TRUE, 260.00, 4, 'Sea View');

-- Hotel 6: Marriott Plaza
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(14, 601, TRUE, 230.00, 2, 'Sea View'),
(14, 602, FALSE, 180.00, 1, 'Mountain View'),
(14, 603, TRUE, 260.00, 3, 'Sea View'),
(14, 604, FALSE, 210.00, 2, 'Mountain View'),
(14, 605, TRUE, 240.00, 4, 'Sea View');

-- Hotel 7: Marriott Cityview
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(15, 701, TRUE, 220.00, 2, 'Sea View'),
(15, 702, FALSE, 170.00, 1, 'Mountain View'),
(15, 703, TRUE, 250.00, 3, 'Sea View'),
(15, 704, FALSE, 200.00, 2, 'Mountain View'),
(15, 705, TRUE, 230.00, 4, 'Sea View');

-- Hotel 8: Marriott Highlands
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(16, 801, TRUE, 240.00, 2, 'Sea View'),
(16, 802, FALSE, 190.00, 1, 'Mountain View'),
(16, 803, TRUE, 270.00, 3, 'Sea View'),
(16, 804, FALSE, 220.00, 2, 'Mountain View'),
(16, 805, TRUE, 260.00, 4, 'Sea View');


-- Inserting Room Data for Hyatt Hotel Chain
-- Hotel 1: Hyatt Regency
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(17, 101, TRUE, 230.00, 2, 'Sea View'),
(17, 102, FALSE, 180.00, 1, 'Mountain View'),
(17, 103, TRUE, 250.00, 3, 'Sea View'),
(17, 104, FALSE, 200.00, 2, 'Mountain View'),
(17, 105, TRUE, 240.00, 4, 'Sea View');

-- Hotel 2: Hyatt Oceanview
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(18, 201, TRUE, 240.00, 2, 'Sea View'),
(18, 202, FALSE, 190.00, 1, 'Mountain View'),
(18, 203, TRUE, 270.00, 3, 'Sea View'),
(18, 204, FALSE, 220.00, 2, 'Mountain View'),
(18, 205, TRUE, 250.00, 4, 'Sea View');

-- Hotel 3: Hyatt Towers
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(19, 301, TRUE, 220.00, 2, 'Sea View'),
(19, 302, FALSE, 170.00, 1, 'Mountain View'),
(19, 303, TRUE, 240.00, 3, 'Sea View'),
(19, 304, FALSE, 200.00, 2, 'Mountain View'),
(19, 305, TRUE, 230.00, 4, 'Sea View');

-- Hotel 4: Hyatt Grand
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(20, 401, TRUE, 250.00, 2, 'Sea View'),
(20, 402, FALSE, 200.00, 1, 'Mountain View'),
(20, 403, TRUE, 280.00, 3, 'Sea View'),
(20, 404, FALSE, 230.00, 2, 'Mountain View'),
(20, 405, TRUE, 260.00, 4, 'Sea View');

-- Hotel 5: Hyatt Beachfront
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(21, 501, TRUE, 240.00, 2, 'Sea View'),
(21, 502, FALSE, 190.00, 1, 'Mountain View'),
(21, 503, TRUE, 270.00, 3, 'Sea View'),
(21, 504, FALSE, 220.00, 2, 'Mountain View'),
(21, 505, TRUE, 250.00, 4, 'Sea View');

-- Hotel 6: Hyatt Resort
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(22, 601, TRUE, 230.00, 2, 'Sea View'),
(22, 602, FALSE, 180.00, 1, 'Mountain View'),
(22, 603, TRUE, 260.00, 3, 'Sea View'),
(22, 604, FALSE, 210.00, 2, 'Mountain View'),
(22, 605, TRUE, 240.00, 4, 'Sea View');

-- Hotel 7: Hyatt Plaza
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(23, 701, TRUE, 220.00, 2, 'Sea View'),
(23, 702, FALSE, 170.00, 1, 'Mountain View'),
(23, 703, TRUE, 250.00, 3, 'Sea View'),
(23, 704, FALSE, 200.00, 2, 'Mountain View'),
(23, 705, TRUE, 230.00, 4, 'Sea View');

-- Hotel 8: Hyatt Highlands
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(24, 801, TRUE, 240.00, 2, 'Sea View'),
(24, 802, FALSE, 190.00, 1, 'Mountain View'),
(24, 803, TRUE, 270.00, 3, 'Sea View'),
(24, 804, FALSE, 220.00, 2, 'Mountain View'),
(24, 805, TRUE, 260.00, 4, 'Sea View');


-- Inserting Room Data for Accor Hotel Chain
-- Hotel 1: Accor Paris
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(25, 101, TRUE, 210.00, 2, 'Sea View'),
(25, 102, FALSE, 160.00, 1, 'Mountain View'),
(25, 103, TRUE, 230.00, 3, 'Sea View'),
(25, 104, FALSE, 180.00, 2, 'Mountain View'),
(25, 105, TRUE, 220.00, 4, 'Sea View');

-- Hotel 2: Accor Beachfront
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(26, 201, TRUE, 230.00, 2, 'Sea View'),
(26, 202, FALSE, 180.00, 1, 'Mountain View'),
(26, 203, TRUE, 250.00, 3, 'Sea View'),
(26, 204, FALSE, 210.00, 2, 'Mountain View'),
(26, 205, TRUE, 240.00, 4, 'Sea View');

-- Hotel 3: Accor Mountains
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(27, 301, TRUE, 220.00, 2, 'Sea View'),
(27, 302, FALSE, 170.00, 1, 'Mountain View'),
(27, 303, TRUE, 240.00, 3, 'Sea View'),
(27, 304, FALSE, 200.00, 2, 'Mountain View'),
(27, 305, TRUE, 230.00, 4, 'Sea View');

-- Hotel 4: Accor Grand
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(28, 401, TRUE, 240.00, 2, 'Sea View'),
(28, 402, FALSE, 190.00, 1, 'Mountain View'),
(28, 403, TRUE, 260.00, 3, 'Sea View'),
(28, 404, FALSE, 210.00, 2, 'Mountain View'),
(28, 405, TRUE, 250.00, 4, 'Sea View');

-- Hotel 5: Accor Resorts
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(29, 501, TRUE, 240.00, 2, 'Sea View'),
(29, 502, FALSE, 190.00, 1, 'Mountain View'),
(29, 503, TRUE, 270.00, 3, 'Sea View'),
(29, 504, FALSE, 220.00, 2, 'Mountain View'),
(29, 505, TRUE, 260.00, 4, 'Sea View');

-- Hotel 6: Accor City View
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(30, 601, TRUE, 230.00, 2, 'Sea View'),
(30, 602, FALSE, 180.00, 1, 'Mountain View'),
(30, 603, TRUE, 250.00, 3, 'Sea View'),
(30, 604, FALSE, 210.00, 2, 'Mountain View'),
(30, 605, TRUE, 240.00, 4, 'Sea View');

-- Hotel 7: Accor Plaza
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(31, 701, TRUE, 220.00, 2, 'Sea View'),
(31, 702, FALSE, 170.00, 1, 'Mountain View'),
(31, 703, TRUE, 240.00, 3, 'Sea View'),
(31, 704, FALSE, 200.00, 2, 'Mountain View'),
(31, 705, TRUE, 230.00, 4, 'Sea View');

-- Hotel 8: Accor Skyview
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(32, 801, TRUE, 240.00, 2, 'Sea View'),
(32, 802, FALSE, 190.00, 1, 'Mountain View'),
(32, 803, TRUE, 270.00, 3, 'Sea View'),
(32, 804, FALSE, 220.00, 2, 'Mountain View'),
(32, 805, TRUE, 260.00, 4, 'Sea View');


-- Inserting Room Data for Wyndham Hotel Chain
-- Hotel 1: Wyndham Grand
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(33, 101, TRUE, 220.00, 2, 'Sea View'),
(33, 102, FALSE, 170.00, 1, 'Mountain View'),
(33, 103, TRUE, 240.00, 3, 'Sea View'),
(33, 104, FALSE, 200.00, 2, 'Mountain View'),
(33, 105, TRUE, 230.00, 4, 'Sea View');

-- Hotel 2: Wyndham Beach Resort
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(34, 201, TRUE, 240.00, 2, 'Sea View'),
(34, 202, FALSE, 190.00, 1, 'Mountain View'),
(34, 203, TRUE, 260.00, 3, 'Sea View'),
(34, 204, FALSE, 210.00, 2, 'Mountain View'),
(34, 205, TRUE, 250.00, 4, 'Sea View');

-- Hotel 3: Wyndham Skyline
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(35, 301, TRUE, 230.00, 2, 'Sea View'),
(35, 302, FALSE, 180.00, 1, 'Mountain View'),
(35, 303, TRUE, 250.00, 3, 'Sea View'),
(35, 304, FALSE, 200.00, 2, 'Mountain View'),
(35, 305, TRUE, 240.00, 4, 'Sea View');

-- Hotel 4: Wyndham Mountain Lodge
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(36, 401, TRUE, 250.00, 2, 'Sea View'),
(36, 402, FALSE, 200.00, 1, 'Mountain View'),
(36, 403, TRUE, 270.00, 3, 'Sea View'),
(36, 404, FALSE, 220.00, 2, 'Mountain View'),
(36, 405, TRUE, 260.00, 4, 'Sea View');

-- Hotel 5: Wyndham Palace
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(37, 501, TRUE, 230.00, 2, 'Sea View'),
(37, 502, FALSE, 180.00, 1, 'Mountain View'),
(37, 503, TRUE, 240.00, 3, 'Sea View'),
(37, 504, FALSE, 200.00, 2, 'Mountain View'),
(37, 505, TRUE, 250.00, 4, 'Sea View');

-- Hotel 6: Wyndham Resort
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(38, 601, TRUE, 240.00, 2, 'Sea View'),
(38, 602, FALSE, 190.00, 1, 'Mountain View'),
(38, 603, TRUE, 260.00, 3, 'Sea View'),
(38, 604, FALSE, 210.00, 2, 'Mountain View'),
(38, 605, TRUE, 250.00, 4, 'Sea View');

-- Hotel 7: Wyndham Oceanfront
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(39, 701, TRUE, 230.00, 2, 'Sea View'),
(39, 702, FALSE, 180.00, 1, 'Mountain View'),
(39, 703, TRUE, 240.00, 3, 'Sea View'),
(39, 704, FALSE, 200.00, 2, 'Mountain View'),
(39, 705, TRUE, 230.00, 4, 'Sea View');

-- Hotel 8: Wyndham International
INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) VALUES
(40, 801, TRUE, 220.00, 2, 'Sea View'),
(40, 802, FALSE, 170.00, 1, 'Mountain View'),
(40, 803, TRUE, 240.00, 3, 'Sea View'),
(40, 804, FALSE, 200.00, 2, 'Mountain View'),
(40, 805, TRUE, 230.00, 4, 'Sea View');


-- Inserting Phone Numbers for Hilton Hotel Chain
INSERT INTO Inst_phone_hotel (hotel_id, hotel_phone) VALUES
(1, '416-555-1001'),
(2, '416-555-1002'),
(3, '416-555-1003'),
(4, '416-555-1004'),
(5, '416-555-1005'),
(6, '416-555-1006'),
(7, '416-555-1007'),
(8, '416-555-1008');

-- Inserting Phone Numbers for Mariott Hotel Chain
INSERT INTO Inst_phone_hotel (hotel_id, hotel_phone) VALUES
(9, '416-555-2001'),
(10, '416-555-2002'),
(11, '416-555-2003'),
(12, '416-555-2004'),
(13, '416-555-2005'),
(14, '416-555-2006'),
(15, '416-555-2007'),
(16, '416-555-2008');

-- Inserting Phone Numbers for Hyatt Hotel Chain
INSERT INTO Inst_phone_hotel (hotel_id, hotel_phone) VALUES
(17, '416-555-3001'),
(18, '416-555-3002'),
(19, '416-555-3003'),
(20, '416-555-3004'),
(21, '416-555-3005'),
(22, '416-555-3006'),
(23, '416-555-3007'),
(24, '416-555-3008');

-- Inserting Phone Numbers for Accor Hotel Chain
INSERT INTO Inst_phone_hotel (hotel_id, hotel_phone) VALUES
(25, '416-555-4001'),
(26, '416-555-4002'),
(27, '416-555-4003'),
(28, '416-555-4004'),
(29, '416-555-4005'),
(30, '416-555-4006'),
(31, '416-555-4007'),
(32, '416-555-4008');

-- Inserting Phone Numbers for Wyndham Hotel Chain
INSERT INTO Inst_phone_hotel (hotel_id, hotel_phone) VALUES
(33, '416-555-5001'),
(34, '416-555-5002'),
(35, '416-555-5003'),
(36, '416-555-5004'),
(37, '416-555-5005'),
(38, '416-555-5006'),
(39, '416-555-5007'),
(40, '416-555-5008');


-- Inserting Damages for Hilton Hotel Chain
INSERT INTO Inst_damages (hotel_id, room_number, damages) VALUES
(1, 101, 'Cracked window'),
(1, 102, 'Leaking sink'),
(2, 201, 'Stained carpet'),
(2, 202, 'Broken door handle'),
(3, 301, 'Damaged air conditioning'),
(3, 302, 'Worn-out mattress'),
(4, 401, 'Burnt carpet'),
(4, 402, 'Leaking shower'),
(5, 501, 'Scratched walls'),
(5, 502, 'Clogged drain');

-- Inserting Damages for Mariott Hotel Chain
INSERT INTO Inst_damages (hotel_id, room_number, damages) VALUES
(9, 101, 'Leaking faucet'),
(9, 102, 'Cracked mirror'),
(10, 201, 'Broken TV'),
(10, 202, 'Worn-out curtains'),
(11, 301, 'Chipped tile'),
(11, 302, 'Loose faucet'),
(12, 401, 'Broken bed frame'),
(12, 402, 'Leaking ceiling'),
(13, 501, 'Stained chair'),
(13, 502, 'Worn-out carpet');

-- Inserting Damages for Hyatt Hotel Chain
INSERT INTO Inst_damages (hotel_id, room_number, damages) VALUES
(17, 101, 'Broken air conditioner'),
(17, 102, 'Damaged door lock'),
(18, 201, 'Cracked tiles'),
(18, 202, 'Leaking toilet'),
(19, 301, 'Worn-out sofa'),
(19, 302, 'Stained curtains'),
(20, 401, 'Broken window blind'),
(20, 402, 'Clogged shower drain'),
(21, 501, 'Worn-out mattress'),
(21, 502, 'Loose bathroom tiles');

-- Inserting Damages for Accor Hotel Chain
INSERT INTO Inst_damages (hotel_id, room_number, damages) VALUES
(25, 101, 'Broken chair'),
(25, 102, 'Scratched floor'),
(26, 201, 'Leaking roof'),
(26, 202, 'Broken lamp'),
(27, 301, 'Cracked sink'),
(27, 302, 'Stained carpet'),
(28, 401, 'Clogged toilet'),
(28, 402, 'Broken fridge'),
(29, 501, 'Leaking window'),
(29, 502, 'Broken bed');

-- Inserting Damages for Wyndham Hotel Chain
INSERT INTO Inst_damages (hotel_id, room_number, damages) VALUES
(33, 101, 'Stained mattress'),
(33, 102, 'Broken bedside table'),
(34, 201, 'Leaking shower head'),
(34, 202, 'Cracked wall'),
(35, 301, 'Broken dresser'),
(35, 302, 'Clogged sink'),
(36, 401, 'Worn-out curtains'),
(36, 402, 'Broken air conditioner'),
(37, 501, 'Cracked floor tile'),
(37, 502, 'Leaking faucet');


-- Inserting Amenities for Hilton Hotel Chain
INSERT INTO Inst_amenities (hotel_id, room_number, amenities) VALUES
(1, 101, 'Free Wi-Fi, Air Conditioning, Mini-bar'),
(1, 102, 'TV, Air Conditioning'),
(2, 201, 'Free Wi-Fi, Sea-view Balcony'),
(2, 202, 'TV, Mini-bar, Sea-view Balcony'),
(3, 301, 'Free Wi-Fi, Mountain-view Balcony'),
(3, 302, 'Air Conditioning, TV'),
(4, 401, 'Free Wi-Fi, Sea-view Balcony'),
(4, 402, 'TV, Mini-bar'),
(5, 501, 'Air Conditioning, Mini-bar, Mountain-view Balcony'),
(5, 502, 'Free Wi-Fi, TV');

-- Inserting Amenities for Mariott Hotel Chain
INSERT INTO Inst_amenities (hotel_id, room_number, amenities) VALUES
(9, 101, 'Free Wi-Fi, TV, Sea-view Balcony'),
(9, 102, 'Air Conditioning, Mini-bar'),
(10, 201, 'Free Wi-Fi, Mountain-view Balcony'),
(10, 202, 'TV, Air Conditioning'),
(11, 301, 'Mini-bar, Free Wi-Fi, TV'),
(11, 302, 'Sea-view Balcony, Air Conditioning'),
(12, 401, 'Free Wi-Fi, Mini-bar, TV'),
(12, 402, 'Mountain-view Balcony, Air Conditioning'),
(13, 501, 'Sea-view Balcony, TV'),
(13, 502, 'Air Conditioning, Free Wi-Fi');

-- Inserting Amenities for Hyatt Hotel Chain
INSERT INTO Inst_amenities (hotel_id, room_number, amenities) VALUES
(17, 101, 'Free Wi-Fi, Mini-bar, Air Conditioning'),
(17, 102, 'TV, Sea-view Balcony'),
(18, 201, 'Free Wi-Fi, Mountain-view Balcony'),
(18, 202, 'TV, Air Conditioning'),
(19, 301, 'Mini-bar, Free Wi-Fi, TV'),
(19, 302, 'Mountain-view Balcony, Sea-view Balcony'),
(20, 401, 'Free Wi-Fi, Mini-bar, Air Conditioning'),
(20, 402, 'TV, Mountain-view Balcony'),
(21, 501, 'Free Wi-Fi, TV, Sea-view Balcony'),
(21, 502, 'Air Conditioning, Mini-bar');

-- Inserting Amenities for Accor Hotel Chain
INSERT INTO Inst_amenities (hotel_id, room_number, amenities) VALUES
(25, 101, 'Free Wi-Fi, TV, Mini-bar'),
(25, 102, 'Air Conditioning, Sea-view Balcony'),
(26, 201, 'Free Wi-Fi, Mountain-view Balcony'),
(26, 202, 'TV, Mini-bar'),
(27, 301, 'Air Conditioning, Free Wi-Fi, TV'),
(27, 302, 'Mountain-view Balcony, Sea-view Balcony'),
(28, 401, 'Mini-bar, TV, Air Conditioning'),
(28, 402, 'Free Wi-Fi, Sea-view Balcony'),
(29, 501, 'Free Wi-Fi, Mini-bar, Mountain-view Balcony'),
(29, 502, 'Air Conditioning, TV');

-- Inserting Amenities for Wyndham Hotel Chain
INSERT INTO Inst_amenities (hotel_id, room_number, amenities) VALUES
(33, 101, 'Free Wi-Fi, Air Conditioning, TV'),
(33, 102, 'Mini-bar, Mountain-view Balcony'),
(34, 201, 'Free Wi-Fi, Sea-view Balcony'),
(34, 202, 'TV, Air Conditioning'),
(35, 301, 'Free Wi-Fi, Mini-bar, Sea-view Balcony'),
(35, 302, 'Air Conditioning, Mountain-view Balcony'),
(36, 401, 'TV, Free Wi-Fi, Mini-bar'),
(36, 402, 'Sea-view Balcony, Air Conditioning'),
(37, 501, 'Mini-bar, Free Wi-Fi, Mountain-view Balcony'),
(37, 502, 'Air Conditioning, TV');

-- Inserting Sample Customer Data
INSERT INTO Customer (customer_id, f_name, m_name, l_name, address, type_id, reg_date) VALUES
(1, 'John', 'Doe', 'Smith', '123 Maple Street, Toronto, ON, M1A 2B3', 'SSN', '2025-03-01'),
(2, 'Jane', 'Alice', 'Brown', '456 Oak Avenue, Ottawa, ON, K1A 0B1', 'Driving Licence', '2025-03-05'),
(3, 'Michael', 'James', 'Wilson', '789 Pine Road, Vancouver, BC, V5K 3L2', 'SIN', '2025-03-10');

-- Sample Employee data
INSERT INTO Employee (SIN, hotel_id, f_name, m_name, l_name, address, role)
VALUES 
('123456789', 1, 'John', 'A.', 'Doe', '123 Main St, Cityville', 'Manager'),
('987654321', 1, 'Jane', 'B.', 'Smith', '456 Oak Rd, Townsville', 'Housekeeper'),
('112233445', 2, 'Michael', 'C.', 'Johnson', '789 Pine Ln, Villagetown', 'Receptionist');

-- Sample Booking data
INSERT INTO Booking (customer_id, SIN, hotel_id, room_number, booking_date, start_date, end_date, status)
VALUES
(1, '123456789', 1, 101, '2025-03-01', '2025-04-01', '2025-04-05', 'Confirmed'),
(2, '987654321', 1, 102, '2025-03-05', '2025-04-10', '2025-04-12', 'Pending'),
(3, '112233445', 2, 201, '2025-03-08', '2025-04-15', '2025-04-20', 'Confirmed');

-- Sample Renting data
INSERT INTO Renting (customer_id, SIN, hotel_id, room_number, renting_date, check_out_date, status)
VALUES
(1, '123456789', 1, 101, '2025-04-01', '2025-04-05', 'Completed'),
(2, '987654321', 1, 102, '2025-04-10', '2025-04-12', 'Active'),
(3, '112233445', 2, 201, '2025-04-15', '2025-04-20', 'Active');

