<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eHotels.ConnectionDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Room</title>
</head>
<body>

<h2>Update Room</h2>

<form action="updateRoom.jsp" method="post">
    <label>Hotel ID: <input type="number" name="hotelId" required /></label><br><br>
    <label>Room Number: <input type="number" name="roomNumber" required /></label><br><br>

    <p><em>Leave any field blank to keep existing value.</em></p>

    <label>Extendable:
        <select name="extendable">
            <option value="">--Leave Unchanged--</option>
            <option value="true">Yes</option>
            <option value="false">No</option>
        </select>
    </label><br><br>

    <label>Price: <input type="number" step="0.01" name="price" /></label><br><br>
    <label>Capacity: <input type="number" name="capacity" /></label><br><br>

    <label>View Type:
        <select name="viewType">
            <option value="">--Leave Unchanged--</option>
            <option value="Sea View">Sea View</option>
            <option value="Mountain View">Mountain View</option>
        </select>
    </label><br><br>

    <button type="submit">Update Room</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int hotelId = Integer.parseInt(request.getParameter("hotelId"));
        int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
        String extendable = request.getParameter("extendable");
        String priceStr = request.getParameter("price");
        String capacityStr = request.getParameter("capacity");
        String viewType = request.getParameter("viewType");

        String dbURL = "jdbc:postgresql://localhost:5432/e-HotelsDB";
        String dbUser = "postgres";
        String dbPassword = "user123";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            List<String> updates = new ArrayList<>();
            List<Object> values = new ArrayList<>();

            if (extendable != null && !extendable.isEmpty()) {
                updates.add("extendable = ?");
                values.add(Boolean.parseBoolean(extendable));
            }
            if (priceStr != null && !priceStr.isEmpty()) {
                updates.add("price = ?");
                values.add(Double.parseDouble(priceStr));
            }
            if (capacityStr != null && !capacityStr.isEmpty()) {
                updates.add("capacity = ?");
                values.add(Integer.parseInt(capacityStr));
            }
            if (viewType != null && !viewType.isEmpty()) {
                updates.add("view_type = ?");
                values.add(viewType);
            }

            if (!updates.isEmpty()) {
                String sql = "UPDATE Room SET " + String.join(", ", updates) + " WHERE hotel_id = ? AND room_number = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    for (int i = 0; i < values.size(); i++) {
                        ps.setObject(i + 1, values.get(i));
                    }
                    ps.setInt(values.size() + 1, hotelId);
                    ps.setInt(values.size() + 2, roomNumber);

                    int rows = ps.executeUpdate();
                    out.println(rows > 0
                        ? "<p style='color:green;'>Room updated successfully.</p>"
                        : "<p style='color:red;'>No room found with that Hotel ID and Room Number.</p>");
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

<br><a href="rooms.jsp">← Back to Room Management</a>

</body>
</html>
