<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'dojo.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		.lightBand{
			background-color: #EFEFEF;
		}
		.darkBand{
			background-color: #E0E0E0;
		}
		.formTitle{
			padding: 1em;
			font-size: larger;
			font-weight: bold;
		}
	
	</style>
	<script type="text/javascript" src="http://localhost:8080/DOJO/dojoroot/dojo/dojo.js" djConfig="parseOnLoad:true,isDebug:true"></script>

  </head>
  
  <body>
    <div>
    	<form>
    		<p>programer interview question</p>
    		<div class="questions">
    			<p>
    				<span>
    					<input type="radio" name="q1" value="yes"/>YES
    				</span>
    				<span>
    					<input type="radio" name="q1" value="no"/>NO
    				</span>
    				are you a C programmer?
    			</p>
    			
    			<p>
    				<span>
    					<input type="radio" name="q1-yes" value="yes"/>YES
    				</span>
    				<span>
    					<input type="radio" name="q1-yes" value="no"/>NO
    				</span>
    				<span>
    					<input type="radio" name="q1-yes" value="maybe"/>don't know
    				</span>
    				have you read kernighan and Ritchie?
    			</p>
    			
    			<p>
    				<span>
    					<input type="radio" name="q2" value="yes"/>男
    				</span>
    				<span>
    					<input type="radio" name="q2" value="no"/>女
    				</span>
    				你的性别？
    			</p>
    			
    			<p>
    				<span>
    					<input type="radio" name="q2" value="yes"/>是
    				</span>
    				<span>
    					<input type="radio" name="q2" value="no"/>否
    				</span>
    				是否会english?
    			</p>
    		</div>
    	
    	</form>
    
    </div>
    
    
  </body>
  <script type="text/javascript">
  	(function(){
		function layout1(){
			dojo.addClass(dojo.query("form > p")[0],"formTitle");//查找form表单子节点的第一个P标签
			dojo.query("div.questions p").forEach(function(node,i){ //返回所有问题节点(div class属性为questions 中的P标签)的Dojo NodeList,NodeList实现了forEach.
				dojo.addClass(node,(i%2)? "lightBand":"darkBand"); //设置了奇数行的class属性为lightBand,偶数行class属性为darkBand
			});  
		}
		dojo.addOnLoad(layout1);//执行初始化代码
  	 })();
	
  </script>
  
</html>
