<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html style="width: 100%; height: 100%">
<head>

<meta charset="utf-8">

</head>

<body style="width: 100%; height: 100%; margin: 0">
<div id="container" style="width: 99%; height: 99%"></div>
<script type="text/javascript" src="<%=basePath%>js/echart-all-3.0.0.js"></script>
<script type="text/javascript" src="<%=basePath%>js/china.js"></script>
<script type="text/javascript" src="<%=basePath%>echarts/jquery.min.js"></script>


<script type="text/javascript">
var dom = document.getElementById("container");
var myChart = echarts.init(dom);

var geoCoordMap = getlocation ();
function getlocation (){
     var map= { } ;
         $.ajax({
          type : "get",
          async : false, //同步执行
          url : "getAlllocation.action",
          dataType : "json", //返回数据形式为json
          success : function(result) {
             if (result) 
             {
                    
                    var i=0;
                    for(i=0;i<result.length;i++){
                      
                       var city_temp = new Array();
                       console.log(result[i].name);

                       city_temp[0]=result[i].longitude;
                       city_temp[1]=result[i].latitude;
	                   map[result[i].name] = city_temp;
                    }
                    
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


function finddata (){
           var arr=new Array();
               $.ajax({
                type : "get",
                async : false, //同步执行
                url : "getTemperdata.action",
                dataType : "json", //返回数据形式为json
                success : function(result) {
                   if (result) {
                          var i=0;
                          for(i=0;i<result.length;i++){
                             var Temper = new Temp_obj();
                             console.log(result[i].name);
                             
							Temper.name=result[i].name;
							Temper.value=result[i].value;
							arr[i]=Temper;
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
                      
                      


function Temp_obj (){
   var name;
   var value;
};









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
            
            return params.name + ' : ' + params.value[2];
        }
    },
    legend: {
        orient: 'vertical',
        y: 'bottom',
        x:'right',
 
        data:['温度'],
 
        textStyle: {
            color: '#fff'
        }
        
    },

    dataRange: {
        min: -10,
        max: 40,
        calculable: true,
        color: ['#f16209','#f5f71d','#0844dd'],
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
            name: '温度',
            type: 'heatmap',
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
