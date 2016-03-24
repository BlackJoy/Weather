<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!doctype html style="width: 100%; height: 100%">
<head>
	<meta charset="utf-8">
</head>
<body style="width: 100%; height: 100%; margin: 0">

<div id="container" style="width: 100%; height: 100%"></div>
<script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>

<script type="text/javascript">

var dom = document.getElementById("container");
var myChart = echarts.init(dom);

//var myChart = echarts.init(document.getElementById('main'));

/*
function fetchData(cb) {
    // 通过 setTimeout 模拟异步加载
    setTimeout(function () {
        cb({
            categories: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"],
            data: [5, 20, 36, 10, 10, 20]
        });
    }, 1000);
}

// 初始 option
option = {
    title: {
        text: '异步数据加载示例'
    },
    tooltip: {},
    legend: {
        data:['销量']
    },
    xAxis: {
        data: []
    },
    yAxis: {},
    series: [{
        name: '销量',
        type: 'bar',
        data: []
    }]
};

fetchData(function (data) {
    myChart.setOption({
        xAxis: {
            data: data.categories
        },
        series: [{
            // 根据名字对应到相应的系列
            name: '销量',
            data: data.data
        }]
    });
});
myChart.setOption(option, true);
*/

/* 
 
//loading动画效果

function fetchData(cb) {
    // 通过 setTimeout 模拟异步加载
    setTimeout(function () {
        cb({
            categories: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"],
            data: [5, 20, 36, 10, 10, 20]
        });
    }, 3000);
}

// 初始 option
option = {
    title: {
        text: '异步数据加载示例'
    },
    tooltip: {},
    legend: {
        data:['销量']
    },
    xAxis: {
        data: []
    },
    yAxis: {},
    series: [{
        name: '销量',
        type: 'bar',
        data: []
    }]
};

myChart.showLoading();

fetchData(function (data) {
    myChart.hideLoading();
    myChart.setOption({
        xAxis: {
            data: data.categories
        },
        series: [{
            // 根据名字对应到相应的系列
            name: '销量',
            data: data.data
        }]
    });
});
myChart.setOption(option);
*/




</script>
</body>
</html>