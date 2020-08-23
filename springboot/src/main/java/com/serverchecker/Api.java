package com.serverchecker;

import com.serverchecker.dto.ServerConfig;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties(ServerConfig.class)
public class Api {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        SpringApplication.run(Api.class, args);
    }
}
