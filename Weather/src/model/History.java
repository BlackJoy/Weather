package model;

public class History {
	
	private int day;
	private int AQI_point;
	private int PM25;
	private int PM10;
	private double co;
	private double no2;
	private double so2;
	
	private String quality;

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getAQI_point() {
		return AQI_point;
	}

	public void setAQI_point(int aQI_point) {
		AQI_point = aQI_point;
	}

	public int getPM25() {
		return PM25;
	}

	public void setPM25(int pM25) {
		PM25 = pM25;
	}

	public int getPM10() {
		return PM10;
	}

	public void setPM10(int pM10) {
		PM10 = pM10;
	}

	

	public double getCo() {
		return co;
	}

	public void setCo(double co) {
		this.co = co;
	}

	public double getNo2() {
		return no2;
	}

	public void setNo2(double no2) {
		this.no2 = no2;
	}

	public double getSo2() {
		return so2;
	}

	public void setSo2(double so2) {
		this.so2 = so2;
	}

	public String getQuality() {
		return quality;
	}

	public void setQuality(String quality) {
		this.quality = quality;
	}
	
	
	
}
