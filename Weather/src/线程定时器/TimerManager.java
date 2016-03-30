package 线程定时器;



import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;  
import java.util.Date;  
import java.util.List;
import java.util.Timer;  

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

  
  
public class TimerManager {  
  
      
    public static void main(String[] args) {
        new TimerManager();    
    }  
    
    //ʱ����(һ��)  
    private static final long PERIOD_DAY =  24 * 60 * 60 * 1000;  
    public TimerManager() {  
        Calendar calendar = Calendar.getInstance();  
        calendar.set(Calendar.HOUR_OF_DAY, 8); //�賿1��  
        calendar.set(Calendar.MINUTE, 38);  
        calendar.set(Calendar.SECOND, 0);  
        Date date=calendar.getTime(); //��һ��ִ�ж�ʱ�����ʱ��  
        //����һ��ִ�ж�ʱ�����ʱ�� С�ڵ�ǰ��ʱ��  
        //��ʱҪ�� ��һ��ִ�ж�ʱ�����ʱ���һ�죬�Ա���������¸�ʱ���ִ�С�����һ�죬���������ִ�С�  
        if (date.before(new Date())) {  
            date = this.addDay(date, 1);  
        }       
        
//        Calendar   cal   =   Calendar.getInstance();
//        cal.add(Calendar.DATE,   -1);
//        String yesterday = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
//        System.out.println(yesterday);

        
        
//---------------------------------------------------------------   
		
 
//---------------------------------------------------------------        
        
        
        
           
        
        
        Timer timer = new Timer();  
        Task task = new Task();  
        //����ָ����������ָ����ʱ�俪ʼ�����ظ��Ĺ̶��ӳ�ִ�С�  
        timer.schedule(task,date,PERIOD_DAY);    
    }  
    // ���ӻ��������  
    public Date addDay(Date date, int num) {  
        Calendar startDT = Calendar.getInstance();  
        startDT.setTime(date);  
        startDT.add(Calendar.DAY_OF_MONTH, num);  
        return startDT.getTime();  
    }  
  
}  