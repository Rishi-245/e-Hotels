<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Section</title>

    <style>
        /* Ensures that labels and inputs stack properly */
        form {
            display: flex;
            flex-direction: column;
            gap: 10px; /* Adds spacing between fields */
            max-width: 400px; /* Limits form width for readability */
        }

        label {
            display: flex;
            flex-direction: column;
            font-weight: bold;
        }

        input, select {
            padding: 8px;
            font-size: 14px;
            width: 100%; /* Ensures inputs don't shrink */
        }

        button {
            padding: 10px;
            font-size: 16px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<!-- Customer Sign-In Form -->
<form id="customerForm" action="createCustomer.jsp" method="post">
    <h2>Customer Info</h2>
    <label>First Name: <input type="text" name="fName" required></label>
    <label>Middle Name (optional): <input type="text" name="mName"></label>
    <label>Last Name: <input type="text" name="lName" required></label>
    <label>Home Address: <input type="text" name="address" required></label>
    <label>ID Type:
        <select name="typeId" required>
            <option value="">--Select ID Type--</option>
            <option value="SSN">SSN</option>
            <option value="SIN">SIN</option>
            <option value="Driving License">Driving License</option>
        </select>
    </label>
    <label>Current Date: <input type="date" name="regDate" required></label>
    <button type="submit">Sign In</button>
</form>

<!-- Room Search Section (Initially Hidden) -->
<div id="roomSearchSection" style="display: none;">
    <h2>Search for Rooms</h2>
    <form id="roomSearchForm" method="post" action="searchRooms.jsp">
        <label>Start Date: <input type="date" name="checkinDate" required></label>
        <label>End Date: <input type="date" name="checkoutDate" required></label>
        <label>Hotel Chain:
            <select name="hotelChain">
                <option value="">--Select Chain--</option>
                <option value="Hilton">Hilton</option>
                <option value="Marriott">Marriott</option>
                <option value="Hyatt">Hyatt</option>
                <option value="Accor">Accor</option>
                <option value="Wyndham">Wyndham</option>
            </select>
        </label>
        <label>City:
            <select name="city">
                <option value="">--Select City--</option>
                <option value="Quebec City">Quebec City</option>
                <option value="Edmonton">Edmonton</option>
                <option value="Calgary">Calgary</option>
                <option value="Toronto">Toronto</option>
                <option value="Montreal">Montreal</option>
                <option value="Vancouver">Vancouver</option>
                <option value="Ottawa">Ottawa</option>
                <option value="Halifax">Halifax</option>
            </select>
        </label>

        <label>Number of Rooms in Hotel (minimum):
            <input type="number" name="numRooms" min="1" placeholder="e.g., 10">
        </label>
        <label>Hotel Rating (1-5):
            <select name="category">
                <option value="">--Select Rating--</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
        </label>
        <label>Room Capacity:
            <input type="number" name="roomCapacity" min="1" placeholder="Enter desired capacity">
        </label>
        <label>Budget (Price Per Night Range): <input type="text" name="priceRange"></label>
        <label>Extendable:
            <select name="extendable">
                <option value="">--Select--</option>
                <option value="true">True</option>
                <option value="false">False</option>
            </select>
        </label>
        <label>View Type:
            <select name="viewType">
                <option value="">--Select--</option>
                <option value="Sea View">Sea View</option>
                <option value="Mountain View">Mountain View</option>
            </select>
        </label>
        <button type="submit">Search for Rooms</button>
    </form>
    <div id="availableRooms"></div>
</div>

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