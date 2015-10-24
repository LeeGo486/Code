<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%String webContext = request.getContextPath(); %>
<html:html>

<head>
<title>店铺/顾客评价</title>
</head>
<script>
var pjlx = '0';//0为店铺评价，1为顾客评价
function initForm(){
	if(document.getElementById("ZT").value=='8'){
		document.getElementsByName("DPPJ")[0].disabled=false;
		document.getElementsByName("DPPJ")[1].disabled=false;
		document.getElementsByName("DPPJ")[2].disabled=false;
		document.getElementById("DPPJYJ").disabled=false;
		document.getElementById("button").disabled=false;
		document.getElementById("button").value="店铺收货及评价";
		pjlx = '0';
	}
	
	if(document.getElementById("ZT").value=='9'){
		document.getElementsByName("GKPJ")[0].disabled=false;
		document.getElementsByName("GKPJ")[1].disabled=false;
		document.getElementsByName("GKPJ")[2].disabled=false;
		document.getElementById("GKPJYJ").disabled=false;
		document.getElementById("button").disabled=false;
		document.getElementById("button").value="顾客评价";
		pjlx = '1';
	}
	
	if(document.getElementById("updateSuccessFlag").value=='1'){
		alert("评价成功");
		if(opener!= null){
			opener.document.forms[0].submit();
			window.close();
		}else{
			parent.window.document.forms[0].submit();
		}
	}

}

function do_submit(){
	if(pjlx=='0'){
		if(document.getElementsByName("DPPJ")[0].checked==false&&document.getElementsByName("DPPJ")[1].checked==false&&document.getElementsByName("DPPJ")[2].checked==false){
			alert('必须选择店铺评价！');
			return;
		}
	}
	
	if(pjlx=='1'){
		if(document.getElementsByName("GKPJ")[0].checked==false&&document.getElementsByName("GKPJ")[1].checked==false&&document.getElementsByName("GKPJ")[2].checked==false){
			alert('必须选择顾客评价！');
			return;
		}
	}
	
	document.forms[0].submit();
}
</script>

<body onload="initForm()">
<html:form action="/appraiseinfo" styleId="appraiseinfoForm" method="post">
	<html:hidden property="guid"/>
	<html:hidden property="ZT"/>
	<html:hidden property="dpbm"/>
	<html:hidden property="userID"/>
	<html:hidden property="method" value="updateAppraise"/>
	<html:hidden property="updateSuccessFlag"/>
	
	
	<div align="center" style="height:200px" id="shopAppraise" title="店铺评价">
		店铺评价：
		<html:radio property="DPPJ" value="0" disabled="true"><img alt="好评" src="<%=webContext %>/mypicture/good.JPG"/>  </html:radio>
		<html:radio property="DPPJ" value="1" disabled="true"><img alt="中评" src="<%=webContext %>/mypicture/commonly.JPG"/></html:radio>
		<html:radio property="DPPJ" value="2" disabled="true"><img alt="差评" src="<%=webContext %>/mypicture/bad.JPG"/></html:radio>
		<br />
		<html:textarea property="DPPJYJ" disabled="true" style="width:400px;height:100px"></html:textarea>
	</div><br />
	
	<div align="center" style="height:200px" title="顾客评价">
		顾客评价：
		<html:radio property="GKPJ" value="0" disabled="true"><img alt="好评" src="<%=webContext %>/mypicture/good.JPG"/></html:radio>
		<html:radio property="GKPJ" value="1" disabled="true"><img alt="中评" src="<%=webContext %>/mypicture/commonly.JPG"/></html:radio>
		<html:radio property="GKPJ" value="2" disabled="true"><img alt="差评" src="<%=webContext %>/mypicture/bad.JPG"/></html:radio>
		<br />
		<html:textarea property="GKPJYJ" disabled="true" style="width:400px;height:100px"></html:textarea>
	</div>
	<div align="center" >
		<html:button style="align:center" disabled="true" property="button" onclick="do_submit()" value="评价"></html:button>
	</div>
</html:form>


</body>

</html:html>