<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.eHotels.ConnectionDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Customer</title>
</head>
<body>

<h2>Delete Customer</h2>

<form action="deleteCustomer.jsp" method="post">
    <label>Customer ID to Delete: <input type="number" name="customerId" required /></label><br><br>
    <button type="submit" onclick="return confirm('Are you sure you want to delete this customer?');">Delete Customer</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String customerIdParam = request.getParameter("customerId");

        if (customerIdParam != null && !customerIdParam.isEmpty()) {
            int customerId = Integer.parseInt(customerIdParam);

            Connection conn = null;
            ConnectionDB db = new ConnectionDB();

            try {
                conn = db.getConnection();
                String sql = "DELETE FROM Customer WHERE customer_id = ?";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, customerId);

                    int rowsDeleted = ps.executeUpdate();
                    if (rowsDeleted > 0) {
                        out.println("<p style='color:green;'>Customer with ID " + customerId + " deleted successfully.</p>");
                    } else {
                        out.println("<p style='color:red;'>No customer found with ID " + customerId + ".</p>");
                    }
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (conn != null) db.close();
            }
        } else {
            out.println("<p style='color:red;'>Please enter a valid customer ID.</p>");
        }
    }
%>

<br><a href="customers.jsp">← Back to Customer Management</a>

</body>
</html>
