<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%'被f22_index.asp引用
if session("cn")="" or isnull(session("cn")) then
  session.Abandon()
  response.Write "<script language='javascript'>"
  response.Write "alert('对不起,会话已超时,请您重新登录!');"
  response.Write "window.top.location.href='/index.asp';"
  response.Write "</script>"
  response.End()
end if

DIM list(9,2)
dim Cfname,Cdname,Cuname,Dfname,Ddname,Duname
dim alta,altc,alte,altf,altd,ext,action
dim page,create,edit,del,copy,task,search,sure,unsure,chksure,unchksure,check,cPop,ePop,cont,report
  if trim(request("com"))<>"" then
    session("com")=request("com")
  else
    com=session("com")
  end if
select case session("com")
case "2005"  pagename=">> 业务中心 >> 进货管理 >> 向总部订货"
  session("formid")=2005 '窗口编号
  session("title")="进货管理" '制单界面初始标题
  
  session("PkSName")="indent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"

  'create="create_indent.asp"
  create="f22_dh.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont=""
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2006"  pagename=">> 业务中心 >> 进货管理 >> 向总部补货"
  session("formid")=2006
  session("title")="登记加盟商补货单"
  
  session("PkSName")="indent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=2 '单据类型号
  session("nums")="nums"

  create="create_indent.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont=""
  task="index.asp"
  search="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  report="report/"
  check="index.asp"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
			  
case "2010"  pagename=">> 业务中心 >> 进货管理 >> 收货"
  session("formid")=2010
  session("title")="登记加盟商收货单汇总表"
  
  session("PkSName")="sell" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("nums")="get_nums"

  create=""
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont=""
  task="index.asp"
  search="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  report="report/"
  check="index.asp"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2050"  pagename=">> 业务中心 >> 加盟管理 >> 订货管理"
  session("formid")=2050 
  session("title")="登记加盟商订货单"
  
  session("PkSName")="indent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"

  create="create_indent_jm.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont=""
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  report="report/"
  unchksure="index.asp"
  check="index.asp"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2051"  pagename=">> 业务中心 >> 加盟管理 >> 补货管理"
  session("formid")=2051
  session("title")="登记加盟商补货单"
  
  session("PkSName")="indent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=2 '单据类型号
  session("nums")="nums"

  create="create_indent_jm.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont=""
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2052"  pagename=">> 业务中心 >> 加盟管理 >> 配货管理"
  session("formid")=2052
  
  session("PkSName")="quota" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"

  create="create_quota.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont="f22cz_indent.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:450px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2053"  pagename=">> 业务中心 >> 加盟管理 >> 发货管理"
  session("formid")=2053
  session("title")="加盟商发货单"
  
  session("PkSName")="sell" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"

  create="create_sell.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont="f22cz_quota.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:450px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2054"  pagename=">> 业务中心 >> 加盟管理 >> 收货管理"
  session("formid")=2054
  session("title")="查询加盟商收货单汇总表"
  
  session("PkSName")="sell" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="get_nums"

  create="create_sell.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:480px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2055"  pagename=">> 业务中心 >> 加盟管理 >> 申请退货"
  session("formid")=2055
  session("title")="加盟商退货发货单"
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"SETsub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("nums")="nums"

  create="create_outindent.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:300px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2056"  pagename=">> 业务中心 >> 加盟管理 >> 退货收货"
  session("formid")=2056
  session("title")="加盟商退货收货单"
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("nums")="nums"

  create="create_outindent.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:300px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
case "2017"  pagename=">> 业务中心 >> 店铺管理 >> 调拨发货"
  session("formid")=2017
  session("title")="店铺调拔发货单"
   
  session("PkSName")="move" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="set_nums"
  
  create="create_move.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2018"  pagename=">> 业务中心 >> 店铺管理 >> 调拨收货"
  session("formid")=2018
  session("title")="店铺收货单"
  
  session("PkSName")="move" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="get_nums"

  create="create_move.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2019"  pagename=">> 业务中心 >> 店铺管理 >> 店铺零售"
  session("formid")=2019
  session("title")="二维录入店铺零售单"
  
  session("PkSName")="retail" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"

  create="create_retail.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:330px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:330px;center: yes;help:no;resizable:yes;status:no'"
  
case "2020"  pagename=">> 业务中心 >> 店铺管理 >> 店铺盘点"
  session("formid")=2020
  session("title")="自营仓店盘点单"
  
  session("PkSName")="inventory" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"

  create="create_inventory.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:280px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2011"  pagename=">> 业务中心 >> 退换货管理 >> 正常换货申请"
  session("formid")=2011
  session("title")="向总部提交正常退货申请单"
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"PROsub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 'backrate正常标识
  session("nums")="nums"

  create="create_outindent_zb.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:290px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
case "2012"  pagename=">> 业务中心 >> 退换货管理 >> 特殊换货申请"
  session("formid")=2012
  session("title")="向总部提交特殊退货申请单"
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"PROsub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=0 'backrate特殊标识
  session("nums")="nums"

  create="create_outindent_zb.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:290px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
case "2014"  pagename=">> 业务中心 >> 退换货管理 >> 发货单"
  session("formid")=2014
  session("title")="向总部做退货发货单"
  session("pedit")="create_outindent.asp" '编辑主单页面
  session("plist")="f22_d_indent_list.asp" '浏览主单页面
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"SETsub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=0 '单据类型号
  session("nums")="set_nums"

  create="create_outindent_zb.asp"
  edit="index.asp"
  del="index.asp"
  cont="f22cz_outindentset.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
end select%>
<%
dim ds,i,menusubid,cn
cn=session("cn")
menusubid=session("menusubid")
set ds=server.CreateObject("ADODB.Recordset")
ds.Activeconnection =cn
ds.source = "select * from web_menusubsub where menusubid="&menusubid&" and enable=1 order by sort asc"
ds.open
i=0
while not ds.eof
  list(i,0)=ds("msname")
  list(i,1)=replace(ds("intra"),vbcrlf,"<br>")
  list(i,2)=ds("com")
  i=i+1
  ds.movenext
wend
ds.close
set ds=nothing
%>
<script language="javascript">
/*统一通用功能接口
 *com:单据类型
 *act:功能,做什么事,单据类型由com决定
 *ispop:是否弹窗
 *ext:扩展参数
 *函数原型
 *function com(com,action,ispop,ext)
 */
function com(action,ispop,ext){
  if(ispop==true)
    switch(action){
	case "create":
	  showModalDialog("<%=create%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "edit":
	  showModalDialog("<%=edit%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "task":
	  showModalDialog("<%=task%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "copy":
	  showModalDialog("<%=copy%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
    case "cont":
	  showModalDialog("<%=cont%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "del":
	  showModalDialog("<%=del%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "search":
	  showModalDialog("<%=search%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "chksure":
	  showModalDialog("<%=chksure%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "unchksure":
	  showModalDialog("<%=unchksure%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "sure":
	  showModalDialog("<%=sure%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "unsure":
	  showModalDialog("<%=unsure%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "check": //确认
	  showModalDialog("<%=check%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "report":
	  showModalDialog("<%=report%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	default:
	  alert("没有为本地接口的Action设置命令!");
    }
  else
    switch(action){
	case "create":
	  window.location.href="<%=create%>?action="+action+"&ext="+ext;
	  break;
	case "edit":
	  window.location.href="<%=edit%>?action="+action+"&ext="+ext;
	  break;
	case "task":
	  window.location.href="<%=task%>?action="+action+"&ext="+ext;
	  break;
	case "copy":
	  window.location.href="<%=copy%>?action="+action+"&ext="+ext;
	  break;
    case "cont":
	  window.location.href="<%=cont%>?action="+action+"&ext="+ext;
	  break;
	case "del":
	  window.location.href="<%=del%>?action="+action+"&ext="+ext;
	  break;
	case "search":
	  window.location.href="<%=search%>?action="+action+"&ext="+ext;
	  break;
	case "chksure":
	  window.location.href="<%=chksure%>?action="+action+"&ext="+ext;
	  break;
	case "sure":
	  window.location.href="<%=sure%>?action="+action+"&ext="+ext;
	  break;
	case "check": //确认
	  window.location.href="<%=check%>?action="+action+"&ext="+ext;
	  break;
	case "report":
	  //window.parent.midFrame.oa_tool();
	  window.location.href="<%=report%>?action="+action+"&ext="+ext;
	  break;
	default:
	  alert("没有为本地接口的Action设置命令!");
    }
}
</script>