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

		<title>�����ʽ����</title>
		
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
  			$.messager.alert("��ʾ","����ɹ���");
  			return;
  		}else if(rs=='0'){
  			$.messager.alert("��ʾ","����ʧ�ܣ�");
  		}else if(rs=='-1'){
  			$.messager.alert("��ʾ","Excel����ʧ�ܣ�");
  		}
  	}
	</script>
	<body onload="initForm()">
		<input type="hidden" id="path" value="<%=path%>">
		<input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
		<center>
		
		<input type="button" value="��Ч" onclick="effect()">
		<input type="button" value="ʧЧ" onclick="loseEffect()">
		<br />
		<br />
		��ʽ�ų���
		<br />
		<s:form id="form1" action="/web/exclude-style!effectExcludeStyle" method="post" theme="simple">
			<s:hidden name="excludeStyle.guid"></s:hidden>
			
			<table>
				
				<tr>
					<td>
						��ʽ���ࣺ
					</td>
					<td>
						<s:textfield type="text" name="excludeStyle.styleType" cssStyle="width:400"></s:textfield>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						��
					</td>
					
				</tr>
				<tr>
					<td>
						��ʽ���ƣ�
					</td>
					<td>
						<s:textfield type="text" name="excludeStyle.styleName" cssStyle="width:400"></s:textfield>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						��
					</td>
					
				</tr>
				<tr>
					<td>
						��ʽ��ţ�
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
