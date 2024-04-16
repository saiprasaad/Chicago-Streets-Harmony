package com.example.demo;
import java.util.List;

public class EventData {

 String name;
 String date;
 String description;
 String url;
 String upcoming;
 List<ParadeData> parade;
public String getName() {
	return name;
}
public String getUpcoming() {
	return upcoming;
}
public void setUpcoming(String upcoming) {
	this.upcoming = upcoming;
}
public void setName(String name) {
	this.name = name;
}
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
}
public String getDescription() {
	return description;
}
public void setDescription(String description) {
	this.description = description;
}
public String getUrl() {
	return url;
}
public void setUrl(String url) {
	this.url = url;
}
public List<ParadeData> getParade() {
	return parade;
}
public void setParade(List<ParadeData> parade) {
	this.parade = parade;
}
 
 
}
