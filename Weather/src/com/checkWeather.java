package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AQI_value;
import model.City;
import model.History;
import model.PageShow;
import model.Temper;
import model.forecast_temper;
import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

import dao.AqiDao;
import dao.CityDao;
import dao.TemperDao;


public class checkWeather {


	public void checkAQI() throws IOException{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response= ServletActionContext.getResponse();


		AqiDao aqidao=new AqiDao();
		CityDao citydao=new CityDao();



		List<AQI_value> array1 = new ArrayList<AQI_value>();


		array1=aqidao.findAll_today();



		System.out.println(array1.toString());
		//        
		//        //设置返回时的编码格式
		response.setContentType("text/html; charset=utf-8");
		//调用JSONArray.fromObject方法把array中的对象转化为JSON格式的数组

		
		
		JSONArray json=JSONArray.fromObject( array1  );
		System.out.println(json.toString());
		//返回给前段页面
		PrintWriter out = response.getWriter();  
		out.println(json);  
		out.flush();  
		out.close();

		//return "json";
	}


	public void checkTemper() throws IOException{

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response= ServletActionContext.getResponse();



		AqiDao aqidao=new AqiDao();

		TemperDao temperdao = new TemperDao();

		//CityDao citydao=new CityDao();

		List<AQI_value> array1 = new ArrayList<AQI_value>();


		array1=temperdao.findAll_today();



		System.out.println(array1.toString());
		//        
		//      //设置返回时的编码格式
		response.setContentType("text/html; charset=utf-8");
		//调用JSONArray.fromObject方法把array中的对象转化为JSON格式的数组
		JSONArray json=JSONArray.fromObject(     array1  );
		System.out.println(json.toString());
		//返回给前段页面
		PrintWriter out = response.getWriter();  
		out.println(json);  
		out.flush();  
		out.close();

		//return "json";
	}


	public void location_all() throws IOException{

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response= ServletActionContext.getResponse();


		AqiDao aqidao=new AqiDao();
		CityDao citydao=new CityDao();




		List<AQI_value> array1 = new ArrayList<AQI_value>();
		List<City> cityls = new ArrayList<City>();

		//array1=aqidao.findAll();
		cityls=citydao.findAll_City();




		System.out.println(cityls.toString());
		//        
		//        //设置返回时的编码格式
		response.setContentType("text/html; charset=utf-8");
		//调用JSONArray.fromObject方法把array中的对象转化为JSON格式的数组
		JSONArray json=JSONArray.fromObject(     cityls  );
		System.out.println(json.toString());
		//返回给前段页面
		PrintWriter out = response.getWriter();  
		out.println(json);  
		out.flush();  
		out.close();

		//return "json";
	}



	public void location_hasAQI() throws IOException{

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response= ServletActionContext.getResponse();


		AqiDao aqidao=new AqiDao();
		CityDao citydao=new CityDao();




		List<AQI_value> array1 = new ArrayList<AQI_value>();
		List<City> cityls = new ArrayList<City>();

		//array1=aqidao.findAll();
		cityls=citydao.findAll_haveAQI();




		System.out.println(cityls.toString());
		//        
		//        //设置返回时的编码格式
		response.setContentType("text/html; charset=utf-8");
		//调用JSONArray.fromObject方法把array中的对象转化为JSON格式的数组
		JSONArray json=JSONArray.fromObject(     cityls  );
		System.out.println(json.toString());
		//返回给前段页面
		PrintWriter out = response.getWriter();  
		out.println(json);  
		out.flush();  
		out.close();

		//return "json";
	}



	public void pageshow() throws IOException{

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response= ServletActionContext.getResponse();


		AqiDao aqidao=new AqiDao();
		CityDao citydao=new CityDao();
		TemperDao temperdao = new TemperDao();

		List<City> cityls = new ArrayList<City>();
		cityls=citydao.findAll_haveAQI();

		List<PageShow> ps_list = new ArrayList<PageShow>();


		for(int i = 0 ;i < cityls.size() ; i++ ){
			PageShow page = new PageShow();

			City city = cityls.get(i);

			String cityname = city.getName();

			List<forecast_temper> page_list = temperdao.find_for5days(cityname);

			page.setName(cityname); 

			List<String> timerdate = new ArrayList<String>();
			List<String> weather = new ArrayList<String>();
			List<String> temp = new ArrayList<String>();
			List<String> wind = new ArrayList<String>();

			for(int  j =  0 ; j  < page_list.size(); j++ ){

				Timestamp temps= page_list.get(j).getDate();
				//System.out.println(temps);
				//System.out.println(temps.getDate() );


				timerdate.add(j,String.valueOf(temps.getDate()) ) ;
				weather.add(j, page_list.get(j).getWeather_condition()) ;
				temp.add(j, page_list.get(j).getTemp()) ;
				wind.add(j, page_list.get(j).getWind()) ;

			}

			page.setTime(timerdate);
			page.setWeather(weather);
			page.setTemper(temp);
			page.setWind(wind);

			ps_list.add(page);
		}


		System.out.println(ps_list.toString());

		System.out.println(ps_list.size());
		//    
		//    //设置返回时的编码格式
		response.setContentType("text/html; charset=utf-8");
		//调用JSONArray.fromObject方法把array中的对象转化为JSON格式的数组
		JSONArray json=JSONArray.fromObject(    ps_list   );
		System.out.println(json.toString());
		//返回给前段页面
		PrintWriter out = response.getWriter();  
		out.println(json);  
		out.flush();  
		out.close();

		//return "json";
	}


	public void checkHistory() throws IOException{

		HttpServletRequest request = ServletActionContext.getRequest();
		request.setCharacterEncoding("utf-8");
		HttpServletResponse response= ServletActionContext.getResponse();


		String type = request.getParameter("type");
	
		String province = request.getParameter("province");
		String city = request.getParameter("city");
		String year = request.getParameter("year");
		String month = request.getParameter("month");

		response.setContentType("text/html; charset=utf-8");
		//调用JSONArray.fromObject方法把array中的对象转化为JSON格式的数组



		CityDao citydao=new CityDao();
		List<City> cityls = new ArrayList<City>();

		//baishan  黄颜色
		//anshun  绿色
	
		String citycode = citydao.getCityCode(city);
		
		List<History> his_AQI = citydao.check_His_AQI(year+"-"+month,citycode);


		//cityls=citydao.findAll_haveAQI();

		

		JSONArray json=JSONArray.fromObject(   his_AQI  );
		System.out.println(json.toString());
		//返回给前段页面
		
		PrintWriter out = response.getWriter();  
		out.println(json);  
		out.flush();  
		out.close();
	

	}


	public void check_BJ() throws IOException{

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response= ServletActionContext.getResponse();


		String year = request.getParameter("year");
		String month = request.getParameter("month");

		response.setContentType("text/html; charset=utf-8");
		//调用JSONArray.fromObject方法把array中的对象转化为JSON格式的数组



		CityDao citydao=new CityDao();
		List<City> cityls = new ArrayList<City>();

		//baishan  黄颜色
		//anshun  绿色

		List<History> his_AQI = citydao.check_His_AQI(year+"-"+month, "beijing");


		//cityls=citydao.findAll_haveAQI();



		JSONArray json=JSONArray.fromObject(   his_AQI  );
		System.out.println(json.toString());
		//返回给前段页面
		PrintWriter out = response.getWriter();  
		out.println(json);  
		out.flush();  
		out.close();

	}

	public void check_SH() throws IOException{

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response= ServletActionContext.getResponse();


		String year = request.getParameter("year");
		String month = request.getParameter("month");

		response.setContentType("text/html; charset=utf-8");
		//调用JSONArray.fromObject方法把array中的对象转化为JSON格式的数组



		CityDao citydao=new CityDao();
		List<City> cityls = new ArrayList<City>();

		//baishan  黄颜色
		//anshun  绿色

		List<History> his_AQI = citydao.check_His_AQI(year+"-"+month, "shanghai");


		//cityls=citydao.findAll_haveAQI();



		JSONArray json=JSONArray.fromObject(   his_AQI  );
		System.out.println(json.toString());
		//返回给前段页面
		PrintWriter out = response.getWriter();  
		out.println(json);  
		out.flush();  
		out.close();

	}

	public void check_GZ() throws IOException{

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response= ServletActionContext.getResponse();


		String year = request.getParameter("year");
		String month = request.getParameter("month");

		response.setContentType("text/html; charset=utf-8");
		//调用JSONArray.fromObject方法把array中的对象转化为JSON格式的数组



		CityDao citydao=new CityDao();
		List<City> cityls = new ArrayList<City>();

		//baishan  黄颜色
		//anshun  绿色

		List<History> his_AQI = citydao.check_His_AQI(year+"-"+month, "guangzhou");


		//cityls=citydao.findAll_haveAQI();



		JSONArray json=JSONArray.fromObject(   his_AQI  );
		System.out.println(json.toString());
		//返回给前段页面
		PrintWriter out = response.getWriter();  
		out.println(json);  
		out.flush();  
		out.close();

	}

}
