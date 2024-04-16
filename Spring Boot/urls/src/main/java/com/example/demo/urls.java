package com.example.demo;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class urls {
	
	@GetMapping("/getEvents")
	public String getMapping() {
		return "Hello There";
	}
	
	@GetMapping("/getEventData")
	public List<EventData> getEventData(){
		ObjectMapper objectmapper = new ObjectMapper();
		try {
            File file = new File("data.json");
            EventData[] peopleArray = objectmapper.readValue(file, EventData[].class);
            return Arrays.asList(peopleArray);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
		
	}

}
