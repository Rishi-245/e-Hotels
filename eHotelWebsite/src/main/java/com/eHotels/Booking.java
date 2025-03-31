package com.eHotels;

import java.sql.Date;

public class Booking {

    private int booking_id;
    private String customer_id;
    private String SIN;
    private int hotel_id;
    private int room_number;
    private Date booking_date;
    private Date start_date;
    private Date end_date;
    private String status;
    /**
     * Constructor
     */
    public Booking(int booking_id, String customer_id, String SIN, int hotel_id, int room_number, Date booking_date, Date start_date, Date end_date, String status) {
        this.booking_id = booking_id;
        this.customer_id = customer_id;
        this.SIN = SIN;
        this.hotel_id = hotel_id;
        this.room_number = room_number;
        this.booking_date = booking_date;
        this.start_date = start_date;
        this.end_date = end_date;
        this.status = status;
    }


    /* Getters */
    public int getBookingID() { return this.booking_id; }
    public String getCustomerID() { return this.customer_id; }
    public String getSIN() { return this.SIN; }
    public int getHotelID() { return this.hotel_id; }
    public int getRoomNumber() { return this.room_number; }
    public Date getBookingDate() { return this.booking_date; }
    public Date getStartDate() { return this.start_date; }
    public Date getEndDate() { return this.end_date; }
    public String getStatus() { return this.status; }

    /* Setters */
    public void setBookingID(int booking_id) { this.booking_id = booking_id; }
    public void setCustomerID(String customer_id) { this.customer_id = customer_id; }
    public void setSIN(String SIN) { this.SIN = SIN; }
    public void setHotelID(int hotel_id) { this.hotel_id = hotel_id; }
    public void setRoomNumber(int room_number) { this.room_number = room_number; }
    public void setBookingDate(Date booking_date) { this.booking_date = booking_date; }
    public void setStartDate(Date start_date) { this.start_date = start_date; }
    public void setEndDate(Date end_date) { this.end_date = end_date; }
    public void setStatus(String status) { this.status = status; }


    @Override
    public String toString() {
        return "<ul>"
                + "<li>booking= " + booking_id + "</li>"
                + "<li>booking= " + customer_id + "</li>"
                + "<li>booking= " + SIN + "</li>"
                + "<li>booking= " + hotel_id + "</li>"
                + "<li>booking= " + room_number + "</li>"
                + "<li>booking= " + booking_date + "</li>"
                + "<li>booking= " + start_date + "</li>"
                + "<li>booking= " + end_date + "</li>"
                + "<li>booking= " + status + "</li>";
    }
}