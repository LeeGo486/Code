<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html><head><title>正在验证用户......</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head><body>
<%
dim dbname

session("dbname")=trim(request("dbname"))
if session("dbname")="" then
	response.Write "数据库参数不存在！"
	response.End()
end if%>
<%
if request.form("act")<>"submit" then
%>
<object id="NewChk" classid="clsid:4E568CBB-33FA-40D8-B587-EB2ADDCEE4D4" height="0" width="0"></object>
<form name="md5Form" method="post" action="index_login.asp">
  <input type="hidden" name="act" id="act" value="submit">
  <input type="hidden" name="dbname" id="dbname" value="<%=request("dbname")%>">
  <input type="hidden" name="name" id="name" value="<%=request("name")%>">
  <input type="hidden" name="pass" id="pass" value="<%=request("pass")%>">
  <input type="hidden" name="url" id="url" value="<%=request("url")%>">
  <input type="hidden" name="regpcv" id="regpcv" value="">
</form>
<br><br><br><center id="tips">
正在验证客户端......<br><br>

如果长时间停留在此页面，请确定你电脑是否安装<a href="../setup/Install.exe">ActiveX登录验证插件</a><br><br>

或与系统管理员联系
</center>

<script type="text/javascript" defer>
document.getElementById("regpcv").value=NewChk.SupCrypt();
document.getElementById("md5Form").submit();
</script>
<%
response.end()
end if
%>

<br><br><br><center>正在验证用户......</center>
<!-- #include file="cn.asp"-->
<!--#include file="pos/f22/config.asp"-->

<%
dim dm,recode,repass,apsszt,rs,f18pass,sqlstr,url,regpcv
  recode=SafeRequest(trim(request("name")),0)
  repass=SafeRequest(trim(request("pass")),0)
  url=SafeRequest(trim(request("url")),0)
  regpcv=SafeRequest(trim(request("regpcv")),0)
  
  '判断用户密码是否正确
  set rs=server.CreateObject("adodb.recordset")
  sqlstr="select username,isnull(usermain,0) as usermain,isnull(mb,'') as mb,isnull(depotid,'') as depotid, "&_
         "isnull(dptype,0) as dptype,isnull(pexport,0) as pexport,isnull(pprint,0) as pprint,isnull(pchk,0) as pchk,"&_
		 "isnull(psure,0) as psure,isnull(padd,0) as padd,isnull(pedit,0) as pedit,isnull(pdel,0) as pdel,"&_
		 "isnull(punchk,0) as punchk,isnull(punsure,0) as punsure,isnull(pwr_cost,0) as pwr_cost,isnull(pwr_price,0) as pwr_price,"&_
		 "isnull(pwr_sprice,0) as pwr_sprice,isnull(usertype,0) as usertype,"&_
		 "(select psendmsg1 from f18master.dbo.sys_f22user where userid ='"&recode&"') as psendmsg1,"&_
 		 "(select isnull(regpc,0) from f18master.dbo.sys_f22user where userid ='"&recode&"') as iregpc,"&_
		 "(select isnull(regpcv,'') from f18master.dbo.sys_f22user "&_
		 "where userid ='"&recode&"') as iregpcv from j_user "&_
		 "where userid='"&recode&"' and password='"&repass&"' and isnull(notuse,0)=0"
		 
		 
		 
		 'response.Write session("dbname")
		 'response.End()
  rs.open sqlstr,cn,1,3
  
  if rs.eof then
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('登录失败，原因可能如下：\n\n1、无此用户或密码不正确。\n\n2、此用户已被封锁。\n\n请返回重新登陆。如仍有问题请联系公司管理员！');history.go(-1);</script>")
     response.end
  end if
  session("psendmsg1")=rs("psendmsg1")
  select case rs("dptype")
  case 0

  case 1
  
  case 2
    if rs("mb")="" then 
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('此用户为分支机构用户，但没有指定相应的分支机构！\n\n请联系公司管理员，并指定相应的分支机构！');history.go(-1);</script>")
     response.end
    end if
  case 3
    if rs("mb")="" then 
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('此用户为分支机构用户，但没有指定相应的分支机构！\n\n请联系公司管理员，并指定相应的分支机构！');history.go(-1);</script>")
     response.end
    end if
  case 4
    if rs("depotid")="" then
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('此用户为POS用户，但没有指定相应的店铺！\n\n请联系管理员，并指定相应的店铺！');history.go(-1);</script>")
     response.end
	elseif rs("iregpc") and rs("iregpcv")="" then		'设置了绑定电脑，并且数据库中的验证码是空
		sql="update f18master.dbo.sys_f22user set regpcv='"&regpcv&"' where userid='"&recode&"' and password='"&repass&"' and isnull(notuse,0)=0"
		cn.execute(sql)
	elseif rs("iregpc") and rs("iregpcv")<>regpcv then	'设置了绑定电脑，并且数据库中的验证码不为空，则开始验证
     rs.close
	 set rs=Nothing
	 cn.close
	 set cn=Nothing
     response.write("<script language=JavaScript>alert('验证失败，请确定当前用户是否允许在此计算机上使用POS系统\n\n若有其它问题请与系统管理员联系！');location.href='../'</script>")
     response.end
	end if
  case else
    response.write "用户类型错误!请返回重新登录!"
	response.end
  end select
  
'读取参数  
  'set dm= new F22System_Dm
  set dm = server.CreateObject("dm.c")
  dm.System_UserId=recode
  dm.System_UserPass=repass
  dm.System_UserName=rs("username")
  'dm.System_UserAdmin=rs("usermain")
  
  if rs("usermain")=True then'是管理员,权限全部赋值为1
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
    dm.System_DepotId=rs("depotid")'POS用户使用
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
	dm.System_DepotId=rs("depotid")'POS用户使用
  end if
	
  rs.close
 
  select case dm.System_UserType
  case 0
     dm.System_UnitName=""
     dm.System_DepotId=""
	response.Cookies("dpthelp") = ""
     dm.System_DepotName=""
     'dm.System_Get_Depotid=""
     'dm.System_Get_DepotName=""
     'dm.System_Set_Depotid=""
     'dm.System_Set_DepotName=""
     dm.System_ParentId=""
  case 1
  
  case 2
	sqlstr="select a.shutname,a.jmdepotid,isnull(a.backRate,0) as backrate,b.d_name,b.parentid,b.dpthelp "& _
		   "from j_merchant a,j_depot b "& _
           "where a.merchantid='"&dm.System_UnitId&"' and a.jmdepotid=b.depotid"
		   'response.Write(sqlstr)
		   'response.End()
    rs.open sqlstr,cn,1,1
      if rs.eof then '不总部用户但是没有设置默认店铺
       response.write("<script language=JavaScript>alert('此用户为POS用户，但没有指定相应的店铺！\n\n请联系管理员，并指定相应的店铺！');history.go(-1);</script>")
       rs.close
	   set rs=Nothing
	   cn.close
	   set cn=Nothing
	   response.end
     end if
     dm.System_UnitName=rs("shutname")'加盟商名称
     dm.System_DepotId=rs("jmdepotid")'加盟商默认仓库
     dm.System_DepotName=rs("d_name")'加盟商默认仓库名称
	 		 response.Cookies("DepotName") = server.URLEncode(rs("d_name"))'加盟商默认仓库名称
     'dm.System_Get_Depotid=rs("depotid")'总部收货仓
     'dm.System_Get_DepotName=rs("d_name1")         
     'dm.System_Set_Depotid=rs("setdepotid")'总部发货仓
     'dm.System_Set_DepotName=rs("d_name2")
     dm.System_ParentId=rs("parentid")'上级ID
	 dm.System_BackRate=rs("backrate")'换货率
	 rs.close
	 sqlstr="select depotid,d_name,unitid,parentid from j_depot where m_type=0 "
	 rs.source = sqlstr
	 rs.open
	 dm.System_Set_Depotid=rs("depotid")
	 dm.System_Set_DepotName=rs("d_name")
	 rs.close
  case 3
  
  case 4 'POS用户
	sqlstr=" select a.d_name,a.dpthelp,a.unitid,a.parentid,a.pos_round,isnull(b.roundcnt,0) as roundcnt,"&_
				 " isnull(vip_chkup,0) as vip_chkup,isnull(vip_lookunit,0) as vip_lookunit, "&_
				 " isnull(b.ctrlback,0) as ctrlback,a.m_type"&_
				 " from j_depot a,j_merchant b "&_
	       " where a.depotid='"&dm.System_DepotId&"' and a.unitid*=b.merchantid"
		   'response.Write(sqlstr)
		   'response.End()
    rs.open sqlstr,cn
      if rs.eof then '不总部用户但是没有设置默认店铺
       response.write("<script language=JavaScript>alert('此用户为POS用户，但没有指定相应的店铺！\n\n请联系管理员，并指定相应的店铺！');history.go(-1);</script>")
       rs.close
	   set rs=Nothing
	   cn.close
	   set cn=Nothing
	   response.end
     end if

	 session("retailid")=""
	 dm.System_UnitId=trim(rs("unitid"))
     'dm.System_UnitName=rs("shutname")'代理商名称
     'dm.System_DepotId=rs("jmdepotid")'加盟商默认仓库
     dm.System_DepotName=rs("d_name")'加盟商默认仓库名称
		 response.Cookies("dpthelp") = rs("dpthelp")'助记码
		 response.Cookies("DepotName") = rs("d_name")'加盟商默认仓库名称
     'dm.System_Get_Depotid=rs("depotid")'总部收货仓
     'dm.System_Get_DepotName=rs("d_name1")         
     'dm.System_Set_Depotid=rs("setdepotid")'总部发货仓
     'dm.System_Set_DepotName=rs("d_name2")
     dm.System_ParentId=rs("parentid")'上级ID
	 'dm.System_BackRate=rs("backrate")'换货率
	 session("roundcnt")=cdbl(rs("roundcnt"))
     session("ctrlback")=rs("ctrlback")
	 session("m_type")=rs("m_type")
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

	 sqlstr="select oauserid,isnull(pos_mdzk,0) as pos_mdzk,isnull(pos_mdsp,0) as pos_mdsp,isnull(pos_back,0) as pos_back,"&_
	        "isnull(pwr_dis,-1) as pwr_dis,isnull(pwr_rdis,-1) as pwr_rdis from j_user where userid='"&recode&"'"
	 rs.source = sqlstr
	 rs.open
	   session("dm_zk")=rs("pos_mdzk")
	   session("dm_sp")=rs("pos_mdsp")
	   session("dm_th")=rs("pos_back")
	   session("oauserid")=rs("oauserid")
	   '最低折扣和最低折上折
	   response.cookies("lowerzk")("zk1")=rs("pwr_dis")
	   response.cookies("lowerzk")("zk2")=rs("pwr_rdis")
	 rs.close
	 rs.source = "select isnull(pos_ifkc,0) pos_ifkc,isnull(setkc0,0) as setkc0,pos_vipshow=isnull(pos_vipshow,0),"&_
	 	" isnull(pos_novip,0) as pos_novip,isnull(pos_cxvip,0) as pos_cxvip,isnull(pos_round,0) as pos_round,"&_
		" isnull(pos_selcx,0) as pos_selcx,isnull(qxadd,'') as qxadd,isnull(xpname,'') as xpname,isnull(zbget,0) as zbget,"&_
		" isnull(onlybdkc,0) as onlybdkc,isnull(nozckc,0) as nozckc,isnull(parentget,0) as parentget,isnull(qryday,0) as qryday,"&_
		" isnull(pos_vipzsz,0) as pos_vipzsz,isnull(clothing_len,0) as clothingid_len,isnull(FRoundDec,0) as FRoundDec,"&_
		" isnull(pos_nozs,0) as pos_nozs,isnull(vip_chkup,0) as vip_chkup,isnull(vip_lookunit,0) as vip_lookunit "&_
		" from j_depot where depotid='"&dm.System_Depotid&"'"
	 rs.open
	 'VIP申请需上级审核
	 session("vip_chkup")=rs("vip_chkup")
	 '是否可全查询同机构下所有店铺资料
	 session("vip_lookunit")=rs("vip_lookunit")
	 
	 '库存为0不允许发货 
	 session("setkc0")=rs("setkc0")
	 '无库存不允许收银
	 session("ifkc")=rs("pos_ifkc")
	 
	 session("dm_round")=rs("pos_round")
	 session("qxadd")=rs("qxadd")
	 '得到小票文件名
	 session("xpname")=rs("xpname")
	 '是否允许直接向总部订补货
	 session("zbget")=rs("zbget")
	 '只能查本店数据,不能查总仓数据
	 session("onlybdkc")=rs("onlybdkc")
	 session("nozckc")=rs("nozckc")
	 '允许向上上级操作
	 session("parentget")=rs("parentget")
	 '条码截取
	 session("postm_ln")=rs("clothingid_len")
	 'VIP不允许折上折
	 session("vipzsz")=rs("pos_vipzsz")
	 '允许选择促销
	 session("selcx")=rs("pos_selcx")
	 '促销/VIP执行方式
	 session("cxvip")=rs("pos_cxvip")
	 'VIP不允许打折
	 session("novip")=rs("pos_novip")
	 '四舍五入保留小数位数
	 session("FRoundDec")=rs("FRoundDec")
	 '是否允许使用赠送功能
	 session("pos_nozs")=rs("pos_nozs")
	 '销售查询天数，0为不控制
	 session("QryDay")=rs("qryday")
	 session("QryDayTj")=" and datediff(d,sure_date,getdate())<="&rs("qryday")
	 'vip显示为*
	 session("pos_vipshow")=rs("pos_vipshow")
	 rs.close
	 
	  '预警是否启用负库存不足时的不允许审核
	 rs.source = "select sysdefvalue from sys_system where systemid=2002"
	 rs.open
	 if not rs.eof then
	    session("setkcyj")=int(rs(0))
	 else
	    session("setkcyj")=0
	 end if
	 rs.close
	 
	 '是否记录条码
	 rs.source = "select sysdefvalue from sys_system where systemid=2033"
	 rs.open
	 if not rs.eof then
	    session("iftmlist")=int(rs(0))
	 else
	    session("iftmlist")=0
	 end if
	 rs.close
	 '是否检查款式经营权限
	 rs.source = "select sysdefvalue from sys_system where systemid=2132"
	 rs.open
	 if not rs.eof then
	    session("stylepower")=int(rs(0))
	 else
	    session("stylepower")=0
	 end if
	 rs.close
	 
	 '是否允许修改销售日期
	 rs.source = "select sysdefvalue from sys_system where systemid=2139"
	 rs.open
	 if not rs.eof then
	    session("ModifySaleDate")=int(rs(0))
	 else
	    session("ModifySaleDate")=0
	 end if
	 rs.close
	 
	 '四舍五入方式
	 rs.source = "select sysdefvalue from sys_system where systemid=2004"
	 rs.open
	 if not rs.eof then
	    session("roundtype")=int(rs(0))
	 else
	    session("roundtype")=3
	 end if
	 rs.close
	 
	  
	 '2143 启用加强策略
	 rs.source = "select sysdefvalue from sys_system where systemid=2143"
	 rs.open
	 if not rs.eof then
	    session("expandpass")=int(rs(0))
	 else
	    session("expandpass")=0
	 end if
	 rs.close
	 
	 
	  
	 '2144 密码长度在此位数以上
	 rs.source = "select sysdefvalue from sys_system where systemid=2144"
	 rs.open
	 if not rs.eof then
	   session("passlength")=int(rs(0))
	 else
	   session("passlength")=0
	 end if
	 rs.close
	 
	 '2146 跨区折扣取值设置
	 rs.source = "select sysdefvalue from sys_system where systemid=2146"
	 rs.open
	 if not rs.eof then
	   session("kqdisc")=int(rs(0))
	 else
	   session("kqdisc")=0
	 end if
	 rs.close
	 
	 if trim(dm.System_ParentId)<>trim(dm.System_UnitId) then
	   
	   if session("kqdisc")=0 then
	      session("kqdisc")=10
	   else
	      session("kqdisc")=11	  
	   end if
	 
	 end if
	 
	 '获取OA地址
	 rs.source = "select case when isnull(oahttp,'')='' then '地址1' else isnull(oahttp,'地址1') end as oahttp from f18master.dbo.sys_f22user where userid='"&recode&"'"
	 rs.open
	 	oahttp=rs("oahttp")
	 rs.close
		if oahttp="地址1" then
			systemid=2001
		elseif oahttp="地址2" then
			systemid=2002
		elseif oahttp="地址3" then
			systemid=2003
		elseif oahttp="地址4" then
			systemid=2004
		elseif oahttp="地址5" then
			systemid=2005
		elseif oahttp="地址6" then
			systemid=2006
		elseif oahttp="地址7" then
			systemid=2007
		elseif oahttp="地址8" then
			systemid=2008
		end if
	 rs.source = "select isnull(systemvalue,'') as systemvalue from f18master.dbo.sys_system where systemid="&systemid&""
	 rs.open
	 	session("oahttp")=rs("systemvalue")
	 rs.close

    
	 
	 '是否收银发送短信
	 rs.source = "select sysdefvalue from sys_system where systemid=2076"
	 rs.open
	 if not rs.eof then
	    session("sysendmsg")=int(rs(0))
	 else
	    session("sysendmsg")=0
	 end if
	 rs.close
	 
	 'VIP启用刷卡截取设置
	 rs.source = "select isnull(sysdefvalue,0)  from sys_system where systemid=2096"
	 rs.open
	 if not rs.eof then
	    response.cookies("vipflash")("cut")=cdbl(rs(0))
	 else
	    response.cookies("vipflash")("cut")=0
	 end if
	 rs.close
	 'VIP截取设置
	 rs.source = "select isnull(sysdefvalue,0) from sys_system where systemid=2097"
	 rs.open
	 if not rs.eof then
	    response.cookies("vipflash")("beg")=cdbl(rs(0))
	 else
	    response.cookies("vipflash")("beg")=1
	 end if
	 rs.close
	 rs.source = "select isnull(sysdefvalue,0) from sys_system where systemid=2098"
	 rs.open
	 if not rs.eof then
	    response.cookies("vipflash")("cnt")=cdbl(rs(0))
	 else
	    response.cookies("vipflash")("cnt")=1
	 end if
	 rs.close 	
	 'POS新短信自动弹出
	 rs.source = "select sysdefvalue from sys_system where systemid=2099"
	 rs.open
	 if not rs.eof then
	    response.cookies("MsgAutoShow")=cdbl(rs(0))
	 else
	    response.cookies("MsgAutoShow")=0
	 end if
	 rs.close 
	 
	 '插入上级权限，查对帐单用
	 rs.source = "select 1 from sys_Merchantpower18ql where userid='"&dm.system_userid&"' and merchantid='"&dm.system_unitid&"'"
	 rs.open
	 if rs.eof then
	    sqlstr="insert into sys_Merchantpower18ql (userid,merchantid,selection,access,freeze) values "&_
	           "('"&dm.system_userid&"','"&dm.system_unitid&"',1,1,0) "
	 else
	    sqlstr="update sys_Merchantpower18ql set selection=1,access=1 where userid='"&dm.system_userid&"' and merchantid='"&dm.system_unitid&"'"
	 end if
	 cn.execute sqlstr
	 rs.close
	 
	 session("webtype")=3
	 sqlstr=" delete from webtmp_retail where retailid in"& _
			" (select retailid from webtmp_retail where setdate<getdate()-1"& _
			" and depotid='"&dm.System_DepotId&"' and retailid like '"&dm.System_DepotId&"-"&dm.System_UserId&"%')"
	rs.Source = sqlstr
	rs.open

	set session("dm")=dm
	session("skindir")="default"
	
  '得到收货记录新款标记
  rs.source = "select cast(sysdefvalue as int) as sysdefvalue from sys_system where systemid=2051"
  rs.open
  if rs.eof then
     session("InsertNewStyle")=0
  else
     session("InsertNewStyle")=rs(0)
  end if  
  rs.close
  
  session("QryDepotTj")=" in (select depotid from sys_depotSetpower18ql where userid='"&dm.System_userid&"' and access=1) "
  set rs = nothing

  set cn=Nothing
     response.Redirect(url)
  case else

  end select
  
  set rs=nothing
  cn.close
  set cn=Nothing
  set session("dm")=dm
  session("skindir")="default" '样式目录
  
if session("screenHeight")="" then
   session("screenWidth")=800
   session("screenHeight")=600
   session("maxWinWidth")=800
   session("maxWinHeight")=460
end if

'response.Redirect("main.asp")
%></body></html>
