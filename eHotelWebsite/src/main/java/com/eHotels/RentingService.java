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
}