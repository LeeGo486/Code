<%
Response.Buffer = True 
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
Response.AddHeader "Pragma", "No-Cache" 
%>
<%dim i%>
<!--#include file="inc/function.asp"-->
<%dim formid,src,stype,pagename

set rs=server.CreateObject("ADODB.Recordset")

rs.ActiveConnection = cn

stype=trim(request.QueryString("stype"))
pagename=request("pagename")
'formid=trim(request.QueryString("formid"))
formid=session("formid")
formid=cint(formid)
alt12=0
alt6=0
alt3="0"
select case formid
case 2019
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  session("tablename")="d_retail"
  session("pkname") = "retailid"
  session("pksname")="retail"
  src="2019_retail_search.asp"
  alt11="showModalDialog('create_retail.asp?action=create','e','dialogWidth:500px;dialogHeight:330px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('create_retail.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:330px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('create_retail.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case 2060
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  session("tablename")="d_indent"
  session("pkname") = "indentid"
  session("pksname")="indent"
  src="2060_indent_search.asp"
  alt11="showModalDialog('2060_indent_create.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('2060_indent_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('2060_indent_create.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt6="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"&opt="&session("pksname")&"&numName=nums','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  alt12="showModalDialog('djcopy.asp?djid='+id+'&oldformid="&session("formid")&"','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no')"
  Drsrc="pdj_input.asp?id='+id+'&act=indent"

case 2061
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  session("tablename")="d_indent"
  session("pkname") = "indentid"
  session("pksname")="indent"
  src="2061_indent_search.asp"
  alt11="showModalDialog('2061_indent_create.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('2061_indent_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('2061_indent_create.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt6="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"&opt="&session("pksname")&"&numName=nums','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  alt12="showModalDialog('djcopy.asp?djid='+id+'&oldformid="&session("formid")&"','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no')"
  Drsrc="pdj_input.asp?id='+id+'&act=indent"
case 2062
  Cfname="getchk_sure"
  Cdname="getchk_date"
  Cuname="getchk_name"
  Dfname="get_sure"
  Ddname="getsure_date"
  Duname="getsure_name"
  session("tablename")="d_sell"
  session("pkname") = "sellid"
  session("pksname")="sell"
  src="2062_indent_search.asp"
  alt4="0"
  alt5="0"
  alt6="0"
  alt11="0"
  alt12="0"
case 2063
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  session("tablename")="d_outindentpro"
  session("pkname") = "outindentid"
  session("pksname")="outindent"
  src="2063_outindent_search.asp"
  alt12="showModalDialog('djcopy.asp?djid='+id+'&oldformid="&session("formid")&"','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no')"
  alt11="showModalDialog('2063_outindent_create.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('2063_outindent_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('2063_outindent_create.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt6="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"&opt=outindentPRO&numName=nums','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  Drsrc="pdj_input.asp?id='+id+'&act=outindentpro"
case 2163
  Cfname="sq_tjsure"
  Cdname="sq_tjdate"
  Cuname="sq_tjname"
	
  Dfname="sq_spsure"
  Ddname="sq_spdate"
  Duname="sq_spname"
	
  session("tablename")="d_outindentsq"
  session("pkname") = "outindentsqid"
  session("pksname")="outindentsq"
  src="2163_outindent_search.asp"
  alt12="showModalDialog('djcopy.asp?djid='+id+'&oldformid="&session("formid")&"','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no')"
  alt11="showModalDialog('2163_outindent_create.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('2163_outindent_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('2163_outindent_create.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt6="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"&opt=outindentsq&numName=sq_tjnums','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"

case 2065,2165
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  session("tablename")="d_outindentset"
  session("pkname") = "outindentid"
  session("pksname")="outindent"
  src="2065_outindentset_search.asp"
  alt11="showModalDialog('2065_outindentset_create.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('2065_outindentset_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('2065_outindentset_create.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt6="showModalDialog('f22_main.asp?id='+id+'&pksname=outindent&opt=outindentset&numName=nums','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  alt12="showModalDialog('djcopy.asp?djid='+id+'&oldformid="&session("formid")&"','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no')"
  Drsrc="pdj_input.asp?id='+id+'&act=outindentset"
case 2066
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  session("tablename")="d_inventory"
  session("pkname") = "inventoryid"
  session("pksname")="inventory"
  src="2066_inventory_search.asp"
  alt11="showModalDialog('2066_inventory_create.asp?action=create','e','dialogWidth:500px;dialogHeight:280px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('2066_inventory_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:280px;center: yes;help:no;resizable:yes;status:no')"
  alt3="showModalDialog('2066_inventory_create.asp?id='+arryid+'&action=delmany','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('2066_inventory_create.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt6="showModalDialog('f22_main.asp?id='+id+'&pksname=inventory&opt=inventory&numName=nums','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  alt12="showModalDialog('djcopy.asp?djid='+id+'&oldformid="&session("formid")&"','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no')"
  Drsrc="pdj_input.asp?id='+id+'&act=inventory"
case 2166
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  session("tablename")="d_inventory"
  session("pkname") = "inventoryid"
  session("pksname")="inventory"
  src="2166_inventory_search.asp"
  alt11="showModalDialog('2166_inventory_create.asp?action=create','e','dialogWidth:500px;dialogHeight:280px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('2166_inventory_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:280px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('2166_inventory_create.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt6="showModalDialog('f22_main.asp?id='+id+'&pksname=inventory&opt=inventory&numName=d_nums','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  alt12="showModalDialog('djcopy.asp?djid='+id+'&oldformid="&session("formid")&"','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no')"
  Drsrc="pdj_input.asp?id='+id+'&act=inventory"
case 2067
  Cfname="setchk_sure"
  Cdname="setchk_date"
  Cuname="setchk_name"
  Dfname="set_sure"
  Ddname="setsure_date"
  Duname="setsure_name"
  session("tablename")="d_move"
  session("pkname") = "moveid"
  session("pksname")="move"
  src="2067_move_search.asp"
  alt11="showModalDialog('2067_move_create.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('2067_move_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('2067_move_create.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt6="showModalDialog('f22_main.asp?id='+id+'&pksname=move&opt=move&numName=set_nums','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  alt12="showModalDialog('djcopy.asp?djid='+id+'&oldformid="&session("formid")&"','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no')"
  Drsrc="pdj_input.asp?id='+id+'&act=move"
case 2068
  Cfname="getchk_sure"
  Cdname="getchk_date"
  Cuname="getchk_name"
  Dfname="get_sure"
  Ddname="getsure_date"
  Duname="getsure_name"
  session("tablename")="d_move"
  session("pkname") = "moveid"
  session("pksname")="move"
  src="2068_move_search.asp"
  alt11="showModalDialog('create_move.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('create_move.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('create_move.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt12="showModalDialog('djcopy.asp?djid='+id+'&oldformid="&session("formid")&"','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no')"
  alt5="0"
  alt6="0"
case 2069
  Cfname="getchk_sure"
  Cdname="getchk_date"
  Cuname="getchk_name"
  Dfname="get_sure"
  Ddname="getsure_date"
  Duname="getsure_name"
  session("tablename")="d_msell"
  session("pkname") = "msellid"
  session("pksname")="msell"
  src="2069_msellget_search.asp"
  
  alt4="0"
  alt5="0"
  alt6="0"
  alt11="0"
  alt12="0"
case 2071
  Cfname="setchk_sure"
  Cdname="setchk_date"
  Cuname="setchk_name"
  Dfname="set_sure"
  Ddname="setsure_date"
  Duname="setsure_name"
  session("tablename")="d_msell"
  session("pkname") = "msellid"
  session("pksname")="msell"
  src="2071_msell_search.asp"
  alt11="showModalDialog('2071_msell_create.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('2071_msell_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('2071_msell_create.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt6="showModalDialog('f22_main.asp?id='+id+'&pksname=msell&opt=msell&numName=set_nums','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  alt12="showModalDialog('djcopy.asp?djid='+id+'&oldformid="&session("formid")&"','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no')"
  Drsrc="pdj_input.asp?id='+id+'&act=msell"
case 2072
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  session("tablename")="d_inventory"
  session("pkname") = "inventoryid"
  session("pksname")="inventory"
  src="2072_inventory_search.asp"
  alt11="showModalDialog('2066_inventory_create.asp?action=create','e','dialogWidth:500px;dialogHeight:280px;center: yes;help:no;resizable:yes;status:no')"
  alt5="showModalDialog('2066_inventory_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:280px;center: yes;help:no;resizable:yes;status:no')"
  alt4="showModalDialog('2066_inventory_create.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  alt6="showModalDialog('f22_main.asp?id='+id+'&pksname=inventory&opt=inventory&numName=nums','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  alt12="showModalDialog('djcopy.asp?djid='+id+'&oldformid="&session("formid")&"','e','dialogWidth:765px;dialogHeight:405px;center: yes;help:no;resizable:yes;status:no')"
  
end select


sub getemployee(oldvalue)
 rs.source="SELECT a.names FROM j_employee a  left join jk_group b on a.groupid=b.groupid "&_ 
			"WHERE isnull(a.valid,0)=0 and isnull(a.usedstatus,0)>0 and a.depotid="&qts(session("dm").System_depotid)
 rs.open
do while not rs.eof
response.write"<option value="&rs(0)
'if rs(0)=oldvalue then response.Write" selected " end if
 response.Write" selected " 
response.write">"
response.write rs(0)
response.write"</option>"
rs.movenext
loop
rs.close
end sub

sub getcrname(oldvalue)
 rs.source="select username from J_user where depotid="&qts(session("dm").System_depotid)
 rs.open
do while not rs.eof
response.write"<option value="&rs(0)
 response.Write" selected " 
response.write">"
response.write rs(0)
response.write"</option>"
rs.movenext
loop
rs.close
end sub



%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/tab.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript">
<!--
var id="",tzid="",s_price,discount,arryid;//此ID在框架内所有页面共享

function exit(){
  //此处应添加判断是否保存代码
  top.id="";
  window.close();
}
 
function toolbar(t,i){
  switch(i){
  case 0: //重置
    break;
  case 1: //显示
    t.className="toolbar";
	break;
  case 2: //隐藏
    t.className="toolbarhide";
    break;
  case 3: //变灰
    t.className="toolbargray";
	break;
  }
}

function mover(t){//鼠标悬停
  if(t.className!="toolbargray")
    t.className="toolbarmover";
}
function mout(t){//鼠标离开
  if(t.className!="toolbargray"){
    t.className="toolbar";
  }
}

function mdown(t,i){//鼠标按下,工具条调用功能模块
 if(t.className!="toolbargray"){
  t.className="toolbarmdown";
  switch(i){
  case 0://查询
    alt0();break;
  case 1: //打印
    alt1();break;
  case 2: //选发货地
    alt2();break;
  case 3: //选收货地
    alt3();break;
  case 4: //删除
    alt4();break;
  case 5:  //编辑
    alt5();break;
  case 6:  //编辑子单
    alt6();break;
  case 7: //审核
    alt7();break;
  case 8: //反审核
    alt8(); break;
  case 9: //登帐
    alt9();break;
  case 10: //反登帐
    alt10();break;
  case 11: //退出
    exit();break;
  case 12:
    alt12();break;
  }
 }
}

function list(){//工具条浏览状态
  var i;
  for(i=4;i<11;i++){
    eval("tbar"+i+".className='toolbargray'");	
  }
}

function edit(){//工具条编辑状态
  var i;
  for(i=4;i<11;i++){
    if(!(i==4 || i==5 || i==6 || i==7))
      eval("tbar"+i+".className='toolbargray'");
	else
	  eval("tbar"+i+".className='toolbar'");
  }
}

function changescan(tzid){
	var t=document.all.btnscan;
	if (tzid.length<5){
		t.setAttribute("value","条码扫描");
	} else {
   	    t.setAttribute("value","捡货扫描");	
	}	
}

function chksured(){//已审核单,工具条状态
  var i;
  for(i=2;i<11;i++){
    if((i==4 || i==5 || i==6 || i==7))
      eval("tbar"+i+".className='toolbargray'");
	else
	  eval("tbar"+i+".className='toolbar'");
  }
}

function sured(){//已登帐单,工具条状态
  var i;
  for(i=2;i<11;i++){
    if((i==4 || i==5 || i==6 || i==7 || i==8 || i==9))
      eval("tbar"+i+".className='toolbargray'");
	else
	  eval("tbar"+i+".className='toolbar'");
  }
}

function alt0(){//查询
  
  document.all.form1.ExportExcel.value=0;
  var pagename='<%=pagename%>';
  if (pagename=='捡货扫描'){ document.all.form1.jh.value=1;}
  if (<%=formid%>==2019 )
  {
     if (document.all.form1.idorsn.value==1)
     {
      document.all.form1.seachid.value= document.all.form1.crname.value;
	 }
  }

  document.form1.submit();
}

 function alt1(){//打印
 	showModalDialog('f22_mx.asp?id='+id,'example04','dialogWidth:100;dialogHeight:100;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
 }

function alt2(){//选发货地
  showModalDialog('selectdepot.asp?action=set&title=<%=server.URLEncode("选择发货地")%>&pksname=<%=pksname%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

function alt3(){//选项收货地
  showModalDialog('selectdepot.asp?action=get&title=<%=server.URLEncode("选择收货地")%>&pksname=<%=pksname%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

function alt4(){//删除
  if(<%=formid%>==2019){alert('零售单不允许操作！');return;}
  if(trim(id)!=""){
    if(confirm("确定要删除 "+ id +" 吗?")){
      var s=<%=alt4%>;
	  altr();
	  /*
      if(s=="r"){
        altr();
      }else if(s=="0"){
	    alert("没有此功能或者您没有此操作权限！");
	  }*/
	}
  }else{
    alert("请先选择单据!");
  }
}

function alt5(){//修改
  if(trim(id)!=""){
    var s=<%=alt5%>;
    if(s=="r"){
      altr();
    }else if(s=="0"){
	  alert("没有此功能或者您没有此操作权限！");
	}
  }else{
    alert("请先选择单据!");
  }
}

function alt6(){//编辑明细
  if(trim(id)!=""){
    var s=<%=alt6%>;
    if(s=="0"){
	  alert("没有此功能或者您没有此操作权限！");
	}
  }else{
    alert("请先选择单据!");
  }
}

function chksure(opt){
  if(id==""){
    alert("请先选择单据！");
	return;
  }
  if(<%=formid%>==2019){alert('零售单不允许操作！');return;}
  switch(opt){
  case "chksure":
    str="<%=server.URLEncode("审核")%>";
	break;
  case "unchksure":
    str="<%=server.URLEncode("反审核")%>";
	break;
  case "sure":
    str="<%=server.URLEncode("登帐")%>";
	break;
  case "unsure":
    str="<%=server.URLEncode("反登帐")%>";
	break;
  default:
    alert("审核登帐参数不正确！");
	return;
  } 
  
  //判断店铺库存为0不可以发货开关
  var  setkc0="<%=session("setkc0")%>";
  var  setkcyj="<%=session("setkcyj")%>";
   
  if (opt=="chksure"&&(setkc0=='True'&&setkcyj!=0))
  {
    // if (setkcyj==2)//不允许出库
	 //{
	   	var r=showModalDialog('F22_tipinfo.asp?id='+id,'a','dialogWidth:400px;dialogHeight:370px;dialogTop:200px;center: yes;help:no;resizable:no;status:no');
		
		if (r!=0)
		{
			window.returnValue=false;
		    return  ;
		}
	     
	 //}
  }
  
 
  showModalDialog('f22_DjOperation.asp?id='+id+'&opt='+opt+'&str='+str+'&Cfname=<%=Cfname%>&Cdname=<%=Cdname%>&Cuname=<%=Cuname%>&Dfname=<%=Dfname%>&Ddname=<%=Ddname%>&Duname=<%=Duname%>','a','dialogWidth:320px;dialogHeight:260px;dialogTop:200px;center: yes;help:no;resizable:no;status:no');
  alt0();
}

function alt7(){ //审核
  chksure('chksure'); 
}

function alt8(){  //反审核
  chksure('unchksure'); 
}

function alt9(){  //登帐
  chksure('sure');
}

function alt10(){  //反登帐
  chksure('unsure');
}
	
function alt11(){//添加
  var s=<%=alt11%>;
  if(s=="r"){
    altr();
  }else if(s=="0"){
	alert("没有此功能或者您没有此操作权限！");
  }
}

function alt12(){//复制
  if(trim(id)==""){
    alert("请先选择单据，才能复制!");
  }else{
    var s=<%=alt12%>;
    if(s=="r"){
      altr();
    }else if(s=="0"){
	  alert("没有此功能或者您没有此操作权限！");
    }
  }
}

function altr(){
  alt0(); 
}

function alti(){
  showModalDialog('f22cz_quota.asp?pksname=<%=pksname%>','example04','dialogWidth:100;dialogHeight:100;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

function altq(){
  showModalDialog('f22cz_indent.asp?pksname=<%=pksname%>','example04','dialogWidth:100;dialogHeight:100;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

function dr(){
if (trim(id)!="")
{
showModalDialog('<%=Drsrc%>','example04','dialogWidth:400px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
//window.open('<%=Drsrc%>','example04','width=400,height=400');
}
else
{alert("请先选择单据!");}
}


//在屏幕中央弹出模态窗口
function openModelWindowNOScroll(width,height,url){
    var d = new Date;
    if(url.lastIndexOf("?")==-1){
        url = url+"?currTime="+d.getTime();
    }else{
        url = url+"&currTime="+d.getTime();
    }
    window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;center:Yes;Help:No;Resizable:No;Scroll:No;Status:no;");    
}

function delmany()
{
   var eless = document.getElementsByName("ext");
   for(var i=0;i<eless.length;i++)
    {
      if(eless[i].checked)
      {
       selectid=eless[i].value;
       break;
      }
    }
  if (selectid!=1)
  {
    alert("未审核的单据才能进行批量删除!");   
    return;
  }
  mdown(this,0);
  var seltype = document.getElementById("stype");
  var selrq1=document.getElementById("rq1");
  var selrq2=document.getElementById("rq2");
  openModelWindowNOScroll(700, 500, '2066_inventory_search_select.aspx?id='+id+'&depotid='+'<%=(session("dm").System_depotid)%>'+'&stype='+seltype.value+
                  '&rq1='+selrq1.value+'&rq2='+selrq2.value+"&date="+'<%=get_date(date)%>');
  
//  showModalDialog('2066_inventory_search_select.aspx?id='+id+'&depotid='+'<%=(session("dm").System_depotid)%>'+'&stype='+seltype.value+
//                  '&rq1='+selrq1.value+'&rq2='+selrq2.value,'e','dialogWidth:650px;dialogHeight:650px;center: yes;help:no;resizable:yes;status:no');
   mdown(this,0);
}

function showcy(){
if (trim(id)!="")
{showModalDialog('2066_inventory_cy_mx.asp?id='+id,'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');}
else
{alert("请先选择单据!");}
}


function thsums(i){
var tbname="d_outindentprosub"; 
if (trim(id)!="")
{ 
  if (i==2065)
  {
  	tbname="d_outindentchksub";
  }
 
  showModalDialog('../../../b28web/Report/report_thsums.aspx?id='+id+'&tbname='+tbname,'e','dialogWidth:890px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');}
else
{alert("请先选择单据!");}
}


function barCode(i){
  if(trim(id)!=""){ 
        if (tzid.length<5){
  			window.location.href="F22_barcode.asp?id="+id+"&typeid="+i;
		}else{
            i=2067000;
			window.location.href="F22_barcode.asp?id="+id+"&typeid="+i;
		}		
  }else{
     alert("请先选择单据!");
  }
   /*
  if(trim(id)!=""){
    switch(i){
	case 2061:
      window.location.href="ajax/2061_indent.asp?id="+id;
	  break;
	case 2062:
      window.location.href="ajax/2062_getsell.asp?id="+id;
	  break;
	case 2063:
      window.location.href="ajax/2063_outindent.asp?id="+id;
	  break;
	case 2163:
      window.location.href="2163_outindent_barcode.asp?id="+id;
	  break;
	case 2065:
      window.location.href="ajax/2065_outindent.asp?id="+id;
	  break;  
	case 2066:
	  window.location.href="ajax/2066_inventory.asp?id="+id;
	  break;
	case 2166:
	  window.location.href="ajax/2166_inventory.asp?id="+id;
	  break;
	case 2067:
     // window.location.href="ajax/2067_move.asp?id="+id;
	  window.location.href="F22_barcode.asp?id="+id+"&typeid="+i;
	  break;
	case 2068:
      window.location.href="ajax/2068_move.asp?id="+id;
	  break;
	case 2069:
      window.location.href="ajax/2069_msellget.asp?id="+id;
	  break;
	case 2071:
	  window.location.href="ajax/2071_msell.asp?id="+id;
	  break;
	case 2072:
	  window.location.href="ajax/2072_inventory.asp?id="+id;
	}
  }else{
    alert("请先选择单据!");
  }
  */
}
//同区调拨发货捡货扫描
function barCodebySet(i){
  i=2067000;
  if(trim(id)!=""){ window.location.href="F22_barcode.asp?id="+id+"&typeid="+i;
  }else{
     alert("请先选择单据!");
  }
} 
function c1(){
  var m;
  if(trim(id)!=""){
  m=window.confirm("真的要生成盘点差异吗?生成盘点差异后,相同的款号将被合并!","bbb","ccc");
  if(m==true){
    showModalDialog('2066_inventory_create_cy.asp?id='+id,'e','dialogWidth:400px;dialogHeight:200px;center: yes;help:no;resizable:yes;status:no');
	alt0();
  }
 }else{
  alert("请先选择单据!"); 
 } 
}

function drnotice(){
  var m;
  if(trim(id)!=""){
  m=window.confirm("真的要读入通知单明细吗?读入会将原单明细覆盖!","bbb","ccc");
  if(m==true){
    showModalDialog('2071_GetNoticesub.asp?id='+id,'e','dialogWidth:400px;dialogHeight:200px;center: yes;help:no;resizable:yes;status:no');
	alt0();
  }
 }else{
  alert("请先选择单据!"); 
 } 
}

function createfh(formid){
  if(trim(id)!="")
    {var m=window.confirm("确定要根据收货差异生成发货吗!","bbb","ccc");
	 if(m==true)
	   {showModalDialog('Create_Cyfh.asp?formid='+formid+'&id='+id,'e','dialogWidth:400px;dialogHeight:200px;center: yes;help:no;resizable:yes;status:no');}
	}
  else
    {alert("请先选择单据!"); }
}

function seeshcy(formid){
  if(trim(id)!="")
    {showModalDialog('See_ShCy.asp?formid='+formid+'&id='+id,'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
	}
  else
    {alert("请先选择单据!"); }
}

function changetype(typeid)
{
  if (<%=formid%>==2019 )
  {
  
	  if (typeid==1)
 	 {
  	   document.getElementById("divcrname").style.display='';
		 document.getElementById("divNormal").style.display='none';
	 
  	 }
  	else
  	{
   	 document.getElementById("divcrname").style.display='none';
		document.getElementById("divNormal").style.display='';
		document.all.form1.seachid.value='';
    
 	 }
  }
}

function selectStyle(formid){
if (trim(id)!=""){
  var m=showModalDialog('report/select1.asp?formid='+formid+'&id='+id,'example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
/*  if(m!="0" && typeof(m)!='undefined'){
     if(formid==2066){showModalDialog('AddStyleToDj.asp?formid='+formid+'&id='+id,'e','dialogWidth:400px;dialogHeight:200px;center: yes;help:no;resizable:yes;status:no');}
    }*/
}else{alert("请先选择单据!"); }
}
-->
</script>
<base target="_self">
</head>
<body>
<!--工具条开始-->
<table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#EDD8D3" bgcolor="#EDD8D3" class="bar">
  <tr>
    <td height="19" valign="bottom" class="f12">业务操作 &gt;&gt; <%=request("pagename")%>
  </td>
  </tr>
</table>
<table width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF" class="bigbar" id="toolbar">
  <tr align="center">
    <td width="7%" class="toolbar" id="tbar0" onMouseDown="mdown(this,0);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/016.gif" width="16" height="16"><br>
    查询</td>
    <td width="7%" class="toolbar" id="tbar1" onMouseDown="mdown(this,1);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/040.gif" width="16" height="16" border="0"><br>
    打印</td>
	<!--
    <td width="8%" class="toolbar" id="tbar2" onMouseDown="mdown(this,2);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    选发货地</td>
    <td width="8%" class="toolbar" id="tbar3" onMouseDown="mdown(this,3);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    选收货地</td>-->
	<td id="tbar1"></td>
	<td id="tbar2"></td>
	<td id="tbar3"></td>
	<%if padd  then%>
	<td width="8%" class="toolbar" id="tbar12" onMouseDown="mdown(this,12);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    拷贝</td>
	<%else%>
	<td width="8%" class="toolbar" id="tbar12" ><img src="img/toolbar/0041.gif" width="16" height="16" border="0"><br>
    拷贝</td>
	<%end if%>
    <!--
    <td width="66" class="toolbar" id="tbar2" onMouseDown="mdown(this,2);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    条码</td>
    <td width="66" class="toolbar" id="tbar3" onMouseDown="mdown(this,3);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    添加</td>-->
    <%if pdel  then%>
	<td width="8%" class="toolbar" id="tbar4" onMouseDown="mdown(this,4);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/132.gif" width="16" height="16" border="0"><br>
    删除</td>
	<%else%>
	<td width="8%" class="toolbar" id="tbar4" ><img src="img/toolbar/1321.gif" width="16" height="16" border="0"><br>
	删除</td>
	<%end if%>
	<%if pedit then%>
    <td width="8%" class="toolbar" id="tbar5" onMouseDown="mdown(this,5);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    编辑</td>
    <td width="8%" class="toolbar" id="tbar6" onMouseDown="mdown(this,6);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    修改明细</td>
	<%else%>
	<td width="8%" class="toolbar" id="tbar5" ><img src="img/toolbar/0041.gif" width="16" height="16" border="0"><br>
    编辑</td>
	<td width="8%" class="toolbar" id="tbar6" ><img src="img/toolbar/0041.gif" width="16" height="16" border="0"><br>
    修改明细</td>
	<%end if%>
	<%if pchk then%>
    <td width="8%" class="toolbar" id="tbar7" onMouseDown="mdown(this,7);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    <%if formid=2163 then%>提交<%else%>审核<%end if%></td>
	<%else%>
	<td width="8%" class="toolbar" id="tbar7" ><img src="img/toolbar/0041.gif" width="16" height="16" border="0"><br>
    <%if formid=2163 then%>提交<%else%>审核<%end if%></td>
	<%end if%>
<%if formid<>2163 then%>
	<%if punchk then%>
    <td width="8%" class="toolbar" id="tbar8" onMouseDown="mdown(this,8);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    反审</td>
	<%else%>
	<td width="8%" class="toolbar" id="tbar8" ><img src="img/toolbar/0041.gif" width="16" height="16" border="0"><br>
    反审</td>
	<%end if%>
	<%if psure then%>
    <td width="8%" class="toolbar" id="tbar9" onMouseDown="mdown(this,9);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>      
    登帐</td>
	<%else%>
	<td width="8%" class="toolbar" id="tbar9" ><img src="img/toolbar/0041.gif" width="16" height="16" border="0"><br>      
    登帐</td>
	<%end if%>
    <%if punsure then%>
	<td width="9%" class="toolbar" id="tbar10" onMouseDown="mdown(this,10);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    反登</td>
	<%else%>
	<td width="9%" class="toolbar" id="tbar10" ><img src="img/toolbar/0041.gif" width="16" height="16" border="0"><br>
    反登</td>
	<%end if%>
<%else%>
	<td width="9%" class="toolbar" id="tbar8" ></td>
	<td width="9%" class="toolbar" id="tbar9" ></td>
	<td width="9%" class="toolbar" id="tbar10" ></td>
<%end if%>
  </tr>
</table>
<!--工具条结束-->
<form name="form1" method="get" action="<%=src%>" target="is" id="form1" >
<input type="hidden" value="0" name="ExportExcel" id="ExportExcel" />
<input type="hidden" value="0" name="jh" id="jh" />
  <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFBFF" class="f12">
    <tr>
      <td colspan="2">
	      <select name="stype" id="stype" style="height:18px; ">
		  <%if  formid=2019 then%>
	      <option value="1">登帐日期</option>
          <option value="0">制单日期</option>
		  <%else%>
		  <option value="0">制单日期</option>
		  <option value="1">登帐日期</option>
		   <%end if%>
		  </select> 
            日期:
              <input name="rq1" type="text" id="rq1" onFocus="setday(this)" value="<%=get_date(date)%>" size="9" maxlength="10" style="height:20px; ">
              <input name="rq2" type="text" id="rq2" size="9" maxlength="10" value="<%=get_date(date)%>" onFocus="setday(this)" style="height:20px; ">
              
              
        <label><input name="ext" type="radio" value="0" 
			  <%if formid=2163 then%>checked<%end if%> onClick="mdown(document.all.tbar0,0)">所有单据</label>
        <label><input name="ext" type="radio" value="1" onClick="mdown(document.all.tbar0,0)">
        <%if formid=2163 then%>已提交<%else%>未审核<%end if%></label>
			  <label><input type="radio" name="ext" value="2" onClick="mdown(document.all.tbar0,0)">
				<%if formid=2163 then%>已审批未回复<%else%>已审核未登帐<%end if%></label>
        <label><input type="radio" name="ext" value="4" onClick="mdown(document.all.tbar0,0)" 
																														<%if formid<>2163 and formid<>2019 then%>checked<%end if%>> 
        <%if formid=2163 then%>未回复<%else%>未登帐<%end if%></label>
        <label><input type="radio" name="ext" value="3" onClick="mdown(document.all.tbar0,0)"
																														<%if formid=2019 then%>checked<%end if%>>
        <%if formid=2163 then%>已回复<%else%>已登帐<%end if%></label>
		
		<%if formid=2071 then%>
		<label><input type="radio" name="ext" value="5" onClick="mdown(document.all.tbar0,0)">
		未收货记录</label>
		<%end if%>
	  
	  <input name="formid" type="hidden" id="formid" value="<%=formid%>">
	  
	  </td>
	  </tr>
	  <tr><td>
	   	<div style=" float:left">
      		<select name="idorsn" id="idorsn" onChange="changetype(this.value);" style="height:18px; ">
        	 <option value="0">按单号查询</option><option value="1">操作员</option> <%if formid=2019 then%><option value="2">营业员</option><% end if %>
			 </select> 
		</div>
	   	<div <% if typ<>"1"   then %>style=" float:left;display:''" <%else %>style=" float:left;display:none" <%end if%> id="divNormal" ><input type="text" name="seachid" size="25">
        </div>
	    
		<div id="divcrname" name="divcrname"  <% if typ="1"  then %>style=" float:left;display:''" <%else %>style=" float:left;display:none" <%end if%>>
	  <select name="crname" id="crname" class="2014">
      <option></option>
       <% getcrname ""%>
       </select>
	   </div>
	   &nbsp;
      <% if  formid=2019  then
     response.write"商场活动：<select name='ActPlanID' style='width:150px;'><option value='全部'>全部</option>"
      
      set ds=server.CreateObject("ADODB.Recordset")
        ds.ActiveConnection = cn
       ds.source=" SELECT ActPlanID,PlanTitle FROM D_MarketActPlan  "&_
                  " WHERE Depotid="&qts(session("dm").System_depotid)&" AND Sure>0 "
       ds.open
        do while not ds.eof
        response.write"<option value="&ds("ActPlanID")
        response.write">"
        response.write ds("PlanTitle")
        response.write"</option>"
        ds.movenext
        loop
        ds.close
        set ds = nothing
     response.write"</select>"

      end if %>
	   <span id="retailidText"></span>
    </td>
	  <td align="right">
  		<%if pprint and formid=2019 then%>
	      <input type="button" name="" style="width:65px" value="重打小票" onClick="openPrintForm()"
        <%if session("xpname")="" then%>disabled="disabled" title="未设置打印小票格式"<%end if%>  />
        <script type="text/javascript">
        function openPrintForm()
				{
					<%
					url = "../../../"
					xpname = session("xpname")
					if instr(lcase(xpname),".aspx") >0 then
						url =url& "b28web/ajax/print/" &xpname
					else
						url =url& "pos/pos/f22/" &xpname
					end if
					%>
//					if(printfile.split('.')[1]=="aspx") printfile="pos_print_"+printfile.split('.')[0]+".asp"
					var id = document.getElementById("retailidText").innerHTML;
					if(id){
						//alert('<%=url%>?id='+id)
						//showModalDialog(printfile+'?id='+id,window,'dialogWidth:300px;dialogHeight:400px;')
						window.open ('<%=url%>?id='+id, 'newwindow', 'height=520, width=650, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=n o, status=no');
             //           wnd.location=printfile+'?id='+id;
                    }
					else{ 
						alert('请选择单据！');
                    }
 				}
        </script>
			<%end if%>
  		<%if pexport and formid=2019 then%>
        <iframe id="frame1" style="display:none"></iframe> 
		<!--
	      <input type="button" name="" style="width:105 px " value="导出当天销售数据" 
          title="嘉信茂广场POS系统接口专用" onClick="go('annil_retail_output.asp');" />
	      <input type="button" name="" style="width:90 px " value="按指定日期导出"
           title="嘉信茂广场POS系统接口专用" onClick="go('annil_retail_output.asp?begdate='+document.getElementById('rq1').value+'&enddate='+document.getElementById('rq2').value);" /> -->
		   
		    <input type="button" name="" style="width:105 px " value="导出到EXCEL" 
          title="" onClick="document.all.form1.ExportExcel.value=1;document.form1.submit();" />
		   
			<script> 
            var n=0; 
            function go(url){ 
			<%
			if request.Cookies("dpthelp") = "" then 
				response.write "alert('该功能需要设置助记码才能使用!');return;"
			end if
			%>
            n==0?new function() 
            { 
            frames("frame1").location=url,n=1 
            }:null; 
            document.getElementById("frame1").readyState!="complete"?setTimeout(go,10):so(); 
            
            function so() 
            { 
            frames("frame1").document.execCommand("SaveAs"),n=0 
            }; 
            } 
            </script> 
	  <%end if%>
    
	<%if padd then%>
  
	  <%if formid=2062 or formid=2068 or formid=2069 then%>
        <input type="button" id="btnscan" name="btnscan" style="width:65 px " value="条码扫描" onClick="barCode(<%=formid%>);">
        <input type="button" name="" style="width:140 px " value="根据收货差异生成发货" onClick="createfh(<%=formid%>);">
	  <%end if%>
    
		<%if formid=2071 then%>
      <input type="button" name="" style="width:85 px " value="读入通知明细" onClick="drnotice();">
    <%end if%>
    
		<%if formid=2066 then%>
      <input type="button" name="btndelmany" style="width:70 px " value="批量删除" onClick="delmany();">
		<%end if %>
		
		<%if formid=2060 or formid=2061 or formid=2063 or formid=2065 or formid=2066 or formid=2067  or formid=2071 then %>
      <input type="button" name="" style="width:80 px " value="文本导入" onClick="dr();">
	  <%end if%>
    
		<%if  formid=2063  then %>
		  <input type="button" name="" style="width:80 px " value="查看退货情况" onClick="thsums(<%=formid%>);">
		<%end if%>
		
		<%if formid=2060 or formid=2061 or formid=2063 or formid=2163 or formid=2065 or (formid=2067 and pagename<>"捡货扫描") or formid=2071 then %>
		  <input type="button" id="btnscan" name="btnscan" style="width:65 px " value="条码扫描" onClick="barCode(<%=formid%>);">
		<%end if%>
	
	        
        <%if formid=2066 or formid=2072 then %>
        <input type="button" name="" style="width:65 px " value="选款读入" onClick="javascript:selectStyle(<%=formid%>);">
        <%end if%>
        
		<%if formid=2166 or formid=2066 or formid=2072 then  %>
        <input type="button" id="btnscan" name="btnscan" style="width:65 px " value="条码扫描" onClick="barCode(<%=formid%>);">
        <%end if%>
        
        <%if formid=2066 then %>
        <input type="button" name="" style="width:65 px " value="生成差异" onClick="c1();">
        <%end if%>
        
	<%end if%>
  
  
	  <%if formid=2062 or formid=2068 or formid=2069 then%>
        <input type="button" name="" style="width:100px" value="查看收货差异" onClick="seeshcy(<%=formid%>);">
	  <%end if%>
		<%if formid=2066 then %>
      <input type="button" name="" style="width:65 px " value="查看差异" onClick="showcy();">
    <%end if%>
  
    </td></tr>
  </table>
</form>
<iframe  name="is" src="about:blank" width="100%" height="81%" frameborder="0"></iframe>
<script type="text/javascript">alt0()</script>
</body>
</html>
