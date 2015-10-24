<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>退货发货界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		table{
			text-align: left;
			line-height: 25px;
			padding-left: 10px;
			font-size: 12px;
			border-bottom-color: #cecece;
			border-bottom-width: 1px;
			border-bottom-style: solid;
		}
	/*间隔行的颜色*/
		table.t1 {
			/**background-color:#add9c0;
			text-align: left;
			line-height: 25px;
			padding-left: 10px;
			font-size: 12px;
			border-bottom-color: #cecece;
			border-bottom-width: 1px;
			border-bottom-style: solid;**/
		}
		tr.a1{
		    background-color:white;
		}
		tr.a2{
			background-color:#F0FFF0;
		}
	
	</style>
	
	<SCRIPT type="text/javascript">
	
 	function check(){
 		var clothingid=document.getElementById("clothingid").value;
 	 	var nums=document.getElementById("nums").value;
 	  	if(clothingid=="")
 	 	{
 	 	  	alert("请输入条码!");
 	  	  	return false;
 	  	}
 	  	else if(nums=="")
 	 	{
 	 	  	alert("请输入数量!");
 	 	  	return false;
 	  	}
 	  	else if(nums <= 0  ||  nums!=parseInt(nums))
 	  	{
 	  	 	alert("请输入正整数!");
 	  	 	return false;
 	  	}
 	}
 	function sound1(){
		//alert();
  		var object = document.getElementById("sound1");   
  		object.play();
  		
  	}
  	function sound2(){
		//alert();
  		var object = document.getElementById("sound2");   
  		object.play();
  		
  	}
	</SCRIPT>

  </head>
  
  <body>
  	<p style="font-size: 13px;color: red;font-weight: bolder;">说明：请根据下列列表不同货权的货品分开集中装箱;扫描时不同货权的货品会发出不同的声音!
  	</p>
  	<table>
  		<tr>
  			<td width="250px">单据号：<s:property value="dOutindentSet.outindentid"/></td>
  			<td width="200px">收货地：<s:property value="jDepot.dname"/></td>
  			<td>制单日期：<s:property value="dOutindentSet.crdate"/></td>
  		</tr>	
  	</table>
  	
  	<table>
  		<tr>
		  	<s:form action="addColorid" id="form1" onsubmit="return check()">
		  	<input type="hidden" value="<s:property value="dOutindentSet.outindentid"/>" name="outindentid"/>	  	
		  			<td>
		  				<!--  条码<input type="text" width="100px" name="styleid" />-->
		  				条码<s:textfield name="id.clothingid" theme="simple" id="clothingid"></s:textfield>
		  			</td>
		  			<td>
		  				<s:radio name="radio" list="%{#{1:'正',0:'负'}}" theme="simple"></s:radio>
		  			</td>
		  			<td>
		  				<!--  数量<input type="text" style="width: 50px;" name="nums"/>-->
		  				数量<s:textfield name="nums" theme="simple" id="nums" cssStyle="width:40px"></s:textfield>
		  			</td>
		  			<td> <input type="submit" value="确定" /> </td>
		  			
		  			<td> <input type="button" value="返回查询页面" onclick="javascript:window.open('http://192.168.2.221:88/pos/pos/f22/search_frame.asp?action=search','_self','')" /> </td>	  		
		  	</s:form>
  		</tr>
  	</table>
  	
  	<table style="color: red;"><tr><td><s:fielderror></s:fielderror></td></tr></table>

  	<table id="TableNew"  class="t1" width="100%" border="1" style="line-height: 15px" bordercolordark="#FFEFEF">
  	<thead>
  		<tr align="center">
  			<td>序号</td><td>货权</td><td>款 号</td><td>款式名称</td><td>颜 色</td><td>尺 码</td><td>数 量</td><td>单 价</td><td>总额</td>
  		</tr>
  		<s:iterator id="dOutindentSetsub" value="dOutindentSetsub" status="list">   	
  		<tr class="EvenOrOddRow"   onclick="changeActiveRow(this);" >
  			<td><s:property value="#list.count" /></td>
  			<s:if test="%{#dOutindentSetsub.rights=='EP'}">
  			<td style="color: red">
  				<s:property value="rights"/>
  			</td>
  			</s:if>
  			<s:else>
  			<td style="color: blue;">
  				<s:property value="rights"/>
  			</td>
  			</s:else>
  			<td><s:property value="id.clothingid"/></td>
  			<td><s:property value="styleid"/></td>
  			<td><s:property value="colorid"/></td>
  			<td><s:property value="sizeid"/></td>
  			<s:if test="%{#dOutindentSetsub.nums<=0}">
  			<td id="td1"  style="color: red">
  			  	<s:property value="nums"/>
  			</td>
  			</s:if>
  			<s:else>
  			<td id="td1">
  			    <s:property value="nums"/>
  			</td>
  			</s:else>
  			<td id="td2"><s:property value="XPrice"/></td>
  			<td id="sum"><s:property value="nums*XPrice"/> </td>	
  		</tr>  		
  		</s:iterator>
  		<tr>
  			<td>合计</td><td></td><td></td><td></td><td></td><td></td>
  			<td id="tottd1" name="tottd1"> </td>
  			<td id="tottd2" name="tottd2"> </td>
  			<td id="totsum" name="totsum"> </td>
  		</tr>
	</thead>
	
  	</table>
  	
  	<br><br><br><br>
  	
 
    
    
  </body>
 
	<script type="text/javascript" language="javascript">
	document.getElementById("clothingid").value = '';
	
	var list = document.getElementsByName("td1");
	var list2 = document.getElementsByName("td2");
	var list3 = document.getElementsByName("sum");
	var sum=0;
	var sum2=0;
	var sum3=0;
	for(var i=0;i<list.length;i++){
		var sum = sum + parseFloat(list[i].innerHTML);
		var sum2 = sum2 + parseFloat(list2[i].innerHTML);
		var sum3 = sum3 + parseFloat(list3[i].innerHTML);
		
	}
	tottd1.innerText = sum;
	tottd2.innerText = sum2;
	totsum.innerText = sum3;
	
	//document.getElementsByName('radio')[0].checked=true;//默认选中正
	//单机改变table颜色
	var currentActiveRow; 
 	function changeActiveRow(obj){  
	 	if(currentActiveRow)   
			currentActiveRow.style.backgroundColor="";   
			currentActiveRow=obj; 
		 	currentActiveRow.style.backgroundColor="#cecece"; 
	 }
	 //table 颜色间隔行
    for (i=1;i<TableNew.rows.length;i++) 
    {
　　    //(i%2==0)?(TableNew.rows(i).className = "a1"):(TableNew.rows(i).className = "");与下边方法相同
        if(i%2==0)
        {
            TableNew.rows(i).className = "a1";
        }
        else
        {
            TableNew.rows(i).className = "a2";
        }
　　}

    var i = "<%= request.getAttribute("sound") %>";
    if(i=="EP"){
    	var musicfile='wav/scan.wav'; 
    	embed='<embed width="0" height="0" loop="false" autostart=1 name="EmbedName" hidden="false" src="';
    	embed +=musicfile; 
    	embed +='"></embed>'; 
    	document.write(embed);
	}
	else if(i=="OTHERS"){
		var musicfile='wav/ding.wav'; 
    	embed='<embed width="0" height="0" loop="false" autostart=1 name="EmbedName" hidden="false" src="';
    	embed +=musicfile; 
    	embed +='"></embed>'; 
    	document.write(embed);
	}

    </script>
</html>
