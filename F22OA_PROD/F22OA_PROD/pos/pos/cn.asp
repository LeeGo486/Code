<!--#include file="inc/const.asp"-->
<%Dim CnStr,MM_cn_STRING,MM_cn_STRING1,adCmdSPStoredProc,adParamReturnValue,adParaminput,adParamOutput,adInteger,adVarChar
Dim cn,cn1,st,et,connfile,filename,fso,conn_server,conn_name,conn_pass
Dim ServerIP,Uid,Pwd

strSourceFile = Server.MapPath("../../web.config") 
    Set objXML =Server.CreateObject("Microsoft.XMLDOM")  '创建一个XML对像 
     objXML.load(strSourceFile)  '把XML文件读入内存      
    Set xml=objXML.documentElement.selectSingleNode("/configuration/connectionStrings/add[@name='webconn']")  '选取节点 Advertisement     
    dbstr=xml.Attributes.item(1).text
 Set xml=nothing 
Set objXML =nothing
dim spdbstr1,spdbstr2,n
if dbstr = "" then
	response.write("请正确配置web.config文件")
	response.End()
else
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
end if

'连接方式从web.config中读取，不用修改
'ServerIP=""
'Uid=""
'Pwd=""

MM_cn_STRING ="Driver={SQL Server};Server="&ServerIP&";Uid="&Uid&";Pwd="&Pwd&";dataBase="&session("dbname")
set cn=server.CreateObject("adodb.connection")
cn.CommandTimeout =1200
cn.open MM_cn_STRING
if err then
   response.write("数据库连接失败！")
   response.end
end if

set session("cn")=cn
session.TimeOut=600

MM_cn_STRING ="Driver={SQL Server};Server="&ServerIP&";Uid="&Uid&";Pwd="&Pwd&";dataBase=f117picture"
session("cnp")=cn1

MM_cn_STRING1 ="Driver={SQL Server};Server="&ServerIP&";Uid="&Uid&";Pwd="&Pwd&";dataBase=f18master"
set cn1=server.CreateObject("adodb.connection")
cn1.open MM_cn_STRING1
if err then
   response.write("数据库连接失败！")
   response.end
end if

adCmdSPStoredProc = 4 
adParamReturnValue = 4 
adParaminput = 1 
adParamOutput = 2 
adInteger = 3 
adVarChar = 200  




%>
