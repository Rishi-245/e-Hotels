<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Management</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<h2>Hotel Management</h2>

<!-- Hotel Management Buttons -->
<h3>Choose Hotel Management Action:</h3>
<div style="display: flex; gap: 20px; margin-top: 10px;">
    <button onclick="location.href='insertHotel.jsp'">Insert Hotel</button>
    <button onclick="location.href='updateHotel.jsp'">Update Hotel</button>
    <button onclick="location.href='deleteHotel.jsp'">Delete Hotel</button>
</div>

<!-- Action area if needed later -->
<div id="adminActionArea" style="margin-top: 20px;"></div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        let dropdown = document.getElementById("actionSelect");

        if (dropdown) {
            dropdown.addEventListener("change", function () {
                let selectedPage = dropdown.value;
                if (selectedPage) {
                    window.location.href = selectedPage;
                }
            });
        }
    });
</script>

</body>
</html>
