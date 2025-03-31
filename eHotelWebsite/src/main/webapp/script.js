    const sections = {
      customer: document.getElementById("customerSection"),
      employee: document.getElementById("employeeSection"),
      admin: document.getElementById("adminSection")
    };

    // Radio role selection logic
    document.querySelectorAll('input[name="role"]').forEach(radio => {
      radio.addEventListener("change", function () {
        Object.values(sections).forEach(s => s.classList.remove("active"));
        sections[this.value].classList.add("active");
      });
    });


   document.getElementById("regDate").value = new Date().toISOString().split("T")[0];


   const rooms = [
     { room: "305", hotelId: "1", chain: "Hilton", city: "Toronto", rating: "5", price: 150, extendable: true, capacity: 4, numOfRoomsInHotel: 15, area: "Downtown" },
     { room: "101", hotelId: "1", chain: "Hilton", city: "Toronto", rating: "5", price: 120, extendable: false, capacity: 2, numOfRoomsInHotel: 15, area: "Downtown" },
     { room: "402", hotelId: "2", chain: "Marriott", city: "Vancouver", rating: "4", price: 180, extendable: true, capacity: 3, numOfRoomsInHotel: 25, area: "West End" },
     { room: "507", hotelId: "3", chain: "Hilton", city: "Calgary", rating: "4", price: 140, extendable: false, capacity: 2, numOfRoomsInHotel: 10, area: "Beltline" },
     { room: "208", hotelId: "4", chain: "Hyatt", city: "Montreal", rating: "3", price: 110, extendable: true, capacity: 2, numOfRoomsInHotel: 18, area: "Old Port" },
     { room: "612", hotelId: "5", chain: "Accor", city: "Ottawa", rating: "2", price: 90, extendable: false, capacity: 1, numOfRoomsInHotel: 12, area: "ByWard Market" },
     { room: "806", hotelId: "6", chain: "Hilton", city: "Edmonton", rating: "3", price: 115, extendable: true, capacity: 2, numOfRoomsInHotel: 22, area: "Downtown" },
     { room: "303", hotelId: "7", chain: "Wyndham", city: "Halifax", rating: "4", price: 130, extendable: false, capacity: 3, numOfRoomsInHotel: 17, area: "Waterfront" },
     { room: "911", hotelId: "8", chain: "Fairmont", city: "Quebec City", rating: "5", price: 200, extendable: true, capacity: 4, numOfRoomsInHotel: 20, area: "Old Quebec" },
     { room: "110", hotelId: "9", chain: "Marriott", city: "Toronto", rating: "4", price: 145, extendable: false, capacity: 2, numOfRoomsInHotel: 30, area: "Financial District" }
   ];

   const hotelChains = [
     { chain_id: "HC001", name: "Hilton", central_office_address: "7930 Jones Branch Dr, McLean, VA, USA", num_hotels: 6 },
     { chain_id: "HC002", name: "Marriott", central_office_address: "10400 Fernwood Rd, Bethesda, MD, USA", num_hotels: 8 },
     { chain_id: "HC003", name: "Hyatt", central_office_address: "150 N Riverside Plaza, Chicago, IL, USA", num_hotels: 5 },
     { chain_id: "HC004", name: "Wyndham", central_office_address: "22 Sylvan Way, Parsippany, NJ, USA", num_hotels: 4 },
     { chain_id: "HC005", name: "Accor", central_office_address: "82 Rue Henri Farman, Issy-les-Moulineaux, France", num_hotels: 3 },
     { chain_id: "HC006", name: "Fairmont", central_office_address: "100 Front St W, Toronto, ON, Canada", num_hotels: 2 },
     { chain_id: "HC007", name: "Best Western", central_office_address: "6201 N 24th Pkwy, Phoenix, AZ, USA", num_hotels: 4 },
     { chain_id: "HC008", name: "Sheraton", central_office_address: "500 Merritt 7, Norwalk, CT, USA", num_hotels: 3 },
     { chain_id: "HC009", name: "Radisson", central_office_address: "701 Carlson Pkwy, Minnetonka, MN, USA", num_hotels: 5 },
     { chain_id: "HC010", name: "InterContinental", central_office_address: "3 Ravinia Dr, Atlanta, GA, USA", num_hotels: 6 }
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

   function populateCityDropdown() {
     const citySelect = document.getElementById("city");

     if (!citySelect) {
       console.warn("City select element not found");
       return;
     }

     const citySet = new Set();

     rooms.forEach(room => {
       if (room.city && room.city.trim() !== "") {
         citySet.add(room.city.trim());
       }
     });

     // Clear all options first
     citySelect.innerHTML = '<option value="">--Select City--</option>';

     citySet.forEach(city => {
       const option = document.createElement("option");
       option.value = city;
       option.textContent = city;
       citySelect.appendChild(option);
     });
   }

   function populateHotelChainDropdown() {
     const chainSelect = document.getElementById("hotelChain");

     if (!chainSelect) {
       console.warn("Hotel chain select element not found");
       return;
     }

     // Use a Set to avoid duplicates
     const chainSet = new Set();

     rooms.forEach(room => {
       if (room.chain && room.chain.trim() !== "") {
         chainSet.add(room.chain.trim());
       }
     });

     // Clear existing options
     chainSelect.innerHTML = '<option value="">--Select Chain--</option>';

     chainSet.forEach(chain => {
       const option = document.createElement("option");
       option.value = chain;
       option.textContent = chain;
       chainSelect.appendChild(option);
     });
   }

   // Ensure this runs only after DOM is loaded
   window.addEventListener("DOMContentLoaded", () => {
     populateCityDropdown();
   });

   window.addEventListener("DOMContentLoaded", () => {
     populateCityDropdown();
     populateHotelChainDropdown();
   });

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
     const selectedChain = document.getElementById("hotelChain").value.toLowerCase();
     const capacityInput = document.getElementById("roomCapacity").value.trim();
     const numRoomsInput = document.getElementById("numRooms").value.trim();
     const minNumRooms = parseInt(numRoomsInput);
     const desiredCapacity = parseInt(capacityInput);


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
       const chainMatch = !selectedChain || r.chain.toLowerCase() === selectedChain;
       const capacityMatch = !desiredCapacity || r.capacity >= desiredCapacity;
       const ratingMatch = !category || r.rating.toLowerCase() === category;
       const priceMatch = r.price >= minPrice && r.price <= maxPrice;
       const extendableMatch = !extendableOption || r.extendable === (extendableOption === "true");
       const roomCountMatch = !minNumRooms || r.numOfRoomsInHotel >= minNumRooms;

       return cityMatch && ratingMatch && priceMatch && extendableMatch && chainMatch
            && capacityMatch && roomCountMatch;
     });

    const output = results.map(r => `
        <button onclick="selectRoom('${r.room}', '${r.hotelId}')">
          Room ${r.room} - ${r.chain} - $${r.price}/night
        </button><br>
      `).join("");

      document.getElementById("availableRooms").innerHTML = results.length
        ? `<h3>Available Rooms</h3>${output}`
        : "<p>No rooms match your criteria.</p>";
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
     document.getElementById("popupCapacity").textContent = room.capacity ?? "N/A";
     document.getElementById("popupNumRooms").textContent = room.numOfRoomsInHotel ?? "N/A";

     // Set correct confirm button behavior
     const confirmBtn = document.getElementById("confirmBookingBtn");
     confirmBtn.onclick = validateAndBookRoom;

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
     document.getElementById("popupCapacity").textContent = room.capacity ?? "N/A";
     document.getElementById("popupNumRooms").textContent = room.numOfRoomsInHotel ?? "N/A";

      // Set confirm button to rent logic
      const confirmBtn = document.getElementById("confirmBookingBtn");
      confirmBtn.onclick = validateAndRentRoom;

     document.getElementById("roomPopup").style.display = "block";
   }


   function bookRoom() {
     alert("Booking confirmed for Room " + document.getElementById("selectedRoomNumber").value);
     document.getElementById("roomPopup").style.display = "none";
   }

   function rentRoom() {
        alert("Renting confirmed for Room " + document.getElementById("selectedRoomNumber").value);
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
           <h3>In-Person Renting</h3>
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
                 `<button onclick="selectInPersonRoom('${r.room}', '${r.hotelId}')">Room ${r.room} - $${r.price}/night</button><br>`
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


   function validateAndBookRoom() {
         const name = document.getElementById("cardName").value.trim();
         const number = document.getElementById("cardNumber").value.trim();
         const expiry = document.getElementById("expiryDate").value.trim();
         const cvv = document.getElementById("cvv").value.trim();


         if (!name || !number || !expiry || !cvv) {
           alert("Please fill in all credit card fields to proceed.");
           return;
         }


         if (!/^[0-9]{16}$/.test(number)) {
           alert("Card number must be 16 digits.");
           return;
         }


         if (!/^[0-9]{3,4}$/.test(cvv)) {
           alert("CVV must be 3 or 4 digits.");
           return;
         }


         bookRoom();
   }

   function validateAndRentRoom() {
            const name = document.getElementById("cardName").value.trim();
            const number = document.getElementById("cardNumber").value.trim();
            const expiry = document.getElementById("expiryDate").value.trim();
            const cvv = document.getElementById("cvv").value.trim();


            if (!name || !number || !expiry || !cvv) {
              alert("Please fill in all credit card fields to proceed.");
              return;
            }


            if (!/^[0-9]{16}$/.test(number)) {
              alert("Card number must be 16 digits.");
              return;
            }


            if (!/^[0-9]{3,4}$/.test(cvv)) {
              alert("CVV must be 3 or 4 digits.");
              return;
            }


            rentRoom();
      }

     const validAdmins = [
       { id: "admin001", name: "Alice Smith" },
       { id: "admin002", name: "Bob Johnson" }
     ];

    document.getElementById("adminLoginForm").addEventListener("submit", function (e) {
      e.preventDefault();
      const adminId = document.getElementById("adminIdInput").value.trim();
      const admin = validAdmins.find(a => a.id === adminId);

      if (!admin) {
        document.getElementById("adminDashboard").style.display = "none";
        alert("Admin ID not found.");
        return;
      }

      document.getElementById("adminWelcomeText").textContent = `Welcome, ${admin.name}!`;
      document.getElementById("adminDashboard").style.display = "block";
      document.getElementById("adminActionArea").innerHTML = ""; // Clear previous
    });

    document.getElementById("adminActionSelect").addEventListener("change", function () {
      const selected = this.value;
      const area = document.getElementById("adminActionArea");

      area.innerHTML = ""; // Clear previous content

      if (!selected) return;

      if (selected === "rooms") {
        area.innerHTML = `
          <div id="roomManagementOptions" style="margin-top: 10px;">
            <p><strong>Choose Room Management Action:</strong></p>
            <div style="display: flex; gap: 20px;">
              <label><input type="radio" name="roomAction" value="insert"> Insert Room</label>
              <label><input type="radio" name="roomAction" value="delete"> Delete Room</label>
              <label><input type="radio" name="roomAction" value="update"> Update Room</label>
            </div>
            <div id="roomActionFormArea" style="margin-top: 20px;"></div>
          </div>
        `;

        document.querySelectorAll('input[name="roomAction"]').forEach(radio => {
          radio.addEventListener('change', function () {
            const formArea = document.getElementById("roomActionFormArea");
            formArea.innerHTML = "";

            if (this.value === "insert") {
                showInsertRoomForm();
            }

            if (this.value === "update") {
                showUpdateRoomForm();
            }

            if (this.value === "delete") {
              if (rooms.length === 0) {
                formArea.innerHTML = "<p>No rooms available for deletion.</p>";
                return;
              }

              let tableHTML = `
                <table border="1" cellpadding="8" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Hotel ID</th>
                      <th>Room Number</th>
                      <th>Extendable</th>
                      <th>Price</th>
                      <th>Capacity</th>
                      <th>View Type</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
              `;

              rooms.forEach(room => {
                const uniqueId = `roomRow-${room.hotelId}-${room.room}`;
                tableHTML += `
                  <tr id="${uniqueId}">
                    <td>${room.hotelId}</td>
                    <td>${room.room}</td>
                    <td>${room.extendable ? "Yes" : "No"}</td>
                    <td>$${room.price}</td>
                    <td>${room.capacity}</td>
                    <td>${room.view_type ?? "N/A"}</td>
                    <td><button onclick="deleteRoom('${room.hotelId}', '${room.room}')">Delete</button></td>
                  </tr>
                `;
              });

              tableHTML += "</tbody></table>";
              formArea.innerHTML = tableHTML;
            }
          });
        });
      } else if (selected === "customers") {
            area.innerHTML = `
                <div id="customerManagementOptions" style="margin-top: 10px;">
                  <p><strong>Choose Customer Management Action:</strong></p>
                  <div style="display: flex; gap: 20px;">
                    <label><input type="radio" name="customerAction" value="insert"> Insert Customer</label>
                    <label><input type="radio" name="customerAction" value="delete"> Delete Customer</label>
                    <label><input type="radio" name="customerAction" value="update"> Update Customer</label>
                  </div>
                  <div id="customerActionFormArea" style="margin-top: 20px;"></div>
                </div>
              `;

              document.querySelectorAll('input[name="customerAction"]').forEach(radio => {
                radio.addEventListener('change', function () {
                  const formArea = document.getElementById("customerActionFormArea");
                  formArea.innerHTML = "";

                  if (this.value === "insert") {
                    formArea.innerHTML = `
                      <h4>Insert New Customer</h4>
                      <form id="insertCustomerForm">
                        <label>Customer ID: <input type="text" required></label><br>
                        <label>First Name: <input type="text" required></label><br>
                        <label>Middle Name: <input type="text"></label><br>
                        <label>Last Name: <input type="text" required></label><br>
                        <label>Address: <input type="text" required></label><br>
                        <label>Type ID: <input type="text" required></label><br>
                        <label>Registration Date: <input type="date" required></label><br>
                        <button type="submit">Insert Customer</button>
                      </form>
                    `;

                    document.getElementById("insertCustomerForm").addEventListener("submit", function(e) {
                        e.preventDefault();
                        // You can now handle insert logic here...
                        alert("Customer inserted (fake alert for now)"); /////////////////////////////////////////////////////
                     });
                  }

                  if (this.value === "delete") {
                    formArea.innerHTML = `
                      <h4>Delete Customer</h4>
                      <form id="deleteCustomerForm">
                        <label>Customer ID: <input type="text" required></label><br>
                        <button type="submit">Delete Customer</button>
                      </form>
                    `;

                    document.getElementById("deleteCustomerForm").addEventListener("submit", function(e) {
                        e.preventDefault();
                        // You can now handle insert logic here...
                        alert("Customer deleted (fake alert for now)"); /////////////////////////////////////////////////////
                    });
                  }

                  if (this.value === "update") {
                    formArea.innerHTML = `
                      <h4>Update Customer</h4>
                      <form id="updateCustomerForm">
                        <label>Customer ID: <input type="text" required></label><br>
                        <p><em>Leave any field blank to keep it unchanged.</em></p>
                        <label>First Name: <input type="text"></label><br>
                        <label>Middle Name: <input type="text"></label><br>
                        <label>Last Name: <input type="text"></label><br>
                        <label>Address: <input type="text"></label><br>
                        <label>Type ID: <input type="text"></label><br>
                        <label>Registration Date: <input type="date"></label><br>
                        <button type="submit">Update Customer</button>
                      </form>
                    `;

                    document.getElementById("updateCustomerForm").addEventListener("submit", function(e) {
                        e.preventDefault();
                        // You can now handle insert logic here...
                        alert("Customer updated (fake alert for now)"); /////////////////////////////////////////////////////
                     });
                  }
                });
              });
      } else if (selected === "employees") {
        area.innerHTML = `
            <div id="employeeManagementOptions" style="margin-top: 10px;">
              <p><strong>Choose Employee Management Action:</strong></p>
              <div style="display: flex; gap: 20px;">
                <label><input type="radio" name="employeeAction" value="insert"> Insert Employee</label>
                <label><input type="radio" name="employeeAction" value="delete"> Delete Employee</label>
                <label><input type="radio" name="employeeAction" value="update"> Update Employee</label>
              </div>
              <div id="employeeActionFormArea" style="margin-top: 20px;"></div>
            </div>
          `;

          document.querySelectorAll('input[name="employeeAction"]').forEach(radio => {
            radio.addEventListener('change', function () {
              const formArea = document.getElementById("employeeActionFormArea");
              formArea.innerHTML = "";

              // INSERT EMPLOYEE
              if (this.value === "insert") {
                formArea.innerHTML = `
                  <h4>Insert New Employee</h4>
                  <form id="insertEmployeeForm">
                    <label>SIN: <input type="text" required></label><br>
                    <label>Hotel ID: <input type="text" required></label><br>
                    <label>First Name: <input type="text" required></label><br>
                    <label>Middle Name: <input type="text"></label><br>
                    <label>Last Name: <input type="text" required></label><br>
                    <label>Address: <input type="text" required></label><br>
                    <label>Role: <input type="text" required></label><br>
                    <button type="submit">Insert Employee</button>
                  </form>
                `;

                document.getElementById("insertEmployeeForm").addEventListener("submit", function (e) {
                  e.preventDefault();
                  alert("Employee inserted (mock alert)");
                });
              }

              // DELETE EMPLOYEE
              if (this.value === "delete") {
                formArea.innerHTML = `
                  <h4>Delete Employee</h4>
                  <form id="deleteEmployeeForm">
                    <label>SIN: <input type="text" required></label><br>
                    <button type="submit">Delete Employee</button>
                  </form>
                `;

                document.getElementById("deleteEmployeeForm").addEventListener("submit", function (e) {
                  e.preventDefault();
                  alert("Employee deleted (mock alert)");
                });
              }

              // UPDATE EMPLOYEE
              if (this.value === "update") {
                formArea.innerHTML = `
                  <h4>Update Employee</h4>
                  <form id="updateEmployeeForm">
                    <label>SIN: <input type="text" required></label><br>
                    <p><em>Leave any field blank to keep it unchanged.</em></p>
                    <label>Hotel ID: <input type="text"></label><br>
                    <label>First Name: <input type="text"></label><br>
                    <label>Middle Name: <input type="text"></label><br>
                    <label>Last Name: <input type="text"></label><br>
                    <label>Address: <input type="text"></label><br>
                    <label>Role: <input type="text"></label><br>
                    <button type="submit">Update Employee</button>
                  </form>
                `;

                document.getElementById("updateEmployeeForm").addEventListener("submit", function (e) {
                  e.preventDefault();
                  alert("Employee updated (mock alert)");
                });
              }
            });
          });
      } else if (selected === "hotels") {
        area.innerHTML = `
            <div id="hotelManagementOptions" style="margin-top: 10px;">
              <p><strong>Choose Hotel Management Action:</strong></p>
              <div style="display: flex; gap: 20px;">
                <label><input type="radio" name="hotelAction" value="insert"> Insert Hotel</label>
                <label><input type="radio" name="hotelAction" value="delete"> Delete Hotel</label>
                <label><input type="radio" name="hotelAction" value="update"> Update Hotel</label>
              </div>
              <div id="hotelActionFormArea" style="margin-top: 20px;"></div>
            </div>
          `;

          document.querySelectorAll('input[name="hotelAction"]').forEach(radio => {
            radio.addEventListener('change', function () {
              const formArea = document.getElementById("hotelActionFormArea");
              formArea.innerHTML = "";

              if (this.value === "insert") {
                formArea.innerHTML = `
                  <h4>Insert New Hotel</h4>
                  <form id="insertHotelForm">
                    <label>Hotel ID: <input type="text" required></label><br>
                    <label>Chain ID: <input type="text" required></label><br>
                    <label>Category: <input type="text" required></label><br>
                    <label>Number of Rooms: <input type="number" required></label><br>
                    <label>Address: <input type="text" required></label><br>
                    <label>Email: <input type="email" required></label><br>
                    <button type="submit">Insert Hotel</button>
                  </form>
                `;

                document.getElementById("insertHotelForm").addEventListener("submit", function (e) {
                    e.preventDefault();
                    alert("Hotel inserted (mock alert)");
                });
              }

              if (this.value === "delete") {
                formArea.innerHTML = `
                  <h4>Delete Hotel</h4>
                  <form id="deleteHotelForm">
                    <label>Hotel ID: <input type="text" required></label><br>
                    <button type="submit">Delete Hotel</button>
                  </form>
                `;

                document.getElementById("deleteHotelForm").addEventListener("submit", function (e) {
                    e.preventDefault();
                    alert("Hotel deleted (mock alert)");
                });
              }

              if (this.value === "update") {
                formArea.innerHTML = `
                  <h4>Update Hotel</h4>
                  <form id="updateHotelForm">
                    <label>Hotel ID: <input type="text" required></label><br>
                    <p><em>Leave any field blank to keep it unchanged.</em></p>
                    <label>Chain ID: <input type="text"></label><br>
                    <label>Category: <input type="text"></label><br>
                    <label>Number of Rooms: <input type="number"></label><br>
                    <label>Address: <input type="text"></label><br>
                    <label>Email: <input type="email"></label><br>
                    <button type="submit">Update Hotel</button>
                  </form>
                `;

                document.getElementById("updateHotelForm").addEventListener("submit", function (e) {
                    e.preventDefault();
                    alert("Hotel updated (mock alert)");
                });
              }
            });
          });
      } else {
        area.innerHTML = `<h3>${selected.charAt(0).toUpperCase() + selected.slice(1)} Management</h3>
          <p>Insert / Delete / Update functionality coming soon for <strong>${selected}</strong>.</p>`;
      }
    });

    // Delete function (mock version)
    function deleteRoom(hotelId, roomNumber) {
      const index = rooms.findIndex(r => r.hotelId === hotelId && r.room === roomNumber);
      if (index === -1) {
        alert("Room not found.");
        return;
      }

      const confirmed = confirm(`Are you sure you want to delete Room ${roomNumber} in Hotel ${hotelId}?`);
      if (confirmed) {
        rooms.splice(index, 1);
        const row = document.getElementById(`roomRow-${hotelId}-${roomNumber}`);
        if (row) row.remove();
        alert("Room deleted successfully.");
      }
    }


    // Insert Room Form Logic
    function showInsertRoomForm() {
      const formArea = document.getElementById("roomActionFormArea");
      formArea.innerHTML = `
        <h4>Insert New Room</h4>
        <form id="insertRoomForm">
          <label>Hotel ID: <input type="text" id="insertHotelId" required></label><br>
          <label>Room Number: <input type="text" id="insertRoomNumber" required></label><br>
          <label>Extendable:
            <select id="insertExtendable" required>
              <option value="">--Select--</option>
              <option value="true">True</option>
              <option value="false">False</option>
            </select>
          </label><br>
          <label>Price: <input type="number" id="insertPrice" required></label><br>
          <label>Capacity: <input type="number" id="insertCapacity" required></label><br>
          <label>View Type: <input type="text" id="insertViewType" required></label><br>
          <button type="submit">Insert Room</button>
        </form>
        <div id="insertRoomMessage" style="margin-top: 10px;"></div>
      `;

      document.getElementById("insertRoomForm").addEventListener("submit", function (e) {
        e.preventDefault();

        const hotelId = document.getElementById("insertHotelId").value.trim();
        const roomNumber = document.getElementById("insertRoomNumber").value.trim();
        const extendable = document.getElementById("insertExtendable").value === "true";
        const price = parseFloat(document.getElementById("insertPrice").value);
        const capacity = parseInt(document.getElementById("insertCapacity").value);
        const viewType = document.getElementById("insertViewType").value.trim();

        if (!hotelId || !roomNumber || isNaN(price) || isNaN(capacity) || !viewType) {
          document.getElementById("insertRoomMessage").textContent = "Please fill all fields correctly.";
          return;
        }

        // Simulated DB logic
        const newRoom = {
          hotelId,
          room: roomNumber,
          extendable,
          price,
          capacity,
          viewType
        };

        console.log("New Room to Insert:", newRoom);
        document.getElementById("insertRoomMessage").textContent =
          `Room ${roomNumber} successfully inserted for Hotel ID ${hotelId}.`;

        this.reset();
      });
    }

    function handleUpdateRoom() {
      const hotelId = document.getElementById("updateHotelId").value.trim();
      const roomNumber = document.getElementById("updateRoomNumber").value.trim();
      const extendable = document.getElementById("updateExtendable").value;
      const price = document.getElementById("updatePrice").value.trim();
      const capacity = document.getElementById("updateCapacity").value.trim();
      const viewType = document.getElementById("updateViewType").value.trim();

      if (!hotelId || !roomNumber) {
        alert("Hotel ID and Room Number are required.");
        return;
      }

      const room = rooms.find(r => r.hotelId === hotelId && r.room === roomNumber);
      if (!room) {
        alert("Room not found.");
        return;
      }

      if (extendable !== "") room.extendable = (extendable === "true");
      if (price !== "") room.price = parseFloat(price);
      if (capacity !== "") room.capacity = parseInt(capacity);
      if (viewType !== "") room.view_type = viewType;

      document.getElementById("updateRoomMessage").textContent =
        `Room ${roomNumber} at Hotel ${hotelId} has been updated.`;

      console.log("Updated Room:", room);
    }


    function showUpdateRoomForm() {
      const formArea = document.getElementById("roomActionFormArea");

      formArea.innerHTML = `
        <h4>Update Room Details</h4>
        <form id="updateRoomForm">
          <label>Hotel ID: <input type="text" id="updateHotelId" required></label><br>
          <label>Room Number: <input type="text" id="updateRoomNumber" required></label><br>
          <p><em>Leave any field blank below if you don't want to update it.</em></p>
          <label>Extendable:
            <select id="updateExtendable">
              <option value="">--Leave Unchanged--</option>
              <option value="true">True</option>
              <option value="false">False</option>
            </select>
          </label><br>
          <label>Price: <input type="number" id="updatePrice" min="0"></label><br>
          <label>Capacity: <input type="number" id="updateCapacity" min="1"></label><br>
          <label>View Type: <input type="text" id="updateViewType"></label><br>
          <button type="submit">Update Room</button>
        </form>
        <div id="updateRoomMessage" style="margin-top: 10px;"></div>
      `;

      document.getElementById("updateRoomForm").addEventListener("submit", function (e) {
        e.preventDefault();
        handleUpdateRoom(); // This is what triggers the logic
      });
    }




