<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Management</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<h2>Room Management</h2>

<h3>Choose Room Management Action:</h3>
<div style="display: flex; gap: 20px; margin-top: 10px;">
    <button onclick="location.href='insertRoom.jsp'">Insert Room</button>
    <button onclick="location.href='updateRoom.jsp'">Update Room</button>
    <button onclick="location.href='deleteRoom.jsp'">Delete Room</button>
</div>

<!-- This is where forms will load -->
<div id="adminActionArea" style="margin-top: 20px;"></div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        let dropdown = document.getElementById("actionSelect");

        dropdown?.addEventListener("change", function () {
            let selectedPage = dropdown.value;
            if (selectedPage) {
                window.location.href = selectedPage;
            }
        });
    });
</script>

</body>
</html>
