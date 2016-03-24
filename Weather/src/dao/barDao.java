package dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ResultSet;



public class barDao {
        private static InitialContext context = null;
        private DataSource dataSource = null;
        private static final String SELECT_ALL = "SELECT*FROM bar ";
        public barDao(){
            try{
                if(context == null){
                    context = new InitialContext();
                }
                dataSource = (DataSource)context.lookup("java:comp/env/jdbc/sampleDS");
            }catch(NamingException e2){
                
            }
        }
        public Connection getConnection(){
            Connection conn = null;
            try{
                conn = (Connection) dataSource.getConnection();
            }catch(SQLException e){}
            return conn;
        }  
        public ArrayList<barBean> select_all()
        {
             Connection conn = null;
             PreparedStatement pstmt = null;
             ResultSet rst = null;
            try{
                conn = (Connection) dataSource.getConnection();
                pstmt = conn.prepareStatement(SELECT_ALL);

                rst = (ResultSet) pstmt.executeQuery();
                ArrayList<barBean> array = new ArrayList<barBean>();
                while(rst.next())
                {
                    barBean bar = new barBean();
                    bar.setName(rst.getString("name"));
                    bar.setNum(rst.getInt("num"));
                    array.add(bar);
                }
                pstmt.close();
                rst.close();
                return array;
            }catch(SQLException e){
                System.out.println("Error occured at barDAO->select_all()");
                return new ArrayList<barBean>();
            }finally{
                try{
                    conn.close();
                }catch(SQLException e){
                    System.out.println("Error occured at closing connection in barDAO");
                }
            }
        }

}


