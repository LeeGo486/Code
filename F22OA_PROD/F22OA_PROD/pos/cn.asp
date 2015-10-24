<!--#include file="inc/const.asp"-->
<%Dim CnStr,MM_cn_STRING,MM_cn_STRING1,MM_cn_STRING2,adCmdSPStoredProc,adParamReturnValue,adParaminput,adParamOutput,adInteger,adVarChar
Dim cn,cn1,cn2,st,et,connfile,filename,fso,conn_server,conn_name,conn_pass
Dim ServerIP,Uid,Pwd,dbstr

    strSourceFile = Server.MapPath("../web.config") 
    Set objXML =Server.CreateObject("Microsoft.XMLDOM") 
			 objXML.load(strSourceFile)  '把XML文件读入内存      
    Set webconn=objXML.documentElement.selectSingleNode("/configuration/connectionStrings/add[@name='webconn']")  '选取节点 Advertisement     
    Set f18master=objXML.documentElement.selectSingleNode("/configuration/connectionStrings/add[@name='f18master']")  '选取节点 Advertisement     
			dbstr=webconn.Attributes.item(1).text
			f18dbstr=f18master.Attributes.item(1).text
		Set f18master=nothing 
		Set webconn=nothing 
Set objXML =nothing
dim spdbstr1,spdbstr2,n
if dbstr = "" or f18dbstr="" then
	response.write("请正确配置web.config文件")
	response.End()
else
	'获取帐套连接
	readConnInfo(dbstr)
	MM_cn_STRING = "Driver={SQL Server};Server="&ServerIP&";Uid="&Uid&";Pwd="&Pwd&";dataBase="&session("dbname")
	
	set cn=server.CreateObject("adodb.connection")
	cn.open MM_cn_STRING
	if err then
		 response.write("数据库连接失败！")
		 response.end
	end if
	session("cn")=MM_cn_STRING
	response.Cookies("cn")=MM_cn_STRING
	session.TimeOut=600
	
	MM_cn_STRING2 ="Driver={SQL Server};Server="&ServerIP&";Uid="&Uid&";Pwd="&Pwd&";dataBase=f117picture"
	response.Cookies("cn2")=MM_cn_STRING2
	
	'获取f18master连接
	readConnInfo(f18dbstr)
	MM_cn_STRING1 ="Driver={SQL Server};Server="&ServerIP&";Uid="&Uid&";Pwd="&Pwd&";dataBase=f18master"
	set cn1=server.CreateObject("adodb.connection")
	cn1.open MM_cn_STRING1
	
	
	if err then
		 response.write("数据库连接失败！")
		 response.end
	end if
		
end if


'连接方式从web.config中读取，不用修改
'ServerIP=""
'Uid=""
'Pwd=""

adCmdSPStoredProc = 4 
adParamReturnValue = 4 
adParaminput = 1 
adParamOutput = 2 
adInteger = 3 
adVarChar = 200

function readConnInfo(str)
	spdbstr1 = split(str,";")
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
end function
%>
