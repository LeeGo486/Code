<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
response.Charset="utf-8"
response.CacheControl="no-cache"
SeID = request.Cookies("ASP.NET_SessionId")

if isnull(SeID) then
	dbname = request.Cookies("gj")("dbname")
	username = request.Cookies("gj")("username")
	userid = request.Cookies("gj")("userid")
		pchk=true
		punchk=true
		psure=true
		padd=true
		pedit=true
		pdel=true
else
	dbname= request.Cookies(SeID)("dbname")
	username = request.Cookies(SeID)("username")
	userid = request.Cookies(SeID)("userid")
end if

	strSourceFile = Server.MapPath("../web.config") 
    Set objXML =Server.CreateObject("Microsoft.XMLDOM") 
			 objXML.load(strSourceFile)  '把XML文件读入内存      
    Set webconn=objXML.documentElement.selectSingleNode("/configuration/connectionStrings/add[@name='webconn']")  '选取节点 Advertisement     
			dbstr=webconn.Attributes.item(1).text
		Set webconn=nothing 
	Set objXML =nothing

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

'ServerIP="(local)"
'Uid="sa"
'Pwd="lenovo"

connstr = "Driver={SQL Server};Server="&ServerIP&";Uid="&Uid&";Pwd="&Pwd&";dataBase="&dbname

set cn=server.CreateObject("adodb.connection")
cn.open connstr

if err then
   response.write("数据库连接失败！")
   response.end
end if

'新版OA使用菜单权限
if SeID<>"" then
	formid=2502008
end if

%>
<!--#include file="inc_function.asp"-->

