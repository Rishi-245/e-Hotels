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
 <label for="roleSelect"><strong>Select Role:</strong></label>
 <select id="roleSelect">
   <option value="customer">Customer</option>
   <option value="employee">Employee</option>
   <option value="admin">Admin</option>
 </select>


 <!-- Customer Section -->
 <div class="section active" id="customerSection">
   <h2>Customer Info</h2>
   <form id="searchForm">
     <label>First Name: <input type="text" id="fName" required></label>
     <label>Middle Name (optional): <input type="text" id="mName"></label>
     <label>Last Name: <input type="text" id="lName" required></label>
     <label>Home Address: <input type="text" id="address" required></label>
     <label>ID Type:
       <select id="typeId" required>
         <option value="">--Select ID Type--</option>
         <option value="SSN">SSN</option>
         <option value="SIN">SIN</option>
         <option value="Driving License">Driving License</option>
       </select>
     </label>
     <label>Enter ID #: <input type="text" id="sin" required></label>
     <label>Current Date: <input type="date" id="regDate" value="" required></label>


     <h2>Booking Info</h2>
     <label>Start Date: <input type="date" id="checkinDate" required></label>
     <label>End Date: <input type="date" id="checkoutDate" required></label>
     <label>City:
       <select id="city">
         <option value="">--Select City--</option>
       </select>
     </label>

     <label>Hotel Chain:
       <select id="hotelChain">
         <option value="">--Select Chain--</option>
       </select>
     </label>

     <label>Room Capacity:
       <input type="number" id="roomCapacity" min="1" placeholder="Enter desired capacity" />
     </label>

     <label>Room Rating (1-5):
       <select id="category" min="1" max="5">
         <option value="">--Select Rating--</option>
         <option value="1">1</option>
         <option value="2">2</option>
         <option value="3">3</option>
         <option value="4">4</option>
         <option value="5">5</option>
       </select>
     </label>
     <label>Budget (Price Per Night Range): <input type="text" id="priceRange"></label>
     <label>Extendable:
       <select id="extendableOption">
         <option value="">--Select--</option>
         <option value="true">True</option>
         <option value="false">False</option>
       </select>
     </label>

     <label>Number of Rooms in Hotel (minimum):
       <input type="number" id="numRooms" min="1" placeholder="e.g., 10">
     </label>

     <input type="hidden" id="selectedRoomNumber">
     <input type="hidden" id="selectedHotelId">


     <button type="submit">Search for Rooms</button>
   </form>
   <div id="availableRooms"></div>
 </div>


 <!-- Employee Section -->
 <div class="section" id="employeeSection">
   <h2>Employee Panel</h2>


   <!-- Step One: Employee ID Entry -->
   <form id="employeeLoginForm">
     <label>Enter Employee ID:
       <input type="text" id="employeeIdInput" required />
     </label>
     <button type="submit">Enter</button>
   </form>


   <div id="bookingTypeSelector" style="display: none; margin-top: 20px;">
         <label for="bookingType"><strong>Select Booking Type:</strong></label>
         <select id="bookingType">
           <option value="">--Select--</option>
           <option value="online">Online Booking</option>
           <option value="inperson">In-Person Renting</option>
         </select>
      </div>


   <!-- Hidden by default: appears after login -->
   <div id="pendingBookingsSection" style="display: none; margin-top: 30px;">
     <h3>Pending Bookings</h3>
     <p>(This section will later list bookings ready for check-in.)</p>
   </div>
 </div>


 <!-- Admin Section -->
 <div class="section" id="adminSection">
   <h2>Admin Panel</h2>
   <p>Manage hotels, rooms, and staff (to be implemented).</p>
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

