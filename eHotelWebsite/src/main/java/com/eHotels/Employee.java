package com.eHotels;

public class Employee {
    private String SIN;
    private int hotel_id;
    private String f_name;
    private String m_name;
    private String l_name;
    private String address;
    private String role;

    public Employee(String SIN, int hotel_id, String f_name, String m_name, String l_name, String address, String role) {
        this.SIN = SIN;
        this.hotel_id = hotel_id;
        this.f_name = f_name;
        this.m_name = m_name;
        this.l_name = l_name;
        this.address = address;
        this.role = role;
    }

    /* Getters and Setters */
    public String getSIN() { return SIN; }
    public int getHotelID() { return hotel_id; }
    public String getFirstName() { return f_name; }
    public String getMiddleName() { return m_name; }
    public String getLastName() { return l_name; }
    public String getAddress() { return address; }
    public String getRole() { return role; }

    public void setSIN(String SIN) { this.SIN = SIN; }
    public void setHotelID(int hotel_id) { this.hotel_id = hotel_id; }
    public void setFirstName(String f_name) { this.f_name = f_name; }
    public void setMiddleName(String m_name) { this.m_name = m_name; }
    public void setLastName(String l_name) { this.l_name = l_name; }
    public void setAddress(String address) { this.address = address; }
    public void setRole(String role) { this.role = role; }
}