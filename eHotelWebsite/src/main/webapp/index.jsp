<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>e-Hotels</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      padding: 20px;
      background-color: #f9f9f9;
    }
    h1, h2 {
      color: #333;
    }
    .section {
      background: #fff;
      padding: 20px;
      margin-top: 20px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      display: none;
    }
    .active {
      display: block;
    }
    label {
      display: block;
      margin: 10px 0 5px;
    }
    input, select, button {
      width: 100%;
      max-width: 400px;
      padding: 8px;
      margin-bottom: 15px;
    }
    button {
      background-color: #007bff;
      color: #fff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
    button:hover {
      background-color: #0056b3;
    }
  </style>
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
          <option value="Toronto">Toronto</option>
          <option value="Montreal">Montreal</option>
          <option value="Vancouver">Vancouver</option>
          <option value="Calgary">Calgary</option>
          <option value="Ottawa">Ottawa</option>
          <option value="Edmonton">Edmonton</option>
          <option value="Quebec City">Quebec City</option>
          <option value="Halifax">Halifax</option>
        </select>
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

      <input type="hidden" id="selectedRoomNumber">
      <input type="hidden" id="selectedHotelId">

      <button type="submit">Search for Hotels</button>
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
            <option value="inperson">In-Person Booking</option>
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

  <div id="roomPopup" style="display:none; position:fixed; top:20%; left:50%; transform:translateX(-50%); background:#fff; padding:20px; border-radius:10px; box-shadow:0 0 10px rgba(0,0,0,0.3); z-index:1000; max-width:90%;">
    <button onclick="document.getElementById('roomPopup').style.display='none'" style="position:absolute; top:3px; right:80px; background:none; border:none; font-size:24px; cursor:pointer; color:black;">&times;</button>
    <h3>Room Info</h3>
    <p><strong>Hotel:</strong> <span id="popupHotel"></span></p>
    <p><strong>City:</strong> <span id="popupCity"></span></p>
    <p><strong>Room Number:</strong> <span id="popupRoom"></span></p>
    <p><strong>Price:</strong> $<span id="popupPrice"></span>/night</p>
    <p><strong>Rating:</strong> <span id="popupRating"></span>/5</p>
    <p><strong>Extendable:</strong> <span id="popupExtendable"></span></p>
    <button onclick="bookRoom()" style="margin-top: 10px;">Book</button>
  </div>

  <script>
    const roleSelect = document.getElementById("roleSelect");
    const sections = {
      customer: document.getElementById("customerSection"),
      employee: document.getElementById("employeeSection"),
      admin: document.getElementById("adminSection")
    };

    roleSelect.addEventListener("change", () => {
      Object.values(sections).forEach(s => s.classList.remove("active"));
      sections[roleSelect.value].classList.add("active");
    });

    document.getElementById("regDate").value = new Date().toISOString().split("T")[0];

    const rooms = [
      { room: "305", hotelId: "1", desc: "Hilton Toronto", city: "toronto", rating: "5", price: 150, extendable: true },
      { room: "402", hotelId: "2", desc: "Marriott Vancouver", city: "vancouver", rating: "4", price: 180, extendable: false },
      { room: "107", hotelId: "3", desc: "Hyatt Montreal", city: "montreal", rating: "3", price: 120, extendable: true },
      { room: "211", hotelId: "4", desc: "Accor Ottawa", city: "ottawa", rating: "2", price: 90, extendable: false },
      { room: "509", hotelId: "5", desc: "Wyndham Calgary", city: "calgary", rating: "5", price: 160, extendable: true }
    ];

    const employees = [
      {
        SIN: "123",
        hotelId: "1",
        fName: "John",
        mName: "A",
        lName: "Smith",
        address: "123 Bay St, Toronto",
        role: "Receptionist"
      },
      {
        SIN: "456",
        hotelId: "2",
        fName: "Emily",
        mName: "B",
        lName: "Davis",
        address: "456 Granville St, Vancouver",
        role: "Front Desk"
      }
    ];

    const bookings = [
      {
        bookingId: "B001",
        customerId: "C001",
        SIN: "111222333",
        hotelId: "1",
        roomNumber: "305",
        bookingDate: "2025-03-25",
        startDate: "2025-03-30",
        endDate: "2025-04-02",
        status: "pending"
      },
      {
        bookingId: "B002",
        customerId: "C002",
        SIN: "444555666",
        hotelId: "2",
        roomNumber: "402",
        bookingDate: "2025-03-20",
        startDate: "2025-03-29",
        endDate: "2025-04-01",
        status: "confirmed"
      },
      {
        bookingId: "B003",
        customerId: "C003",
        SIN: "111222333",
        hotelId: "1",
        roomNumber: "211",
        bookingDate: "2025-03-27",
        startDate: "2025-04-03",
        endDate: "2025-04-05",
        status: "pending"
      }
    ];

    document.getElementById("searchForm").addEventListener("submit", function(e) {
      e.preventDefault();

      const requiredFields = ["fName", "lName", "address", "typeId", "sin", "regDate", "checkinDate", "checkoutDate"];
      let isValid = true;
      requiredFields.forEach(id => {
        const el = document.getElementById(id);
        if (!el.value) {
          isValid = false;
          el.style.border = "2px solid red";
        } else {
          el.style.border = "";
        }
      });

      const checkinDate = new Date(document.getElementById("checkinDate").value);
      const checkoutDate = new Date(document.getElementById("checkoutDate").value);
      if (checkinDate >= checkoutDate) {
        alert("End date must be after start date.");
        return;
      }

      if (!isValid) {
        alert("Please fill in all required fields.");
        return;
      }

      const city = document.getElementById("city").value.toLowerCase();
      const category = document.getElementById("category").value.toLowerCase();
      const budgetRange = document.getElementById("priceRange").value.trim();
      let minPrice = 0, maxPrice = Infinity;

      if (budgetRange.includes("-")) {
        const [min, max] = budgetRange.split("-").map(p => parseFloat(p));
        if (!isNaN(min)) minPrice = min;
        if (!isNaN(max)) maxPrice = max;
      } else {
        const single = parseFloat(budgetRange);
        if (!isNaN(single)) maxPrice = single;
      }

      const extendableOption = document.getElementById("extendableOption").value;
      const results = rooms.filter(r => {
        const cityMatch = !city || r.city.toLowerCase() === city;
        const ratingMatch = !category || r.rating.toLowerCase() === category;
        const priceMatch = r.price >= minPrice && r.price <= maxPrice;
        const extendableMatch = !extendableOption || r.extendable === (extendableOption === "true");
        return cityMatch && ratingMatch && priceMatch && extendableMatch;
      });

      const output = results.map(r => `<button onclick="selectRoom('${r.room}', '${r.hotelId}')">Room ${r.room} - ${r.desc} - $${r.price}/night</button><br>`).join("");
      document.getElementById("availableRooms").innerHTML = results.length ? `<h3>Available Rooms</h3>${output}` : "<p>No rooms match your criteria.</p>";
    });

    function selectRoom(roomNumber, hotelId) {
      const room = rooms.find(r => r.room === roomNumber && r.hotelId === hotelId);
      if (!room) return;
      document.getElementById("selectedRoomNumber").value = room.room;
      document.getElementById("selectedHotelId").value = room.hotelId;
      document.getElementById("popupHotel").textContent = room.desc;
      document.getElementById("popupCity").textContent = room.city;
      document.getElementById("popupRoom").textContent = room.room;
      document.getElementById("popupPrice").textContent = room.price;
      document.getElementById("popupRating").textContent = room.rating;
      document.getElementById("popupExtendable").textContent = room.extendable ? "Yes" : "No";
      document.getElementById("roomPopup").style.display = "block";
    }

    function selectInPersonRoom(roomNumber, hotelId) {
      const room = rooms.find(r => r.room === roomNumber && r.hotelId === hotelId);
      if (!room) return;

      document.getElementById("selectedRoomNumber").value = room.room;
      document.getElementById("selectedHotelId").value = room.hotelId;
      document.getElementById("popupHotel").textContent = room.desc;
      document.getElementById("popupCity").textContent = room.city;
      document.getElementById("popupRoom").textContent = room.room;
      document.getElementById("popupPrice").textContent = room.price;
      document.getElementById("popupRating").textContent = room.rating;
      document.getElementById("popupExtendable").textContent = room.extendable ? "Yes" : "No";

      // Change button label to reflect in-person
      const bookBtn = document.querySelector("#roomPopup button");


      document.getElementById("roomPopup").style.display = "block";
    }

    function bookRoom() {
      alert("Booking confirmed for Room " + document.getElementById("selectedRoomNumber").value);
      document.getElementById("roomPopup").style.display = "none";
    }

    function bookInPersonRoom() {
      const roomNum = document.getElementById("selectedRoomNumber").value;
      const hotelId = document.getElementById("selectedHotelId").value;
      alert(`Room ${roomNum} at hotel ${hotelId} has been booked for the customer (in-person).`);

      // Optional: close modal
      document.getElementById("roomPopup").style.display = "none";
    }


    document.getElementById("employeeLoginForm").addEventListener("submit", function(e) {
      e.preventDefault();
      const empId = document.getElementById("employeeIdInput").value.trim();

      const employee = employees.find(emp => emp.SIN === empId);
      const bookingsContainer = document.getElementById("pendingBookingsSection");

      if (!employee) {
        document.getElementById("bookingTypeSelector").style.display = "none";
        bookingsContainer.style.display = "none";
        alert("Employee ID not found.");
        return;
      }

      // Show booking type dropdown
      document.getElementById("bookingTypeSelector").style.display = "block";

      // Generate online booking content ahead of time
      const employeeHotelBookings = bookings.filter(b =>
        b.hotelId === employee.hotelId && b.status.toLowerCase() === "pending"
      );

      let onlineBookingHTML = `<p>Logged in as ${employee.fName} ${employee.lName} (${employee.role}) at Hotel ID ${employee.hotelId}</p>`;

      if (employeeHotelBookings.length) {
        onlineBookingHTML += `
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
        `;
        employeeHotelBookings.forEach(b => {
          onlineBookingHTML += `
            <tr id="bookingRow-${b.bookingId}">
              <td>${b.bookingId}</td>
              <td>${b.customerId}</td>
              <td>${b.roomNumber}</td>
              <td>${b.startDate}</td>
              <td>${b.endDate}</td>
              <td id="status-${b.bookingId}">${b.status}</td>
              <td><button onclick="confirmBooking('${b.bookingId}')">Confirm</button></td>
            </tr>
          `;
        });
        onlineBookingHTML += `</tbody></table>`;
      } else {
        onlineBookingHTML += `<p>No pending bookings at this time.</p>`;
      }

      // Handle dropdown change
      document.getElementById("bookingType").onchange = function () {
        const type = this.value;
        const bookingContent = document.getElementById("pendingBookingsSection");

        if (type === "online") {
          bookingContent.innerHTML = `<h3>Pending Bookings</h3>${onlineBookingHTML}`;
          bookingContent.style.display = "block";
        } else if (type === "inperson") {
          bookingContent.innerHTML = `
            <h3>In-Person Booking</h3>
            <form id="inPersonBookingForm">
              <label>First Name: <input type="text" id="ipFirstName" required></label>
              <label>Middle Name (optional): <input type="text" id="ipMiddleName"></label>
              <label>Last Name: <input type="text" id="ipLastName" required></label>
              <label>Home Address: <input type="text" id="ipAddress" required></label>
              <label>ID Type:
                <select id="ipIdType" required>
                  <option value="">--Select ID Type--</option>
                  <option value="SSN">SSN</option>
                  <option value="SIN">SIN</option>
                  <option value="Driving License">Driving License</option>
                </select>
              </label>
              <label>Enter ID #: <input type="text" id="ipIdNumber" required></label>
              <label>Current Date: <input type="date" id="ipDate" required></label>

              <h4>Booking Info</h4>
              <label>End Date: <input type="date" id="ipEndDate" required></label>
              <label>Budget (Max Price Per Night): <input type="number" id="ipBudget" min="0" ></label>

              <button type="submit">Search for Rooms</button>
            </form>

            <div id="inPersonAvailableRooms"></div>
          `;
          bookingContent.style.display = "block";

          document.getElementById("ipDate").value = new Date().toISOString().split("T")[0];

          document.getElementById("inPersonBookingForm").addEventListener("submit", function (e) {
            e.preventDefault();

            const budgetInput = document.getElementById("ipBudget").value.trim();
            const budget = parseFloat(budgetInput);
            const hasBudget = budgetInput !== "" && !isNaN(budget) && budget > 0;

            const endDate = new Date(document.getElementById("ipEndDate").value);
            const today = new Date();

            if (endDate <= today) {
              alert("End date must be in the future.");
              return;
            }

            // Get current employee hotel from previous login
            const empId = document.getElementById("employeeIdInput").value.trim();
            const employee = employees.find(emp => emp.SIN === empId);
            if (!employee) return;

            const filteredRooms = rooms.filter(room =>
              room.hotelId === employee.hotelId &&
              (hasBudget ? room.price <= budget : true)
            );


            const roomList = filteredRooms.length
              ? filteredRooms.map(r =>
                  `<button onclick="selectInPersonRoom('${r.room}', '${r.hotelId}')">Room ${r.room} - $${r.price}/night - ${r.desc}</button><br>`
                ).join("")
              : `<p>No rooms available in your hotel under the selected budget.</p>`;

            document.getElementById("inPersonAvailableRooms").innerHTML = `
              <h4>Available Rooms in Your Hotel</h4>
              ${roomList}
            `;
          });
        } else {
          bookingContent.style.display = "none";
        }
      };


      // Reset previous display
      bookingsContainer.innerHTML = "";
      bookingsContainer.style.display = "none";
    });

    function confirmBooking(bookingId) {
      const booking = bookings.find(b => b.bookingId === bookingId);
      if (!booking) return;

      // Update status
      booking.status = "confirmed";

      // Update DOM
      document.getElementById(`status-${bookingId}`).textContent = "confirmed";

      document.getElementById(`bookingRow-${bookingId}`).style.display = "none";

      alert(`Booking ${bookingId} has been confirmed.`);
    }

  </script>
</body>
</html>
