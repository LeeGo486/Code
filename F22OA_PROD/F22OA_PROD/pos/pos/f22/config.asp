<%
dim cf
set cf=server.CreateObject("adodb.recordset")
cf.open "select setid,settype,value1,value2,value3,value4 from sys_possetup ",cn,1,1
	do while not cf.eof
		select case cf("settype")
		case 1
			session("cf_"&cf("setid"))=cf("value1")
		case 2
			session("cf_"&cf("setid"))=cf("value2")
		case 3
			session("cf_"&cf("setid"))=cf("value3")
		case 4
			session("cf_"&cf("setid"))=cf("value4")
		end select
	cf.movenext
	loop
cf.close
set cf=nothing
%>
