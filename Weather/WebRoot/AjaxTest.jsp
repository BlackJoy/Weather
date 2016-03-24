<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


<html>
<head>

<script type="text/javascript" language="javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#check_username").click(function(){
			var username = $("#username").val();
			
			$("#check_username").val("正在检测中……");
			alert(username);
			$.ajax({
				type: "GET",
				url: "validate.action",
				data: "username="+username,
				dataType:'text',
				success:function(data){
					alert(data);
					$("#check_username").val("检查会员名是否可用");
				},
				error:function(data){
					alert(data);
					alert("查询失败，请联系管理员！");
					$("#check_username").val("检查会员名是否可用");
				}
			});
		});
	});
</script>
</head>
<body>

	<form name="sub" action="">
		username:<input name="username" id="username" value=""/>
		<button name="check_username" id="check_username" type="button" >检查用户名是否符合规则</button>
		password:<input name="password"  id="password"  value=""/>
		
	</form>

</body>
</html>