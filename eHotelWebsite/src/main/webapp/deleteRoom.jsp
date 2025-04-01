<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.eHotels.ConnectionDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Room</title>
</head>
<body>

<h2>Delete Room</h2>

<form action="deleteRoom.jsp" method="post">
    <label>Hotel ID: <input type="number" name="hotelId" required /></label><br><br>
    <label>Room Number: <input type="number" name="roomNumber" required /></label><br><br>
    <button type="submit" onclick="return confirm('Are you sure you want to delete this room?');">Delete Room</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String hotelIdParam = request.getParameter("hotelId");
        String roomNumberParam = request.getParameter("roomNumber");

        if (hotelIdParam != null && !hotelIdParam.isEmpty() &&
            roomNumberParam != null && !roomNumberParam.isEmpty()) {

            int hotelId = Integer.parseInt(hotelIdParam);
            int roomNumber = Integer.parseInt(roomNumberParam);

            Connection conn = null;
            ConnectionDB db = new ConnectionDB();

            try {
                conn = db.getConnection();
                String sql = "DELETE FROM Room WHERE hotel_id = ? AND room_number = ?";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, hotelId);
                    ps.setInt(2, roomNumber);

                    int rowsDeleted = ps.executeUpdate();
                    if (rowsDeleted > 0) {
                        out.println("<p style='color:green;'>Room " + roomNumber + " in Hotel " + hotelId + " deleted successfully.</p>");
                    } else {
                        out.println("<p style='color:red;'>No room found with that Hotel ID and Room Number.</p>");
                    }
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (conn != null) db.close();
            }

        } else {
            out.println("<p style='color:red;'>Please enter both Hotel ID and Room Number.</p>");
        }
    }
%>

<br><a href="rooms.jsp">← Back to Room Management</a>

</body>
</html>
