<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<h2>Employee Management</h2>

<!-- Employee Management Buttons -->
<h3>Choose Employee Management Action:</h3>
<div style="display: flex; gap: 20px; margin-top: 10px;">
    <button onclick="location.href='insertEmployee.jsp'">Insert Employee</button>
    <button onclick="location.href='updateEmployee.jsp'">Update Employee</button>
    <button onclick="location.href='deleteEmployee.jsp'">Delete Employee</button>
</div>

<!-- This is where forms will load -->
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
