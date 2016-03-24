package util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.swing.text.DefaultFormatter;

import model.AQI_Model;
import model.Temper;

public class getFile {

	public static void main(String[] args) throws ClassNotFoundException, SQLException{
		
		//得到温度文件数据
//		String path="F://temperature";
//		getTemperatureFile(path);
		
		//得到AQI文件数据
		String path="F://aqi";
		getAQIFile(path);
		
	}


	public static void getTemperatureFile(String path) throws ClassNotFoundException, SQLException{

		File file = new File(path);
		File[] array = file.listFiles();

		for(int i=0;i < array.length ;i ++){

			if(array[i].isFile()){
				
				List<Temper>  ls = new ArrayList<Temper>();
 				
				
				String[] name_arr=array[i].getPath().split("_");
				String name=name_arr[name_arr.length-1];
				String[] city_name_temp =name.split("\\\\");
				System.out.println(city_name_temp);
				String city_name=city_name_temp[0];
				try { 
					BufferedReader br = new BufferedReader(new FileReader(array[i].getPath())); 
					String line = "";
					StringBuffer sb=new StringBuffer();
					while((line=br.readLine()) != null) {
						
						sb.append(line);
						System.out.println(line); 
					}
					
					String temp=sb.toString();
					if(temp!=null && !temp.equals("")){
							String[] temparray=temp.split("------------------------------");
							for(int j=0;j<temparray.length;j++){
								String[] array1=temparray[j].split("</td>");
								System.out.println(array1);
								
									Temper temperture= new Temper();
									temperture.setCity_name(city_name);
								
									String[] arr=array1[0].split("</a>");
									String str1=arr[arr.length-1].toString();
									arr=str1.split(" ");
									String date=arr[arr.length-1];
									String[] date_arr=date.split("");
									date_arr[5]="-";
									date_arr[8]="-";
									date_arr[11]="";
									System.out.println(date_arr);
									
									StringBuffer sb_temp=new StringBuffer();
									for(int p=0;p<date_arr.length;p++)
										sb_temp.append(date_arr[p]);
									date=sb_temp.toString();
									date=date+" 00:00:00.0";
									System.out.println(date);
									
//									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//									String str = sdf.format(date);
//									str2Timestamp(date,"yyyy-MM-dd HH:mm:ss");
									
									temperture.setDate(Timestamp.valueOf(date));
									System.out.println(temperture.getDate());
								for(int p=1;p<array1.length-1;p++){
									
									Pattern t = Pattern.compile("\\s*|\t|\r|\n");
						            Matcher m = t.matcher(array1[p]);
						            array1[p]=m.replaceAll("");
									
									arr=array1[p].split("<td>");
									if(p==1){
										String weather_condition=arr[arr.length-1];
										System.out.println(weather_condition);
										temperture.setWeather_condition(weather_condition);
									}else if(p==2){
										String temper=arr[arr.length-1];
										System.out.println(temper);
										temperture.setTemp(temper);
									}else if(p==3){
										String wind=arr[arr.length-1];
										System.out.println(wind);
										temperture.setWind(wind);
									}
								}
								ls.add(temperture);
							}
					
					System.out.println(temparray);
					}
				} catch (FileNotFoundException e) { 
					e.printStackTrace(); 
				} catch (IOException e) { 
					e.printStackTrace(); 
				} 
				
				
				
				
				System.out.println("^^^^^" + array[i].getName()); 
				System.out.println("#####" + array[i]);   
				System.out.println("*****" + array[i].getPath());
				
				
				//得到数据格式
				System.out.println(ls);
				toDatabase.save(ls);
				
				
			}else if (array[i].isDirectory()){

				getTemperatureFile(array[i].getPath());
			}
		}
	}
	

	
	public static void getAQIFile(String path) throws ClassNotFoundException, SQLException{
		
		File file = new File(path);
		File[] array = file.listFiles();
		
		for(int i=0;i < array.length ;i ++){

			if(array[i].isFile()){
				
				List<AQI_Model>  ls = new ArrayList<AQI_Model>();
 				
				
				String[] name_arr=array[i].getPath().split("_");
				String name=name_arr[name_arr.length-1];
				String[] city_name_temp =name.split("\\\\");
				
				String city_name=city_name_temp[0];
				System.out.println(city_name);
				try { 
					BufferedReader br = new BufferedReader(new FileReader(array[i].getPath())); 
					String line = "";
					StringBuffer sb=new StringBuffer();
					while((line=br.readLine()) != null) {
						
						sb.append(line);
						System.out.println(line); 
					}
					
					String temp=sb.toString();
					if(temp!=null && !temp.equals("")){
							String[] temparray=temp.split("------------------------------");
							for(int j=0;j<temparray.length;j++){
								String[] array1=temparray[j].split("</td>");
								System.out.println(array1);
								
							/**	
								
								<td>
                                <b>日期</b></td>
                            <td>
                                <b>AQI指数</b></td>
                            <td>
                                <b>质量等级</b></td>
                            <td>
                                <b>当天AQI排名</b></td>
                            
                            <td>
                                <b>PM2.5</b></td>
                            <td>
                                <b>PM10</b></td>
                         <!--   <td>
                                <b>Co</b></td>
                            <td>
                                <b>No2</b></td>
                            <td>
                                <b>So2</b></td>
                          -->
                            </tr>

							*/
								
									AQI_Model aqi=new AQI_Model();
									System.out.println(city_name);
									aqi.setCity_name(city_name);
									
									
									
									String[] arr=array1[0].split(" ");
									String date=arr[arr.length-1];
									
									//System.out.println(date);
									
//									StringBuffer sb_temp=new StringBuffer();
//									for(int p=0;p<date_arr.length;p++)
//										sb_temp.append(date_arr[p]);
//									date=sb_temp.toString();
									date=date+" 00:00:00.0";
									System.out.println(date);
									
//									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//									String str = sdf.format(date);
//									str2Timestamp(date,"yyyy-MM-dd HH:mm:ss");
									
									aqi.setDate(Timestamp.valueOf(date));
//									System.out.println(aqi.getDate());
								for(int p=1;p<array1.length-1;p++){
									
									Pattern t = Pattern.compile("\\s*|\t|\r|\n");
						            Matcher m = t.matcher(array1[p]);
						            array1[p]=m.replaceAll("");
									
									arr=array1[p].split("<td>");
									if(p==1){
										//AQI_point
										String AQI_point=arr[arr.length-1];
										System.out.println(AQI_point);
										aqi.setAQI_point(AQI_point);
									}else if(p==2){
										//quality_level
										String temp2[]=array1[p].split(">");
										String quality_level=temp2[temp2.length-1];
										System.out.println(quality_level);
										aqi.setQuality_level(quality_level);
									}else if(p==3){
										//AQI_number
										String AQI_number=arr[arr.length-1];
										System.out.println(AQI_number);
										aqi.setAQI_number(AQI_number);
									}else if(p==4){
										//PM25
										String PM25=arr[arr.length-1];
										System.out.println(PM25);
										aqi.setPM25(PM25);
									}else if(p==5){
										//PM10
										String PM10=arr[arr.length-1];
										System.out.println(PM10);
										aqi.setPM10(PM10);
									}else if(p==6){
										//Co
										String Co=arr[arr.length-1];
										System.out.println(Co);
										aqi.setCo(Co);
									}else if(p==7){
										//No2
										String No2=arr[arr.length-1];
										System.out.println(No2);
										aqi.setNo2(No2);
									}else if(p==8){
										//So2
										String So2=arr[arr.length-1];
										System.out.println(So2);
										aqi.setSo2(So2);
									}
									
								}
								ls.add(aqi);
							}
					
//					System.out.println(temparray);
					}
				} catch (FileNotFoundException e) { 
					e.printStackTrace(); 
				} catch (IOException e) { 
					e.printStackTrace(); 
				} 
				
				
				
				
				System.out.println("^^^^^" + array[i].getName()); 
				System.out.println("#####" + array[i]);   
				System.out.println("*****" + array[i].getPath());
				
				
				//得到数据格式
				System.out.println(ls);
				toDatabase.saveAQI(ls);
				
				
			}else if (array[i].isDirectory()){

				getAQIFile(array[i].getPath());
			}
		
		
		
		
		
		}
		
		
		
	}
	
	
	
	
	
}
