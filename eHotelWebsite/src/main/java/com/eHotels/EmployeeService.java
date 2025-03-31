package com.eHotels;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

}
