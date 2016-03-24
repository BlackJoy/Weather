package dao;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import model.AQI_value;


import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ResultSet;

public class AqiDao {
	public static final String url = "jdbc:mysql://localhost:3306/weather";  
    public static final String name = "com.mysql.jdbc.Driver";  
    public static final String user = "root";  
    public static final String password = "123456";  
  
    public static Connection conn = null;  
    public static PreparedStatement pst = null; 
    
    
    
    public List<AQI_value> findAll_today() {  
    	
    	List<AQI_value> ls = new ArrayList<AQI_value>();
    	
    	Calendar   cal   =   Calendar.getInstance();
        cal.add(Calendar.DATE,   0);
        String today = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
        today+="00:00:00";
        
        try {  
            Class.forName(name);//
            conn = (Connection) DriverManager.getConnection(url, user, password);//
            pst = conn.prepareStatement("select * from AQI where date = '"+today+"'  and AQI_point != 0   ");//
            ResultSet rs =  (ResultSet) pst.executeQuery();
			
			while(rs.next()){
				AQI_value aqi= new AQI_value();
				
				aqi.setName(rs.getString("city_name"));
				
				String aqi_point = rs.getString("AQI_point");
				String quality_level = rs.getString("quality_level");

				aqi.setValue(Integer.valueOf(aqi_point) );
				
				ls.add(aqi);
			}
            pst.close(); 
            conn.close();
            
        } catch (Exception e) {  
            e.printStackTrace();  
        }
		return ls;  
    } 
    
    
    
}
