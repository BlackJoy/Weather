<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<script type="text/javascript">
     
    
       function myselect()
       {
           var s1=document.getElementById("select1");
           var select2=document.getElementById("select2");
           var number=select2.options.length;
           for(var j=select2.length-1;j>=0;j--){
              select2.removeChild(select2.childNodes.item(j));
           }
 
           var dopt = document.createElement("OPTION");
           dopt.text="请输入市";
           select2.add(dopt);       
 
 			if(s1.value=="def")
           {
               for(var j=select2.length-1;j>=0;j--){
              		select2.removeChild(select2.childNodes.item(j));
           		}        
 				var opt = document.createElement("OPTION");
               opt.text = "请选择";
               opt.value = "def";
               opt.selected=false;
              select2.add(opt);
           }
 			
           else if(s1.value=="ah")
           {
              var opt = document.createElement("OPTION");
               opt.text = "合肥";
               opt.value = "hf";
               opt.selected=false;
              select2.add(opt);
        
              var opt2 = document.createElement("OPTION");
               opt2.text = "宣城";
               opt2.value = "xc";
               opt2.selected=false;
              select2.add(opt2);            
 
           }else if(s1.value=="bj")
           {
              var opt3 = document.createElement("OPTION");
               opt3.text = "朝阳";
               opt3.value = "cy";
               opt3.selected=false;
              select2.add(opt3);
 
             var opt4 = document.createElement("OPTION");
               opt4.text = "西城";
               opt4.value = "xc";
               opt4.selected=false;
              select2.add(opt4);
           }
           //if(s1.value=="nj")
           else
           {
              var opt5 = document.createElement("OPTION");
               opt5.text = "总统府";
               opt5.value = "ztf";
               opt5.selected=false;
              select2.add(opt5);
 
              var opt6 = document.createElement("OPTION");
               opt6.text = "雨花石";
               opt6.value = "yhs";
               opt6.selected=false;
              select2.add(opt6);
           }
       }
    </script>
</head>
请选择省份：
<select id="select1" onChange="myselect()">
	<option value="def">请选择省份</option>
	<option value="ah">安徽</option>
	<option value="bj">北京</option>
	<option value="nj">南京</option>
</select>
请选择市名：
<select id="select2"><option value="0">请输入市</option>
</select>
</html>