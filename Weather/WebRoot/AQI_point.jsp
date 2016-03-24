<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html">
<head>

<meta charset="utf-8">

</head>

<body >

<div id="container" style="width: 99%; height: 99%"></div>

<script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>
<script type="text/javascript" src="<%=basePath%>js/china.js"></script>
<script type="text/javascript" src="<%=basePath%>echarts/jquery.min.js"></script>

<script type="text/javascript">


var dom = document.getElementById("container");
var myChart = echarts.init(dom);

var geoCoordMap = getlocation ();

var city_Temper = getCityTemper() ;

function getCityTemper (){
     var map= {} ;
         $.ajax({
          type : "get",
          async : false, //同步执行
          url : "getPageShow.action",
          dataType : "json", //返回数据形式为json
          success : function(result) {
             if (result) 
             {
                    
                    var i=0;
                    for(i=0;i<result.length;i++){
                      
                      
                       var temp_list = new Array();
                      
                       var time = new Array();
                       var weather = new Array();
                       var temper = new Array();
                       var wind = new Array();
                      
                      jQuery.each(result[i].time, function(i,item){     
		                 time.push(item); 
		              });
                      jQuery.each(result[i].weather, function(i,item){     
		                 weather.push(item); 
		              });
		              jQuery.each(result[i].temper, function(i,item){     
		                 temper.push(item); 
		              });
		              jQuery.each(result[i].wind, function(i,item){     
		                 wind.push(item); 
		              });
                      
                      temp_list.push(time);
                      temp_list.push(weather);
                      temp_list.push(temper);
                      temp_list.push(wind);
                      
                      
                      //var temper_arr = new Array();
                      
                      
                       console.log(result[i].name);
                       
                       
                       
                       //"海门":[121.15,31.89],
                       
                       //
					   /*
                       time=result[i].time;
                       weather=result[i].weather;
                       temper=result[i].temper;
                       wind=result[i].wind;
                      
                       temper_arr[0]=result[i].time;
                       temper_arr[1]=weather;
                       temper_arr[2]=temper;
                       temper_arr[3]=wind; 
                       */
	                   map[result[i].name] = temp_list;


                    }
                    
                    //alert(map);
                     
             };

 
    	 		},
       error : function(errorMsg) {
            alert(errorMsg.responseText);
       	 alert(errorMsg );
           alert("不好意思，大爷，图表请求数据失败啦!");
           myChart.hideLoading();
       }
  		});
    	return map;
}








var convertData = function (data) {
   
    var res = [];
    for (var i = 0; i < data.length; i++) {
       
        var geoCoord = geoCoordMap[data[i].name];
       
        
        if (geoCoord) {

            res.push({
                name: data[i].name,
                value: geoCoord.concat(data[i].value)
            });
        }
    }
    return res;
};






function finddata (){
           var arr=new Array();
               $.ajax({
                type : "get",
                async : false, //同步执行
                url : "getdata.action",
                dataType : "json", //返回数据形式为json
                success : function(result) {
                   if (result) {
                          var i=0;
                          for(i=0;i<result.length;i++){
                             var AQI_temp = new AQI_obj();
                             console.log(result[i].name);
                             
							AQI_temp.name=result[i].name;
							AQI_temp.value=result[i].value;
							arr[i]=AQI_temp;
                          }
                          
                          
                          //alert(arr);    
                   };
       
          	 		},
             error : function(errorMsg) {
                  alert(errorMsg.responseText);
             	 alert(errorMsg );
                 alert("不好意思，大爷，图表请求数据失败啦!");
                 myChart.hideLoading();
             }
        		});
          	return arr;
      }
                      
                      


function AQI_obj (){
   var name;
   var value;
};


function getlocation (){
     var map= { } ;
         $.ajax({
          type : "get",
          async : false, //同步执行
          url : "getAQIlocation.action",
          dataType : "json", //返回数据形式为json
          success : function(result) {
             if (result) 
             {
                    
                    var i=0;
                    for(i=0;i<result.length;i++){
                      
                       var city_temp = new Array();
                       console.log(result[i].name);
                       //[{name: "海门", value: 9},
                       
                       
                       
                       city_temp[0]=result[i].longitude;
                       city_temp[1]=result[i].latitude;
	                   map[result[i].name] = city_temp;


                    }
                    
                    //alert(map);
                     
             };

 
    	 		},
       error : function(errorMsg) {
            alert(errorMsg.responseText);
       	 alert(errorMsg );
           alert("不好意思，大爷，图表请求数据失败啦!");
           myChart.hideLoading();
       }
  		});
    	return map;
}



option = {
    backgroundColor: '#404a59',
    title: {
        text: '全国主要城市空气质量',
        x:'center',
        textStyle: {
            color: '#fff'
        }
    },
    tooltip: {
        trigger: 'item',
        formatter: function (params) {
        	
        	var tt = city_Temper[params.name];
        	
        
            return params.name + '  AQI : ' + params.value[2] +
                     '<br/> '+ tt[0][0]+'日: ' + tt[1][0] +' ' + tt[2][0] +' '+ tt[3][0]+
                     '<br/> '+ tt[0][1]+'日: ' + tt[1][1] +' ' + tt[2][1] +' '+ tt[3][1]+
                     '<br/> '+ tt[0][2]+'日: ' + tt[1][2] +' ' + tt[2][2] +' '+ tt[3][2]+
                     '<br/> '+ tt[0][3]+'日: ' + tt[1][3] +' ' + tt[2][3] +' '+ tt[3][3]+
                     '<br/> '+ tt[0][4]+'日: ' + tt[1][4] +' ' + tt[2][4] +' '+ tt[3][4];
        }
    },
    legend: {
        orient: 'vertical',
        y: 'bottom',
        x:'right',
        data:['AQI'],
        textStyle: {
            color: '#fff'
        }
    },
    dataRange: {
        min: 0,
        max: 200,
        calculable: true,
        color: ['#d94e5d','#eac736','#50a3ba'],
        textStyle: {
            color: '#fff'
        }
    },
    geo: {
        map: 'china',
        label: {
            emphasis: {
                show: false
            }
        },
        roam: true,
        itemStyle: {
            normal: {
                areaColor: '#323c48',
                borderColor: '#111'
            },
            emphasis: {
                areaColor: '#2a333d'
            }
        }
    },
    series: [
        {
            name: 'AQI',
            type: 'scatter',
            coordinateSystem: 'geo',
            data: convertData(
			
            	finddata ()
            
            ),
            symbolSize: 12,
            label: {
                normal: {
                    formatter: '{b}',
                    position: 'right',
                    show: false
                },
                emphasis: {
                    show: true
                }
            },
            itemStyle: {
                emphasis: {
                    borderColor: '#fff',
                    borderWidth: 1
                }
            }
        }
    ]
};

myChart.setOption(option);


</script>
</body>
</html>
