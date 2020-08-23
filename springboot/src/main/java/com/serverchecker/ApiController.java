package com.serverchecker;
import com.serverchecker.dto.ServerInfo;
import com.serverchecker.service.DataService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class ApiController {
    @Autowired
    private DataService dataservice;

	@RequestMapping("/api")
	public List<ServerInfo> index() {
		return dataservice.getServerInfo();
	}

}