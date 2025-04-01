package com.eHotels;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeService {

    /**
     * Method to get all employees from the database
     *
     * @return List of employees from database
     * @throws Exception when trying to connect to database
     */
    public List<Employee> getEmployees() throws Exception {
        String sql = "SELECT * FROM Employee";
        ConnectionDB db = new ConnectionDB();
        List<Employee> employees = new ArrayList<>();

        try (Connection con = db.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Employee employee = new Employee(
                        rs.getString("SIN"),
                        rs.getInt("hotel_iD"),
                        rs.getString("f_name"),
                        rs.getString("m_name"),
                        rs.getString("l_name"),
                        rs.getString("address"),
                        rs.getString("role")
                );
                employees.add(employee);
            }

            db.close();
            return employees;
        } catch (Exception e) {
            throw new Exception("Error retrieving employees: " + e.getMessage());
        }
    }

    /**
     * Method to check if an employee with the same SIN already exists in the database.
     */
    public boolean employeeExists(String sin) throws Exception {
        String sql = "SELECT 1 FROM Employee WHERE sin = ?";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, sin);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // true if at least one row exists

        } catch (SQLException e) {
            throw new Exception("Error checking employee existence: " + e.getMessage());
        }
    }

    /**
     * Method to add a new employee to the database. If the employee already exists, do nothing.
     */
    public void addEmployee(Employee employee) throws Exception {
        if (employeeExists(employee.getSIN())) {
            System.out.println("Employee already exists with SIN: " + employee.getSIN());
            return;
        }

        String sql = "INSERT INTO Employee (sin, hotel_id, f_name, m_name, l_name, address, role) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, employee.getSIN());
            stmt.setInt(2, employee.getHotelID());
            stmt.setString(3, employee.getFirstName());
            stmt.setString(4, employee.getMiddleName());
            stmt.setString(5, employee.getLastName());
            stmt.setString(6, employee.getAddress());
            stmt.setString(7, employee.getRole());

            stmt.executeUpdate();
            System.out.println("Employee added successfully");

        } catch (SQLException e) {
            throw new Exception("Error adding employee: " + e.getMessage());
        }
    }
}
