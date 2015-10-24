<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.custanalysis.entity.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>异店查询</title>
    <link rel="stylesheet" href="./css/common.css" type="text/css"></link>
    <script type="text/javascript" src="./js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="./js/jquery.dataTables.min.js"></script>
  	<link rel="stylesheet" href="./dataTables/css/jquery.dataTables.css" type="text/css"></link>
    <script type="text/javascript">
    	var oTable;
    	var xmlHttp1;
    	var PARAMTER_VALUE = null;   
    	
    	$(document).ready(function(){
    		oTable = $("#listData").dataTable({
				"bFilter": false,
				"bSort": true,
				"bAutoWidth": true,
				"bLengthChange": false,
				"bInfo": false,
				"bProcessing": true,
				"bPaginate": false,
				"bScrollInfinite": true,
		        "sScrollX": "1000px",
		        "oLanguage": {
			      "sEmptyTable": "没有记录"
			    }
			});
			
			//getList("","","");
    	});
    	
    	function getParamter(paramName) {   
		    if(!PARAMTER_VALUE) {   //第一次初始化   
		        PARAMTER_VALUE = new Array();   
		        var paramStr = location.search.substring(1);   
		        var paramArr = paramStr.split("&");   
		        var len = paramArr.length;
		        var index;     
		        for(var i = 0; i < len; i++) { 
		        	index = paramArr[i].indexOf("=");  
		            PARAMTER_VALUE[paramArr[i].substring(0,index)] = paramArr[i].substring(index+1,paramArr[i].length);   
		        }   
		    }   
		    var paramValue = PARAMTER_VALUE[paramName];   
		    if(paramValue) {   
		        return paramValue;   
		    } else {
		    	return "";
		    }   
		}
		
		function createXMLHttpRequest() {
			if (window.ActiveXObject) {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} else if (window.XMLHttpRequest) {
				xmlHttp = new XMLHttpRequest();
			}
			return xmlHttp;
		}
		
		function getList(name,mobile,card) {			
			xmlHttp1 = createXMLHttpRequest();
			xmlHttp1.onreadystatechange = getListProcessor;
			xmlHttp1.open("GET","AjaxServlet?action=getList&userid="+getParamter("userid")+"&name="+encodeURI(name)+"&mobile="+mobile+"&card="+card+"&tm="+new Date().toString());
			xmlHttp1.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			xmlHttp1.send(null);
		}
		
		function getListProcessor() {
			var html = "";
			if (xmlHttp1.readyState == 4) {
				if (xmlHttp1.status == 200) {
					oTable.fnDestroy();
					var obj = eval('('+xmlHttp1.responseText+')');
					
					for (var i = 0;i < obj.List.length;i++) {
						html = html + "<tr>";
						html = html + "<td class='depot'>"+obj.List[i].DEPOT+"</td>";
						html = html + "<td class='name'>"+obj.List[i].ACCOUNTNAME+"</td>";
						html = html + "<td class='mobile'>"+obj.List[i].MOBILE+"</td>";
						html = html + "<td class='card'>"+obj.List[i].CARD+"</td>";
						html = html + "<td class='date'>"+obj.List[i].DATE+"</td>";
						html = html + "<td class='operate'><a href='./GetUser?"+obj.List[i].URL+"'>查看</a></td>";
						html = html + "</tr>";
					}
					$("#listData tbody").html(html);
					
					oTable = $("#listData").dataTable({
						"bFilter": false,
						"bSort": true,
						"bAutoWidth": true,
						"bLengthChange": false,
						"bInfo": false,
						"bProcessing": true,
						"bPaginate": false,
						"bScrollInfinite": true,
				        "sScrollX": "1000px",
				        "oLanguage": {
					      "sEmptyTable": "没有记录"
					    }
					});
				}
			}
		}
    </script>
  </head>
  <body>
    <div id="title">
    	<div id="sign">CRM Assistant</div>
    	<div id="titleName">异店查询</div>
    </div>
    <div id="search">
    	<div>姓名
    		<input type="text" id="name"/>
    	</div>
    	<div>手机
    		<input type="text" id="mobile" maxlength="11" style="ime-mode: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
    	</div>
    	<div>卡号
    		<input type="text" id="code"/>
    	</div>
    	<div>
    		<input type="button" id="sel" value="查询"/>
    	</div>
    </div>
    <table id="listData" cellpadding="0" cellspacing="0">
    	<thead>
    		<tr>
    			<th class="depot">店铺名称</th>
    			<th class="name">姓名</th>
    			<th class="mobile">手机</th>
    			<th class="card">卡号</th>
    			<th class="date">最近消费日期</th>
    			<th class="operate">操作</th>
    		</tr>
    	</thead>
    	<tbody>
    		
    	</tbody>
    </table>
    <script type="text/javascript">
    	$("#sel").click(function(){
    		if ($("#name").val() == "" && $("#mobile").val() == "" && $("#code").val() == "")
    			alert("必须输入一个条件");
    		else if ($("#name").val() != "" && $("#name").val().length < 2)
    			alert("姓名长度必须大于等于2位");
    		else if ($("#mobile").val() != "" && $("#mobile").val().length != 11)
    			alert("手机号码长度必须为11位");
    		else
    			getList($("#name").val(),$("#mobile").val(),$("#code").val());
    	});
    </script>
  </body>
</html>
