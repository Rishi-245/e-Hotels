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

<!DOCTYPE html>
<html lang="en">
<link rel="stylesheet" href="styles.css">
<head>
 <meta charset="UTF-8" />
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <title>e-Hotels</title>
</head>
<body>
 <h1>Welcome to e-Hotels</h1>


 <!-- Role Selection -->
 <fieldset>
   <legend><strong>Select Role:</strong></legend>
   <label><input type="radio" name="role" value="customer" checked> Customer</label>
   <label><input type="radio" name="role" value="employee"> Employee</label>
   <label><input type="radio" name="role" value="admin"> Admin</label>
 </fieldset>


 <!-- Customer Section -->
 <div class="section active" id="customerSection">
     <jsp:include page="customerSection.jsp" />
 </div>


 <!-- Employee Section -->
 <div class="section" id="employeeSection">
   <h2>Employee Panel</h2>

   <%
       String role = request.getParameter("role");
       if (role == null) role = "customer";
   %>
   <script>
       document.addEventListener("DOMContentLoaded", function () {
           document.querySelectorAll(".section").forEach(section => section.classList.remove("active"));
           document.getElementById("<%= role %>Section").classList.add("active");
       });
   </script>

    <!-- Step 1: Employee Login -->
    <form method="post" action="index.jsp?role=employee">
        <label>Enter Employee ID:
            <input type="text" name="employeeId" required />
        </label>
        <button type="submit">Enter</button>
    </form>


    <% if (employee != null) { %>
        <p>Logged in as <strong><%= employee.getFirstName() %> <%= employee.getLastName() %></strong>
        (Role: <%= employee.getRole() %>) at Hotel ID: <%= employee.getHotelID() %></p>

        <!-- Step 2: Booking Type Selection -->
        <form method="post">
            <input type="hidden" name="employeeId" value="<%= employeeId %>" />
            <label><strong>Select Action Type:</strong></label>
            <select name="bookingType" onchange="this.form.submit()">
                <option value="">--Select--</option>
                <option value="online" <%= "online".equals(bookingType) ? "selected" : "" %>>Online Booking</option>
                <option value="inperson" <%= "inperson".equals(bookingType) ? "selected" : "" %>>In-Person Renting</option>
            </select>
        </form>

        <!-- Step 3: Pending Bookings -->
        <% if ("online".equals(bookingType)) { %>
            <div id="pendingBookingsSection">
                <h3>Pending Bookings</h3>
                <% if (!pendingBookings.isEmpty()) { %>
                    <table border="1" cellpadding="8" cellspacing="0" style="margin-top:10px; width:100%; max-width:800px;">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Customer ID</th>
                                <th>Room</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Booking booking : pendingBookings) { %>
                                <tr>
                                    <td><%= booking.getBookingID() %></td>
                                    <td><%= booking.getCustomerID() %></td>
                                    <td><%= booking.getRoomNumber() %></td>
                                    <td><%= booking.getStartDate() %></td>
                                    <td><%= booking.getEndDate() %></td>
                                    <td><%= booking.getStatus() %></td>
                                    <td>
                                        <form method="post" action="confirmBooking.jsp">
                                            <input type="hidden" name="bookingId" value="<%= booking.getBookingID() %>">
                                            <input type="hidden" name="employeeId" value="<%= employeeId %>">
                                            <button type="submit">Confirm</button>
                                        </form>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <p>No pending bookings at this time.</p>
                <% } %>
            </div>
        <% } %>

        <!-- Step 4: In-Person Renting -->
        <% if ("inperson".equals(bookingType)) { %>
            <div id="inPersonBookingSection">
                <h3>In-Person Renting</h3>
                <form id="customerForm" action="createCustomer2.jsp" method="post">
                    <input type="hidden" name="employeeId" value="<%= employeeId %>" />
                    <input type="hidden" name="bookingType" value="inperson" />

                    <label>First Name: <input type="text" name="ipFirstName" required></label>
                    <label>Middle Name (optional): <input type="text" name="ipMiddleName"></label>
                    <label>Last Name: <input type="text" name="ipLastName" required></label>
                    <label>Home Address: <input type="text" name="ipAddress" required></label>

                    <label>ID Type:
                        <select name="ipIdType" required>
                            <option value="">--Select ID Type--</option>
                            <option value="SSN">SSN</option>
                            <option value="SIN">SIN</option>
                            <option value="Driving License">Driving License</option>
                        </select>
                    </label>
                    <label>Current Date: <input type="date" name="ipDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required></label>
                    <label>End Date: <input type="date" name="ipEndDate" required></label>
                    <button type="submit">Sign In/Register</button>
                </form>
                <!-- Available Rooms -->
                <% if (!availableRooms.isEmpty()) { %>
                    <div id="roomSearchSection" style="display: none;">
                        <h4>Available Rooms in Your Hotel</h4>
                        <label>Current Date: <input type="date" name="ipDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required></label>
                        <label>End Date: <input type="date" name="ipEndDate" required></label>
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
                                            <form method="post" action="createRenting.jsp">
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

                <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const urlParams = new URLSearchParams(window.location.search);
                    const isRegistered = urlParams.get("registered");
                    const errorMsg = urlParams.get("error");

                    if (isRegistered) {
                        document.getElementById("customerForm").style.display = "none";
                        document.getElementById("roomSearchSection").style.display = "block";
                    }

                    if (errorMsg) {
                        alert("Error: " + decodeURIComponent(errorMsg));
                    }
                });
                </script>


            </div>
        <% } %>
    <% } else if (employeeId != null) { %>
        <p style="color: red;">Invalid Employee ID. Please try again.</p>
    <% } %>
 </div>

<!-- Admin Section -->
<div class="section" id="adminSection">
    <jsp:include page="adminSection.jsp" />
</div>

<script src="script.js"></script>
</body>
</html>
