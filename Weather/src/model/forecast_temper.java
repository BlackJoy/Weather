package model;


import java.sql.Timestamp;

public class forecast_temper {
	
	String city_name;
	Timestamp date;
	String weather_condition;
	String temp;
	String wind;
	
	public String getCity_name() {
		return city_name;
	}
	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}
	
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public String getWeather_condition() {
		return weather_condition;
	}
	public void setWeather_condition(String weather_condition) {
		this.weather_condition = weather_condition;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getWind() {
		return wind;
	}
	public void setWind(String wind) {
		this.wind = wind;
	}
	
	
}
