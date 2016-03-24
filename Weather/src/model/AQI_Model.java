package model;

import java.sql.Timestamp;

public class AQI_Model {
	
	String city_name;
	Timestamp date;
	
	String AQI_point;
	String quality_level;
	String AQI_number;
	String PM25;
	String PM10;
	String Co;
	String No2;
	String So2;
	
	
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
	public String getAQI_point() {
		return AQI_point;
	}
	public void setAQI_point(String aQI_point) {
		AQI_point = aQI_point;
	}
	public String getQuality_level() {
		return quality_level;
	}
	public void setQuality_level(String quality_level) {
		this.quality_level = quality_level;
	}
	public String getAQI_number() {
		return AQI_number;
	}
	public void setAQI_number(String aQI_number) {
		AQI_number = aQI_number;
	}
	public String getPM25() {
		return PM25;
	}
	public void setPM25(String pM25) {
		PM25 = pM25;
	}
	public String getPM10() {
		return PM10;
	}
	public void setPM10(String pM10) {
		PM10 = pM10;
	}
	public String getCo() {
		return Co;
	}
	public void setCo(String co) {
		Co = co;
	}
	public String getNo2() {
		return No2;
	}
	public void setNo2(String no2) {
		No2 = no2;
	}
	public String getSo2() {
		return So2;
	}
	public void setSo2(String so2) {
		So2 = so2;
	}
	
	
	
	
}
