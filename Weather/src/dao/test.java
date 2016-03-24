package dao;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class test {
	
//	
//	public static void main(String args[]){
//		
//		DBHelper.open();
//	}
//	
	
	public static  class DBHelper {  
	    public static final String url = "jdbc:mysql://localhost:3306/weather";  
	    public static final String name = "com.mysql.jdbc.Driver";  
	    public static final String user = "root";  
	    public static final String password = "123456";  
	  
	    public static Connection conn = null;  
	    public static PreparedStatement pst = null;  
	  
	    public static void open() {  
	        try {  
	            Class.forName(name);//指定连接类型  
	            conn = (Connection) DriverManager.getConnection(url, user, password);//获取连接  
	            pst = conn.prepareStatement("insert into city(id,provinceid,cityname) values( '1','2','济南') ");//准备执行语句  
	            pst.execute();
	            pst.close(); 
	            conn.close();
	            
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }  
	    } 
	}
}
