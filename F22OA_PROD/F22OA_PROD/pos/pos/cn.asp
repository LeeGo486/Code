<!--#include file="inc/const.asp"-->
<%Dim CnStr,MM_cn_STRING,MM_cn_STRING1,adCmdSPStoredProc,adParamReturnValue,adParaminput,adParamOutput,adInteger,adVarChar
Dim cn,cn1,st,et,connfile,filename,fso,conn_server,conn_name,conn_pass
Dim ServerIP,Uid,Pwd

strSourceFile = Server.MapPath("../../web.config") 
    Set objXML =Server.CreateObject("Microsoft.XMLDOM")  '����һ��XML���� 
     objXML.load(strSourceFile)  '��XML�ļ������ڴ�      
    Set xml=objXML.documentElement.selectSingleNode("/configuration/connectionStrings/add[@name='webconn']")  'ѡȡ�ڵ� Advertisement     
    dbstr=xml.Attributes.item(1).text
 Set xml=nothing 
Set objXML =nothing
dim spdbstr1,spdbstr2,n
if dbstr = "" then
	response.write("����ȷ����web.config�ļ�")
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

'���ӷ�ʽ��web.config�ж�ȡ�������޸�
'ServerIP=""
'Uid=""
'Pwd=""

MM_cn_STRING ="Driver={SQL Server};Server="&ServerIP&";Uid="&Uid&";Pwd="&Pwd&";dataBase="&session("dbname")
set cn=server.CreateObject("adodb.connection")
cn.CommandTimeout =1200
cn.open MM_cn_STRING
if err then
   response.write("���ݿ�����ʧ�ܣ�")
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
   response.write("���ݿ�����ʧ�ܣ�")
   response.end
end if

adCmdSPStoredProc = 4 
adParamReturnValue = 4 
adParaminput = 1 
adParamOutput = 2 
adInteger = 3 
adVarChar = 200  




%>
