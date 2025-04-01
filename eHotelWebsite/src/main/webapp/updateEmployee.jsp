<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eHotels.ConnectionDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Employee</title>
</head>
<body>

<h2>Update Employee</h2>

<form action="updateEmployee.jsp" method="post">
    <label>SIN: <input type="text" name="sin" required /></label><br><br>

    <p><em>Leave fields blank to keep existing data.</em></p>

    <label>Hotel ID: <input type="number" name="hotel_id" /></label><br><br>
    <label>First Name: <input type="text" name="f_name" /></label><br><br>
    <label>Middle Name: <input type="text" name="m_name" /></label><br><br>
    <label>Last Name: <input type="text" name="l_name" /></label><br><br>
    <label>Address: <input type="text" name="address" /></label><br><br>
    <label>Role: <input type="text" name="role" /></label><br><br>

    <button type="submit">Update Employee</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String sin = request.getParameter("sin");
        String hotelId = request.getParameter("hotel_id");
        String f_name = request.getParameter("f_name");
        String m_name = request.getParameter("m_name");
        String l_name = request.getParameter("l_name");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        String dbURL = "jdbc:postgresql://localhost:5432/e-HotelsDB";
        String dbUser = "postgres";
        String dbPassword = "user123";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            List<String> updates = new ArrayList<>();
            List<Object> values = new ArrayList<>();

            if (hotelId != null && !hotelId.isEmpty()) {
                updates.add("hotel_id = ?");
                values.add(Integer.parseInt(hotelId));
            }
            if (f_name != null && !f_name.isEmpty()) {
                updates.add("f_name = ?");
                values.add(f_name);
            }
            if (m_name != null && !m_name.isEmpty()) {
                updates.add("m_name = ?");
                values.add(m_name);
            }
            if (l_name != null && !l_name.isEmpty()) {
                updates.add("l_name = ?");
                values.add(l_name);
            }
            if (address != null && !address.isEmpty()) {
                updates.add("address = ?");
                values.add(address);
            }
            if (role != null && !role.isEmpty()) {
                updates.add("role = ?");
                values.add(role);
            }

            if (!updates.isEmpty()) {
                String sql = "UPDATE Employee SET " + String.join(", ", updates) + " WHERE sin = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    for (int i = 0; i < values.size(); i++) {
                        ps.setObject(i + 1, values.get(i));
                    }
                    ps.setString(values.size() + 1, sin);

                    int rows = ps.executeUpdate();
                    out.println(rows > 0
                        ? "<p style='color:green;'>Employee updated successfully.</p>"
                        : "<p style='color:red;'>No employee found with that SIN.</p>");
                }
            } else {
                out.println("<p style='color:orange;'>No fields were updated.</p>");
            }

        } catch (SQLException e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>

<br><a href="employees.jsp">← Back to Employee Management</a>

</body>
</html>
