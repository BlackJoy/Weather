package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;




public class LngAndLatUtil {

	public static Map<String,Double> getLngAndLat(String address){
		Map<String,Double> map=new HashMap<String, Double>();
		String url = "http://api.map.baidu.com/geocoder/v2/?address="+address+"&output=json&ak=yaqmuGm3lwc7WfqHO63ZCqPX";
		String json = loadJSON(url);
		JSONObject obj = JSONObject.fromObject(json);
		if(obj.get("status").toString().equals("0")){
			double lng=obj.getJSONObject("result").getJSONObject("location").getDouble("lng");
			double lat=obj.getJSONObject("result").getJSONObject("location").getDouble("lat");
			map.put("lng", lng);
			map.put("lat", lat);
			//System.out.println("���ȣ�"+lng+"---γ�ȣ�"+lat);
		}else{
			//System.out.println("δ�ҵ���ƥ��ľ�γ�ȣ�");
		}
		return map;
	}

	public static String loadJSON (String url) {
		StringBuilder json = new StringBuilder();
		try {
			URL oracle = new URL(url);
			URLConnection yc = oracle.openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(
					yc.getInputStream()));
			String inputLine = null;
			while ( (inputLine = in.readLine()) != null) {
				json.append(inputLine);
			}
			in.close();
		} catch (MalformedURLException e) {
		} catch (IOException e) {
		}
		return json.toString();
	}
	
	
	
	
	public static void main(String[] args){
		
		Map<String,Double> map=LngAndLatUtil.getLngAndLat("�Ϻ��л���������·");
		System.out.println("���ȣ�"+map.get("lng")+"---γ�ȣ�"+map.get("lat"));
	}

}
