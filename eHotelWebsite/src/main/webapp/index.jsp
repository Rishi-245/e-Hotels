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
    <p>Manage bookings, check-ins, and payments (to be implemented).</p>
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

    function bookRoom() {
      alert("Booking confirmed for Room " + document.getElementById("selectedRoomNumber").value);
      document.getElementById("roomPopup").style.display = "none";
    }
  </script>
</body>
</html>
