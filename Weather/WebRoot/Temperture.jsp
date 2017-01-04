<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<%--<!doctype html style="width: 100%; height: 100%">
<head>

<meta charset="utf-8">

</head>

<body style="width: 100%; height: 100%; margin: 0">--%>
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
<section class="hz-section">
    <%--<div class="container">--%>
    <div class="section-header">
        <h2>
            <span>全国城市温度概览</span>

            <div class="line"></div>
        </h2>
    </div>
    <div id="map_container" style="width: 100%; height: 90%"></div>
    <script type="text/javascript" src="<%=basePath%>js/echart-all-3.0.0.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/china.js"></script>
    <script type="text/javascript" src="<%=basePath%>echarts/jquery.min.js"></script>


    <script type="text/javascript">
        var dom = document.getElementById("map_container");
        var myChart = echarts.init(dom);

        var geoCoordMap = getlocation();
        function getlocation() {
            var map = {};
            $.ajax({
                type: "get",
                async: false, //同步执行
                url: "getAlllocation.action",
                dataType: "json", //返回数据形式为json
                success: function (result) {
                    if (result) {

                        var i = 0;
                        for (i = 0; i < result.length; i++) {

                            var city_temp = new Array();
                            console.log(result[i].name);

                            city_temp[0] = result[i].longitude;
                            city_temp[1] = result[i].latitude;
                            map[result[i].name] = city_temp;
                        }

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


        function finddata() {
            var arr = new Array();
            $.ajax({
                type: "get",
                async: false, //同步执行
                url: "getTemperdata.action",
                dataType: "json", //返回数据形式为json
                success: function (result) {
                    if (result) {
                        var i = 0;
                        for (i = 0; i < result.length; i++) {
                            var Temper = new Temp_obj();
                            console.log(result[i].name);

                            Temper.name = result[i].name;
                            Temper.value = result[i].value;
                            arr[i] = Temper;
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


        function Temp_obj() {
            var name;
            var value;
        }
        ;


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

                    return params.name + ' : ' + params.value[2];
                }
            },
            legend: {
                orient: 'vertical',
                y: 'bottom',
                x: 'right',

                data: ['温度'],

                textStyle: {
                    color: '#fff'
                }

            },

            dataRange: {
                min: -10,
                max: 40,
                calculable: true,
                color: ['#f16209', '#f5f71d', '#0844dd'],
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
                }
            ]
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
