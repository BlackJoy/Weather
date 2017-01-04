package dao;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import model.AQI_value;
import model.City;
import model.History;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ResultSet;

public class CityDao {

	public static final String url = "jdbc:mysql://localhost:3306/weather";  
	public static final String name = "com.mysql.jdbc.Driver";  
	public static final String user = "root";  
	public static final String password = "123456";  

	public static Connection conn = null;  
	public static PreparedStatement pst = null; 


	
	public List<History> check_His_AQI(String date,String cityname) {  

		List<History> ls = new ArrayList<History>();

		Calendar   cal   =   Calendar.getInstance();
		cal.add(Calendar.DATE, 0);
		String today = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
		today+="00:00:00";


		try {  
			Class.forName(name);//
			conn = (Connection) DriverManager.getConnection(url, user, password);//
			pst = conn.prepareStatement(" select * from AQI aq  where aq.AQI_point !=0 and date like '"+date+"%'  and city_name = '"+cityname+"'  ");//
			ResultSet rs =  (ResultSet) pst.executeQuery();
			
			//if(rs == null)  return null;
			
			
			while(rs.next()){
				History his= new History();
				
				Timestamp temp_time = rs.getTimestamp("date");
				String temp =temp_time.toString();
				String[] temp1 = temp.split(" ");
				String[] temp2 = temp1[0].split("-");
				String day_temp = temp2[2];
				
				
				
				int day= temp_time.getDay();
				
				day = Integer.valueOf(day_temp);
				
				
				his.setDay(day );
				his.setAQI_point( Integer.valueOf(rs.getString("AQI_point")));
				his.setPM25(Integer.valueOf(rs.getString("PM25")));
				his.setPM10(Integer.valueOf(rs.getString("PM10")));
				his.setCo(Double.valueOf(rs.getString("co")));
				his.setNo2(Double.valueOf(rs.getString("no2")));
				his.setSo2(Double.valueOf(rs.getString("so2")));
				his.setQuality(rs.getString("quality_level"));
				
				ls.add(his);
			}
			pst.close(); 
			conn.close();

		} catch (Exception e) {  
			e.printStackTrace();  
		}
		return ls;  
	}
	
	

	public List<City> findAll_haveAQI() {  

		List<City> ls = new ArrayList<City>();

		Calendar   cal   =   Calendar.getInstance();
		cal.add(Calendar.DATE,   0);
		String today = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
		today+="00:00:00";


		try {  
			Class.forName(name);//
			conn = (Connection) DriverManager.getConnection(url, user, password);//
			pst = conn.prepareStatement("select * from AQI aq , city t where aq.city_name=t.cityname and aq.AQI_point !=0 and date = '"+today+"'");//
			ResultSet rs =  (ResultSet) pst.executeQuery();

			while(rs.next()){
				City city= new City();
				city.setName(rs.getString("cityname"));
				city.setLongitude(rs.getDouble("longitude"));
				city.setLatitude(rs.getDouble("latitude"));
				ls.add(city);
			}
			pst.close(); 
			conn.close();

		} catch (Exception e) {  
			e.printStackTrace();  
		}
		return ls;  
	} 



	public List<City> findAll_City() {  

		List<City> ls = new ArrayList<City>();

		Calendar   cal   =   Calendar.getInstance();
		cal.add(Calendar.DATE,   0);
		String today = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
		today+="00:00:00";


		try {  
			Class.forName(name);//
			conn = (Connection) DriverManager.getConnection(url, user, password);//
			pst = conn.prepareStatement("select * from city  ");//
			ResultSet rs =  (ResultSet) pst.executeQuery();

			while(rs.next()){
				City city= new City();
				city.setName(rs.getString("cityname"));
				city.setLongitude(rs.getDouble("longitude"));
				city.setLatitude(rs.getDouble("latitude"));
				ls.add(city);
			}
			pst.close(); 
			conn.close();

		} catch (Exception e) {  
			e.printStackTrace();  
		}
		return ls;  
	} 


}
