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
    
    //时间间隔(一天)  
    private static final long PERIOD_DAY =  24 * 60 * 60 * 1000;  
    public TimerManager() {  
        Calendar calendar = Calendar.getInstance();  
        calendar.set(Calendar.HOUR_OF_DAY, 8); //凌晨1点    
        calendar.set(Calendar.MINUTE, 39);  
        calendar.set(Calendar.SECOND, 0);  
        Date date=calendar.getTime(); //第一次执行定时任务的时间   
        //如果第一次执行定时任务的时间 小于当前的时间  
        //此时要在 第一次执行定时任务的时间加一天，以便此任务在下个时间点执行。如果不加一天，任务会立即执行。
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
        //安排指定的任务在指定的时间开始进行重复的固定延迟执行。
        timer.schedule(task,date,PERIOD_DAY);    
    }  
    // 增加或减少天数  
    public Date addDay(Date date, int num) {  
        Calendar startDT = Calendar.getInstance();  
        startDT.setTime(date);  
        startDT.add(Calendar.DAY_OF_MONTH, num);  
        return startDT.getTime();  
    }  
  
}  