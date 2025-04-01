<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.eHotels.Room" %>
<%@ page import="com.eHotels.RoomService" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Room</title>
</head>
<body>
<h2>Insert Room</h2>

<form method="post">
    <label>Hotel ID: <input type="number" name="hotelId" required></label><br><br>
    <label>Room Number: <input type="number" name="roomNumber" required></label><br><br>
    <label>Extendable:
        <select name="extendable" required>
            <option value="">--Select--</option>
            <option value="true">Yes</option>
            <option value="false">No</option>
        </select>
    </label><br><br>
    <label>Price: <input type="number" step="0.01" name="price" required></label><br><br>
    <label>Capacity: <input type="number" name="capacity" required></label><br><br>
    <label>View Type:
            <select name="viewType" required>
                <option value="">--Select View--</option>
                <option value="Sea View">Sea View</option>
                <option value="Mountain View">Mountain View</option>
            </select>
    </label><br><br>

    <button type="submit">Add Room</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));
            int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
            boolean extendable = Boolean.parseBoolean(request.getParameter("extendable"));
            double price = Double.parseDouble(request.getParameter("price"));
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String viewType = request.getParameter("viewType");

            Room room = new Room(hotelId, roomNumber, extendable, price, capacity, viewType);
            RoomService roomService = new RoomService();
            roomService.addRoom(room);

            out.println("<p style='color:green;'>Room inserted successfully!</p>");
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>

<a href="rooms.jsp">Back to Room Management</a>
</body>
</html>
