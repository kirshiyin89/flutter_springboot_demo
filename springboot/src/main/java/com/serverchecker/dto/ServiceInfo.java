package com.serverchecker.dto;

public class ServiceInfo {

    public final String name;

    public final boolean running;

    public ServiceInfo(String name, boolean running) {
        this.name = name;
        this.running = running;
    }

}
