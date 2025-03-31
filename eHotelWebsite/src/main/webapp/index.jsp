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

    <!-- Step 1: Employee Login -->
    <form method="post">
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
                <form method="post">
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
                    <label>Enter ID #: <input type="text" name="ipIdNumber" required></label>

                    <label>Current Date: <input type="date" name="ipDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required></label>
                    <label>End Date: <input type="date" name="ipEndDate" required></label>

                    <label>Budget (Max Price Per Night): <input type="number" name="ipBudget" min="0"></label>
                    <button type="submit">Search for Rooms</button>
                </form>

                <!-- Available Rooms -->
                <% if (!availableRooms.isEmpty()) { %>
                    <h4>Available Rooms in Your Hotel</h4>
                    <ul>
                        <% for (Room room : availableRooms) { %>
                            <li>Room <%= room.getRoomNumber() %> - $<%= room.getPrice() %>/night</li>
                        <% } %>
                    </ul>
                <% } else if (request.getParameter("ipBudget") != null) { %>
                    <p>No rooms available under the selected budget.</p>
                <% } %>
            </div>
        <% } %>
    <% } else if (employeeId != null) { %>
        <p style="color: red;">Invalid Employee ID. Please try again.</p>
    <% } %>
 </div>


 <!-- Admin Section -->
 <div class="section" id="adminSection">
   <h2>Admin Panel</h2>

   <!-- Step One: Admin ID Entry -->
   <form id="adminLoginForm">
     <label>Enter Admin ID:
       <input type="text" id="adminIdInput" required />
     </label>
     <button type="submit">Enter</button>
   </form>

   <!-- Admin Dashboard Area -->
   <div id="adminDashboard" style="display: none; margin-top: 20px;">
     <p id="adminWelcomeText"></p>

     <label for="adminActionSelect"><strong>Select Management Section:</strong></label>
     <select id="adminActionSelect">
       <option value="">-- Select Section --</option>
       <option value="customers">Manage Customers</option>
       <option value="employees">Manage Employees</option>
       <option value="hotels">Manage Hotels</option>
       <option value="rooms">Manage Rooms</option>
     </select>

     <div id="adminActionArea" style="margin-top: 20px;"></div>
     <!-- Room management options (initially hidden) -->
       <div id="roomManagementOptions" style="display: none;">
         <p><strong>Choose Room Management Action:</strong></p>
         <div style="display: flex; gap: 20px;">
           <label><input type="radio" name="roomAction" value="insert"> Insert Room</label>
           <label><input type="radio" name="roomAction" value="delete"> Delete Room</label>
           <label><input type="radio" name="roomAction" value="update"> Update Room</label>
         </div>
       </div>

       <!-- Placeholder where the selected form (insert/delete/update) will go -->
       <div id="roomActionFormArea" style="margin-top: 20px;"></div>
   </div>
 </div>


 <div id="roomPopup" style="display: none; position: fixed; top: 10%; left: 50%; transform: translateX(-50%); background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 0 15px rgba(0,0,0,0.35); z-index: 1000; width: 600px; max-width: 95%; max-height: 80vh; overflow-y: auto;">
   <button onclick="document.getElementById('roomPopup').style.display='none'" style="position:absolute; top:5px; left:400px; background:none; border:none; font-size:28px; cursor:pointer; color:black;">&times;</button>

   <h3>Room Info</h3>
   <p><strong>Hotel Chain:</strong> <span id="popupHotel"></span></p>
   <p><strong>City:</strong> <span id="popupCity"></span></p>
   <p><strong>Room Number:</strong> <span id="popupRoom"></span></p>
   <p><strong>Price:</strong> $<span id="popupPrice"></span>/night</p>
   <p><strong>Rating:</strong> <span id="popupRating"></span>/5</p>
   <p><strong>Extendable:</strong> <span id="popupExtendable"></span></p>
   <p><strong>Capacity:</strong> <span id="popupCapacity"></span> guests</p>
   <p><strong>Total Rooms in Hotel:</strong> <span id="popupNumRooms"></span></p>

   <h4 style="margin-top: 20px;">Payment Info:</h4>
   <div style="display: flex; flex-direction: column; gap: 12px; margin-top: 10px;">
     <div>
       <label for="cardName"><strong>Credit Card Name</strong></label><br>
       <input type="text" id="cardName" required style="width: 100%;" />
     </div>
     <div>
       <label for="cardNumber"><strong>Card Number</strong></label><br>
       <input type="text" id="cardNumber" required style="width: 100%;" />
     </div>
     <div>
       <label for="expiryDate"><strong>Expiry Date</strong></label><br>
       <input type="month" id="expiryDate" required style="width: 100%;" />
     </div>
     <div>
       <label for="cvv"><strong>CVV</strong></label><br>
       <input type="text" id="cvv" required style="width: 100%;" />
     </div>
   </div>

   <button id="confirmBookingBtn" style="margin-top: 15px;">Confirm</button>
 </div>

<script src="script.js"></script>
</body>
</html>
