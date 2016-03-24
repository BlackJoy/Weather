<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
  	<meta charset="utf-8">

  </head>
  
  <div id="container" style="width: 100%; height: 100%"></div>
  <script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>
  
  <script type="text/javascript">
  	
  	
  	var dom = document.getElementById("container");
	var myChart = echarts.init(dom);
  	
  	option = {
	    xAxis: {
	        type: 'value'
	    },
	    yAxis: {
	        type: 'value'
	    },
	     dataZoom: [
	         {
	            type: 'slider',
	            xAxisIndex: 0,
	            start: 10,
	            end: 60
	        },
	        {
	            type: 'inside',
	            xAxisIndex: 0,
	            start: 10,
	            end: 60
	        },
	        {
	            type: 'slider',
	            yAxisIndex: 0,
	            start: 30,
	            end: 80
	        },
	        {
	            type: 'inside',
	            yAxisIndex: 0,
	            start: 30,
	            end: 80
	        }
	    ],
	    series: [
	        {
	            type: 'scatter', // 这是个『散点图』
	            itemStyle: {
	                normal: {
	                    opacity: 0.8
	                }
	            },
	            symbolSize: function (val) {
	                return val[2] * 40;
	            },
	            data: [["14.616","7.241","0.896"],["3.958","5.701","0.955"],["2.768","8.971","0.669"],["9.051","9.710","0.171"],["14.046","4.182","0.536"],["12.295","1.429","0.962"],["4.417","8.167","0.113"],["0.492","4.771","0.785"],["7.632","2.605","0.645"],["14.242","5.042","0.368"]]
	        }
	    ]
	};
	myChart.setOption(option);
  	
  
  </script>
  
  <body>
  
  </body>
</html>
