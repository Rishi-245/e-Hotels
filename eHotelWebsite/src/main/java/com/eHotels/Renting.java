package com.eHotels;

import java.sql.Date;

public class Renting {
    private int renting_id;
    private int customer_id;
    private String SIN;
    private int hotel_id;
    private int room_number;
    private Date renting_date;
    private Date check_out_date;
    private String status;

    public Renting(int renting_id, int customer_id, String SIN, int hotel_id, int room_number, Date renting_date, Date check_out_date, String status) {
        this.renting_id = renting_id;
        this.customer_id = customer_id;
        this.SIN = SIN;
        this.hotel_id = hotel_id;
        this.room_number = room_number;
        this.renting_date = renting_date;
        this.check_out_date = check_out_date;
        this.status = status;
    }

    /* Getters */
    public int getRentingID() { return renting_id; }
    public int getCustomerID() { return customer_id; }
    public String getSIN() { return SIN; }
    public int getHotelID() { return hotel_id; }
    public int getRoomNumber() { return room_number; }
    public Date getRentingDate() { return renting_date; }
    public Date getCheckOutDate() { return check_out_date; }
    public String getStatus() { return status; }

    /* Setters */
    public void setRentingID(int renting_id) { this.renting_id = renting_id; }
    public void setCustomerID(int customer_id) { this.customer_id = customer_id; }
    public void setSIN(String SIN) { this.SIN = SIN; }
    public void setHotelID(int hotel_id) { this.hotel_id = hotel_id; }
    public void setRoomNumber(int room_number) { this.room_number = room_number; }
    public void setRentingDate(Date renting_date) { this.renting_date = renting_date; }
    public void setCheckOutDate(Date check_out_date) { this.check_out_date = check_out_date; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "<ul>"
                + "<li>renting= " + renting_id + "</li>"
                + "<li>renting= " + customer_id + "</li>"
                + "<li>renting= " + SIN + "</li>"
                + "<li>renting= " + hotel_id + "</li>"
                + "<li>renting= " + room_number + "</li>"
                + "<li>renting= " + renting_date + "</li>"
                + "<li>renting= " + check_out_date + "</li>"
                + "<li>renting= " + status + "</li>";
    }
}