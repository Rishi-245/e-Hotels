package com.eHotels;

public class Hotel {
    private int hotel_id;
    private int chain_id;
    private int category;
    private int num_rooms;
    private String hotel_address;
    private String hotel_email;

    public Hotel(int hotel_id, int chain_id, int category, int num_rooms, String hotel_address, String hotel_email) {
        this.hotel_id = hotel_id;
        this.chain_id = chain_id;
        this.category = category;
        this.num_rooms = num_rooms;
        this.hotel_address = hotel_address;
        this.hotel_email = hotel_email;
    }

    public int getHotelID() { return hotel_id; }
    public int getChainID() { return chain_id; }
    public int getCategory() { return category; }
    public int getNumRooms() { return num_rooms; }
    public String getHotelAddress() { return hotel_address; }
    public String getHotelEmail() { return hotel_email; }
}