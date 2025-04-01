<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.eHotels.Customer" %>
<%@ page import="com.eHotels.CustomerService" %>
<%@ page import="java.sql.Date" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Customer</title>
</head>
<body>
<h2>Insert Customer</h2>

<form method="post">
    <label>First Name: <input type="text" name="fName" required></label><br><br>
    <label>Middle Name: <input type="text" name="mName"></label><br><br>
    <label>Last Name: <input type="text" name="lName" required></label><br><br>
    <label>Address: <input type="text" name="address" required></label><br><br>
    <label>ID Type:
        <select name="typeId" required>
            <option value="">--Select--</option>
            <option value="SIN">SIN</option>
            <option value="SSN">SSN</option>
            <option value="License">License</option>
        </select>
    </label><br><br>
    <label>Registration Date: <input type="date" name="regDate" required></label><br><br>

    <button type="submit">Add Customer</button>
</form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String fName = request.getParameter("fName");
        String mName = request.getParameter("mName");
        String lName = request.getParameter("lName");
        String address = request.getParameter("address");
        String typeId = request.getParameter("typeId");
        String regDateStr = request.getParameter("regDate");

        try {
            Customer customer = new Customer(
                    0,
                    fName,
                    mName,
                    lName,
                    address,
                    typeId,
                    Date.valueOf(regDateStr)
            );

            CustomerService customerService = new CustomerService();
            customerService.addCustomer(customer);

            out.println("<p style='color:green;'>Customer inserted successfully!</p>");
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>

<a href="customers.jsp">Back to Customer Management</a>
</body>
</html>
