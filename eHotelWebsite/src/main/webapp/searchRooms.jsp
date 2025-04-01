<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.eHotels.Room, com.eHotels.RoomService" %>
<%@ page import="com.eHotels.RoomService" %>
<%@ page import="com.eHotels.HotelService" %>
<%@ page import="com.eHotels.HotelChainService" %>
<%@ page import="com.eHotels.Room" %>
<%@ page import="java.util.List" %>

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
    List<Room> availableRooms = null;

    RoomService roomService = new RoomService();
    try {
        availableRooms = roomService.searchRooms(
            checkinDate, checkoutDate, hotelChain, city, numRooms,
            category, roomCapacity, priceRange, extendable, viewType
        );
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }

    HotelService hotelService = new HotelService();
    HotelChainService hotelChainService = new HotelChainService();
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
                <th>Hotel Chain</th>
                <th>City</th>
                <th>Room Capacity</th>
                <th>Price Per Night</th>
                <th>Extendable</th>
                <th>View Type</th>
                <th>Book Now</th>
            </tr>
            <% for (Room room : availableRooms) { %>
                <tr>
                    <td><%= room.getHotelChainName() != null ? room.getHotelChainName() : "N/A" %></td>
                    <td><%= room.getHotelAddress() != null ? room.getHotelAddress() : "N/A" %></td>
                    <td><%= room.getCapacity() %></td>
                    <td><%= room.getPrice() %></td>
                    <td><%= room.isExtendable() ? "Yes" : "No" %></td>
                    <td><%= room.getViewType() %></td>
                    <td>
                        <form action="createBooking.jsp" method="post">
                            <input type="hidden" name="hotel_id" value="<%= room.getHotelID() %>" />
                            <input type="hidden" name="room_number" value="<%= room.getRoomNumber() %>" />
                            <input type="hidden" name="checkin_date" value="<%= checkinDate %>" />
                            <input type="hidden" name="checkout_date" value="<%= checkoutDate %>" />
                            <input type="submit" value="Book" />
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    <% } %>
</body>
</html>

