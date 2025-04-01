<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.eHotels.Hotel" %>
<%@ page import="com.eHotels.HotelService" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Hotel</title>
</head>
<body>
<h2>Insert Hotel</h2>

<form method="post">
    <label>Chain ID: <input type="number" name="chainId" required></label><br><br>
    <label>Category: <input type="number" name="category" required></label><br><br>
    <label>Number of Rooms: <input type="number" name="numRooms" required></label><br><br>
    <label>Hotel Address: <input type="text" name="hotelAddress" required></label><br><br>
    <label>Hotel Email: <input type="email" name="hotelEmail" required></label><br><br>

    <button type="submit">Add Hotel</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String chainIdStr = request.getParameter("chainId");
        String categoryStr = request.getParameter("category");
        String numRoomsStr = request.getParameter("numRooms");
        String hotelAddress = request.getParameter("hotelAddress");
        String hotelEmail = request.getParameter("hotelEmail");

        try {
            int chainId = Integer.parseInt(chainIdStr);
            int category = Integer.parseInt(categoryStr);
            int numRooms = Integer.parseInt(numRoomsStr);

            Hotel hotel = new Hotel(
                0, // hotel_id will be generated in the service class
                chainId,
                category,
                numRooms,
                hotelAddress,
                hotelEmail
            );

            HotelService hotelService = new HotelService();
            hotelService.addHotel(hotel);

            out.println("<p style='color:green;'>Hotel inserted successfully!</p>");
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>

<a href="hotels.jsp">← Back to Hotel Management</a>
</body>
</html>
