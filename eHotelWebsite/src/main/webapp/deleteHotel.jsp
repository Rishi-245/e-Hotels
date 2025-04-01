<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.eHotels.ConnectionDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Hotel</title>
</head>
<body>

<h2>Delete Hotel</h2>

<form action="deleteHotel.jsp" method="post">
    <label>Hotel ID to Delete: <input type="number" name="hotelId" required /></label><br><br>
    <button type="submit" onclick="return confirm('Are you sure you want to delete this hotel?');">Delete Hotel</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String hotelIdParam = request.getParameter("hotelId");

        if (hotelIdParam != null && !hotelIdParam.isEmpty()) {
            int hotelId = Integer.parseInt(hotelIdParam);

            Connection conn = null;
            ConnectionDB db = new ConnectionDB();

            try {
                conn = db.getConnection();
                String sql = "DELETE FROM Hotel WHERE hotel_id = ?";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, hotelId);

                    int rowsDeleted = ps.executeUpdate();
                    if (rowsDeleted > 0) {
                        out.println("<p style='color:green;'>Hotel with ID " + hotelId + " deleted successfully.</p>");
                    } else {
                        out.println("<p style='color:red;'>No hotel found with ID " + hotelId + ".</p>");
                    }
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (conn != null) db.close();
            }
        } else {
            out.println("<p style='color:red;'>Please enter a valid hotel ID.</p>");
        }
    }
%>

<br><a href="hotels.jsp">← Back to Hotel Management</a>

</body>
</html>
