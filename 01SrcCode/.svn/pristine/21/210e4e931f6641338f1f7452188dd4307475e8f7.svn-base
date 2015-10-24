<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>确认登帐</title>
    <base target ="_self" />
<style type="text/css">
 .raised{background:transparent;width:100%;margin-left: 3px;margin-top: 3px;}
 .raised h1,.raised p{margin:0 10px;}
 .raised h1{font-size:2em;color:#f0f8ff;}
 .raised p{padding-bottom:0.5em;}
 .raised .b1,.raised .b2,.raised .b3,.raised .b4,.raised .b1b,.raised .b2b,.raised .b3b,.raised .b4b{display:block;overflow:hidden;font-size:1px;}
 .raised .b1,.raised .b2,.raised .b3,.raised .b1b,.raised .b2b,.raised .b3b{height:1px;}
 .raised .b2{background:#f0f8ff;border-left:1px solid #fff;border-right:1px solid #eee;}
 .raised .b3{background:#f0f8ff;border-left:1px solid #fff;border-right:1px solid #ddd;}
 .raised .b4{background:#f0f8ff;border-left:1px solid #fff;border-right:1px solid #aaa;}
 .raised .b4b{background:#f0f8ff;border-left:1px solid #eee;border-right:1px solid #999;}
 .raised .b3b{background:#f0f8ff;border-left:1px solid #ddd;border-right:1px solid #999;}
 .raised .b2b{background:#f0f8ff;border-left:1px solid #aaa;border-right:1px solid #999;}
 .raised .b1{margin:0 5px;background:#fff;}
 .raised .b2, .raised .b2b{margin:0 3px;border-width:0 2px;}
 .raised .b3, .raised .b3b{margin:0 2px;}
 .raised .b4, .raised .b4b{height:2px; margin:0 1px;}
 .raised .b1b{margin:0 5px; background:#999;}
 .raised .boxcontent{display:block;background:#f0f8ff;border-left:1px solid #fff;border-right:1px solid #999;height: 40px;text-align: center;}
 
 table{background-color: #f0f8ff;width: 100%;border: 1px solid #ccc;}
 td{font-size: 12px;}
 </style>
 <sx:head extraLocales="en_us"/>
 <script type="text/javascript">
 function submit1(){
	// alert();
	 document.form.submit(); 
	 //window.close();
	 
 }

 </script>
  </head>
  
  <body>

  <div class="raised">
 <b class="b1"></b><b class="b2"></b><b class="b3"></b><b class="b4"></b>
 <div class="boxcontent">
 <font style="font-size: 13px">确认&nbsp;登帐&nbsp;日期：</font>
 </div>
 <b class="b4b"></b><b class="b3b"></b><b class="b2b"></b><b class="b1b"></b>
 </div>
    <s:form action="crmMethod" id="form">
    <s:hidden value="" name="outindentid" id="outindentid"></s:hidden>
    <s:hidden value="" name="surename" id="surename"></s:hidden>
    	<table >
    		<tr><td>登帐后的单据不可修改和删除!</td></tr>
    		<tr>
    			<td>单据生效以登帐日期为准!</td>
    		</tr>
    		<tr>
    			<td>登帐日期： <sx:datetimepicker name="suredate" toggleType="explode" value="%{'today'}" language="en_us"/>  </td>
    		</tr>
    		<tr> 	
    				<td>真的要登帐吗?</td>
    		</tr>
    	</table>
    	<div style="width: 100%;background-color:#f0f8ff;margin-top: 3px;border: 1px solid #ccc; text-align: center;">
    		<input type="button" value="确认" onclick="submit1();"/>
    		<input type="button" value="取消" onclick="window.close();"/>
    	</div>
    	<div style="color: red; font-weight: bolder;font-size: 12px;">
    		注：单据登帐后,按货权自动拆分一张或者两张单据!
    	
    	</div>
    </s:form>
    
  </body>
 	<SCRIPT type="text/javascript">
 	var outindentid='<%= request.getParameter("outindentid") %>';
 	var surename='<%= request.getParameter("userid") %>';
 	var error='<%= request.getAttribute("error") %>';
 	document.getElementById("outindentid").value=outindentid;
 	document.getElementById("surename").value=surename;
 	//alert(document.getElementById("outindentid").value);
 	if(error!='' && error!='null'){
 		alert(error);
 		window.close();
 	}
 	
 	
 	</SCRIPT>
  
</html>
