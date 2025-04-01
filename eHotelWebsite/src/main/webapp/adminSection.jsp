<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Section</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<h2>Admin Panel</h2>

<!-- Admin Login Form -->
<form id="adminLoginForm">
    <label>Enter Admin ID:
        <input type="text" id="adminIdInput" required />
    </label>
    <button type="button" onclick="handleAdminLogin()">Login</button>
</form>

<!-- Admin Content (Initially Hidden) -->
<div id="adminContent" style="display: none;">
    <h3>Welcome, Admin</h3>

    <label for="adminActionSelect"><strong>Select Management Section:</strong></label>
    <select id="adminActionSelect" onchange="showAdminSection(this.value)">
        <option value="">-- Select Section --</option>
        <option value="customers">Manage Customers</option>
        <option value="employees">Manage Employees</option>
        <option value="hotels">Manage Hotels</option>
        <option value="rooms">Manage Rooms</option>
    </select>

    <div id="adminActionArea" style="margin-top: 20px;"></div>

    <button onclick="logoutAdmin()">Logout</button>
</div>

<script>
    function handleAdminLogin() {
        const adminId = document.getElementById("adminIdInput").value;

        if (adminId === "admin123") {  // Hardcoded validation (replace with backend check)
            localStorage.setItem("isAdminLoggedIn", "true");  // Store session in local storage
            document.getElementById("adminLoginForm").style.display = "none";
            document.getElementById("adminContent").style.display = "block";
        } else {
            alert("Invalid Admin ID. Please try again.");
        }
    }

    function logoutAdmin() {
        localStorage.removeItem("isAdminLoggedIn");
        location.reload();  // Refresh the page to reset the state
    }

    function showAdminSection(section) {
        if (section) {
            fetch(section + ".jsp")
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Page not found");
                    }
                    return response.text();
                })
                .then(html => {
                    document.getElementById("adminActionArea").innerHTML = html;
                })
                .catch(error => {
                    document.getElementById("adminActionArea").innerHTML = "<p style='color:red;'>Error loading section.</p>";
                    console.error("Error:", error);
                });
        } else {
            document.getElementById("adminActionArea").innerHTML = '';
        }
    }

    // Check if admin is already logged in (persists even after refresh)
    window.onload = function () {
        if (localStorage.getItem("isAdminLoggedIn") === "true") {
            document.getElementById("adminLoginForm").style.display = "none";
            document.getElementById("adminContent").style.display = "block";
        }
    };
</script>

</body>
</html>
