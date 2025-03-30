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