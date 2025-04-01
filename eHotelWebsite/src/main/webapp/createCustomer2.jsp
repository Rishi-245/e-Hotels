<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.eHotels.CustomerService" %>
<%@ page import="com.eHotels.Customer" %>
<%@ page import="java.sql.Date" %>

<%
    // Get values from the request (from the form)
    String firstName = request.getParameter("ipFirstName");
    String middleName = request.getParameter("ipMiddleName");
    String lastName = request.getParameter("ipLastName");
    String address = request.getParameter("ipAddress");
    String idType = request.getParameter("ipIdType");
    String employeeId = request.getParameter("employeeId");
    String bookingType = request.getParameter("bookingType");

    // Create a Customer object (customer_id = 0 since it's auto-generated)
    Customer customer = new Customer(0, firstName, middleName, lastName, address, idType, new java.sql.Date(System.currentTimeMillis()));

    // Initialize CustomerService
    CustomerService customerService = new CustomerService();

    try {
        // Attempt to add the customer to the database
        customerService.addCustomer(customer);

        int customerId = customerService.getCustomerIDIfExists(customer);
        if (customerId == -1) {
            out.println("You must be logged in to make a renting.");
            return;
        }

        // Set session login
        session.setAttribute("customer_id", String.valueOf(customerId));

        // Redirect .jsp with a success flag
        response.sendRedirect("availableRooms.jsp?registered=true&employeeId=" + employeeId + "&bookingType=inperson");
    } catch (Exception e) {
        e.printStackTrace();
        // Redirect back with an error flag
        response.sendRedirect("index.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
    }
%>

