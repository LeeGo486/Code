<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%'功能接口,可包含,或直接提交
'包含其实是自己提交给自己
dim com,ispop,ext,action
dim Cfname,Cdname,Cuname,Dfname,Ddname,Duname
dim create,eidt,del,copy
'接收参数
  com=trim(request("com"))
  action=trim(request("action"))
  ispop=trim(request("ispop"))
  ext=trim(request("ext"))
  if action<>"" then action=lcase(action)
  if lcase(ispop)="true" then
    ispop=true
  else
    ispop=false
  end if
select case com '每种单审核登帐时用到的字段名
case "1-1-1" '进货->订货d_indent

  Cfname="chk_sure" '审核登帐字段名
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"

  select case action
  case "create"
  
  case "edit"
  
  case "del"
  
  case "copy"
  
  end select
  create="create_indent.asp?action=create','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  altc="showModalDialog('create_indent.asp?id='+id+'&action=copy','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_indent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_indent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
    
  button="<input type='button' name='Submit' value='根据已有订单生成订货单(C)' style='width:170px;' onClick='altc();' accesskey='c'>"
case "1-1-2" '进货->补货
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_indent.asp?action=create','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_indent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_indent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "1-1-3":'进货->收货d_sell
  Cfname="getchk_sure"
  Cdname="getchk_date"
  Cuname="getchk_name"
  Dfname="get_sure"
  Ddname="getsure_date"
  Duname="getsure_name"
  alta="1"
  alte="1"
  altf="1"
  altd="1"
case "2-1-1":'加盟->发货->订货
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_indent.asp?action=create','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_indent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_indent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "2-1-2":'发货->补货
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_indent.asp?action=create','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_indent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_indent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "2-1-3":'发货->配货d_quota
  Cfname="setchk_sure"
  Cdname="setchk_date"
  Cuname="setchk_name"
  Dfname="set_sure"
  Ddname="setsure_date"
  Duname="setsure_name"
  alta="showModalDialog('create_quota.asp?action=create','e','dialogWidth:500px;dialogHeight:480px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_quota.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:480px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_quota.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  
  ext="<input type='button' name='Submit' value='参照订补单(Q)' style='width:120px;' onClick='altq();' accesskey='q'>"
case "2-1-4":'发货->发货
  Cfname="setchk_sure"
  Cdname="setchk_date"
  Cuname="setchk_name"
  Dfname="set_sure"
  Ddname="setsure_date"
  Duname="setsure_name"
  alta="showModalDialog('create_sell.asp?action=create','e','dialogWidth:500px;dialogHeight:480px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_sell.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:480px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_sell.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  
  ext="<input type='button' name='Submit' value='参照生成发货单(I)' style='width:120px;' onClick='alti();' accesskey='i'>"
case "2-1-5":'发货->收货d_sell
  Cfname="getchk_sure"
  Cdname="getchk_date"
  Cuname="getchk_name"
  Dfname="get_sure"
  Ddname="getsure_date"
  Duname="getsure_name"
  alta="1"
  alte="1"
  altf="1"
  altd="1"
case "2-2-1":'加盟->退货->退货申请d_outindent
 Cfname="chk_sure"
 Cdname="chk_date"
 Cuname="chk_name"
 Dfname="sure"
 Ddname="sure_date"
 Duname="sure_name"
case "2-2-2":'退货->退货入库收货登帐审核
 Cfname="getchk_sure"
 Cdname="getchk_suredate"
 Cuname="getchk_name"
 Dfname="get_sure"
 Ddname="getsure_date"
 Duname="getsure_name"
 
case "3-2-1":'加盟->店铺->发货
  Cfname="setchk_sure"
  Cdname="setchk_date"
  Cuname="setchk_name"
  Dfname="set_sure"
  Ddname="setsure_date"
  Duname="setsure_name"
  alta="showModalDialog('create_move.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_move.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_move.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "3-2-2":'店铺->收货
  Cfname="getchk_sure"
  Cdname="getchk_date"
  Cuname="getchk_name"
  Dfname="get_sure"
  Ddname="getsure_date"
  Duname="getsure_name"
  alta="showModalDialog('create_move.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_move.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_move.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "3-2-3":'店铺->零售'
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_retail.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_retail.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_retail.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "3-2-4":'店铺->盘点
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_inventory.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_inventory.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_inventory.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "5-1-1" '正常退货
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_outindent.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_outindent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_outindent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "5-1-2" '特殊退货
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_outindent.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_outindent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_outindent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "5-1-3" '正常退货
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_outindent.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_outindent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_outindent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "5-1-4" '特殊退货
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_outindent.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_outindent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_outindent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "5-1-5" '特殊退货
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_outindent.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_outindent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_outindent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "2066":'店铺->盘点
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_inventory.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_inventory.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_inventory.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"

end select
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
function com(){

  var com = arguments[0] || "<%=session("com")%>";
  var action = arguments[1] || "";
  var ispop = arguments[2] || 0;
  var ext = arguments[3] || "";

  switch(action){
  case 0://添加新单
    if(ispop==0){
	
	}else{
      var alta=<%=alta%>;
	}
    break;
  case 1://通用查询单据
    if(ispop==0){
	  window.location.href="index.asp?com="+com+"&action="+action+"&ext="+ext;
	}else{
      var alta=<%=alta%>;
	}
    
    break;
  case 2://根据任务查询单据
    ext="task";
    if(ispop==0){
	  window.location.href="index.asp?com="+com+"&action="+action+"&ext="+ext+"&stype=2";
	}else{
     showModalDialog("index.asp?com="+com+"&action="+action+"&ext="+ext+"&stype=2",'e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no');
	}
    break;
  case 3://修改单据
    
    break;
  case 4://根据
  
    break;
  default:
    
  }
}
</script>