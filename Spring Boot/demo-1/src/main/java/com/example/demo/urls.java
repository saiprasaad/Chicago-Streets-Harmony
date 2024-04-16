package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class urls {
	
	@GetMapping("/hello")
	public String hello() {
		return "Hello from spring boot";
	}

}
