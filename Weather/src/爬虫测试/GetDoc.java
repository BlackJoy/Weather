package 爬虫测试;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class GetDoc {
	
	
	
	public static String readHtml(String myurl) {
	    StringBuffer sb = new StringBuffer("");
	    URL url;
	    try {
	        url = new URL(myurl);
	        BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(), "gbk"));
	        String s = "";
	        while ((s = br.readLine()) != null) {
	            sb.append(s + "\r\n");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return sb.toString();
	}
	
	public static String readHtml_utf8(String myurl) {
	    StringBuffer sb = new StringBuffer("");
	    URL url;
	    try {
	        url = new URL(myurl);
	        BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(), "utf8"));
	        String s = "";
	        while ((s = br.readLine()) != null) {
	            sb.append(s + "\r\n");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return sb.toString();
	}
	
	
	
	/**
	 * @param args
	 * @throws IOException 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static void main(String[] args) throws IOException, ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		
		Document doc = Jsoup.connect("http://wthrcdn.etouch.cn/WeatherApi?city="+URLEncoder.encode("����", "UTF-8"))													
				  .data("query", "Java")
				  .userAgent("Mozilla")
				  .cookie("auth", "token")
				  .timeout(3000)
				  .get();
		
		
		String temp = doc.toString();
		
		
		//String XML_test= readHtml_utf8("http://wthrcdn.etouch.cn/WeatherApi?citykey=101010100");
		
		
		String test = readHtml("http://www.tianqihoubao.com/lishi/");
		
		
		//��������״��
		//�еĻ���ʱ��AQI���в������
		
		Elements environment = doc.select("environment");
		
		if(environment!=null){
		
			String aqi=doc.select("aqi").text();
			String pm25=doc.select("pm25").text();
			String quality=doc.select("quality").text();
			String o3=doc.select("o3").text();
			String co=doc.select("co").text();
			String pm10=doc.select("pm10").text();
			String so2=doc.select("so2").text();
			String no2=doc.select("no2").text();
			
			
			forecast_AQI aqi_model = new forecast_AQI();
			
			//aqi_model.setDate(Timestamp.valueOf(new Date()));
	
			SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		        
	        Date date1 = new Date();
	        String time_temp=bartDateFormat.format(date1);
	        
	        System.out.println();
	  
	        time_temp= time_temp+" 00:00:00.0";
	        aqi_model.setCity_name("����");   //--------------------
			aqi_model.setAQI_point(aqi);
			aqi_model.setPM25(pm25);
			aqi_model.setQuality_level(quality);
			aqi_model.setCo(co);
			aqi_model.setPM10(pm10);
			aqi_model.setSo2(so2);
			aqi_model.setNo2(no2);
			aqi_model.setDate(Timestamp.valueOf(time_temp));
			
			
			
			List<forecast_AQI>  aqi_list =new ArrayList<forecast_AQI>();
			aqi_list.add(aqi_model);
			toDatabase.saveAQI(aqi_list);   //��Ԥ����д洢AQI
			
			
			System.out.println(aqi);
		}
		
		
		// ��ʱ�¶����
		Elements forecast = doc.select("forecast");
		Elements weathers = doc.select("weather");
		
		
		Calendar   cal   =   Calendar.getInstance();
        cal.add(Calendar.DATE,   0);
        String today = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
        today+="00:00:00";
        
        cal.add(Calendar.DATE,   1);
        String day1 = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
        day1+="00:00:00";
        cal.add(Calendar.DATE,   2);
        String day2 = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
        day2+="00:00:00";
        cal.add(Calendar.DATE,   3);
        String day3 = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
        day3+="00:00:00";
        cal.add(Calendar.DATE,   4);
        String day4 = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
        day4+="00:00:00";
      

		Object[] obs= weathers.toArray();
		
		
		Elements date = doc.select("date");
		Elements high = doc.select("high");
		Elements low = doc.select("low");
		
		Elements type = doc.select("type");
		Elements fengxiang = doc.select("fengxiang");
		Elements fengli = doc.select("fengli");
		
		String weather_temp;
		String temper_temp;
		String wind_temp;
		
		List<forecast_temper>  temper_list =new ArrayList<forecast_temper>();
		
		for(int i=0;i<obs.length;i++){
			
			forecast_temper temper= new forecast_temper();
			temper.setCity_name("����");
			temper.setDate(Timestamp.valueOf(today));
			
			weather_temp = type.get(i*2+0).text()+"/"+type.get(i*2+1).text();
			temper.setWeather_condition(weather_temp);
			temper_temp = high.get(i).text()+"/"+low.get(i).text();
			temper.setTemp(temper_temp);
			wind_temp = fengxiang.get(i*2+0).text()+fengli.get(i*2+0).text()+"/"+fengxiang.get(i*2+1).text()+fengli.get(i*2+1).text();
			temper.setWind(wind_temp);
			
			temper_list.add(temper);
			
		}
		
		toDatabase.save_forecastTemper(temper_list);
			

		//-------------------------------------
		//�����¶���ݹ鵵-----------------------------
		
		Temper temper = new Temper();
		
		temper.setCity_name("����");
		
		cal  = Calendar.getInstance();	
        cal.add(Calendar.DATE,   -1);
        String yesterday = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
        yesterday+="00:00:00";
        System.out.println(yesterday);
		
        temper.setDate(Timestamp.valueOf(yesterday));
        
		//Elements yesterday=doc.select("yesterday");
		
//	    String date_1 =doc.select("date_1").text();
        
		String high_1 = doc.select("high_1").text();
		String low_1 = doc.select("low_1").text();
		
		temper_temp = high_1+"/"+low_1;
		temper.setTemp(temper_temp);
		
		Elements type_1 = doc.select("type_1");
		String type_temp=type_1.get(0).text()+"/"+type_1.get(1).text();
		temper.setWeather_condition(type_temp);
		
		Elements fx_1 = doc.select("fx_1");
		Elements fl_1 = doc.select("fl_1");
		
		String fx_temp=fx_1.get(0).text()+ fl_1.get(0).text()  +"/"+fx_1.get(1).text()+fl_1.get(1).text();
		temper.setWind(fx_temp);
		
		
		List<Temper>  temper_ls = new ArrayList<Temper>();
		temper_ls.add(temper);
		
		toDatabase.save_Temper(temper_ls);
		
		//System.out.println(date+"-----"+high+"-----"+low+"------"+type);
		
		
		Document doc1 = Jsoup.parse(test);
		
		Elements links = doc1.select("a[href]");
		
		
//		Document doc = Jsoup.connect("http://www.tianqihoubao.com/lishi/")  
//				 .data("query", "Java")   // �������   // ���� User-Agent   
//				 .cookie("auth", "token") // ���� cookie   
//				 .timeout(3000)           // �������ӳ�ʱʱ��  
//				 .get();  
		
		System.out.println(doc1);
		
		
	}

}
