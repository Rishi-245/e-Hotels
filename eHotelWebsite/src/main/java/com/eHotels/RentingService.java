package com.eHotels;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RentingService {

    public List<Renting> getRentings() throws Exception {
        String sql = "SELECT * FROM Renting";
        ConnectionDB db = new ConnectionDB();
        List<Renting> rentings = new ArrayList<>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Renting renting = new Renting(
                        rs.getInt("renting_id"),
                        rs.getInt("customer_id"),
                        rs.getString("SIN"),
                        rs.getInt("hotel_id"),
                        rs.getInt("room_number"),
                        rs.getDate("renting_date"),
                        rs.getDate("check_out_date"),
                        rs.getString("status")
                );
                rentings.add(renting);
            }
            rs.close();
            stmt.close();
            con.close();
            db.close();
            return rentings;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public void addRenting(Renting renting) throws Exception {
        // Step 1: Get the next available renting_id
        int rentingId = getNextRentingID();

        // Step 2: Insert booking into database
        String sql = "INSERT INTO Renting (renting_id, customer_id, SIN, hotel_id, room_number, renting_date, checkout_date, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?) " +
                "ON CONFLICT (renting_id) DO NOTHING"; // Optional: prevents duplicate inserts

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, rentingId);
            stmt.setInt(2, renting.getCustomerID());
            stmt.setString(3, renting.getSIN());
            stmt.setInt(4, renting.getHotelID());
            stmt.setInt(5, renting.getRoomNumber());
            stmt.setDate(6, renting.getRentingDate());
            stmt.setDate(7, renting.getCheckOutDate());
            stmt.setString(8, renting.getStatus());

            stmt.executeUpdate();

            System.out.println("Renting #" + rentingId + " added successfully.");

        } catch (Exception e) {
            throw new Exception("Error adding renting: " + e.getMessage());
        }
    }

    public int getNextRentingID() throws Exception {
        String sql = "SELECT COUNT(*) AS total FROM Renting";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total") + 1;
            }

        } catch (Exception e) {
            throw new Exception("Error retrieving next renting ID: " + e.getMessage());
        }

        return 1; // Fallback if no bookings exist
    }
}