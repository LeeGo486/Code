<!--#include file="inc/function.asp"-->
<% 
dpthelp = request.Cookies("dpthelp")
depotid=trim(session("dm").System_depotid)
begdate = request("begdate")
enddate = request("enddate")
if begdate<>"" and enddate<>"" then
	filename = replace(begdate,"-","")&"-"&replace(enddate,"-","")
else
	md = Month(Now)
	if md<10 then md="0"&md
	dd = Day(Now)
	if dd<10 then dd="0"&dd
	today=Year(Now)&"-"&md&"-"&dd
	filename = dpthelp&""&replace(today,"-","")
	begdate = today
	enddate = today
end if
	'Response.ContentType="text/plain"
	'Response.AddHeader "Content-Disposition","filename="&server.URLEncode(filename)&".txt"
fileurl = "../../../file/retailtemp/"
Set fso = server.CreateObject("scripting.filesystemobject")
if fso.FolderExists(Server.MapPath(fileurl)) then  
	fso.DeleteFolder(Server.MapPath(fileurl))
end if
fso.createFolder(Server.MapPath(fileurl))
files = Server.MapPath(fileurl&filename&".txt")

'--����txt�ļ�  
set myfile = fso.CreateTextFile(files,true)  
Set rs = Server.CreateObject("ADODB.Recordset")  
sql = "retail_output_001 '"&depotid&"', '"&dpthelp&"', '"&begdate&"', '"&enddate&"'" 
rs.Open sql,cn,1,1  

if rs.EOF and rs.BOF then  
	response.Write "���ڣ�"&filename&"û����������!"
else
strLine=""
'--�����������д��txt  
Do while Not rs.EOF  
strLine=""  
for each x in rs.Fields  
strLine = strLine & x.value & chr(9)  
next
'--���������д��txt  
myfile.writeline strLine  
rs.MoveNext  
loop  
end if  
rs.Close  
set rs = nothing  
Response.Redirect(fileurl&filename&".txt")
set myfile = nothing
set fso = nothing
%>