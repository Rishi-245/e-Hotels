<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.eHotels.ConnectionDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Employee</title>
</head>
<body>

<h2>Delete Employee</h2>

<form action="deleteEmployee.jsp" method="post">
    <label>SIN of Employee to Delete: <input type="text" name="sin" required /></label><br><br>
    <button type="submit" onclick="return confirm('Are you sure you want to delete this employee?');">Delete Employee</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String sinParam = request.getParameter("sin");

        if (sinParam != null && !sinParam.trim().isEmpty()) {
            Connection conn = null;
            ConnectionDB db = new ConnectionDB();

            try {
                conn = db.getConnection();
                String sql = "DELETE FROM Employee WHERE sin = ?";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, sinParam.trim());

                    int rowsDeleted = ps.executeUpdate();
                    if (rowsDeleted > 0) {
                        out.println("<p style='color:green;'>Employee with SIN " + sinParam + " deleted successfully.</p>");
                    } else {
                        out.println("<p style='color:red;'>No employee found with SIN " + sinParam + ".</p>");
                    }
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (conn != null) db.close();
            }
        } else {
            out.println("<p style='color:red;'>Please enter a valid SIN.</p>");
        }
    }
%>

<br><a href="employees.jsp">← Back to Employee Management</a>

</body>
</html>
