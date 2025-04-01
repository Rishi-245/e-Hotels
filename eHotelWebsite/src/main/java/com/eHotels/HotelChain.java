package com.eHotels;

public class HotelChain {
    private int chain_id;
    private String name;

    public HotelChain(int chain_id, String name) {
        this.chain_id = chain_id;
        this.name = name;
    }

    public int getChainID() {
        return chain_id;
    }

    public String getName() {
        return name;
    }
}

