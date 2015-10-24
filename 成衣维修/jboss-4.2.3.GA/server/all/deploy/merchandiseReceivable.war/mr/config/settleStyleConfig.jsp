<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>结算款式配置</title>
		
		<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/demo/demo.css">
		<script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>
		<script type="text/javascript" src="<%=path %>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" src="<%=path %>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
  		<script src="<%=path%>/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>


	</head>
	<script type="text/javascript">
	function effect(){
		document.forms[0].submit();
	}
	function loseEffect(){
		$("#form1").attr("action",$('#path').attr('value')+ "/web/exclude-style!loseEffectExcludeStyle");
		document.forms[0].submit();
	}
	
	function initForm(){
  		var rs = $('#result').attr('value');
  		//alert(rs);
  		if(rs=='1'){
  			$.messager.alert("提示","保存成功！");
  			return;
  		}else if(rs=='0'){
  			$.messager.alert("提示","保存失败！");
  		}else if(rs=='-1'){
  			$.messager.alert("提示","Excel解析失败！");
  		}
  	}
	</script>
	<body onload="initForm()">
		<input type="hidden" id="path" value="<%=path%>">
		<input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
		<center>
		
		<input type="button" value="生效" onclick="effect()">
		<input type="button" value="失效" onclick="loseEffect()">
		<br />
		<br />
		款式排除表
		<br />
		<s:form id="form1" action="/web/exclude-style!effectExcludeStyle" method="post" theme="simple">
			<s:hidden name="excludeStyle.guid"></s:hidden>
			
			<table>
				
				<tr>
					<td>
						款式种类：
					</td>
					<td>
						<s:textfield type="text" name="excludeStyle.styleType" cssStyle="width:400"></s:textfield>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						或
					</td>
					
				</tr>
				<tr>
					<td>
						款式名称：
					</td>
					<td>
						<s:textfield type="text" name="excludeStyle.styleName" cssStyle="width:400"></s:textfield>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						或
					</td>
					
				</tr>
				<tr>
					<td>
						款式编号：
					</td>
					<td>
						<s:textfield type="text" name="excludeStyle.styleNo" cssStyle="width:400"></s:textfield>
					</td>
				</tr>
			</table>


		</s:form>
		
		</center>
	</body>
</html>
