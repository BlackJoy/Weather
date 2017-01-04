<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
 <meta charset="utf-8">
</head>

<body  bgcolor="#333">--%>

<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta name="baidu-site-verification" content="XN2OVFQdUg">
    <title>
        AQIShow </title>
    <meta content="0" name="is-login">
    <meta content="1" name="is-open">
    <link href="./css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" media="screen" href="./css/font-awesome.min.css">
    <link rel="stylesheet" media="screen" href="./css/es-icon.css">
    <link rel="stylesheet" type="text/css" href="./css/iconfont.css">
    <link rel="stylesheet" type="text/css" href="./css/AQIShow.css">
    <script type="text/javascript" src="./js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="./js/index-nav.js"></script>
    <script type="text/javascript" src="./js/setOption.js"></script>
</head>

<body class="index">
<header class="header">
    <div class="container">
        <div class="navbar-header">
            <a href="http://localhost:8080/Weather/AQI_point.jsp" class="navbar-brand">
                <img src="./res/logo.png" class="img-responsive">
            </a>
        </div>
        <nav class="collapse navbar-collapse pull-left">
            <ul class="nav navbar-nav topmenu">
                <li class="">
                    <a href="http://localhost:8080/Weather/AQI_point.jsp">首页 </a>
                </li>
                <li class="">
                    <a href="http://localhost:8080/Weather/History.jsp">AQI查询 </a>
                </li>
                <li class="">
                    <a href="http://localhost:8080/Weather/Compare.jsp">AQI对比 </a>
                </li>
                <li class="">
                    <a href="http://localhost:8080/Weather/Temperture.jsp">TEMP显示 </a>
                </li>
            </ul>
        </nav>
        <ul class="nav user-nav pull-right">
            <li>
                <div class="form-group">
                    <input class="form-control js-search" name="q" placeholder="输入城市名 查空气指数" autocomplete="off">
                </div>
            </li>
            <li>
                <button type="submit" class="btn btn-sm btn-primary">查询</button>
            </li>
        </ul>
    </div>
</header>

<section class="history-tag hz-section">
    <div class="section-header">
        <h2>
            <span>城市空气质量历史数据</span>

            <div class="line"></div>
        </h2>
    </div>
    <script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>
    <script type="text/javascript" src="<%=basePath%>echarts/jquery.min.js"></script>
    <script type="text/javascript">
        var myDate = new Date();
        var curr_year = myDate.getFullYear();
        var curr_month = myDate.getMonth();
        function myselect() {
            var year = document.getElementById("year");
            var month = document.getElementById("month");
            var number = month.options.length;
            for (var j = month.length - 1; j >= 0; j--) {
                month.removeChild(month.childNodes.item(j));
            }
            if (year.value == "请选择") {
                for (var j = month.length - 1; j >= 0; j--) {
                    month.removeChild(month.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "";

                opt.selected = false;
                month.add(opt);
            }
            else if (year.value != "2016" && year.value != "def") {
                for (var j = month.length - 1; j >= 0; j--) {
                    month.removeChild(month.childNodes.item(j));
                }
                for (var i = 1; i <= 12; i++) {
                    var opt = document.createElement("OPTION");

                    if (i < 10) {
                        opt.text = "0" + i;
                        opt.value = "0" + i;
                    } else {
                        opt.text = i;
                        opt.value = i;
                    }
                    opt.selected = false;
                    month.add(opt);
                }
            } else if (year.value == "2016") {
                for (var j = month.length - 1; j >= 0; j--) {
                    month.removeChild(month.childNodes.item(j));
                }

                for (var i = 1; i <= 4; i++) {
                    var opt = document.createElement("OPTION");
                    if (i < 10) {
                        opt.text = "0" + i;
                        opt.value = "0" + i;
                    } else {
                        opt.text = i;
                        opt.value = i;
                    }
                    opt.selected = false;
                    month.add(opt);
                }
            }

        }
    </script>
    <script type="text/javascript">
        function selectCity() {
            var province = document.getElementById("province");
            var city = document.getElementById("city");
            var number = city.options.length;
            for (var j = city.length - 1; j >= 0; j--) {
                city.removeChild(city.childNodes.item(j));
            }
            if (province.value == "请选择") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "shanghai") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "上海";
                opt.value = "上海";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "yunnan") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "昆明";
                opt.value = "昆明";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "neimenggu") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "呼和浩特";
                opt.value = "呼和浩特";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "beijing") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "北京";
                opt.value = "北京";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "jilin") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "长春";
                opt.value = "长春";
                opt.selected = false;
                city.add(opt);
            }

            if (province.value == "sichuan") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "成都";
                opt.value = "成都";
                opt.selected = false;
                city.add(opt);
            }

            if (province.value == "tianjin") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "天津";
                opt.value = "天津";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "ningxia") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "银川";
                opt.value = "银川";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "anhui") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "合肥";
                opt.value = "合肥";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "shandong") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "济南";
                opt.value = "济南";
                opt.selected = false;
                city.add(opt);
                opt = document.createElement("OPTION");
                opt.text = "青岛";
                opt.value = "青岛";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "shanxi") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "太原";
                opt.value = "太原";
                opt.selected = false;
                city.add(opt);

            }
            if (province.value == "guangdong") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var temp = ["江门",
                    "深圳",
                    "惠州",
                    "肇庆",
                    "珠海",
                    "广州",
                    "东莞",
                    "佛山",
                    "中山"];

                for (var i = 0; i < temp.length; i++) {
                    var opt = document.createElement("OPTION");
                    opt.text = temp[i];
                    opt.value = temp[i];
                    opt.selected = false;
                    city.add(opt);
                }
            }
            if (province.value == "guangxi") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "南宁";
                opt.value = "南宁";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "xinjiang") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "乌鲁木齐";
                opt.value = "乌鲁木齐";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "jiangsu") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var temp = ["泰州",
                    "苏州",
                    "扬州",
                    "无锡",
                    "常州",
                    "盐城",
                    "连云港",
                    "镇江",
                    "徐州",
                    "宿迁",
                    "南通",
                    "淮安",
                    "南京"
                ];
                for (var i = 0; i < temp.length; i++) {
                    var opt = document.createElement("OPTION");
                    opt.text = temp[i];
                    opt.value = temp[i];
                    opt.selected = false;
                    city.add(opt);
                }
            }
            if (province.value == "jiangxi") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }

                var opt = document.createElement("OPTION");
                opt.text = "南昌";
                opt.value = "南昌";
                opt.selected = false;
                city.add(opt);
            }

            if (province.value == "hebei") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var temp = [
                    "沧州",
                    "秦皇岛",
                    "承德",
                    "廊坊",
                    "石家庄",
                    "保定",
                    "邯郸",
                    "衡水",
                    "唐山",
                    "张家口"
                ];
                for (var i = 0; i < temp.length; i++) {
                    var opt = document.createElement("OPTION");
                    opt.text = temp[i];
                    opt.value = temp[i];
                    opt.selected = false;
                    city.add(opt);
                }
            }
            if (province.value == "henan") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "郑州";
                opt.value = "郑州";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "zhejiang") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var temp = [
                    "丽水",
                    "湖州",
                    "杭州",
                    "衢州",
                    "嘉兴",
                    "宁波",
                    "温州",
                    "台州",
                    "金华",
                    "绍兴"
                ];
                for (var i = 0; i < temp.length; i++) {
                    var opt = document.createElement("OPTION");
                    opt.text = temp[i];
                    opt.value = temp[i];
                    opt.selected = false;
                    city.add(opt);
                }
            }
            if (province.value == "hainan") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "海口";
                opt.value = "海口";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "hubei") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "武汉";
                opt.value = "武汉";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "hunan") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "长沙";
                opt.value = "长沙";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "gansu") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "兰州";
                opt.value = "兰州";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "fujian") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "厦门";
                opt.value = "厦门";
                opt.selected = false;
                city.add(opt);
                opt = document.createElement("OPTION");
                opt.text = "福州";
                opt.value = "福州";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "xizang") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "拉萨";
                opt.value = "拉萨";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "guizhou") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "贵阳";
                opt.value = "贵阳";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "liaoning") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "大连";
                opt.value = "大连";
                opt.selected = false;
                city.add(opt);
                opt = document.createElement("OPTION");
                opt.text = "沈阳";
                opt.value = "沈阳";
                opt.selected = false;
                city.add(opt);
            }

            if (province.value == "chongqing") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "重庆";
                opt.value = "重庆";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "shanxi1") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "西安";
                opt.value = "西安";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "qinghai") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "西宁";
                opt.value = "西宁";
                opt.selected = false;
                city.add(opt);
            }
            if (province.value == "heilongjiang") {
                for (var j = city.length - 1; j >= 0; j--) {
                    city.removeChild(city.childNodes.item(j));
                }
                var opt = document.createElement("OPTION");
                opt.text = "哈尔滨";
                opt.value = "哈尔滨";
                opt.selected = false;
                city.add(opt);
            }
        }
    </script>
    <script type="text/javascript">
        var AQI_MAX = 0;
        var day_num = 0;
        var his_data = new Array();
        function checkForm() {
            if ($("#province").val() == "请选择") {
                alert("请选择查询省份！");
            }
            else if ($("#city").val() == null || $("#city").val() == "") {
                alert("请选择查询城市！");
            }
            else if ($("#year").val() == "请选择") {
                alert("请选择查询年份！");
            }
            else if ($("#month").val() == null || $("#month").val() == "") {
                alert("请选择查询月份！");
            } else {
                //myChart = echarts.init(dom);
                select_city = $("#city").val();
                $("#select_city").val($("#city").val());
                finddata();
                //option.seriesName=select_city;
                select_city = $("#city").val();
                //option.series[0].name = select_city;
                //option.legend.data = select_city;
                var select_year = $("#year").val();
                var select_month = $("#month").val();
                select_date = select_year + ' 年 ' + select_month + ' 月 ';
                if (AQI_MAX <= 150) {
                    option.color[0] = '#80F1BE';
                }
                else if (150 < AQI_MAX && AQI_MAX <= 200) {
                    option.color[0] = '#fec42c';
                }
                else if (200 < AQI_MAX) {

                    option.color[0] = '#dd4444';
                }
                option.legend.data[0].name = select_city;
                option.series[0].name = select_city;
                option.title.text = select_city + ' ' + select_date + "历史数据";
                myChart.setOption(option);
                //alert(myChart.getOption());
                //myChart.setOption(option);
            }
        }
        ;
        function history() {
            var value;
        }
        function finddata() {
            var arr = new Array();
            var province = $("#province").val();
            var city = $("#city").val();
            var year = $("#year").val();
            var month = $("#month").val();
            $.ajax({
                type: "post",
                async: false, //同步执行
                url: "checkHistory.action",
                data: {"province": province, "city": city, "year": year, "month": month},
                dataType: "json", //返回数据形式为json
                success: function (result) {
                	AQI_MAX=0;
                    if (result) {
                        var i = 0;
                        for (i = 0; i < result.length; i++) {
                            show_temp = show_obj();
                            dataBJ[i] = new Array();
                            console.log(result[i].day);
                            dataBJ[i][0] = result[i].day;
                            if (result[i].AQI_point > AQI_MAX)  AQI_MAX = result[i].AQI_point;
                            dataBJ[i][1] = result[i].AQI_point;
                            dataBJ[i][2] = result[i].PM25;
                            dataBJ[i][3] = result[i].PM10;
                            dataBJ[i][4] = result[i].co;
                            dataBJ[i][5] = result[i].no2;
                            dataBJ[i][6] = result[i].so2;
                            dataBJ[i][7] = result[i].quality;
                        }
                        day_num = result.length;
                    } else {
                        alert("您所选的城市该月份没有数据");
                    }
                },
                error: function (errorMsg) {
                    alert(errorMsg.responseText);
                    alert(errorMsg);
                    alert("不好意思，大爷，图表请求数据失败啦!");
                    myChart.hideLoading();
                }
            });
            return arr;
        }
    </script>
    <form style="height: 50px; font-size: 16px; padding-left: 100px">
        <div class="styled-select">
        省份: &nbsp;<select id="province" name="province" onChange="selectCity()">
        <option>请选择</option>
        <option value="beijing">北京市</option>
        <option value="shanghai">上海市</option>
        <option value="tianjin">天津市</option>
        <option value="yunnan">云南省</option>
        <option value="chongqing">重庆市</option>
        <option value="anhui">安徽省</option>
        <option value="shandong">山东省</option>
        <option value="shanxi">山西省</option>
        <option value="guangdong">广东省</option>
        <option value="jiangsu">江苏省</option>
        <option value="jiangxi">江西省</option>
        <option value="hebei">河北省</option>
        <option value="henan">河南省</option>
        <option value="zhejiang">浙江省</option>
        <option value="hainan">海南省</option>
        <option value="hubei">湖北省</option>
        <option value="hunan">湖南省</option>
        <option value="gansu">甘肃省</option>
        <option value="fujian">福建省</option>
        <option value="jilin">吉林省</option>
        <option value="sichuan">四川省</option>
        <option value="guizhou">贵州省</option>
        <option value="liaoning">辽宁省</option>
        <option value="shanxi1">陕西省</option>
        <option value="qinghai">青海省</option>
        <option value="heilongjiang">黑龙江省</option>
        <option value="neimenggu">内蒙古自治区</option>
        <option value="ningxia">宁夏回族自治区</option>
        <option value="guangxi">广西壮族自治区</option>
        <option value="xinjiang">新疆维吾尔自治区</option>
        <option value="xizang">西藏自治区</option>
    </select>
        城市: &nbsp;<select id="city" name="city">

    </select>
        年份：&nbsp;<select id="year" name="year" onChange="myselect()">
        <option>请选择</option>
        <option value="2013">2013</option>
        <option value="2014">2014</option>
        <option value="2015">2015</option>
        <option value="2016">2016</option>
    </select>
        月份：&nbsp;<select id="month" name="month">

    </select>
        <input type="button" value="查询" class="btn btn-sm btn-primary" onclick="checkForm()"/>
            </div>
    </form>
    <div id="container" style="width: 100%; height: 90%"></div>
    <input id="select_city" type="hidden" name="select_city" value="">
    <script type="text/javascript">
        var dom = document.getElementById("container");
        var myChart = echarts.init(dom);
        var select_date;
        var select_city;
        var show_temp;
        function show_obj() {
            var name;
            var data_BJ;
        }
        var dataBJ = new Array();  //= new Array();
        /*
         [
         [1,55,9,56,0.46,18,6,"良"],
         [2,25,11,21,0.65,34,9,"优"],
         [3,56,7,63,0.3,14,5,"良"],
         [4,33,7,29,0.33,16,6,"优"],
         [5,42,24,44,0.76,40,16,"优"],
         [6,82,58,90,1.77,68,33,"良"],
         [7,74,49,77,1.46,48,27,"良"],
         [8,78,55,80,1.29,59,29,"良"],
         [9,267,216,280,4.8,108,64,"重度污染"],
         [10,185,127,216,2.52,61,27,"中度污染"],
         [11,39,19,38,0.57,31,15,"优"],
         [12,41,11,40,0.43,21,7,"优"],
         [13,64,38,74,1.04,46,22,"良"],
         [14,108,79,120,1.7,75,41,"轻度污染"],
         [15,108,63,116,1.48,44,26,"轻度污染"],
         [16,33,6,29,0.34,13,5,"优"],
         [17,94,66,110,1.54,62,31,"良"],
         [18,186,142,192,3.88,93,79,"中度污染"],
         [19,57,31,54,0.96,32,14,"良"],
         [20,22,8,17,0.48,23,10,"优"],
         [21,39,15,36,0.61,29,13,"优"],
         [22,94,69,114,2.08,73,39,"良"],
         [23,99,73,110,2.43,76,48,"良"],
         [24,31,12,30,0.5,32,16,"优"],
         [25,42,27,43,1,53,22,"优"],
         [26,154,117,157,3.05,92,58,"中度污染"],
         [27,234,185,230,4.09,123,69,"重度污染"],
         [28,160,120,186,2.77,91,50,"中度污染"],
         [29,134,96,165,2.76,83,41,"轻度污染"],
         [30,52,24,60,1.03,50,21,"良"],
         [31,46,5,49,0.28,10,6,"优"]
         ]; */
        var dataGZ = [
            [1, 26, 37, 27, 1.163, 27, 13, "优"],
            [2, 85, 62, 71, 1.195, 60, 8, "良"],
            [3, 78, 38, 74, 1.363, 37, 7, "良"],
            [4, 21, 21, 36, 0.634, 40, 9, "优"],
            [5, 41, 42, 46, 0.915, 81, 13, "优"],
            [6, 56, 52, 69, 1.067, 92, 16, "良"],
            [7, 64, 30, 28, 0.924, 51, 2, "良"],
            [8, 55, 48, 74, 1.236, 75, 26, "良"],
            [9, 76, 85, 113, 1.237, 114, 27, "良"],
            [10, 91, 81, 104, 1.041, 56, 40, "良"],
            [11, 84, 39, 60, 0.964, 25, 11, "良"],
            [12, 64, 51, 101, 0.862, 58, 23, "良"],
            [13, 70, 69, 120, 1.198, 65, 36, "良"],
            [14, 77, 105, 178, 2.549, 64, 16, "良"],
            [15, 109, 68, 87, 0.996, 74, 29, "轻度污染"],
            [16, 73, 68, 97, 0.905, 51, 34, "良"],
            [17, 54, 27, 47, 0.592, 53, 12, "良"],
            [18, 51, 61, 97, 0.811, 65, 19, "良"],
            [19, 91, 71, 121, 1.374, 43, 18, "良"],
            [20, 73, 102, 182, 2.787, 44, 19, "良"],
            [21, 73, 50, 76, 0.717, 31, 20, "良"],
            [22, 84, 94, 140, 2.238, 68, 18, "良"],
            [23, 93, 77, 104, 1.165, 53, 7, "良"],
            [24, 99, 130, 227, 3.97, 55, 15, "良"],
            [25, 146, 84, 139, 1.094, 40, 17, "轻度污染"],
            [26, 113, 108, 137, 1.481, 48, 15, "轻度污染"],
            [27, 81, 48, 62, 1.619, 26, 3, "良"],
            [28, 56, 48, 68, 1.336, 37, 9, "良"],
            [29, 82, 92, 174, 3.29, 0, 13, "良"],
            [30, 106, 116, 188, 3.628, 101, 16, "轻度污染"],
            [31, 118, 50, 0, 1.383, 76, 11, "轻度污染"]
        ];
        var dataSH = [
            [1, 91, 45, 125, 0.82, 34, 23, "良"],
            [2, 65, 27, 78, 0.86, 45, 29, "良"],
            [3, 83, 60, 84, 1.09, 73, 27, "良"],
            [4, 109, 81, 121, 1.28, 68, 51, "轻度污染"],
            [5, 106, 77, 114, 1.07, 55, 51, "轻度污染"],
            [6, 109, 81, 121, 1.28, 68, 51, "轻度污染"],
            [7, 106, 77, 114, 1.07, 55, 51, "轻度污染"],
            [8, 89, 65, 78, 0.86, 51, 26, "良"],
            [9, 53, 33, 47, 0.64, 50, 17, "良"],
            [10, 80, 55, 80, 1.01, 75, 24, "良"],
            [11, 117, 81, 124, 1.03, 45, 24, "轻度污染"],
            [12, 99, 71, 142, 1.1, 62, 42, "良"],
            [13, 95, 69, 130, 1.28, 74, 50, "良"],
            [14, 116, 87, 131, 1.47, 84, 40, "轻度污染"],
            [15, 108, 80, 121, 1.3, 85, 37, "轻度污染"],
            [16, 134, 83, 167, 1.16, 57, 43, "轻度污染"],
            [17, 79, 43, 107, 1.05, 59, 37, "良"],
            [18, 71, 46, 89, 0.86, 64, 25, "良"],
            [19, 97, 71, 113, 1.17, 88, 31, "良"],
            [20, 84, 57, 91, 0.85, 55, 31, "良"],
            [21, 87, 63, 101, 0.9, 56, 41, "良"],
            [22, 104, 77, 119, 1.09, 73, 48, "轻度污染"],
            [23, 87, 62, 100, 1, 72, 28, "良"],
            [24, 168, 128, 172, 1.49, 97, 56, "中度污染"],
            [25, 65, 45, 51, 0.74, 39, 17, "良"],
            [26, 39, 24, 38, 0.61, 47, 17, "优"],
            [27, 39, 24, 39, 0.59, 50, 19, "优"],
            [28, 93, 68, 96, 1.05, 79, 29, "良"],
            [29, 188, 143, 197, 1.66, 99, 51, "中度污染"],
            [30, 174, 131, 174, 1.55, 108, 50, "中度污染"],
            [31, 187, 143, 201, 1.39, 89, 53, "中度污染"]
        ];
        var schema = [
            {name: 'date', index: 0, text: '日'},
            {name: 'AQIindex', index: 1, text: 'AQI指数'},
            {name: 'PM25', index: 2, text: 'PM2.5'},
            {name: 'PM10', index: 3, text: 'PM10'},
            {name: 'CO', index: 4, text: '一氧化碳（CO）'},
            {name: 'NO2', index: 5, text: '二氧化氮（NO2）'},
            {name: 'SO2', index: 6, text: '二氧化硫（SO2）'}
        ];
        var itemStyle = {
            normal: {
                opacity: 0.8,
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowOffsetY: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
        };
        option = {
            backgroundColor: '#333',
            //城市颜色，可以根据AQI指数不同指定
            color: [
                '#dd4444'
            ],
            title: {
                text: '城市历史数据展示',
                top: 20 ,
                left: 'center',
                textStyle: {
                    color: '#fff'
                }
            },
            legend: {
                y: '5%',
                data: [{name: '显示/隐藏'}],//[, '上海', '广州'],
                textStyle: {
                    color: '#fff',
                    fontSize: 16
                }
            },
            grid: {
                x: '5%',
                x2: 150,
                y: '12%',
                y2: '10%'
            },
            tooltip: {
                padding: 10,
                backgroundColor: '#222',
                borderColor: '#777',
                borderWidth: 1,
                formatter: function (obj) {
                    //alert(select_city);
                    var value = obj.value;
                    return '<div style="border-bottom: 1px solid rgba(255,255,255,.3); font-size: 18px;padding-bottom: 7px;margin-bottom: 7px">'
                            + select_city + ' ' + value[0] + '日：'
                            + value[7]
                            + '</div>'
                            + schema[1].text + '：' + value[1] + '<br>'
                            + schema[2].text + '：' + value[2] + '<br>'
                            + schema[3].text + '：' + value[3] + '<br>'
                            + schema[4].text + '：' + value[4] + '<br>'
                            + schema[5].text + '：' + value[5] + '<br>'
                            + schema[6].text + '：' + value[6] + '<br>';
                }
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
            xAxis: {
                type: 'value',
                name: '日期',
                nameGap: 16,
                nameTextStyle: {
                    color: '#fff',
                    fontSize: 14
                },
                max: 31,
                splitLine: {
                    show: false
                },
                axisLine: {
                    lineStyle: {
                        color: '#777'
                    }
                },
                axisTick: {
                    lineStyle: {
                        color: '#777'
                    }
                },
                axisLabel: {
                    formatter: '{value}',
                    textStyle: {
                        color: '#fff'
                    }
                }
            },
            yAxis: {
                type: 'value',
                name: 'AQI指数',
                nameLocation: 'end',
                nameGap: 20,
                nameTextStyle: {
                    color: '#fff',
                    fontSize: 16
                },
                axisLine: {
                    lineStyle: {
                        color: '#777'
                    }
                },
                axisTick: {
                    lineStyle: {
                        color: '#777'
                    }
                },
                splitLine: {
                    show: false
                },
                axisLabel: {
                    textStyle: {
                        color: '#fff'
                    }
                }
            },
            visualMap: [
                {
                    left: '88%',
                    top: '20%',
                    dimension: 2,
                    min: 0,
                    max: 250,
                    itemWidth: 30,
                    itemHeight: 120,
                    calculable: true,
                    precision: 0.1,
                    text: ['圆形大小：PM2.5'],
                    textGap: 30,
                    textStyle: {
                        color: '#fff'
                    },
                    inRange: {
                        symbolSize: [10, 70]
                    },
                    outOfRange: {
                        symbolSize: [10, 70],
                        color: ['rgba(255,255,255,.2)']
                    },
                    controller: {
                        inRange: {
                            color: ['#c23531']
                        },
                        outOfRange: {
                            color: ['#444']
                        }
                    }
                },
                {
                    left: '88%',
                    bottom: '20%',
                    dimension: 6,
                    min: 0,
                    max: 50,
                    itemHeight: 120,
                    calculable: true,
                    precision: 0.1,
                    text: ['明暗：二氧化硫'],
                    textGap: 30,
                    textStyle: {
                        color: '#fff'
                    },
                    inRange: {
                        colorLightness: [1, 0.5]
                    },
                    outOfRange: {
                        color: ['rgba(255,255,255,.2)']
                    },
                    controller: {
                        inRange: {
                            color: ['#c23531']
                        },
                        outOfRange: {
                            color: ['#444']
                        }
                    }
                }
            ],
            series: /* function() {
             var serie = [];


             var select_city_name = show_temp.name;
             alert(select_city_name);
             var data = show_temp.data_BJ;

             select_city = $("#city").val();

             alert(select_city);
             var item = {

             name : select_city_name,
             type : 'scatter',
             data : data ,
             };


             serie.push(item);

             return serie;
             }() */


                    [
                        {
                            name: '显示/隐藏',
                            type: 'scatter',
                            itemStyle: itemStyle,
                            data: dataBJ
                        }
                    ]
            /*,
             {
             name: '上海',
             type: 'scatter',
             itemStyle: itemStyle,
             data: dataSH
             },
             {
             name: '广州',
             type: 'scatter',
             itemStyle: itemStyle,
             data: dataGZ
             }

             */

        };
        myChart.setOption(option);
    </script>
</section>

<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-5 ">
                <a href="./main.html"><img src="./res/foot-logo.png"></a>
            </div>
            <div class="col-md-4 about">
                <span><a href="http://www.howzhi.com/info/about">关于我们</a></span>|
                <span><a href="http://www.howzhi.com/group/feedback/discuss/15754" target="_blank">加入我们</a></span>|
                <span><a href="http://www.howzhi.com/daren/" target="_blank">合作申请</a></span>|
                <span><a href="http://www.howzhi.com/group/feedback">意见反馈</a></span>
            </div>
        </div>
    </div>
</footer>
<div class="friendlinks">
    <div class="container">
        <font>友情链接</font>
        <a href="http://www.cma.gov.cn/" target="_blank" class="white">中国气象局</a>
        <span>|</span>
        <a href="http://data.cma.cn/" target="_blank" class="white">中国气象数据网</a>
        <span>|</span>
        <a href="http://www.weathertv.cn/" target="_blank" class="white">中国气象频道</a>
        <span>|</span>
        <a href="http://www.weather.com.cn/" target="_blank" class="white">中国天气网</a>
        <span>|</span>
        <a href="http://www.zhb.gov.cn/" target="_blank" class="white">国家环境保护部</a>
        <span>|</span>
        <a href="http://pm25.in/" target="_blank" class="white">PM25.in</a>
        <br> Copyright © 2016-2017 AQIShow团队. All Rights Reserved.
    </div>
</div>
</body>
</html>
