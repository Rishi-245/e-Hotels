<%@ page import="java.util.List" %>
<%@ page import="com.eHotels.Booking" %>
<%@ page import="com.eHotels.BookingService" %>
<%@ page import="com.eHotels.Employee" %>
<%@ page import="com.eHotels.EmployeeService" %>
<%@ page import="com.eHotels.Room" %>
<%@ page import="com.eHotels.RoomService" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ page import="java.util.ArrayList" %>

<%
    // retrieve employee ID from form submission
    String employeeId = request.getParameter("employeeId");
    String bookingType = request.getParameter("bookingType");
    String customerId = request.getParameter("customer_id");


    Employee employee = null;
    List<Employee> employees = new EmployeeService().getEmployees(); // Fetch all employees
    for (Employee emp : employees) {
        if (emp.getSIN().equals(employeeId)) {
            employee = emp;
            break;
        }
    }

    // List to store pending bookings (filtered by hotel)
    List<Booking> pendingBookings = new ArrayList<>();
    if (employee != null) {
        BookingService bookingService = new BookingService();
        List<Booking> allBookings = bookingService.getBookings();

        for (Booking booking : allBookings) {
            if ("Pending".equalsIgnoreCase(booking.getStatus()) && booking.getHotelID() == employee.getHotelID()) {
                pendingBookings.add(booking);
            }
        }
    }

    // Handle In-Person Renting Form Submission
    List<Room> availableRooms = new ArrayList<>();
    if (bookingType != null && bookingType.equals("inperson")) {
        String budgetStr = request.getParameter("ipBudget");
        double budget = budgetStr != null && !budgetStr.isEmpty() ? Double.parseDouble(budgetStr) : -1;

        RoomService roomService = new RoomService();
        List<Room> allRooms = roomService.getRooms();

        for (Room room : allRooms) {
            if (room.getHotelID() == employee.getHotelID() && (budget == -1 || room.getPrice() <= budget)) {
                availableRooms.add(room);
            }
        }
    }

%>

<%
    String registered = request.getParameter("registered");
    if ("true".equals(registered)) {
%>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("customerForm").style.display = "none";
            document.getElementById("roomSearchSection").style.display = "block";
        });
    </script>
<%
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Available Rooms</title>
</head>
<body>
    <h2>Available Rooms</h2>
    <% if (availableRooms != null && !availableRooms.isEmpty()) { %>
        <div id="roomSearchSection">
            <h4>Available Rooms in Your Hotel</h4>
            <form method="get">
                <label>Current Date:
                    <input type="date" name="ipDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                </label>
                <label>End Date:
                    <input type="date" name="ipEndDate" required>
                </label>
            </form>
            <table border="1" cellpadding="8" cellspacing="0" style="margin-top:10px; width:100%; max-width:800px;">
                <thead>
                    <tr>
                        <th>Room</th>
                        <th>Price</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Room room : availableRooms) { %>
                        <tr>
                            <td><%= room.getRoomNumber() %></td>
                            <td><%= room.getPrice() %>/night</td>
                            <td>
                                <form method="post" action="index.jsp">
                                    <input type="hidden" name="employeeId" value="<%= employeeId %>">
                                    <input type="hidden" name="hotelId" value="<%= room.getHotelID() %>">
                                    <input type="hidden" name="roomNumber" value="<%= room.getRoomNumber() %>">
                                    <button type="submit">Confirm</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    <% } else { %>
        <p>No rooms available.</p>
    <% } %>
</body>
</html>
