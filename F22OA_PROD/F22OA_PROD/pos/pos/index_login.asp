<%
session("zkname")=trim(request("books"))
%>
<html><head><title>�� �� �� �� �� �� ......</title></head><body>
<br><br><br><center>�� �� �� �� �� �� ......</center>
<!-- #include file="cn.asp" -->
<%dim dm,recode,repass,apsszt,rs,f18pass,sqlstr
  recode=SafeRequest(trim(request("name")),0)
  repass=SafeRequest(trim(request("pass")),0)
  passzt=SafeRequest(trim(request("passzt")),0)
  
  '�ж���������
  set rs=server.CreateObject("adodb.recordset")
  rs.open "select isnull(f18pass,'') as f18pass from f18books where dbalia='"&trim(session("zkname"))&"'",cn1
  'response.Write "select isnull(f18pass,'') as f18pass from f18books where dbalia='"&trim(session("zkname"))&"'"
  'response.End()
  if passzt="" then passzt="0" end if
  if not rs.eof then
    if trim(rs("f18pass"))="" then f18pass="0" else f18pass=trim(rs("f18pass")) end if
  else
     response.write("<script language=JavaScript>alert('��¼ʧ�ܣ�ԭ��������£�\n\n1����ѡ������ײ���ȷ��\n\n�뷵������¼�롣');history.go(-1);</script>")
  end if
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
  sqlstr="select username,isnull(usermain,0) as usermain,isnull(mb,'') as mb,isnull(depotid,'') as depotid, "&_
         "isnull(dptype,0) as dptype,isnull(pexport,0) as pexport,isnull(pprint,0) as pprint,isnull(pchk,0) as pchk,"&_
		 "isnull(psure,0) as psure,isnull(padd,0) as padd,isnull(pedit,0) as pedit,isnull(pdel,0) as pdel,"&_
		 "isnull(punchk,0) as punchk,isnull(punsure,0) as punsure,isnull(pwr_cost,0) as pwr_cost,isnull(pwr_price,0) as pwr_price,"&_
         "isnull(pwr_sprice,0) as pwr_sprice,isnull(usertype,0) as usertype from j_user "&_
		 "where userid='"&recode&"' and password='"&repass&"' and isnull(notuse,0)=0"
		 'response.Write sqlstr
		 'response.End()
  rs.open sqlstr,cn
  if rs.eof then
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('��¼ʧ�ܣ�ԭ��������£�\n\n1���޴��û������벻��ȷ��\n\n2�����û��ѱ�������\n\n�뷵�����µ�½����������������ϵ��˾����Ա��');history.go(-1);</script>")
     response.end
  end if
  
  select case rs("dptype")
  case 0
  
  case 1
  
  case 2
    if rs("mb")="" then 
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('���û�Ϊ��֧�����û�����û��ָ����Ӧ�ķ�֧������\n\n����ϵ��˾����Ա����ָ����Ӧ�ķ�֧������');history.go(-1);</script>")
     response.end
    end if
  case 3
    if rs("mb")="" then 
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('���û�Ϊ��֧�����û�����û��ָ����Ӧ�ķ�֧������\n\n����ϵ��˾����Ա����ָ����Ӧ�ķ�֧������');history.go(-1);</script>")
     response.end
    end if
  case 4
    if rs("depotid")="" then
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('���û�Ϊ��POS�û�����û��ָ����Ӧ�ĵ��̣�\n\n����ϵ����Ա����ָ����Ӧ�ĵ��̣�');history.go(-1);</script>")
     response.end
	end if
  case else
    response.write "�û����ʹ���!�뷵�����µ�¼!"
	response.end
  end select
  

'��ȡ����  
  'set dm= new F22System_Dm
  set dm = server.CreateObject("dm.c")
  dm.System_UserId=recode
  dm.System_UserPass=repass
  dm.System_UserName=rs("username")
  'dm.System_UserAdmin=rs("usermain")
  if rs("usermain")=True then'�ǹ���Ա,Ȩ��ȫ����ֵΪ1
    dm.System_UserAdmin=1
	dm.System_UserType=rs("dptype")
    dm.System_Login=true
    dm.Set_UserPower 1,1
    dm.Set_UserPower 2,1
    dm.Set_UserPower 3,1
    dm.Set_UserPower 4,1
    dm.Set_UserPower 5,1
    dm.Set_UserPower 6,1
    dm.Set_UserPower 7,1
    dm.Set_UserPower 8,1
    dm.Set_UserPower 9,1
    dm.Set_UserPower 10,1
    dm.Set_UserPower 11,1
    dm.System_UnitId=rs("mb")
  else
    dm.System_UserAdmin=0
	dm.System_UserType=rs("dptype")
    dm.System_Login=true
    dm.Set_UserPower 1,rs("pexport")
    dm.Set_UserPower 2,rs("pprint") 
    dm.Set_UserPower 3,rs("pchk") 
    dm.Set_UserPower 4,rs("psure") 
    dm.Set_UserPower 5,rs("padd") 
    dm.Set_UserPower 6,rs("pdel") 
    dm.Set_UserPower 7,rs("punchk") 
    dm.Set_UserPower 8,rs("punsure") 
    dm.Set_UserPower 9,rs("pwr_price") 
    dm.Set_UserPower 10,rs("pwr_sprice") 
    dm.Set_UserPower 11,rs("pwr_cost") 
    dm.System_UnitId=rs("mb")
	dm.System_DepotId=rs("depotid")'POS�û�ʹ��
  end if
  
  rs.close
  
  select case dm.System_UserType
  case 0
     dm.System_UnitName=""
     dm.System_DepotId=""
     dm.System_DepotName=""
     'dm.System_Get_Depotid=""
     'dm.System_Get_DepotName=""
     'dm.System_Set_Depotid=""
     'dm.System_Set_DepotName=""
     dm.System_ParentId=""
  case 1
  
  case 2
	sqlstr="select a.shutname,a.jmdepotid,isnull(a.backRate,0) as backrate,b.d_name,b.parentid "& _
		   "from j_merchant a,j_depot b "& _
           "where a.merchantid='"&dm.System_UnitId&"' and a.jmdepotid=b.depotid"
		   'response.Write(sqlstr)
		   'response.End()
    rs.open sqlstr,cn
      if rs.eof then '���ܲ��û�����û������Ĭ�ϵ���
       response.write("<script language=JavaScript>alert('���û�������֧����û������Ĭ�ϵ��̣�\n\n����ϵ��˾����Ա��Ϊ�÷�֧��������Ĭ�ϵ��̣�');history.go(-1);</script>")
       rs.close
	   set rs=Nothing
	   cn.close
	   set cn=Nothing
	   response.end
     end if
     dm.System_UnitName=rs("shutname")'����������
     dm.System_DepotId=rs("jmdepotid")'������Ĭ�ϲֿ�
     dm.System_DepotName=rs("d_name")'������Ĭ�ϲֿ�����
		 response.Cookies("gj")("DepotName")=rs("d_name")
     'dm.System_Get_Depotid=rs("depotid")'�ܲ��ջ���
     'dm.System_Get_DepotName=rs("d_name1")         
     'dm.System_Set_Depotid=rs("setdepotid")'�ܲ�������
     'dm.System_Set_DepotName=rs("d_name2")
     dm.System_ParentId=rs("parentid")'�ϼ�ID
	 dm.System_BackRate=rs("backrate")'������
	 rs.close
	 sqlstr="select depotid,d_name,unitid,parentid from j_depot where m_type=0 "
	 rs.source = sqlstr
	 rs.open
	 dm.System_Set_Depotid=rs("depotid")
	 dm.System_Set_DepotName=rs("d_name")
	 rs.close
  case 3
  
  case 4
	sqlstr="select d_name,unitid,parentid,pos_round from j_depot where depotid='"&dm.System_DepotId&"'"
		   'response.Write(sqlstr)
		   'response.End()
    rs.open sqlstr,cn
      if rs.eof then '���ܲ��û�����û������Ĭ�ϵ���
       response.write("<script language=JavaScript>alert('���û�Ϊ��POS�û�����û��ָ����Ӧ�ĵ��̣�\n\n����ϵ����Ա����ָ����Ӧ�ĵ��̣�');history.go(-1);</script>")
       rs.close
	   set rs=Nothing
	   cn.close
	   set cn=Nothing
	   response.end
     end if
	 session("retailid")=""
	 dm.System_UnitId=trim(rs("unitid"))
     'dm.System_UnitName=rs("shutname")'����������
     'dm.System_DepotId=rs("jmdepotid")'������Ĭ�ϲֿ�
     dm.System_DepotName=rs("d_name")'������Ĭ�ϲֿ�����
     'dm.System_Get_Depotid=rs("depotid")'�ܲ��ջ���
     'dm.System_Get_DepotName=rs("d_name1")         
     'dm.System_Set_Depotid=rs("setdepotid")'�ܲ�������
     'dm.System_Set_DepotName=rs("d_name2")
     dm.System_ParentId=rs("parentid")'�ϼ�ID
	 'dm.System_BackRate=rs("backrate")'������
	 rs.close
	 'sqlstr="select depotid,d_name,unitid,parentid from j_depot where m_type=0 "
	 sqlstr="select depotid,d_name,unitid,parentid from webp_depot where m_type=90 and merchantid= '"&dm.System_UnitId&"'"
	 'response.Write sqlstr
	 'response.End()
	 rs.source = sqlstr
	 rs.open
	 if not rs.eof then
	   dm.System_Set_Depotid=rs("depotid")
	   dm.System_Set_DepotName=rs("d_name")
	 end if
	 rs.close
	 sqlstr="select isnull(pos_mdzk,0) pos_mdzk,isnull(pos_mdsp,0) pos_mdsp,isnull(pos_back,0) pos_back from j_user where userid='"&recode&"'"
	 rs.source = sqlstr
	 rs.open
	   session("dm_zk")=rs("pos_mdzk")
	   session("dm_sp")=rs("pos_mdsp")
	   session("dm_th")=rs("pos_back")
	 rs.close
	 session("webtype")=3
	 sqlstr=" delete from webtmp_retail where retailid in"& _
			" (select retailid from webtmp_retail where setdate<getdate()-1"& _
			" and depotid='"&dm.System_DepotId&"' and retailid like '"&dm.System_DepotId&"-"&dm.System_UserId&"%')"
	rs.Source = sqlstr
	rs.open
  case else
  
  end select
  
  set rs=nothing
  cn.close
  set cn=Nothing
  set session("dm")=dm
  session("skindir")="default" '��ʽĿ¼
  
if session("screenHeight")="" then
   session("screenWidth")=800
   session("screenHeight")=600
   session("maxWinWidth")=800
   session("maxWinHeight")=460
end if

response.Redirect("main.asp")
%></body></html>