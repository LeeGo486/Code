<%option explicit
Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
</head>

<body>
<%dim cd,id,lx,pdrq
id=trim(request.querystring("id"))
lx=trim(request.querystring("lx"))
pdrq=trim(request.querystring("pdrq"))

  Set cn = server.CreateObject("ADODB.Connection")
  cn.ConnectionString = Session("cn")
  cn.Open
  Set cd = server.CreateObject("ADODB.Command")
  cd.ActiveConnection = cn
cd.Commandtype=4
cd.CommandText="sp_Crpdcy"
cd.Parameters.Append cd.CreateParameter("@lx",adInteger,adParamInput,2,lx)
cd.Parameters.Append cd.CreateParameter("@id",adVarchar,adParamInput,40,id)
cd.Parameters.Append cd.CreateParameter("@depotid",adVarchar,adParamInput,20,session("dm").System_Depotid)
cd.Parameters.Append cd.CreateParameter("@pdrq",adVarchar,adParamInput,12,pdrq)
cd.Execute

cd.CommandType = 1
'cd.Parameters.Clear
cd.CommandText = "update d_inventory set diff=1 where inventoryid="&qts(id)
cd.Execute

  cn.Close
  Set cd = Nothing
  Set cn = Nothing

%>
<table width="100%"  border="1">
  <tr>
    <td align="center"><p>�����̵����ɹ�!</p>
    <p><a href="create_pdcy.asp">�����ﷵ��</a></p></td>
  </tr>
</table>
</body>
</html>
