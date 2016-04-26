<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

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
</head>

<body class="index">
<header class="header">
    <div class="container">
        <div class="navbar-header">
            <a href="./main.html" class="navbar-brand">
                <img src="./res/logo.png" class="img-responsive">
            </a>
        </div>
        <nav class="collapse navbar-collapse pull-left">
            <ul class="nav navbar-nav topmenu">
                <li class="">
                    <a href="http://localhost:8080/AQI_point.jsp">首页 </a>
                </li>
                <li class="">
                    <a href="http://localhost:8080/History.jsp">AQI查询 </a>
                </li>
                <li class="">
                    <a href="http://localhost:8080/Compare.jsp">AQI对比 </a>
                </li>
                <li class="">
                    <a href="http://localhost:8080/Temperture.jsp">TEMP显示 </a>
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
<section class="hz-section">
    <%--<div class="container">--%>
        <div class="section-header">
            <h2>
                <span>全国主要城市空气质量</span>

                <div class="line"></div>
            </h2>
        </div>
        <div id="map_container" style="width: 100%; height: 90%"></div>
        <script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/china.js"></script>
        <script type="text/javascript" src="<%=basePath%>echarts/jquery.min.js"></script>
        <script type="text/javascript">
            var dom = document.getElementById("map_container");
            var myChart = echarts.init(dom);
            var geoCoordMap = getlocation();
            var city_Temper = getCityTemper();
            function getCityTemper() {
                var map = {};
                $.ajax({
                    type: "get",
                    async: false, //同步执行
                    url: "getPageShow.action",
                    dataType: "json", //返回数据形式为json
                    success: function (result) {
                        if (result) {
                            var i = 0;
                            for (i = 0; i < result.length; i++) {
                                var temp_list = new Array();
                                var time = new Array();
                                var weather = new Array();
                                var temper = new Array();
                                var wind = new Array();
                                jQuery.each(result[i].time, function (i, item) {
                                    time.push(item);
                                });
                                jQuery.each(result[i].weather, function (i, item) {
                                    weather.push(item);
                                });
                                jQuery.each(result[i].temper, function (i, item) {
                                    temper.push(item);
                                });
                                jQuery.each(result[i].wind, function (i, item) {
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
                        }
                        ;
                    },
                    error: function (errorMsg) {
                        alert(errorMsg.responseText);
                        alert(errorMsg);
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
            function finddata() {
                var arr = new Array();
                $.ajax({
                    type: "get",
                    async: false, //同步执行
                    url: "getdata.action",
                    dataType: "json", //返回数据形式为json
                    success: function (result) {
                        if (result) {
                            var i = 0;
                            for (i = 0; i < result.length; i++) {
                                var AQI_temp = new AQI_obj();
                                console.log(result[i].name);

                                AQI_temp.name = result[i].name;
                                AQI_temp.value = result[i].value;
                                arr[i] = AQI_temp;
                            }
                            //alert(arr);
                        }
                        ;
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
            function AQI_obj() {
                var name;
                var value;
            }
            ;
            function getlocation() {
                var map = {};
                $.ajax({
                    type: "get",
                    async: false, //同步执行
                    url: "getAQIlocation.action",
                    dataType: "json", //返回数据形式为json
                    success: function (result) {
                        if (result) {
                            var i = 0;
                            for (i = 0; i < result.length; i++) {
                                var city_temp = new Array();
                                console.log(result[i].name);
                                //[{name: "海门", value: 9},
                                city_temp[0] = result[i].longitude;
                                city_temp[1] = result[i].latitude;
                                map[result[i].name] = city_temp;
                            }
                            //alert(map);
                        }
                        ;
                    },
                    error: function (errorMsg) {
                        alert(errorMsg.responseText);
                        alert(errorMsg);
                        alert("不好意思，大爷，图表请求数据失败啦!");
                        myChart.hideLoading();
                    }
                });
                return map;
            }
            option = {
                backgroundColor: '#404a59',
                /*title: {
                    text: '全国主要城市空气质量',
                    x: 'center',
                    textStyle: {
                        color: '#fff'
                    }
                },*/
                tooltip: {
                    trigger: 'item',
                    formatter: function (params) {
                        var tt = city_Temper[params.name];
                        return params.name + '  AQI : ' + params.value[2] +
                                '<br/> ' + tt[0][0] + '日: ' + tt[1][0] + ' ' + tt[2][0] + ' ' + tt[3][0] +
                                '<br/> ' + tt[0][1] + '日: ' + tt[1][1] + ' ' + tt[2][1] + ' ' + tt[3][1] +
                                '<br/> ' + tt[0][2] + '日: ' + tt[1][2] + ' ' + tt[2][2] + ' ' + tt[3][2] +
                                '<br/> ' + tt[0][3] + '日: ' + tt[1][3] + ' ' + tt[2][3] + ' ' + tt[3][3] +
                                '<br/> ' + tt[0][4] + '日: ' + tt[1][4] + ' ' + tt[2][4] + ' ' + tt[3][4];
                    }
                },
                legend: {
                    orient: 'vertical',
                    y: 'bottom',
                    x: 'right',
                    data: ['AQI'],
                    textStyle: {
                        color: '#fff'
                    }
                },
                dataRange: {
                    min: 0,
                    max: 200,
                    calculable: true,
                    color: ['#d94e5d', '#eac736', '#50a3ba'],
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
                series: [{
                    name: 'AQI',
                    type: 'scatter',
                    coordinateSystem: 'geo',
                    data: convertData(
                            finddata()
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
                }]
            };
            myChart.setOption(option);
        </script>
    <%--</div>--%>
</section>
<section class="hot-tag hz-section">
    <div class="container">
        <div class="section-header">
            <h2>
                <span>热门城市</span>

                <div class="line"></div>
            </h2>
        </div>
        <div class="section-body">
            <div class="hot-tag-main tag-hide row" style="display: block;">
                <div class="col-md-6">
                    <ul class="">
                        <li class="col-xs-5 item-s">
                            <a href="History.jsp?province=jiangsu&city=changzhou">
                                <img src="./res/changzhou.jpg" alt="常州">
                                <span class="label label-b label-md">常州</span>
                            </a>
                        </li>
                        <li class="col-xs-7 item-s">
                            <a href="http://www.howzhi.com/tag/After%20Effect">
                                <img src="./res/yangzhou.jpg" alt="扬州">
                                <span class="label label-b label-md">扬州</span>
                            </a>
                        </li>
                        <li class="col-xs-7 item-l">
                            <a href="http://www.howzhi.com/tag/%E5%BB%B6%E6%97%B6%E6%91%84%E5%BD%B1">
                                <img src="./res/zhenjiang.jpg" alt="镇江">
                                <span class="label label-b label-md">镇江</span>
                            </a>
                        </li>
                        <li class="col-xs-5 item-l">
                            <a href="http://www.howzhi.com/tag/%E8%8B%B1%E8%AF%AD">
                                <img src="./res/wuxi.jpg" alt="无锡">
                                <span class="label label-b label-md">无锡</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <ul class="">
                        <li class="col-xs-7 item-l">
                            <a href="http://www.howzhi.com/tag/%E5%88%9B%E6%84%8F%E6%91%84%E5%BD%B1">
                                <img src="./res/maanshan.jpg" alt="马鞍山">
                                <span class="label label-b label-md">马鞍山</span>
                            </a>
                        </li>
                        <li class="col-xs-5 item-l">
                            <a href="http://www.howzhi.com/tag/PHP">
                                <img src="./res/wuhu.jpg" alt="芜湖">
                                <span class="label label-b label-md">芜湖</span>
                            </a>
                        </li>
                        <li class="col-xs-5 item-s">
                            <a href="http://www.howzhi.com/tag/%E9%9F%B3%E9%A2%91%E5%88%B6%E4%BD%9C">
                                <img src="./res/chuzhou.jpg" alt="滁州">
                                <span class="label label-b label-md">滁州</span>
                            </a>
                        </li>
                        <li class="col-xs-7 item-s">
                            <a href="http://www.howzhi.com/tag/Excel">
                                <img src="./res/huaian.jpg" alt="淮安">
                                <span class="label label-b label-md">淮安</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
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


<%--<!doctype "html">--%>
<%--<head>--%>

<%--<meta charset="utf-8">--%>

<%--</head>--%>

<%--<body >--%>

<%--<div id="container" style="width: 99%; height: 99%"></div>--%>

<%--<script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>--%>
<%--<script type="text/javascript" src="<%=basePath%>js/china.js"></script>--%>
<%--<script type="text/javascript" src="<%=basePath%>echarts/jquery.min.js"></script>--%>

<%--<script type="text/javascript">--%>


<%--var dom = document.getElementById("container");--%>
<%--var myChart = echarts.init(dom);--%>

<%--var geoCoordMap = getlocation ();--%>

<%--var city_Temper = getCityTemper() ;--%>

<%--function getCityTemper (){--%>
<%--var map= {} ;--%>
<%--$.ajax({--%>
<%--type : "get",--%>
<%--async : false, //同步执行--%>
<%--url : "getPageShow.action",--%>
<%--dataType : "json", //返回数据形式为json--%>
<%--success : function(result) {--%>
<%--if (result) --%>
<%--{--%>
<%----%>
<%--var i=0;--%>
<%--for(i=0;i<result.length;i++){--%>
<%----%>
<%----%>
<%--var temp_list = new Array();--%>
<%----%>
<%--var time = new Array();--%>
<%--var weather = new Array();--%>
<%--var temper = new Array();--%>
<%--var wind = new Array();--%>
<%----%>
<%--jQuery.each(result[i].time, function(i,item){     --%>
<%--time.push(item); --%>
<%--});--%>
<%--jQuery.each(result[i].weather, function(i,item){     --%>
<%--weather.push(item); --%>
<%--});--%>
<%--jQuery.each(result[i].temper, function(i,item){     --%>
<%--temper.push(item); --%>
<%--});--%>
<%--jQuery.each(result[i].wind, function(i,item){     --%>
<%--wind.push(item); --%>
<%--});--%>
<%----%>
<%--temp_list.push(time);--%>
<%--temp_list.push(weather);--%>
<%--temp_list.push(temper);--%>
<%--temp_list.push(wind);--%>
<%----%>
<%----%>
<%--//var temper_arr = new Array();--%>
<%----%>
<%----%>
<%--console.log(result[i].name);--%>
<%----%>
<%----%>
<%----%>
<%--//"海门":[121.15,31.89],--%>
<%----%>
<%--//--%>
<%--/*--%>
<%--time=result[i].time;--%>
<%--weather=result[i].weather;--%>
<%--temper=result[i].temper;--%>
<%--wind=result[i].wind;--%>
<%----%>
<%--temper_arr[0]=result[i].time;--%>
<%--temper_arr[1]=weather;--%>
<%--temper_arr[2]=temper;--%>
<%--temper_arr[3]=wind; --%>
<%--*/--%>
<%--map[result[i].name] = temp_list;--%>


<%--}--%>
<%----%>
<%--//alert(map);--%>
<%----%>
<%--};--%>

<%----%>
<%--},--%>
<%--error : function(errorMsg) {--%>
<%--alert(errorMsg.responseText);--%>
<%--alert(errorMsg );--%>
<%--alert("不好意思，大爷，图表请求数据失败啦!");--%>
<%--myChart.hideLoading();--%>
<%--}--%>
<%--});--%>
<%--return map;--%>
<%--}--%>


<%--var convertData = function (data) {--%>
<%----%>
<%--var res = [];--%>
<%--for (var i = 0; i < data.length; i++) {--%>
<%----%>
<%--var geoCoord = geoCoordMap[data[i].name];--%>
<%----%>
<%----%>
<%--if (geoCoord) {--%>

<%--res.push({--%>
<%--name: data[i].name,--%>
<%--value: geoCoord.concat(data[i].value)--%>
<%--});--%>
<%--}--%>
<%--}--%>
<%--return res;--%>
<%--};--%>


<%--function finddata (){--%>
<%--var arr=new Array();--%>
<%--$.ajax({--%>
<%--type : "get",--%>
<%--async : false, //同步执行--%>
<%--url : "getdata.action",--%>
<%--dataType : "json", //返回数据形式为json--%>
<%--success : function(result) {--%>
<%--if (result) {--%>
<%--var i=0;--%>
<%--for(i=0;i<result.length;i++){--%>
<%--var AQI_temp = new AQI_obj();--%>
<%--console.log(result[i].name);--%>
<%----%>
<%--AQI_temp.name=result[i].name;--%>
<%--AQI_temp.value=result[i].value;--%>
<%--arr[i]=AQI_temp;--%>
<%--}--%>
<%----%>
<%----%>
<%--//alert(arr);    --%>
<%--};--%>
<%----%>
<%--},--%>
<%--error : function(errorMsg) {--%>
<%--alert(errorMsg.responseText);--%>
<%--alert(errorMsg );--%>
<%--alert("不好意思，大爷，图表请求数据失败啦!");--%>
<%--myChart.hideLoading();--%>
<%--}--%>
<%--});--%>
<%--return arr;--%>
<%--}--%>
<%----%>
<%----%>


<%--function AQI_obj (){--%>
<%--var name;--%>
<%--var value;--%>
<%--};--%>


<%--function getlocation (){--%>
<%--var map= { } ;--%>
<%--$.ajax({--%>
<%--type : "get",--%>
<%--async : false, //同步执行--%>
<%--url : "getAQIlocation.action",--%>
<%--dataType : "json", //返回数据形式为json--%>
<%--success : function(result) {--%>
<%--if (result) --%>
<%--{--%>
<%----%>
<%--var i=0;--%>
<%--for(i=0;i<result.length;i++){--%>
<%----%>
<%--var city_temp = new Array();--%>
<%--console.log(result[i].name);--%>
<%--//[{name: "海门", value: 9},--%>
<%----%>
<%----%>
<%----%>
<%--city_temp[0]=result[i].longitude;--%>
<%--city_temp[1]=result[i].latitude;--%>
<%--map[result[i].name] = city_temp;--%>


<%--}--%>
<%----%>
<%--//alert(map);--%>
<%----%>
<%--};--%>

<%----%>
<%--},--%>
<%--error : function(errorMsg) {--%>
<%--alert(errorMsg.responseText);--%>
<%--alert(errorMsg );--%>
<%--alert("不好意思，大爷，图表请求数据失败啦!");--%>
<%--myChart.hideLoading();--%>
<%--}--%>
<%--});--%>
<%--return map;--%>
<%--}--%>


<%--option = {--%>
<%--backgroundColor: '#404a59',--%>
<%--title: {--%>
<%--text: '全国主要城市空气质量',--%>
<%--x:'center',--%>
<%--textStyle: {--%>
<%--color: '#fff'--%>
<%--}--%>
<%--},--%>
<%--tooltip: {--%>
<%--trigger: 'item',--%>
<%--formatter: function (params) {--%>
<%----%>
<%--var tt = city_Temper[params.name];--%>
<%----%>
<%----%>
<%--return params.name + '  AQI : ' + params.value[2] +--%>
<%--'<br/> '+ tt[0][0]+'日: ' + tt[1][0] +' ' + tt[2][0] +' '+ tt[3][0]+--%>
<%--'<br/> '+ tt[0][1]+'日: ' + tt[1][1] +' ' + tt[2][1] +' '+ tt[3][1]+--%>
<%--'<br/> '+ tt[0][2]+'日: ' + tt[1][2] +' ' + tt[2][2] +' '+ tt[3][2]+--%>
<%--'<br/> '+ tt[0][3]+'日: ' + tt[1][3] +' ' + tt[2][3] +' '+ tt[3][3]+--%>
<%--'<br/> '+ tt[0][4]+'日: ' + tt[1][4] +' ' + tt[2][4] +' '+ tt[3][4];--%>
<%--}--%>
<%--},--%>
<%--legend: {--%>
<%--orient: 'vertical',--%>
<%--y: 'bottom',--%>
<%--x:'right',--%>
<%--data:['AQI'],--%>
<%--textStyle: {--%>
<%--color: '#fff'--%>
<%--}--%>
<%--},--%>
<%--dataRange: {--%>
<%--min: 0,--%>
<%--max: 200,--%>
<%--calculable: true,--%>
<%--color: ['#d94e5d','#eac736','#50a3ba'],--%>
<%--textStyle: {--%>
<%--color: '#fff'--%>
<%--}--%>
<%--},--%>
<%--geo: {--%>
<%--map: 'china',--%>
<%--label: {--%>
<%--emphasis: {--%>
<%--show: false--%>
<%--}--%>
<%--},--%>
<%--roam: true,--%>
<%--itemStyle: {--%>
<%--normal: {--%>
<%--areaColor: '#323c48',--%>
<%--borderColor: '#111'--%>
<%--},--%>
<%--emphasis: {--%>
<%--areaColor: '#2a333d'--%>
<%--}--%>
<%--}--%>
<%--},--%>
<%--series: [--%>
<%--{--%>
<%--name: 'AQI',--%>
<%--type: 'scatter',--%>
<%--coordinateSystem: 'geo',--%>
<%--data: convertData(--%>
<%----%>
<%--finddata ()--%>
<%----%>
<%--),--%>
<%--symbolSize: 12,--%>
<%--label: {--%>
<%--normal: {--%>
<%--formatter: '{b}',--%>
<%--position: 'right',--%>
<%--show: false--%>
<%--},--%>
<%--emphasis: {--%>
<%--show: true--%>
<%--}--%>
<%--},--%>
<%--itemStyle: {--%>
<%--emphasis: {--%>
<%--borderColor: '#fff',--%>
<%--borderWidth: 1--%>
<%--}--%>
<%--}--%>
<%--}--%>
<%--]--%>
<%--};--%>

<%--myChart.setOption(option);--%>


<%--</script>--%>
<%--</body>--%>
<%--</html>--%>

