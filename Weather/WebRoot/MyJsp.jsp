<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Weather</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  
  <script type="text/javascript">
  	function checkcityid(obj) {
		var cityidval=document.getElementById("cityid").value;
		alert(cityidval);
		if(cityidval==null || cityidval==""){
			alert("please input the cityname");
		}else{
			obj.form.action="city.action";
			obj.form.submit();
		}
	}
  </script>
  
  <body>
    <form action="">
                     省份: <input name="provinceid" id="provinceid" value="">
    	 城市：<input name="cityid" id="cityid" value=""/>
    	<button type="submit" onclick="checkcityid(this)">search</button>
    </form>
  </body>
</html>
