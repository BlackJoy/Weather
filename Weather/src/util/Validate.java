package util;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import model.User;

import java.sql.*;
 
public class Validate extends ActionSupport {
//    public void doGet(HttpServletRequest request, HttpServletResponse response) 
//        throws IOException, ServletException {
//            String user_name = new String(request.getParameter("userName").getBytes("ISO-8859-1"), "UTF-8");
//            String user_pwd = new String(request.getParameter("password").getBytes("ISO-8859-1"), "UTF-8");
//            PrintWriter out = response.getWriter();
//            String driver = "com.mysql.jdbc.Driver";
//            String dbUser = "root";
//            String dbPwd = "3306";
//            String db = "appbase";
//            String url = "jdbc:mysql://localhost:3306/" + db + "?user=" + dbUser + "&password=" + dbPwd;
//            ResultSet rs = null;
//            String sqlString = "select * from client where login_account='" + user_name + "' and password='" + user_pwd + "'";
//            try {
//                Class.forName(driver).newInstance();
//                Connection conn = DriverManager.getConnection(url);
//                Statement ps = conn.createStatement();
//                rs = ps.executeQuery(sqlString);
//                if(rs.next())
//                    out.println("1");
//                else
//                    out.println("0");
//            } catch(ClassNotFoundException e) {
//                out.println("ClassNotFoundException"); 
//            } catch(SQLException ex) {
//                out.println("SQLException");
//            } catch(Exception exe) {
//                out.println("OtherException");
//            }           
//    }
	private User user;
	private String username;
	private String password;
	public void checkusername() throws IOException{
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		PrintWriter writer = response.getWriter();
		
		if(username.equals("wangxiao")){
			writer.print("hello"+username);
			writer.flush();
			writer.close();
			
		}else{
			writer.print("¹§Ï²Äã!ÓÃ»§Ãû["+username+"]ÉÐÎ´×¢²á£¡");
			writer.flush();
			writer.close();
			
		}	
		
		
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	
}