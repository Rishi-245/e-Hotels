<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eHotels.ConnectionDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Hotel</title>
</head>
<body>

<h2>Update Hotel</h2>

<form action="updateHotel.jsp" method="post">
    <label>Hotel ID: <input type="number" name="hotel_id" required /></label><br><br>

    <p><em>Leave fields blank to keep existing data.</em></p>

    <label>Chain ID: <input type="number" name="chain_id" /></label><br><br>
    <label>Category: <input type="number" name="category" min="1" max="5" /></label><br><br>
    <label>Number of Rooms: <input type="number" name="num_rooms" /></label><br><br>
    <label>Address: <input type="text" name="hotel_address" /></label><br><br>
    <label>Email: <input type="email" name="hotel_email" /></label><br><br>

    <button type="submit">Update Hotel</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
        String chainId = request.getParameter("chain_id");
        String category = request.getParameter("category");
        String numRooms = request.getParameter("num_rooms");
        String address = request.getParameter("hotel_address");
        String email = request.getParameter("hotel_email");

        String dbURL = "jdbc:postgresql://localhost:5432/e-HotelsDB";
        String dbUser = "postgres";
        String dbPassword = "user123";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            List<String> updates = new ArrayList<>();
            List<Object> values = new ArrayList<>();

            if (chainId != null && !chainId.isEmpty()) {
                updates.add("chain_id = ?");
                values.add(Integer.parseInt(chainId));
            }
            if (category != null && !category.isEmpty()) {
                updates.add("category = ?");
                values.add(Integer.parseInt(category));
            }
            if (numRooms != null && !numRooms.isEmpty()) {
                updates.add("num_rooms = ?");
                values.add(Integer.parseInt(numRooms));
            }
            if (address != null && !address.isEmpty()) {
                updates.add("hotel_address = ?");
                values.add(address);
            }
            if (email != null && !email.isEmpty()) {
                updates.add("hotel_email = ?");
                values.add(email);
            }

            if (!updates.isEmpty()) {
                String sql = "UPDATE Hotel SET " + String.join(", ", updates) + " WHERE hotel_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    for (int i = 0; i < values.size(); i++) {
                        ps.setObject(i + 1, values.get(i));
                    }
                    ps.setInt(values.size() + 1, hotelId);

                    int rows = ps.executeUpdate();
                    out.println(rows > 0
                        ? "<p style='color:green;'>Hotel updated successfully.</p>"
                        : "<p style='color:red;'>No hotel found with that ID.</p>");
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

<br><a href="hotels.jsp">← Back to Hotel Management</a>

</body>
</html>
