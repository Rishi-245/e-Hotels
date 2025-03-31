package com.eHotels;

import java.sql.*;

public class CustomerService {

    /**
     * Method to check if a customer exists in the database.
     * If the customer exists, return their customer_id.
     * Otherwise, return -1.
     */
    public int getCustomerIDIfExists(Customer customer) throws Exception {
        String sql = "SELECT customer_id FROM Customer WHERE f_name = ? AND m_name = ? AND l_name = ? AND address = ?";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            // Set query parameters
            stmt.setString(1, customer.getFirstName());
            stmt.setString(2, customer.getMiddleName());
            stmt.setString(3, customer.getLastName());
            stmt.setString(4, customer.getAddress());

            // Execute query
            ResultSet rs = stmt.executeQuery();

            // If customer exists, return their customer_id
            if (rs.next()) {
                return rs.getInt("customer_id");
            }

        } catch (SQLException e) {
            throw new Exception("Error checking customer existence: " + e.getMessage());
        }

        // Customer does not exist
        return -1;
    }

    /**
     * Method to get the next available customer_id.
     * This is determined by counting the total number of customers and adding 1.
     */
    public int getNextCustomerID() throws Exception {
        String sql = "SELECT COUNT(*) AS total FROM Customer";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            // If count is retrieved, return count + 1
            if (rs.next()) {
                return rs.getInt("total") + 1;
            }

        } catch (SQLException e) {
            throw new Exception("Error retrieving next customer ID: " + e.getMessage());
        }

        // Default fallback
        return 1;
    }

    /**
     * Method to add a new customer to the database.
     * If the customer already exists, their existing customer_id is used.
     * Otherwise, a new customer is inserted with the next available customer_id.
     */
    public void addCustomer(Customer customer) throws Exception {
        int customerID = getCustomerIDIfExists(customer);

        // If customer does not exist, get the next available customer_id
        if (customerID == -1) {
            customerID = getNextCustomerID();
        }

        // SQL query to insert a new customer (if they don’t already exist)
        String sql = "INSERT INTO Customer (customer_id, f_name, m_name, l_name, address, type_id, reg_date) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?) " +
                "ON CONFLICT (customer_id) DO NOTHING"; // Avoid duplicate insertions

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            // Set values for placeholders in SQL query
            stmt.setInt(1, customerID);   // customer_id
            stmt.setString(2, customer.getFirstName()); // f_name
            stmt.setString(3, customer.getMiddleName()); // m_name
            stmt.setString(4, customer.getLastName());  // l_name
            stmt.setString(5, customer.getAddress());   // address
            stmt.setString(6, customer.getTypeID());    // type_id (e.g., "SIN", "License")
            stmt.setDate(7, new Date(System.currentTimeMillis())); // reg_date

            // Execute the insert query
            stmt.executeUpdate();

            System.out.println("Customer added successfully");

        } catch (SQLException e) {
            throw new Exception("Error adding customer: " + e.getMessage());
        }
    }
}
