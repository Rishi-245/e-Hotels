package com.eHotels;

public class Customer {
    private int customer_id;
    private String f_name;
    private String m_name;
    private String l_name;
    private String address;
    private String type_id;

    public Customer(int customer_id, String f_name, String m_name, String l_name, String address, String type_id) {
        this.customer_id = customer_id;
        this.f_name = f_name;
        this.m_name = m_name;
        this.l_name = l_name;
        this.address = address;
        this.type_id = type_id;
    }

    /* Getters and Setters */
    public int getCustomerID() { return customer_id; }
    public String getFirstName() { return f_name; }
    public String getMiddleName() { return m_name; }
    public String getLastName() { return l_name; }
    public String getAddress() { return address; }
    public String getTypeID() { return type_id; }

    public void setCustomerID(int customer_id) { this.customer_id = customer_id; }
    public void setFirstName(String f_name) { this.f_name = f_name; }
    public void setMiddleName(String m_name) { this.m_name = m_name; }
    public void setLastName(String l_name) { this.l_name = l_name; }
    public void setAddress(String address) { this.address = address; }
    public void setTypeID(String type_id) { this.type_id = type_id; }
}