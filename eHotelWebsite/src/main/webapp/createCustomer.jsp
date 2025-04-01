<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.eHotels.CustomerService" %>
<%@ page import="com.eHotels.Customer" %>
<%@ page import="java.sql.Date" %>

<%
    // Get values from the request (from the form)
    String firstName = request.getParameter("fName");
    String middleName = request.getParameter("mName");
    String lastName = request.getParameter("lName");
    String address = request.getParameter("address");
    String idType = request.getParameter("typeId");

    // Create a Customer object (customer_id = 0 since it's auto-generated)
    Customer customer = new Customer(0, firstName, middleName, lastName, address, idType, new java.sql.Date(System.currentTimeMillis()));

    // Initialize CustomerService
    CustomerService customerService = new CustomerService();

    try {
        // Attempt to add the customer to the database
        customerService.addCustomer(customer);

        int customerId = customerService.getCustomerIDIfExists(customer);
        if (customerId == -1) {
            out.println("You must be logged in to make a booking.");
            return;
        }

        // Set session login
        session.setAttribute("customer_id", String.valueOf(customerId));

        // Redirect to room search or customer section
        response.sendRedirect("customerSection.jsp?registered=true");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("customerSection.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
    }
%>

