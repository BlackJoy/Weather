package 爬虫测试;



import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ResultSet;


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
            pst = conn.prepareStatement("insert into city(id,provinceid,cityname) values( '1','2','锟斤拷锟斤拷') ");//
            pst.execute();
            pst.close(); 
            conn.close();
            
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    } 
	
    
    
    
    public static List<String> findAllCity(){
    	
    	List<String> citylist = new ArrayList<String>();
    	
    	ResultSet rs =  null;
    	try {  
            Class.forName(name);//
            conn = (Connection) DriverManager.getConnection(url, user, password);//
            pst = conn.prepareStatement(" select cityname from city  ");//
            
            
            rs= (ResultSet) pst.executeQuery();
            
            while(rs.next()){
            	
            	String cityname = rs.getString("cityname");
            	citylist.add(cityname);
            }
            
            pst.close(); 
            conn.close();
            
        } catch (Exception e) {  
            e.printStackTrace();  
        } 
    	
    	return  citylist;
    }
    
  
    
    
    
    
    
    public static void delete_forecastTemper() throws SQLException, ClassNotFoundException{
    	
    	Class.forName(name);//指锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷  
        conn = (Connection) DriverManager.getConnection(url, user, password);//锟斤拷取锟斤拷锟斤拷  
        Temper temp= new Temper();
		
			 try {  
		           	String sql="delete from forecast_temper";
		            pst = conn.prepareStatement(sql);//准锟斤拷执锟斤拷锟斤拷锟� 
		            pst.execute();
		            pst.close();  
	        } catch (Exception e) {  
	            e.printStackTrace();  
		     }
	
		
		
		conn.close();
    	
    }
    
    
	
    public static void save_Temper(List<Temper> ls) throws ClassNotFoundException, SQLException{
		Class.forName(name);//指锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷  
        conn = (Connection) DriverManager.getConnection(url, user, password);//锟斤拷取锟斤拷锟斤拷  
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
		            pst = conn.prepareStatement(sql);//准锟斤拷执锟斤拷锟斤拷锟� 
		            pst.execute();
		            pst.close();  
	        } catch (Exception e) {  
	            e.printStackTrace();  
		     }
			 
			 
		}
		
		
		conn.close();
	}
	
	
	
	
	public static void save_forecastTemper(List<forecast_temper> ls) throws ClassNotFoundException, SQLException{
		 Class.forName(name);//指锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷  
         conn = (Connection) DriverManager.getConnection(url, user, password);//锟斤拷取锟斤拷锟斤拷  
         forecast_temper temp= new forecast_temper();
		for(int i = 0;i < ls.size(); i ++ ){
			temp=ls.get(i);
			String city_name=temp.getCity_name();
			Timestamp date= temp.getDate();
	
			String temper=temp.getTemp();
			String weather=temp.getWeather_condition();
			String wind=temp.getWind();
			 try {  
		           	String sql="insert into forecast_temper(city_name,date,weather,temp,wind) values('"+city_name+"','"+date+"','"+weather+"','"+temper+"','"+wind+"') ";
		            pst = conn.prepareStatement(sql);//准锟斤拷执锟斤拷锟斤拷锟� 
		            pst.execute();
		            pst.close(); 
		           
		            
		        } catch (Exception e) {  
		            e.printStackTrace();  
		        }
			 
			 
		}
		
		
		conn.close();
	}
	
	
	public static void saveAQI(List<forecast_AQI> ls) throws ClassNotFoundException, SQLException{
		 Class.forName(name);//指锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷  
        conn = (Connection) DriverManager.getConnection(url, user, password);//锟斤拷取锟斤拷锟斤拷  
        forecast_AQI aqi= new forecast_AQI();
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
		
			String PM25 = aqi.getPM25();
			String PM10 = aqi.getPM10();
			String Co = aqi.getCo();
			String No2 = aqi.getNo2();
			String So2 = aqi.getSo2();
			
			 try {  
		           	String sql="insert into AQI(city_name,date,AQI_point,quality_level,PM25,PM10,Co,No2,So2)" +
		           			" values('"+city_name+"','"+date+"','"+AQI_point+"','"+quality_level+"','"+PM25+"','"+PM10+"','"+Co+"','"+No2+"','"+So2+"') ";
		            pst = conn.prepareStatement(sql);//准锟斤拷执锟斤拷锟斤拷锟� 
		            pst.execute();
		            pst.close(); 
		           
		            
		        } catch (Exception e) {  
		            e.printStackTrace();  
		        }
			 
			 
		}
		
		
		conn.close();
	}
	
	
	
	
	
	
	
	
}	
