<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.eHotels.Room, com.eHotels.RoomService" %>

<%
    // Get parameters from form
    String checkinDate = request.getParameter("checkinDate");
    String checkoutDate = request.getParameter("checkoutDate");
    String hotelChain = request.getParameter("hotelChain");  // Still kept for potential future use
    String city = request.getParameter("city");  // Still kept for potential future use
    String numRooms = request.getParameter("numRooms");  // Still kept for potential future use
    String category = request.getParameter("category");  // Still kept for potential future use
    String roomCapacity = request.getParameter("roomCapacity");
    String priceRange = request.getParameter("priceRange");
    String extendable = request.getParameter("extendable");
    String viewType = request.getParameter("viewType");

    // Call RoomService to get results
    RoomService roomService = new RoomService();
    List<Room> availableRooms = roomService.searchRooms(checkinDate, checkoutDate, hotelChain, city, numRooms, category, roomCapacity, priceRange, extendable, viewType);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Rooms</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Available Rooms</h1>

    <% if (availableRooms.isEmpty()) { %>
        <p>No rooms found matching your criteria.</p>
    <% } else { %>
        <table border="1">
            <tr>
                <th>Hotel</th>
                <th>City</th>
                <th>Room Capacity</th>
                <th>Price Per Night</th>
                <th>Extendable</th>
                <th>View Type</th>
                <th>Book Now</th>
            </tr>
            <% for (Room room : availableRooms) { %>
                <tr>
                    <td><%= room.getHotelID() %></td>  <!-- Display Hotel ID for now -->
                    <td>N/A</td>  <!-- Fix: No city info in Room.java -->
                    <td><%= room.getCapacity() %></td>
                    <td><%= room.getPrice() %></td>
                    <td><%= room.isExtendable() ? "Yes" : "No" %></td>
                    <td><%= room.getViewType() %></td>
                    <td><button>Book</button></td>
                </tr>
            <% } %>
        </table>
    <% } %>
</body>
</html>
