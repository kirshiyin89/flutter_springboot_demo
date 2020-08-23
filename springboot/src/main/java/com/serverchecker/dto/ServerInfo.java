
package com.serverchecker.dto;

import java.util.List;

public class ServerInfo {
    
    public final String name;

    public final List<ServiceInfo> services;

    public ServerInfo(String name, List<ServiceInfo> services) {
        this.name = name;
        this.services = services;
    }
    
    
    
    
    
}
