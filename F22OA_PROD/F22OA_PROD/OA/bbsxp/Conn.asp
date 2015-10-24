<%@ CodePage=936 Language="VBScript"%>
<!-- #include file="BBSXP_Class.asp" -->
<%
Response.Charset="gb2312"
Response.Buffer=True
IsSqlDataBase=1		'定义数据库类别，0为Access数据库，1为SQL数据库
If IsSqlDataBase=0 Then
'''''''''''''''''''''''''''''' Access数据库设置 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SqlDataBase	= "database/bbsxp2007.mdb"	'数据库路径
	SqlProvider	= "Microsoft.Jet.OLEDB.4.0"	'驱动程序[ Microsoft.Jet.OLEDB.4.0  Microsoft.ACE.OLEDB.12.0 ]
	Connstr="Provider="&SqlProvider&";Data Source="&Server.MapPath(SqlDataBase)
	SqlNowString="Now()"
	SqlChar="'"
	IsSqlVer="ACCESS"
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Else
'''''''''''''''''''''''''''''' SQL数据库设置 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SqlLocalName	="(local)"	'连接IP  [ 本地用 (local) 外地用IP ]
	SqlUserName	="sa"		'SQL用户名
	SqlPassword	="lenovo"		'SQL用户密码
	SqlDataBase	="bbsxp"	'数据库名
	SqlProvider	="SQLOLEDB"	'驱动程序 [ SQLOLEDB  SQLNCLI ]
	ConnStr="Provider="&SqlProvider&"; User ID="&SqlUserName&"; Password="&SqlPassword&"; Initial CataLog="&SqlDataBase&"; Data Source="&SqlLocalName&";"
	SqlNowString="GetDate()"
	IsSqlVer="MSSQL"
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
END IF
On Error Resume Next
Set Conn=Server.CreateObject("ADODB.Connection")
Conn.open ConnStr
If Err Then
	Response.Write ""&IsSqlVer&"数据库连接出错，请检查连接字串。<br><br>"&Err.Source&" ("&Err.Number&")"
	Set Conn = Nothing
	err.Clear
	Response.End
End If


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
ForumsBuild="7.3.070707"
ForumsProgram="BBSXP 2007 "&IsSqlVer&""

Set Rs=Execute("Select * from [BBSXP_SiteSettings]")
	CreateUserAgreement = Rs("CreateUserAgreement")
	GenericHeader = Rs("GenericHeader")
	GenericTop = Rs("GenericTop")
	GenericBottom = Rs("GenericBottom")
	AdminNotes = Rs("AdminNotes")
	BestOnline = Rs("BestOnline")
	BestOnlineTime = Rs("BestOnlineTime")
	SiteSettingsXML=Rs("SiteSettingsXML")
	BBSxpDataBaseVersion = Rs("BBSxpVersion")
Rs.Close
Set Rs=Nothing

if IsNumeric(RequestCookies("UserID")) then
	sql="Select * from [BBSXP_Users] where UserID="&RequestCookies("UserID")&""
	Set Rs=Execute(sql)
	if Rs.eof then
		CleanCookies()
	elseif RequestCookies("Userpass") <> Rs("Userpass") then
		CleanCookies()
	else
		CookieUserID=Rs("UserID")
		CookieUserName=Rs("UserName")
		CookieUserPass=Rs("UserPass")
		CookieUserEmail=Rs("UserEmail")
		CookieUserMoney=Rs("UserMoney")
		CookieNewMessage=Rs("NewMessage")
		CookieUserAccountStatus=Rs("UserAccountStatus")
		CookieUserRoleID=Rs("UserRoleID")
		CookieUserMate=Rs("UserMate")
		CookieUserRegisterTime=Rs("UserRegisterTime")
		CookieUserPostTime=Rs("UserPostTime")
		CookieModerationLevel=Rs("ModerationLevel")
		CookieReputation=Rs("Reputation")
		CookieTotalPosts=Rs("TotalPosts")
		if CookieUserRoleID=1 or CookieUserRoleID=2 then BestRole=1
	end if
	Rs.Close
	Set Rs=Nothing
end if

On Error GoTo 0


set AutoTerminate=new AutoTerminate_Class
Set Rs = Server.CreateObject("ADODB.Recordset")
Set XMLDOM=Server.CreateObject("Microsoft.XMLDOM")
Set SiteConfigXMLDOM=Server.CreateObject("Microsoft.XMLDOM")
SiteConfigXMLDOM.loadxml("<bbsxp>"&SiteSettingsXML&"</bbsxp>")

'''''''''''''''''''''''''''''''''''''''''''
Server.ScriptTimeout=SiteConfig("Timeout")	'设置脚本超时时间 单位:秒

REMOTE_ADDR=Server.HTMLEncode(Request.ServerVariables("REMOTE_ADDR"))
Script_Name=LCase(Request.ServerVariables("script_name"))
Server_Name=Request.ServerVariables("server_name")
Query_String=Request.ServerVariables("Query_String")
ReturnUrl=Request.ServerVariables("http_referer")

if RequestCookies("Themes")=empty then ResponseCookies "Themes",SiteConfig("DefaultSiteStyle"),"0"

dim SqlQueryNum,ForumsList,ForumTreeList,TotalPage,PageCount,RankName,RankIconUrl,IsResponseTop,MailSubject,MailBody
startime=timer()


%>