<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.eHotels.RentingService, com.eHotels.Renting" %>
<%@ page import="java.sql.Date" %>

<%


    // Get customer ID from session
    String customerIdStr = (String) session.getAttribute("customer_id");

    if (customerIdStr == null) {
        out.println("<p style='color:red;'>You must be logged in to make a booking.</p>");
        return;
    }

    if (hotelId == null || roomNumber == null || checkin == null || checkout == null) {
        out.println("<p style='color:red;'>One or more required parameters are missing.</p>");
        return;
    }


    int customerId = Integer.parseInt(customerIdStr);

    Renting renting = new Renting(0, customerId, employeeId, Integer.parseInt(hotelId),Integer.parseInt(roomNumber), Date.valueOf(currentDate),  Date.valueOf(endDate), "Active");
    RentingService rentingService = new RentingService();

    try {
        rentingService.addRenting(renting);

        %>
            <div class="success">Congrats! Booking has been made successfully marked as <strong>Pending!</strong>.</div>
            <a href="index.jsp">Exit</a>
        <%

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

<a href="availableRooms.jsp">Back to Search</a>

