<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%'顶级控制,粒度是主单,用于每个单据的主调用界面,保存单据的全局信息.
dim com,title,comarr(20,1),ca,formid
com=trim(request.querystring("com"))
menusubid=trim(request.QueryString("msid"))
session("com")=com
session("menusubid")=menusubid
select case com
case "1-1-1","2005":'进货->订货
  session("formid")=2005 '窗口编号
  session("title")="进货管理" '制单界面初始标题
  
  session("PkSName")="indent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"
case "1-1-2","2006":'进货->补货
  session("formid")=2006
  session("title")="登记加盟商补货单"
  
  session("PkSName")="indent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=2 '单据类型号
  session("nums")="nums"
case "1-1-3","2010":'进货->收货
  session("formid")=2010
  session("title")="登记加盟商收货单汇总表"
  
  session("PkSName")="sell" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("nums")="get_nums"
case "2-1-1","2050":'加盟->发货->订货
  session("formid")=2050 
  session("title")="登记加盟商订货单"
  
  session("PkSName")="indent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"
case "2-1-2","2051":'发货->补货
  session("formid")=2051
  session("title")="登记加盟商补货单"
  
  session("PkSName")="indent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=2 '单据类型号
  session("nums")="nums"
case "2-1-3","2052":'发货->配货
  session("formid")=2052
  
  session("PkSName")="quota" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"
case "2-1-4","2053":'发货->发货
  session("formid")=2053
  session("title")="加盟商发货单"
  
  session("PkSName")="sell" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"
case "2-1-5","2054":'发货->收货
  session("formid")=2054
  session("title")="查询加盟商收货单汇总表"
  
  session("PkSName")="sell" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="get_nums"
case "2-2-1","2055":'加盟->退货->退货发货
  session("formid")=2055
  session("title")="加盟商退货发货单"
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"SETsub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("nums")="nums"
case "2-2-2","2056":'退货->退货入库
  session("formid")=2056
  session("title")="加盟商退货收货单"
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("nums")="nums"
'case "2-3-1":'加盟->店铺->发货
'  tt="加盟商店铺调拔发货单"
'case "2-3-2":'店铺->收货
'  tt="加盟商店铺调拔收货单"
'case "2-3-3":'店铺->零售
'  tt="加盟店铺零售单"
'case "2-3-4":'店铺->盘点
'  tt="加盟仓店盘点单"
'************************************************************************8
'case "3-1-1":'直营->发货->订货
'  tt="登记店铺定货单"
'case "3-1-2":'发货->补货
'  tt="登记店铺补货单"
'case "3-1-3":'发货->配货
'  tt="做自营店配货单"
'case "3-1-4":'发货->发货
'  tt="店铺发货单"
'case "3-1-5":'发货->收货
'  tt="店铺收货单"
case "3-2-1","2017":'店铺->发货'*******************************************************
  session("formid")=2017
  session("title")="店铺调拔发货单"
   
  session("PkSName")="move" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="set_nums"
case "3-2-2","2018":'店铺->收货
  session("formid")=2018
  session("title")="店铺收货单"
  
  session("PkSName")="move" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="get_nums"
case "3-2-3","2019":'店铺->零售
  session("formid")=2019
  session("title")="二维录入店铺零售单"
  
  session("PkSName")="retail" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"
case "3-2-4","2020":'店铺->盘点
  session("formid")=2020
  session("title")="自营仓店盘点单"
  
  session("PkSName")="inventory" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"
case "4-1-1","":'财务->收款
  tt="录入收款凭证"
  comarr(0,0)="录入收款凭证"
  comarr(0,1)="move3.asp"
  ca=0
  comarr(1,1)="f22_cw.asp?d="
  session("tablename")="d_Inventory"
  session("tablesub")="d_Inventorysub"
  session("PkName")="Inventoryid"
  session("PkSName")="Inventory"
  session("SPName")="f22_lr"& session("PkSName") &"sub"
  session("nums")="nums"
case "5-1-1","2011":'退货->正常退货申请***************************************88
  session("formid")=2011
  session("title")="向总部提交正常退货申请单"
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"PROsub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 'backrate正常标识
  session("nums")="nums"
case "5-1-2","2012":'特殊退货申请
  session("formid")=2012
  session("title")="向总部提交特殊退货申请单"
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"PROsub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=0 'backrate特殊标识
  session("nums")="nums"
case "5-1-3","2013"'退货审核
  session("formid")=2013
  session("title")="退货审批单"
  session("pedit")="create_outindent.asp" '编辑主单页面
  session("plist")="f22_d_indent_list.asp" '浏览主单页面
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"CHKsub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=0 '单据类型号
  session("nums")="nums"
case "5-1-4","2014" '退货发货单
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
case "5-1-5","2015" '退货收货单
  session("formid")=2015
  session("title")="向总部做退货发货单"
  session("pedit")="create_outindent.asp" '编辑主单页面
  session("plist")="f22_d_indent_list.asp" '浏览主单页面
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=0 '单据类型号
  session("nums")="get_nums"
  
case "2060"
  session("formid")=2060 
  session("title")="POS订货单"
  
  session("PkSName")="indent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"
case "2061"
  session("formid")=2061
  session("title")="登记加盟商补货单"
  
  session("PkSName")="indent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=2 '单据类型号
  session("nums")="nums"
case "2062"
  session("formid")=2062
  
  session("PkSName")="move" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="get_nums"
case "2063"
  session("formid")=2063
  session("title")="向总部提交正常退货申请单"
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"PROsub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 'backrate正常标识
  session("nums")="nums"
case "2064"
  session("formid")=2064
  session("title")="向总部提交正常退货申请单"
  
  session("PkSName")="outindent" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"PROsub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=0 'backrate正常标识
  session("nums")="nums"
case "2065"
case "2066"
  session("formid")=2066
  session("title")="自营仓店盘点单"
  
  session("PkSName")="inventory" '短名
  session("PkName")=session("PkSName")&"id" '主键名
  session("tablename")="d_"&session("PkSName") '表名
  session("tablesub")=session("tablename")&"sub" '子表名
  session("SPName")="f22_lr"& session("PkSName") &"sub" '用到的存储过程名
  session("d_type")=1 '单据类型号
  session("nums")="nums"
end select
%>