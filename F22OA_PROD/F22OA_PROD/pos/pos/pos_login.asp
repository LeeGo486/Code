<%session("zkname")=trim(request("books"))%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
</head>

<body>
<!-- #include file="cn.asp" -->
<%dim dm,recode,repass,apsszt,rs,f18pass,sqlstr
  recode=SafeRequest(request("name"),0)
  repass=SafeRequest(request("pass"),0)
  passzt=SafeRequest(request("passzt"),0)
  
  '判断帐套密码
  set rs=server.CreateObject("adodb.recordset")
  rs.open "select isnull(f18pass,'') as f18pass from f18books where dbalia='"&session("zkname")&"'",cn1
  if passzt="" then passzt="0" end if
  if trim(rs("f18pass"))="" then f18pass="0" else f18pass=trim(rs("f18pass")) end if
  if f18pass<>passzt then
     response.write("<script language=JavaScript>alert('登录失败，原因可能如下：\n\n1、帐套密码不对。\n\n请返回重新录入。');history.go(-1);</script>")
     response.end
  end if
  rs.close
  set rs=nothing
  cn1.close
  set cn1=nothing
  
  '判断用户密码是否正确
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
     response.write("<script language=JavaScript>alert('登录失败，原因可能如下：\n\n1、无此用户或密码不正确。\n\n2、此用户已被封锁。\n\n请返回重新登陆。如仍有问题请联系公司管理员！');history.go(-1);</script>")
     response.end
  end if
  
  if rs("mb")="" and rs("dptype")=4 then 
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('此用户为分支机构用户，但没有指定相应的分支机构！\n\n请联系公司管理员，并指定相应的分支机构！');history.go(-1);</script>")
     response.end
  end if
%>
</body>
</html>
