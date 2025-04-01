<%@ page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%@ page import="com.eHotels.ConnectionDB" %>

<%
    String bookingId = request.getParameter("bookingId");
    String employeeId = request.getParameter("employeeId");

    if (bookingId != null && !bookingId.isEmpty()) {
        ConnectionDB db = new ConnectionDB();
        Connection con = null;
        PreparedStatement stmt = null;

        try {
            con = db.getConnection();
            String sql = "UPDATE Booking SET status = 'Confirmed' WHERE booking_id = ?";
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(bookingId));
            stmt.executeUpdate();
            stmt.close();

            // Redirect back to main page with employee ID
            response.sendRedirect("index.jsp?employeeId=" + employeeId + "&bookingType=online");
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (stmt != null) stmt.close();
            if (con != null) con.close();
            db.close();
        }
    } else {
        out.println("Invalid Booking ID");
    }
%>
