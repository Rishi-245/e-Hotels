package com.eHotels;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingService {

    /**
     * Method to get all bookings from the database
     *
     * @return List of bookings from database
     * @throws Exception when trying to connect to database
     */


    public List<Booking> getBookings() throws Exception {
        // sql query
        String sql = "SELECT * FROM Booking";
        // database connection object
        ConnectionDB db = new ConnectionDB();

        // data structure to keep all bookings retrieved from database
        List<Booking> bookings = new ArrayList<>();

        // try to connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();


            // iterate through the result set
            while (rs.next()) {
                // create new booking object
                Booking booking = new Booking(
                        rs.getInt("booking_id"),
                        rs.getInt("customer_id"),
                        rs.getString("SIN"),
                        rs.getInt("hotel_id"),
                        rs.getInt("room_number"),
                        rs.getDate("booking_date"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getString("status")
                );

                // append booking in bookings list
                bookings.add(booking);
            }

            //close the result set
            rs.close();
            // close the statement
            stmt.close();
            con.close();
            db.close();

            // return the bookings retrieved from database
            return bookings;
        } catch (Exception e) {
            // throw any errors occurred
            throw new Exception(e.getMessage());
        }
    }
    public String updateBooking(String booking_id) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "UPDATE Booking SET status = 'Confirmed' WHERE booking_id = ?";
//        "UPDATE students SET name=" + student.getName().toString() +", surname=" +

        // connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            // get connection
            con = db.getConnection();

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setString(1, booking_id);

            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while updating booking: " + e.getMessage();

        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "booking successfully updated!";
        }

        // return respective message
        return message;
    }

    /*
    public String deleteBooking(int booking_id) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "DELETE FROM Booking WHERE booking_id = ?;";

        // database connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection();

            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setInt(1, booking_id);

            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while delete booking: " + e.getMessage();
        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Booking successfully deleted!";
        }

        return message;
    }*/

    public void addBooking(Booking booking) throws Exception {
        // Step 1: Get the next available booking_id
        int bookingId = getNextBookingID();

        // Step 2: Insert booking into database
        String sql = "INSERT INTO Booking (booking_id, customer_id, SIN, hotel_id, room_number, start_date, end_date, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?) " +
                "ON CONFLICT (booking_id) DO NOTHING"; // Optional: prevents duplicate inserts

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            stmt.setInt(2, booking.getCustomerID());
            stmt.setString(3, booking.getSIN());
            stmt.setInt(4, booking.getHotelID());
            stmt.setInt(5, booking.getRoomNumber());
            stmt.setDate(6, booking.getStartDate());
            stmt.setDate(7, booking.getEndDate());
            stmt.setString(8, booking.getStatus());

            stmt.executeUpdate();

            System.out.println("Booking #" + bookingId + " added successfully.");

        } catch (Exception e) {
            throw new Exception("Error adding booking: " + e.getMessage());
        }
    }

    public int getNextBookingID() throws Exception {
        String sql = "SELECT COUNT(*) AS total FROM Booking";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total") + 1;
            }

        } catch (Exception e) {
            throw new Exception("Error retrieving next booking ID: " + e.getMessage());
        }

        return 1; // Fallback if no bookings exist
    }



}
