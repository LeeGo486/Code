<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'dojo-query.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="http://localhost:8080/DOJO/dojoroot/dojo/dojo.js" djConfig="parseOnLoad:true,isDebug:true"></script>

  </head>
  
  <body>
    <div id="fixture">
    	<div class="sction1">
    		<h1>Section1</h1>
    		<p>introduction text</p>
    		<div class="sction1-1">
    			<h2>section1.1</h2>
    			<p>section1.1 ,paragraph-1</p>
    			<p class="special">
    				section1.1 ,paragraph-2(class=special)
    			</p>
    			<p myAttrib="special">
    				section1.1 ,paragraph-3(myAttrib="special")
    			</p>
    			<p myAttrib="special-1 special-2 special-3">
    				section1.1 ,paragraph-4( myAttrib="special-1 special-2 special-3")
    			</p>
    		</div>
    	</div>
    
    </div>
    
    <p> 页面底部加一个表格，用于收集css选择器字符串.
    	当提交这个表格时，dojo.query寻找选择器字符串描述的节点集合，并且在集合中的每个节点用红边框标出。</p>  
    	
    <div class="queryTester" style="background-color: #DDDDDD;padding: 5px;">
    	<form id="qform">
    		<input id="query" type="text" name="querySelector" size="40"/>
    		<input type="submit"/>
    	</form>
    
    </div>
    
    <script type="text/javascript">
    	dojo.addOnLoad(function(){
			dojo.connect(dojo.byId("qform"),"submit",function(e){
				dojo.stopEvent(e);
				dojo.query("*","fixture").style("border","");
				var query=dojo.byId("query").value;
				dojo.query(query,"fixture").style("border","2px solid red");
			});	
        });
    
    </script>
    
    
      
  </body>
</html>
