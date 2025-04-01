package com.eHotels;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoomService {

    /**
     * Method to get all rooms from the database
     *
     * @return List of rooms
     * @throws Exception when trying to connect to database
     */
    public List<Room> getRooms() throws Exception {
        String sql = "SELECT * FROM Room";
        ConnectionDB db = new ConnectionDB();
        List<Room> rooms = new ArrayList<>();

        try (Connection con = db.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Room room = new Room(
                        rs.getInt("hotel_id"),
                        rs.getInt("room_number"),
                        rs.getBoolean("extendable"),
                        rs.getDouble("price"),
                        rs.getInt("capacity"),
                        rs.getString("view_type")
                );
                rooms.add(room);
            }

            db.close();
            return rooms;
        } catch (Exception e) {
            throw new Exception("Error retrieving rooms: " + e.getMessage());
        }
    }

    /*
    public List<Room> getAvailableRooms(int hotelID, double maxBudget) throws Exception {
        String sql = "SELECT * FROM Room WHERE hotelID = ? AND isAvailable = 1 AND price <= ?";
        ConnectionDB db = new ConnectionDB();
        List<Room> rooms = new ArrayList<>();

        try (Connection con = db.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, hotelID);
            stmt.setDouble(2, maxBudget);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    rooms.add(new Room(
                            rs.getInt("hotel_id"),
                            rs.getInt("room_number"),
                            rs.getBoolean("extendable"),
                            rs.getDouble("price"),
                            rs.getInt("capacity"),
                            rs.getString("view_type")
                    ));
                }
            }

            db.close();
            return rooms;
        } catch (Exception e) {
            throw new Exception("Error retrieving available rooms: " + e.getMessage());
        }
    }

    public String updateRoomAvailability(int roomNumber, int hotelID, boolean isAvailable) throws Exception {
        String sql = "UPDATE Room SET isAvailable = ? WHERE room = ? AND hotelID = ?";
        ConnectionDB db = new ConnectionDB();
        String message = "";

        try (Connection con = db.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setBoolean(1, isAvailable);
            stmt.setInt(2, roomNumber);
            stmt.setInt(3, hotelID);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                message = "Room availability updated successfully!";
            } else {
                message = "Room not found or already in desired state.";
            }
        } catch (Exception e) {
            message = "Error updating room availability: " + e.getMessage();
        } finally {
            db.close();
        }

        return message;
    } */

    public List<Room> searchRooms(String checkinDate, String checkoutDate, String hotelChain, String city,
                                  String numRooms, String category, String roomCapacity, String priceRange,
                                  String extendable, String viewType) throws Exception {

        StringBuilder sql = new StringBuilder(
                "SELECT r.*, h.hotel_address AS hotel_address, hc.name AS hotel_chain_name " +
                        "FROM Room r " +
                        "JOIN Hotel h ON r.hotel_id = h.hotel_id " +
                        "JOIN hotel_chain hc ON h.chain_id = hc.chain_id " +
                        "WHERE 1=1"
        );


        List<Object> params = new ArrayList<>();

        if (hotelChain != null && !hotelChain.isEmpty()) {
            sql.append(" AND hc.name ILIKE ?");
            params.add("%" + hotelChain + "%");
        }

        if (city != null && !city.isEmpty()) {
            sql.append(" AND h.hotel_address ILIKE ?");
            params.add("%" + city + "%");
        }

        if (numRooms != null && !numRooms.isEmpty()) {
            sql.append(" AND h.num_rooms >= ?");
            params.add(Integer.parseInt(numRooms));
        }

        if (category != null && !category.isEmpty()) {
            sql.append(" AND h.category = ?");
            params.add(Integer.parseInt(category));
        }

        if (roomCapacity != null && !roomCapacity.isEmpty()) {
            sql.append(" AND r.capacity >= ?");
            params.add(Integer.parseInt(roomCapacity));
        }

        if (priceRange != null && !priceRange.isEmpty()) {
            if (priceRange.contains("-")) {
                String[] parts = priceRange.split("-");
                if (!parts[0].isEmpty()) {
                    sql.append(" AND r.price >= ?");
                    params.add(Double.parseDouble(parts[0]));
                }
                if (parts.length > 1 && !parts[1].isEmpty()) {
                    sql.append(" AND r.price <= ?");
                    params.add(Double.parseDouble(parts[1]));
                }
            } else {
                sql.append(" AND r.price <= ?");
                params.add(Double.parseDouble(priceRange));
            }
        }

        if (extendable != null && !extendable.isEmpty()) {
            sql.append(" AND r.extendable = ?");
            params.add(Boolean.parseBoolean(extendable));
        }

        if (viewType != null && !viewType.isEmpty()) {
            sql.append(" AND r.view_type ILIKE ?");
            params.add("%" + viewType + "%");
        }

        List<Room> rooms = new ArrayList<>();
        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Room room = new Room(
                        rs.getInt("hotel_id"),
                        rs.getInt("room_number"),
                        rs.getBoolean("extendable"),
                        rs.getDouble("price"),
                        rs.getInt("capacity"),
                        rs.getString("view_type")
                );
                room.setHotelChainName(rs.getString("hotel_chain_name"));
                room.setHotelAddress(rs.getString("hotel_address"));
                rooms.add(room);


                // Optional: Add these if your Room class supports them
                // room.setHotelAddress(rs.getString("hotel_address"));
                // room.setHotelChainName(rs.getString("hotel_chain_name"));

                rooms.add(room);
            }
        }

        return rooms;
    }

    public boolean doesRoomExist(int hotelId, int roomNumber) throws Exception {
        String sql = "SELECT 1 FROM Room WHERE hotel_id = ? AND room_number = ?";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, hotelId);
            stmt.setInt(2, roomNumber);

            ResultSet rs = stmt.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            throw new Exception("Error checking room existence: " + e.getMessage());
        }
    }

    public void addRoom(Room room) throws Exception {
        if (doesRoomExist(room.getHotelID(), room.getRoomNumber())) {
            throw new Exception("Room with hotel ID " + room.getHotelID() + " and room number " + room.getRoomNumber() + " already exists.");
        }

        String sql = "INSERT INTO Room (hotel_id, room_number, extendable, price, capacity, view_type) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, room.getHotelID());
            stmt.setInt(2, room.getRoomNumber());
            stmt.setBoolean(3, room.isExtendable());
            stmt.setDouble(4, room.getPrice());
            stmt.setInt(5, room.getCapacity());
            stmt.setString(6, room.getViewType());

            stmt.executeUpdate();
            System.out.println("Room added successfully");

        } catch (SQLException e) {
            throw new Exception("Error adding room: " + e.getMessage());
        }
    }
}

