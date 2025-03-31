package com.eHotels;

public class Room {
    private int hotel_id;
    private int room_number;
    private boolean extendable;
    private double price;
    private int capacity;
    private String view_type;

    public Room(int hotel_id, int room_number, boolean extendable, double price, int capacity, String view_type) {
        this.hotel_id = hotel_id;
        this.room_number = room_number;
        this.extendable = extendable;
        this.price = price;
        this.capacity = capacity;
        this.view_type = view_type;
    }

    public int getHotelID() { return hotel_id; }
    public int getRoomNumber() { return room_number; }
    public boolean isExtendable() { return extendable; }
    public double getPrice() { return price; }
    public int getCapacity() { return capacity; }
    public String getViewType() { return view_type; }
}