<%option explicit
Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
var id="";
function gtDoSelect(t){
	var row = t.getSelectedRow();
	id=row.cells[0].innerHTML;
}
function gtDoDblClick(t){
  try{
	var row = t.getSelectedRow();
	id=row.cells[0].innerText;
	if(id=='�ϼ�'){return false;}
	var dptname=row.cells[1].innerText;
	var merchantid=row.cells[4].innerText;
	var parentid=row.cells[6].innerText;
	var p = window.dialogArguments;
  <%
	'������ϵ�ˡ��绰����ַ
	if request.QueryString("getinfo")="true" then%>
		p.document.getElementById("fmsrname").value = row.cells[6].innerText;
		p.document.getElementById("fmsmobtel").value = row.cells[5].innerText;
		p.document.getElementById("fmsaddress").value = row.cells[4].innerText;
	<%end if%>

    <% if trim(request.QueryString("action"))="spdx" then %>
	    window.returnValue="'"+row.cells[1].innerText.replace(/^\s+|\s+$/g,"")+"'";
	<%else %>
    	window.returnValue=id+","+dptname+","+merchantid+","+parentid;//id+","+dptname+","+merchantid+","+parentid+","+set_sums+","+get_sums;
    <%end if %>
    window.close();
  }catch(ex){
		alert(ex);
		}
}


function gtchkselect(t)
{ 
   var selectall="all";
   var val="";
   var   checks=document.getElementsByTagName("input");   
  
   for(var   i=0;i<checks.length;i++)   
   {     
      if   (checks[i].type=="checkbox")
	  {  
	     if (checks[i].checked)
      	 val=val+",'"+checks[i].value+"'";   
	  }
	  	  
   } 
   
   //�������ȫѡ
   for(var   i=0;i<checks.length;i++)   
   {     
      if   (checks[i].type=="checkbox")
	  {  
	     if (checks[i].checked==false)
      	 selectall="noall";
	  }
	  	  
   }   
   
   if (selectall=="all")
   {
      window.returnValue=selectall;
	  window.close();
   }
   else
   {
   	 try
     {
   
      val=val.substring(1,val.length);  
	  window.returnValue=val;
	  window.close();
     }
	 catch(ex)
	 {
   	   alert(ex);
     }
   }
}

function SetchkselectAll(t)
{ 
   
   var val="";
   var   checks=document.getElementsByTagName("input");   
   
   for(var   i=0;i<checks.length;i++)   
   {     
      if   (checks[i].type=="checkbox")
	  {  
	     if (t=="ȫѡ(Q)")
		 {
	     	checks[i].checked=true; 
		 }
		 else
		 {
		    checks[i].checked=false; 
		 }
	  }
   }   
}

function gtDoEnter(t){
}
</script>
</head>

<body>
<div id="">
<%dim sql,userid,depotid
dim o,action,key,way
action=trim(request.QueryString("action"))
key=trim(request.QueryString("key"))
way=trim(request.QueryString("way"))
key=replace(key,"'","")
userid=trim(session("dm").System_UserId)
depotid=trim(session("dm").System_depotid)
if not isnumeric(way) then
  way=1
else
  way=cint(way)
end if
select case way
case 1
  if key<>"" then key=" and a.d_name like '%"&key&"%' "
case 2
  if key<>"" then key=" and dpthelp like '"&key&"%' "
case 3
  if key<>"" then key=" and a.depotid like '"&key&"%' "
end select

dim rs
set rs=server.CreateObject("adodb.recordset")
rs.open "SELECT 1 FROM sys_system WHERE systemid='2132' and isnull(systemvalue,0)=1",cn,1,1
if not rs.eof and not rs.bof then
	key=key&" and a.depotid in (select j2.depotid from j_branddepot j1,j_branddepot j2 where j1.depotid="&qts(depotid)&" and j1.drandid=j2.drandid) "
end if
rs.close
set rs=nothing

select case action
case "sd","out_sd"
  dim addstr
  if action = "out_sd" then
    addstr =" and  thck_sure = 1 "
  end if

  sql=" select a.depotid,a.d_name,a.unitid,(select u.ShutName from j_merchant u where u.merchantid=a.unitid) as unitname,a.parentid,"&_
		  " (select p.ShutName from j_merchant p where p.merchantid=a.parentid) as parentname,b.dpthelp,d.drname "&_
			" from webp_depot a,j_depot b left join j_brand d on b.brandid=d.drandid "&_
      " where a.depotid=b.depotid and isnull(b.freeze,0)<>1 and a.m_type in (10,80,81,90,91) "&_
	  	" and a.merchantid= '"&session("dm").System_UnitId&"' "&key
  
  if not session("zbget") and not session("parentget") then
     sql=sql&" and a.userid='"&session("dm").System_UserID&"' "
  end if
  'if session("zbget") then
     sql=sql&" union select a.depotid,a.d_name,a.unitid,"&_
		 				 " (select u.ShutName from j_merchant u where u.merchantid=a.unitid) as unitname,a.parentid,"&_
						 " (select p.ShutName from j_merchant p where p.merchantid=a.parentid) as parentname,a.dpthelp,d.drname "&_
		 				 " from j_depot a left join j_brand d on a.brandid=d.drandid "&_
						 " where a.m_type in (0,1) and isnull(a.freeze,0)<>1 "&key &addstr
 ' end if
  if session("parentget") then
     sql=sql&" union select a.depotid,a.d_name,a.unitid,"&_
		 				 " (select u.ShutName from j_merchant u where u.merchantid=a.unitid) as unitname,a.parentid,"&_
					   " (select p.ShutName from j_merchant p where p.merchantid=a.parentid) as parentname,b.dpthelp,d.drname "&_
		 				 " from webp_depot a,j_depot b left join j_brand d on b.brandid=d.drandid "&_
             " where a.depotid=b.depotid and isnull(b.freeze,0)<>1 and a.m_type in (80,81,90,91) "&_
			 			 " and a.merchantid= '"&session("dm").System_ParentId&"' "&key	
  end if

	  ' de sql
case "sm"
  sql=" select a.depotid,a.d_name,a.unitid,"&_
		  " (select u.ShutName from j_merchant u where u.merchantid=a.unitid) as unitname,a.parentid,"&_
		  " (select p.ShutName from j_merchant p where p.merchantid=a.parentid) as parentname,a.dpthelp,d.drname "&_
			" from webp_depot a,j_depot b left join j_brand d on b.brandid=d.drandid "&_
      " where a.userid="&qts(userid)&" and a.depotid=b.depotid "&key
case "move"
  sql=" select a.depotid,a.d_name,a.unitid,"&_
		  " (select u.ShutName from j_merchant u where u.merchantid=a.unitid) as unitname,a.parentid,"&_
		  " (select p.ShutName from j_merchant p where p.merchantid=a.parentid) as parentname,a.dpthelp,d.drname "&_
			" from J_depot a left join j_brand d on a.brandid=d.drandid"&_
			
			" where isnull(a.freeze,0)<>1 and a.depotid <>'"&depotid&"' and a.m_type not in (0,1,80,90)  and a.unitid= '"&session("dm").System_UnitId&"' "&key
     ' " where isnull(a.freeze,0)<>1 and a.depotid <>'"&depotid&"'  and a.unitid= '"&session("dm").System_UnitId&"' "&key
case "msell"
   '1��ȡ����Ȩ��	
  if trim(session("dm").System_ParentId)=trim(session("dm").System_UnitID) then
	   sql=" select a.depotid,a.address,a.tel,a.r_name,a.d_name,a.unitid,"&_
		  " (select u.ShutName from j_merchant u where u.merchantid=a.unitid) as unitname,a.parentid,"&_
		  " (select p.ShutName from j_merchant p where p.merchantid=a.parentid) as parentname,a.dpthelp,d.drname "&_
			" from j_depot a left join j_brand d on a.brandid=d.drandid,j_merchantsub b "&_
      " where isnull(a.freeze,0)<>1 and  a.m_type<>0 and a.m_type<>1 and a.unitid=b.depotid and b.merchantid='"&session("dm").System_ParentId&"' "&key&_
	  " and b.depotid<>'"&session("dm").System_UnitID&"' and b.p_move=1 "
  else
    '2��������ֱ������������
    sql=" select top 0 a.depotid,a.address,a.tel,a.r_name,a.d_name,a.unitid,"&_
		  " (select u.ShutName from j_merchant u where u.merchantid=a.unitid) as unitname,a.parentid,"&_
		  " (select p.ShutName from j_merchant p where p.merchantid=a.parentid) as parentname,a.dpthelp,d.drname "&_
			" from j_depot a left join j_brand d on a.brandid=d.drandid "&_
      " where isnull(a.freeze,0)<>1 and a.unitid<>'"&session("dm").System_UnitID&"' "&key&_
	  " and a.parentid='"&session("dm").System_ParentId&"'"	  
  end if
 ' de sql
			
case "sp"	'������Ȩ��

  sql=" select a.depotid,a.d_name,a.unitid,"&_
		  " (select u.ShutName from j_merchant u where u.merchantid=a.unitid) as unitname,a.parentid,"&_
		  " (select p.ShutName from j_merchant p where p.merchantid=a.parentid) as parentname,a.dpthelp,d.drname "&_
			" from sys_depotSetpower18ql p,j_depot a left join j_brand d on a.brandid=d.drandid "&_
      " where isnull(a.freeze,0)<>1 and a.depotid=p.depotid and p.userid='"&session("dm").System_UserID&"' and p.access=1 "&key	
	 
case "spdx"	'������Ȩ��dx

  sql=" select  '<input type=""checkbox"" name=""ckdx"" value=""'+a.depotid+'"" />' as  dx,a.depotid,a.d_name,a.unitid,"&_
		  " (select u.ShutName from j_merchant u where u.merchantid=a.unitid) as unitname,a.parentid,"&_
		  " (select p.ShutName from j_merchant p where p.merchantid=a.parentid) as parentname,a.dpthelp,d.drname "&_
			" from j_depot a left join j_brand d on a.brandid=d.drandid,j_merchantsub b "&_
      " where isnull(a.freeze,0)<>1 and b.p_kc=1  and a.unitid=b.depotid and b.merchantid='"&session("dm").System_UnitID&"' "&key 
  sql=sql&" union  select '<input type=""checkbox"" name=""ckdx"" value=""'+a.depotid+'"" />' as dx,  a.depotid,a.d_name,a.unitid,"&_
		  " (select u.ShutName from j_merchant u where u.merchantid=a.unitid) as unitname,a.parentid,"&_
		  " (select p.ShutName from j_merchant p where p.merchantid=a.parentid) as parentname,a.dpthelp,d.drname "&_
			" from sys_depotSetpower18ql p,j_depot a left join j_brand d on a.brandid=d.drandid "&_
      " where isnull(a.freeze,0)<>1 and a.depotid=p.depotid and p.userid='"&session("dm").System_UserID&"' and p.access=1 "&key


end select

'de sql
dim t
set t = new Table
t.ActiveConnection = cn
t.CommandType = 1
t.CommandText = sql
t.IsAutoColor=1

if action="spdx" then
t.setField "dx","","30",2
end if

t.setField "depotid","���̱��","80",2
t.setField "d_name","��������","120",2
t.setField "dpthelp","������","80",2
t.setField "drname","��ӪƷ��","80",2
t.setField "unitid","һ�����","80",2
t.setField "unitname","һ������","80",2
t.setField "parentid","�������","80",2
t.setField "parentname","��������","80",2
if request.QueryString("getinfo")="true" then
t.setField "address","��ַ","80",2
t.setField "tel","�绰","60",2
t.setField "r_name","��ϵ��","60",2
end if
t.Show
set t = nothing



set o=Server.CreateObject("f22_selectsf.c")
if action="sd" then
  o.setHeight="100%"
  o.setWidth="100%"
  o.setField "dptHelp","������","45"
  o.setField "depotId","���̱���","55"
  o.setField "dptName","��������","120"
  o.setField "jmrate","�ۿ�","30"
  o.setField "jms_sums","���ý��","50"
  o.setField "jmsums","Ŀǰ���","50"
  o.setField "parentid","һ�����","50"
  o.setField "merchantid","�������","50"
  'o.setField "roundcnt","ȡ��λ��","50"
  o.setField "jmbackrate","�˻���","40"
  'o.setField "jmbackdate","�˻�����","50"
else
  o.setHeight="100%"
  o.setWidth="100%"
  o.setField "dptHelp","������","45"
  o.setField "depotId","���̱���","55"
  o.setField "dptName","��������","120"
  o.setField "jmrate","�ۿ�","30"
  o.setField "jms_sums","���ý��","50"
  o.setField "jmsums","Ŀǰ���","50"
  o.setField "parentid","һ�����","50"
  o.setField "merchantid","�������","50"
  'o.setField "roundcnt","ȡ��λ��","50"
  o.setField "jmbackrate","�˻���","40"
  'o.setField "jmbackdate","�˻�����","50"
end if
  'o.sopen
set o=nothing%>
</div>
</body>
</html>
