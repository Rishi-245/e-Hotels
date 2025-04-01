package com.eHotels;

import java.sql.*;

public class HotelService {

    public Hotel getHotelById(int hotelId) throws Exception {
        String sql = "SELECT * FROM Hotel WHERE hotel_id = ?";
        ConnectionDB db = new ConnectionDB();

        try (Connection con = db.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, hotelId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Hotel(
                        rs.getInt("hotel_id"),
                        rs.getInt("chain_id"),
                        rs.getInt("category"),
                        rs.getInt("num_rooms"),
                        rs.getString("hotel_address"),
                        rs.getString("hotel_email")
                );
            }

            return null; // No hotel found for that ID
        } catch (Exception e) {
            throw new Exception("Error retrieving hotel by ID: " + e.getMessage());
        } finally {
            db.close();
        }
    }

    public int getNextHotelID() throws Exception {
        String sql = "SELECT MAX(hotel_id) AS max_id FROM Hotel";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("max_id") + 1;
            }
        } catch (SQLException e) {
            throw new Exception("Error retrieving next hotel ID: " + e.getMessage());
        }

        return 1;
    }

    public void addHotel(Hotel hotel) throws Exception {
        int hotelID = getNextHotelID();

        String sql = "INSERT INTO Hotel (hotel_id, chain_id, category, num_rooms, hotel_address, hotel_email) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, hotelID);
            stmt.setInt(2, hotel.getChainID());
            stmt.setInt(3, hotel.getCategory());
            stmt.setInt(4, hotel.getNumRooms());
            stmt.setString(5, hotel.getHotelAddress());
            stmt.setString(6, hotel.getHotelEmail());

            stmt.executeUpdate();
            System.out.println("Hotel added successfully with ID: " + hotelID);

        } catch (SQLException e) {
            throw new Exception("Error adding hotel: " + e.getMessage());
        }
    }
}
