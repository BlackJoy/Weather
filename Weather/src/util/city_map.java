package util;

import java.io.IOException;

import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;




import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class city_map {

	/**
	 * @param args
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		
		Document doc = null;
		
		String url= "http://www.tianqihoubao.com/lishi/";
		try {
			doc=Jsoup.parse(new URL(url).openStream(), "GBK" ,url);
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
//		try {
//			doc = (Document) Jsoup.connect("http://www.tianqihoubao.com/lishi/")
//					  .timeout(5000000)
//					  .data("query", "Java")
//					  .userAgent("Mozilla")
//					  .cookie("auth", "token")
//					  .get();
//		} catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		List<String[]> ls = new ArrayList();
		
		Elements elements = doc.select("dd").select("a[href*=/lishi/]");
		
		for(int i = 0;i<elements.size();i++){
			System.out.println(elements.get(i));
			
			String a_ele=elements.get(i).toString();
			String arr[]= a_ele.split("\">");
			
			System.out.println(arr);
			
			arr[0]=arr[0].substring(16, arr[0].length());
			String[] key_arr=arr[0].split("\" ");
			key_arr = key_arr[0].split("\\.");
			String key = key_arr[0];
			System.out.println(key);
			
			String value=elements.get(i).text();
			System.out.println(value);
			
			String[]  temp_arr = {"",""} ;
			temp_arr[0]=key;
			temp_arr[1]=value;
			ls.add(temp_arr);
		}
		
		
		toDatabase.saveCityList(ls);
		
	}

}
