<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<h2>Customer Management</h2>

<!-- Dropdown for Actions -->
<label for="actionSelect"><strong>Select Action:</strong></label>
<!-- Customer Management Buttons -->
<h3>Choose Customer Management Action:</h3>
<div style="display: flex; gap: 20px; margin-top: 10px;">
    <button onclick="location.href='insertCustomer.jsp'">Insert Customer</button>
    <button onclick="location.href='updateCustomer.jsp'">Update Customer</button>
    <button onclick="location.href='deleteCustomer.jsp'">Delete Customer</button>
</div>


<!-- This is where forms will load -->
<div id="adminActionArea" style="margin-top: 20px;"></div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        let dropdown = document.getElementById("actionSelect");

            dropdown.addEventListener("change", function () {
            let selectedPage = dropdown.value;
            if (selectedPage) {
                window.location.href = selectedPage;  // 🔁 Redirect directly to JSP page
            }
        });
    });
</script>

</body>
</html>
