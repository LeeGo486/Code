<%@ CodePage="936" Language="VBScript"%>
<!-- #include file="Class.asp" -->
<%
Response.Charset="gb2312"
Response.Buffer=True

'���ݿ�����ȡ��web.config
Set objXML =Server.CreateObject("Microsoft.XMLDOM") 
	objXML.load(Server.MapPath("../../web.Config") )  '��XML�ļ������ڴ�      
	dbstr=objXML.documentElement.selectSingleNode("/configuration/connectionStrings/add[@name='mdburl']").Attributes.item(1).text
Set objXML =nothing

dim spdbstr1,spdbstr2,n
	'��ȡ��������
	spdbstr1 = split(dbstr,";")
	for n = 0 to ubound(spdbstr1)
		spdbstr2 = split(spdbstr1(n),"=")
		if lcase(spdbstr2(0))="data source" then
			ServerIP=spdbstr2(1)
		elseif lcase(spdbstr2(0))="uid" then
			Uid=spdbstr2(1)
		elseif lcase(spdbstr2(0))="pwd" then
			Pwd=spdbstr2(1)
		end if
	next
	ConnStr="Provider=SQLOLEDB; User ID="&Uid&"; Password="&Pwd&"; Initial CataLog=voa; Data Source="&ServerIP&";"
	SqlNowString="GetDate()"
	IsSqlVer="MSSQL"

On Error Resume Next
Set Conn=Server.CreateObject("ADODB.Connection")
Conn.open ConnStr
If Err Then
	Response.Write ""&IsSqlVer&"���ݿ����ӳ������������ִ���<br><br>"&Err.Source&" ("&Err.Number&")"
	Set Conn = Nothing
	err.Clear
	Response.End
End If

On Error GoTo 0

Sub CloseConn
   Conn.close
   Set Conn=Nothing
End Sub

'�õ�asp.net���û�cookies
SessID=Request.Cookies("ASP.NET_SessionId")
response.Cookies("UserID")=Request.Cookies(SessID)("userid")
set rs=server.createobject("adodb.recordset")
rs.open "select username from j_user where userid='"&trim(request.Cookies("UserID"))&"'",conn,1,1
if not rs.eof then
   response.Cookies("UserName")=rs("username")
else
   response.Cookies("UserName")=""
end if
rs.close
set rs=nothing
%>