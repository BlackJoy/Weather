package util;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import com.mysql.jdbc.Connection;

import model.AQI_Model;
import model.Temper;

public class toDatabase {
	
	
	public static final String url = "jdbc:mysql://localhost:3306/weather";  
    public static final String name = "com.mysql.jdbc.Driver";  
    public static final String user = "root";  
    public static final String password = "123456";  
  
    public static Connection conn = null;  
    public static PreparedStatement pst = null;  
  
    public static void open() {  
        try {  
            Class.forName(name);//
            conn = (Connection) DriverManager.getConnection(url, user, password);//
            pst = conn.prepareStatement("insert into city(id,provinceid,cityname) values( '1','2','����') ");//
            pst.execute();
            pst.close(); 
            conn.close();
            
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    } 
	
	
	
	
	
	
	
	public static void save(List<Temper> ls) throws ClassNotFoundException, SQLException{
		 Class.forName(name);//ָ����������  
         conn = (Connection) DriverManager.getConnection(url, user, password);//��ȡ����  
		Temper temp= new Temper();
		for(int i = 0;i < ls.size(); i ++ ){
			temp=ls.get(i);
			String city_name=temp.getCity_name();
			Timestamp date= temp.getDate();
			
			
			String temper=temp.getTemp();
			String weather=temp.getWeather_condition();
			String wind=temp.getWind();
			 try {  
		           	String sql="insert into temper(city_name,date,weather_condition,temp,wind) values('"+city_name+"','"+date+"','"+weather+"','"+temper+"','"+wind+"') ";
		            pst = conn.prepareStatement(sql);//׼��ִ�����  
		            pst.execute();
		            pst.close(); 
		           
		            
		        } catch (Exception e) {  
		            e.printStackTrace();  
		        }
			 
			 
		}
		
		
		conn.close();
	}
	
	
	public static void saveAQI(List<AQI_Model> ls) throws ClassNotFoundException, SQLException{
		 Class.forName(name);//ָ����������  
        conn = (Connection) DriverManager.getConnection(url, user, password);//��ȡ����  
        AQI_Model aqi= new AQI_Model();
		for(int i = 0;i < ls.size(); i ++ ){
			aqi=ls.get(i);
			
			/**
			 * 
			 * 	String city_name;
				Timestamp date;
				
				String AQI_point;
				String quality_level;
				String AQI_rank;
				String PM25;
				String PM10;
				String Co;
				String No2;
				String So2;
			 * 
			 */
			
			String city_name=aqi.getCity_name();
			Timestamp date= aqi.getDate();
			String AQI_point = aqi.getAQI_point();
			String quality_level = aqi.getQuality_level();
			String AQI_number = aqi.getAQI_number();
			String PM25 = aqi.getPM25();
			String PM10 = aqi.getPM10();
			String Co = aqi.getCo();
			String No2 = aqi.getNo2();
			String So2 = aqi.getSo2();
			
			 try {  
		           	String sql="insert into AQI(city_name,date,AQI_point,quality_level,AQI_rank,PM25,PM10,Co,No2,So2)" +
		           			" values('"+city_name+"','"+date+"','"+AQI_point+"','"+quality_level+"','"+AQI_number+"','"+PM25+"','"+PM10+"','"+Co+"','"+No2+"','"+So2+"') ";
		            pst = conn.prepareStatement(sql);//׼��ִ�����  
		            pst.execute();
		            pst.close(); 
		           
		            
		        } catch (Exception e) {  
		            e.printStackTrace();  
		        }
			 
			 
		}
		
		
		conn.close();
	}
	
	
	
	
	
	
	
	
}	
