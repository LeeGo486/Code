<%session("zkname")=trim(request("books"))%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
</head>

<body>
<!-- #include file="cn.asp" -->
<%dim dm,recode,repass,apsszt,rs,f18pass,sqlstr
  recode=SafeRequest(request("name"),0)
  repass=SafeRequest(request("pass"),0)
  passzt=SafeRequest(request("passzt"),0)
  
  '�ж���������
  set rs=server.CreateObject("adodb.recordset")
  rs.open "select isnull(f18pass,'') as f18pass from f18books where dbalia='"&session("zkname")&"'",cn1
  if passzt="" then passzt="0" end if
  if trim(rs("f18pass"))="" then f18pass="0" else f18pass=trim(rs("f18pass")) end if
  if f18pass<>passzt then
     response.write("<script language=JavaScript>alert('��¼ʧ�ܣ�ԭ��������£�\n\n1���������벻�ԡ�\n\n�뷵������¼�롣');history.go(-1);</script>")
     response.end
  end if
  rs.close
  set rs=nothing
  cn1.close
  set cn1=nothing
  
  '�ж��û������Ƿ���ȷ
  set rs=server.CreateObject("adodb.recordset")
  sqlstr="select username,isnull(usermain,0) as usermain,isnull(mb,'') as mb,"&_
         "isnull(dptype,0) as dptype,isnull(pexport,0) as pexport,isnull(pprint,0) as pprint,isnull(pchk,0) as pchk,"&_
		 "isnull(psure,0) as psure,isnull(padd,0) as padd,isnull(pedit,0) as pedit,isnull(pdel,0) as pdel,"&_
		 "isnull(punchk,0) as punchk,isnull(punsure,0) as punsure,isnull(pwr_cost,0) as pwr_cost,isnull(pwr_price,0) as pwr_price,"&_
         "isnull(pwr_sprice,0) as pwr_sprice,isnull(usertype,0) as usertype from j_user "&_
		 "where userid='"&recode&"' and password='"&repass&"' and isnull(notuse,0)=0"
  rs.open sqlstr,cn
  if rs.eof then
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('��¼ʧ�ܣ�ԭ��������£�\n\n1���޴��û������벻��ȷ��\n\n2�����û��ѱ�������\n\n�뷵�����µ�½����������������ϵ��˾����Ա��');history.go(-1);</script>")
     response.end
  end if
  
  if rs("mb")="" and rs("dptype")=4 then 
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('���û�Ϊ��֧�����û�����û��ָ����Ӧ�ķ�֧������\n\n����ϵ��˾����Ա����ָ����Ӧ�ķ�֧������');history.go(-1);</script>")
     response.end
  end if
%>
</body>
</html>
