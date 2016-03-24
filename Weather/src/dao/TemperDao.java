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
import model.PageShow;
import model.forecast_temper;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ResultSet;

public class TemperDao {
	public static final String url = "jdbc:mysql://localhost:3306/weather";  
    public static final String name = "com.mysql.jdbc.Driver";  
    public static final String user = "root";  
    public static final String password = "123456";  
  
    public static Connection conn = null;  
    public static PreparedStatement pst = null; 
    
    
    
    public List<forecast_temper> find_for5days(String cityname) {  
    	
    	List<forecast_temper> ls = new ArrayList<forecast_temper>();

        try {  
        	 Class.forName(name);//
             conn = (Connection) DriverManager.getConnection(url, user, password);//
   
             pst = conn.prepareStatement(" select * from forecast_temper t  where t.city_name = '"+cityname+"' ");//
             ResultSet rs =  (ResultSet) pst.executeQuery();
 			
 			while(rs.next()){
 				
 				forecast_temper fortemper = new forecast_temper();
 				
 				String city_name = rs.getString("city_name");
 				Timestamp timerdate = rs.getTimestamp("date");
 				String weather = rs.getString("weather");
 				String temp = rs.getString("temp");
 				String wind = rs.getString("wind");
 				
 				fortemper.setCity_name(city_name);
 				fortemper.setDate(timerdate);
 				fortemper.setWeather_condition(weather);
 				fortemper.setTemp(temp);
 				fortemper.setWind(wind);
 				
 				ls.add(fortemper);
 				 
 			}
             pst.close(); 
             conn.close();
            
        } catch (Exception e) {  
            e.printStackTrace();  
        }
		return ls;  
    } 
    
    
    public List<AQI_value> findAll_today() {  
    	
    	List<AQI_value> ls = new ArrayList<AQI_value>();
    	
    	Calendar   cal   =   Calendar.getInstance();
        cal.add(Calendar.DATE,   0);
        String today = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
        today+="00:00:00";
        
        try {  
            Class.forName(name);//
            conn = (Connection) DriverManager.getConnection(url, user, password);//
            pst = conn.prepareStatement("select * from forecast_temper where date = '"+today+"'     ");//
            ResultSet rs =  (ResultSet) pst.executeQuery();
			
			while(rs.next()){
				AQI_value aqi= new AQI_value();
				
				aqi.setName(rs.getString("city_name"));
				
				String temperture = rs.getString("temp");
				
				String [] arr = temperture.split("/");
				
				arr = arr[0].split(" ");
				
				String high_temper = arr[1];
				
				String[] arr_split = high_temper.split("");
				
				arr_split[arr_split.length-1] = "";
				
				StringBuilder sb = new StringBuilder();
				
				
				for(int i = 0 ; i < arr_split.length ; i++ )
					if(arr_split[i]!="")
					sb.append(arr_split[i]);
				
				//System.out.println( sb.toString() );
				
				
				aqi.setValue(Integer.valueOf(sb.toString()) );
				
				ls.add(aqi);
			}
            pst.close(); 
            conn.close();
            
        } catch (Exception e) {  
            e.printStackTrace();  
        }
        
        //System.out.println( ls );
		return ls;  
    } 
    
    
}
