package com.eHotels;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
}
