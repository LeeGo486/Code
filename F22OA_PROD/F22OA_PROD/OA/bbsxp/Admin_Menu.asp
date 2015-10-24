<!-- #include file="Setup.asp" -->
<%
AdminTop
if RequestCookies("Userpass")="" or RequestCookies("Userpass")<>session("pass") then response.redirect "Admin_Default.asp"
Log("")
MenuID=RequestInt("MenuID")
ParentID=RequestInt("ParentID")
Name=HTMLEncode(Request("Name"))
Url=HTMLEncode(Request("Url"))

XmlFilePath=Server.MapPath("Utility/Menu.xml")
XMLDOM.load(XmlFilePath)
Set XMLRoot = XMLDOM.documentElement

select case Request("menu")
	case ""
		Show
	case "add"
		add
	case "addok"
		If ParentID>=0 Then
			Set TempNode = XMLDOM.createNode("element","Menu","")
			TempNode.text = Name
			XMLRoot.childNodes(ParentID).appendChild(TempNode)
		Else
			Set TempNode = XMLDOM.createNode("element","Category","")
			AppendNewAttribute "Name",Name
			XMLRoot.appendChild(TempNode)
		End If
		AppendNewAttribute "Url",Url
		
		XMLDOM.save(XmlFilePath)
		Set TempNode = nothing
		Show
	case "edit"
		edit
	case "editok"
		editok
	case "Del"
		Set ParentNode=XMLRoot.childNodes(ParentID)
		If MenuID>=0 Then
			ParentNode.removeChild ParentNode.childNodes(MenuID)
		Else
			XMLRoot.removeChild ParentNode
		End If
		XMLDOM.save(XmlFilePath)
		Set ParentNode=nothing
		Show
end select

Function AppendNewAttribute(attributeName,attributeValue)
	Set NewAttribute=XMLDOM.CreateNode("attribute",attributeName,"")
	NewAttribute.Text=attributeValue
	TempNode.SetAttributeNode NewAttribute
End Function

Sub Show
%>
��̳�˵�����<br>
<form method="POST" action="?menu=addok" name=form>
<input type=hidden name=ParentID value=-1>
<input type=hidden name=url value="#">
�˵����ƣ������磺��̳�����<input name="name"> <input type="submit" value="���"></form>
<table cellspacing=1 cellpadding=5 width=70% border=0 id=CommonListArea align=center>
	<%Adminmenu(0)%>
</table>
<br>
<%
End Sub

Sub add
%>
<form method="POST" action="?menu=addok" name=form>
<table cellspacing="1" cellpadding="5" width="60%" border="0" id=CommonListArea align="center">
	<tr id=CommonListTitle>
		<td align="center" colspan="4">��Ӳ˵�</td>
	</tr>
	<tr id=CommonListCell>
		<td align="right" width="10%">���⣺</td>
		<td width="40%"><input name="name"></td>
		<td align="right" width="10%">���ࣺ</td>
		<td width="40%">
		<select name="ParentID">
			<option value="-1">һ���˵�</option>
<%
	For NodeIndex=0 To XMLRoot.childNodes.length-1
		Set childNode=XMLRoot.childNodes(NodeIndex)
%>
			<option value="<%=NodeIndex%>" <%if ParentID=NodeIndex then%>selected<%end if%>><%=childNode.getAttribute("Name")%></option>
<%
	Next
	Set childNode=nothing
%>
		</select>
		</td>
	</tr>
	<tr id=CommonListCell>
		<td align="right" width="10%">���ӣ�</td>
		<td width="90%" colspan="3"><input name="url" size="50"></td>
	</tr>
	<tr id=CommonListCell>
		<td align="center" width="100%" colspan="4"> 
			<input type="submit" value=" �� �� "> <input type="reset" value=" �� �� ">
		</td>
	</tr>
</table>
<%
End Sub

Sub editok
	If MenuID=Request("ParentID") Then Alert("���ô���")
	
	If ParentID<0 Then
		Set EditNode=XMLRoot.childNodes(MenuID)
		EditNode.setAttribute "Name",Name
	ElseIf ParentID>=0 Then
		Set ParentNode=XMLRoot.childNodes(ParentID)
		Set EditNode=ParentNode.childNodes(MenuID)
		EditNode.text=Name
	End If
	EditNode.setAttribute "Url",Url
	XMLDOM.save(XmlFilePath)
	Set EditNode=nothing
	Show
End Sub

Sub edit
	If ParentID<0 Then
		Set EditNode=XMLRoot.childNodes(MenuID)
		MenuName=EditNode.getAttribute("Name")
	ElseIf ParentID>=0 Then
		Set ParentNode=XMLRoot.childNodes(ParentID)
		Set EditNode=ParentNode.childNodes(MenuID)
		MenuName=EditNode.text
	End If
%>
<form method="POST" action="?menu=editok" name=form>
<input type=hidden name=MenuID value=<%=MenuID%>>
<table cellspacing="1" cellpadding="5" width="60%" border="0" id=CommonListArea align="center">
	<tr id=CommonListTitle>
		<td align="center" colspan="4">�༭�˵�</td>
	</tr>
	<tr id=CommonListCell>
		<td align="right" width="10%">���⣺</td>
		<td width="40%"><input name="name" value="<%=MenuName%>"></td>
		<td align="right" width="10%">���ࣺ</td>
		<td width="40%">
		<select name="ParentID">
			<option value="-1">һ���˵�</option>
<%
	For NodeIndex=0 To XMLRoot.childNodes.length-1
		Set childNode=XMLRoot.childNodes(NodeIndex)
%>
			<option value="<%=NodeIndex%>" <%if ParentID=NodeIndex then%>selected<%end if%>><%=childNode.getAttribute("Name")%></option>
<%
	Next
	Set childNode=nothing
%>
		</select>
		</td>
	</tr>
	<tr id=CommonListCell>
		<td align="right" width="10%">���ӣ�</td>
		<td colspan="3">
		<input name="url" value="<%=EditNode.getAttribute("Url")%>" size="50"></td>
	</tr>
	<tr id=CommonListCell>
		<td align="center" width="100%" colspan="4"> 
		<input type="submit" value=" �� �� ">
		<input type="reset" value=" �� �� "></td>
	</tr>
</table>
<%
	Set EditNode=nothing
End Sub

Sub Adminmenu(selec)
	For NodeIndex=0 To XMLRoot.childNodes.length-1
		Set ParentNode=XMLRoot.childNodes(NodeIndex)
%>
	<tr id=CommonListTitle>
		<td align=center><%=ParentNode.getAttribute("Name")%></td>
		<td align=right width=150>
			<a href="?menu=add&ParentID=<%=NodeIndex%>">���</a> | 
			<a href="?menu=edit&ParentID=-1&MenuID=<%=NodeIndex%>">�༭</a> | 
			<a href="?menu=Del&ParentID=<%=NodeIndex%>&MenuID=-1">ɾ��</a>
		</td>
	</tr>
<%
		For j=0 To ParentNode.childNodes.length-1
			Set childNode=ParentNode.childNodes(j)
%>
	<tr id=CommonListCell>
		<td><%=childNode.text%>��<a href=<%=childNode.getAttribute("Url")%> target=_blank><%=childNode.getAttribute("Url")%></a>��</td>
		<td align=right>
			<a href=?menu=edit&ParentID=<%=NodeIndex%>&MenuID=<%=j%>>�༭</a> | 
			<a href=?menu=Del&ParentID=<%=NodeIndex%>&MenuID=<%=j%>>ɾ��</a>
		</td>
	</tr>
<%
		Next
		Set childNode=nothing
	Next
	Set ParentNode=nothing
End Sub

Set XMLRoot=nothing
Set XMLDOM=nothing
AdminFooter
%>