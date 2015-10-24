<%dim i%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<title><%=title%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/tab.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript" src="../inc/js/setday.js"></script>
<!--#include file="inc/controler.asp"-->
<script type="text/javascript">
<!--
var id="",s_price,discount;//此ID在框架内所有页面共享

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
  document.form1.submit();
}

 function alt1(){//打印
 	showModalDialog('f22_mx.asp?id='+top.id,'example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
 }

function alt2(){//选发货地
  showModalDialog('selectdepot.asp?action=set&title=选择发货地&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

function alt3(){//选项收货地
  showModalDialog('selectdepot.asp?action=get&title=选择收货地&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

function alt4(){//删除
  if(trim(id)!=""){
    if(confirm("确定要删除 "+ id +" 吗?")){
      var s=<%=alt4%>;
      if(s=="r"){
        altr();
      }else if(s=="0"){
	    alert("没有此功能或者您没有此操作权限！");
	  }
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
  switch(opt){
  case "chksure":
    str="审核";
	break;
  case "unchksure":
    str="反审核";
	break;
  case "sure":
    str="登帐";
	break;
  case "unsure":
    str="反登帐";
	break;
  default:
    alert("审核登帐参数不正确！");
	return;
  } 
  showModalDialog('f22_DjOperation.asp?id='+id+'&opt='+opt+'&str='+str+'&Cfname=<%=Cfname%>&Cdname=<%=Cdname%>&Cuname=<%=Cuname%>&Dfname=<%=Dfname%>&Ddname=<%=Ddname%>&Duname=<%=Duname%>','a','dialogWidth:320px;dialogHeight:260px;dialogTop:200px;center: yes;help:no;resizable:no;status:no');
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

function alt13(){//参照
  var s=<%=alt13%>;
  if(s=="r"){
    altr();
  }else if(s=="0"){
	alert("没有此功能或者您没有此操作权限！");
  }
}

function altr(){
  is.location.reload(); 
}

function alti(){
  showModalDialog('f22cz_quota.asp?pksname=<%=session("pksname")%>','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

function altq(){
  showModalDialog('f22cz_indent.asp?pksname=<%=session("pksname")%>','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

-->
</script>
<base target="_self">
</head>
<body>
<!--工具条开始-->
<table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#EDD8D3" bgcolor="#EDD8D3" class="bar">
  <tr>
    <td height="19" valign="bottom" class="f12">业务中心 &gt;&gt; 
	<%dim ds
  set ds=server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  ds.Source = "select distinct a.menuname,a.menuid,b.menusubname,b.menusubid from web_menu a ,web_menusub b where a.menuid=b.menuid and menusubid="&session("menusubid")
  ds.open
  if not ds.eof then%>
  <%=ds("menuname")%> &gt;&gt; <span class="au"><a href="f22_index.asp?com=<%=session("com")%>&msid=<%=session("menusubid")%>"><%=ds("menusubname")%></a></span>
  <%end if
  ds.close
  set ds=nothing%>
  </td>
  </tr>
</table>
<table width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF" class="bigbar" id="toolbar">
  <tr align="center">
    <td width="7%" class="toolbar" id="tbar0" onMouseDown="mdown(this,0);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/PixadexFile.png" width="20" height="20"><br>
    查询</td>
    <td width="7%" class="toolbar" id="tbar1" onMouseDown="mdown(this,1);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/040.gif" width="16" height="16" border="0"><br>
    打印</td>
    <td width="8%" class="toolbar" id="tbar2" onMouseDown="mdown(this,2);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    选发货地</td>
    <td width="8%" class="toolbar" id="tbar3" onMouseDown="mdown(this,3);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    选收货地</td>
    <td width="8%" class="toolbar" id="tbar12" onMouseDown="mdown(this,12);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    拷贝</td>
    <!--
    <td width="66" class="toolbar" id="tbar2" onMouseDown="mdown(this,2);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    条码</td>
    <td width="66" class="toolbar" id="tbar3" onMouseDown="mdown(this,3);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    添加</td>-->
    <td width="8%" class="toolbar" id="tbar4" onMouseDown="mdown(this,4);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/132.gif" width="16" height="16" border="0"><br>
    删除</td>
    <td width="8%" class="toolbar" id="tbar5" onMouseDown="mdown(this,5);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    编辑</td>
    <td width="8%" class="toolbar" id="tbar6" onMouseDown="mdown(this,6);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    修改明细</td>
    <td width="8%" class="toolbar" id="tbar7" onMouseDown="mdown(this,7);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    审核</td>
    <td width="8%" class="toolbar" id="tbar8" onMouseDown="mdown(this,8);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    反审</td>
    <td width="8%" class="toolbar" id="tbar9" onMouseDown="mdown(this,9);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>      
    登帐</td>
    <td width="9%" class="toolbar" id="tbar10" onMouseDown="mdown(this,10);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    反登</td>
  </tr>
</table>
<!--工具条结束-->
<form name="form1" method="get" action="main.asp" target="is">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFBFF">
    <tr>
      <td width="91%"><table width="713"  border="0" cellspacing="0">
        <tr valign="middle" class="f12">
          <td width="58">查询方式:</td>
          <td width="123"><select name="stype" id="stype" style="height:18px; ">
              <option value="0">按制单日期查询</option>
              <option value="1">按登帐日期查询</option>
              <option value="2" <%if stype="2" then response.Write " selected" end if%>>按任务查询</option>
          </select></td>
          <td width="58">查询范围:</td>
          <td width="466"><input name="rq1" type="text" id="rq1" onFocus="setday(this)" value="<%=get_date(date-30)%>" size="10" maxlength="10" style="height:20px; ">
              <input name="rq2" type="text" id="rq2" size="10" maxlength="10" value="<%=get_date(date)%>" onFocus="setday(this)" style="height:20px; ">
              <input name="com" type="hidden" id="com" value="<%=request.querystring("com")%>">
              <input name="ext" type="hidden" id="ext" value="<%=request.querystring("ext")%>">
              <input name="ext" type="radio" value="0">
              所有
              <input name="ext" type="radio" value="1" checked>
              未审
              <input type="radio" name="ext" value="2">
              已审
              <input type="radio" name="ext" value="3">
              未登
              <input type="radio" name="ext" value="4">
            已登            </td>
          </tr>
      </table></td>
      <td width="9%" align="right"><%=cont%><%'=button%></td></tr>
  </table>
</form>
<iframe  name="is" src="main.asp?<%=request.ServerVariables("QUERY_STRING")%>" width="100%" height="84%" frameborder="0"></iframe>
<script language="javascript">
  list();
  try{
    <%=exts%>;
  }catch(ex){}
</script>
</body>
</html>
