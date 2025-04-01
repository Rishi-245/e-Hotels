<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.eHotels.BookingService, com.eHotels.Booking" %>
<%@ page import="java.sql.Date" %>

<%
    String hotelId = request.getParameter("hotel_id");
    String roomNumber = request.getParameter("room_number");
    String checkin = request.getParameter("checkin_date");
    String checkout = request.getParameter("checkout_date");

    // ✅ Get customer ID from session
    String customerIdStr = (String) session.getAttribute("customer_id");
    String sin = "123344556"; // default employee SIN for online bookings

    if (customerIdStr == null) {
        out.println("<p style='color:red;'>You must be logged in to make a booking.</p>");
        return;
    }

    if (hotelId == null || roomNumber == null || checkin == null || checkout == null) {
        out.println("<p style='color:red;'>One or more required parameters are missing.</p>");
        return;
    }


    int customerId = Integer.parseInt(customerIdStr);

    Booking booking = new Booking(0, customerId, sin, Integer.parseInt(hotelId),Integer.parseInt(roomNumber), null, Date.valueOf(checkin),  Date.valueOf(checkout), "Pending");
    BookingService bookingService = new BookingService();

    try {
        bookingService.addBooking(booking);

        %>
            <div class="success">Congrats! Booking has been made successfully marked as <strong>Pending!</strong>.</div>
            <a href="customerSection.jsp"><strong>-----Exit-----</strong></a>
        <%

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

<a href="searchRooms.jsp">Back to Search</a>
