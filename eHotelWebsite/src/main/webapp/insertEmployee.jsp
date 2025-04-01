<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.eHotels.EmployeeService, com.eHotels.Employee" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Employee</title>
</head>
<body>

<h2>Insert New Employee</h2>

<form action="insertEmployee.jsp" method="post">
    <label>SIN: <input type="text" name="sin" required></label><br><br>
    <label>Hotel ID: <input type="text" name="hotel_id" required></label><br><br>
    <label>First Name: <input type="text" name="f_name" required></label><br><br>
    <label>Middle Name: <input type="text" name="m_name"></label><br><br>
    <label>Last Name: <input type="text" name="l_name" required></label><br><br>
    <label>Address: <input type="text" name="address" required></label><br><br>
    <label>Role: <input type="text" name="role" required></label><br><br>

    <button type="submit">Insert Employee</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String sin = request.getParameter("sin");
        int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
        String fName = request.getParameter("f_name");
        String mName = request.getParameter("m_name");
        String lName = request.getParameter("l_name");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        Employee employee = new Employee(sin, hotelId, fName, mName, lName, address, role);
        EmployeeService employeeService = new EmployeeService();

        try {
            employeeService.addEmployee(employee);
            out.println("<p style='color:green;'>Employee inserted successfully.</p>");
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>


<br><a href="employees.jsp">← Back to Employee Management</a>

</body>
</html>