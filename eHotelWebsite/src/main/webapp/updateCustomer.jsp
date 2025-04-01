<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eHotels.ConnectionDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Customer</title>
</head>
<body>

<h2>Update Customer</h2>

<form action="updateCustomer.jsp" method="post">
    <label>Customer ID: <input type="number" name="customerId" required></label><br><br>

    <p><em>Leave fields blank to keep existing data.</em></p>

    <label>First Name: <input type="text" name="f_name" /></label><br><br>
    <label>Middle Name: <input type="text" name="m_name" /></label><br><br>
    <label>Last Name: <input type="text" name="l_name" /></label><br><br>
    <label>Address: <input type="text" name="address" /></label><br><br>
    <label for="typeId">New Type ID:</label>
    <select name="typeId" required>
        <option value="">--Select City--</option>
        <option value="SSN">SSN</option>
        <option value="SIN">SIN</option>
        <option value="Driving License">Driving License</option>
    </select><br><br>
    <button type="submit">Update Customer</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String f_name = request.getParameter("f_name");
        String m_name = request.getParameter("m_name");
        String l_name = request.getParameter("l_name");
        String address = request.getParameter("address");
        String type_id = request.getParameter("type_id");

        String dbURL = "jdbc:postgresql://localhost:5432/e-HotelsDB";
        String dbUser = "postgres";
        String dbPassword = "user123";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            List<String> updates = new ArrayList<>();
            List<Object> values = new ArrayList<>();

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
            if (type_id != null && !type_id.isEmpty()) {
                updates.add("type_id = ?");
                values.add(type_id);
            }

            if (!updates.isEmpty()) {
                String sql = "UPDATE Customer SET " + String.join(", ", updates) + " WHERE customer_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    for (int i = 0; i < values.size(); i++) {
                        ps.setObject(i + 1, values.get(i));
                    }
                    ps.setInt(values.size() + 1, customerId);

                    int rows = ps.executeUpdate();
                    out.println(rows > 0
                        ? "<p style='color:green;'>Customer updated successfully.</p>"
                        : "<p style='color:red;'>No customer found with that ID.</p>");
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

<br><a href="customers.jsp">← Back to Customer Management</a>

</body>
</html>
