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
var id="",s_price,discount;//��ID�ڿ��������ҳ�湲��

function exit(){
  //�˴�Ӧ����ж��Ƿ񱣴����
  top.id="";
  window.close();
}
 
function toolbar(t,i){
  switch(i){
  case 0: //����
    break;
  case 1: //��ʾ
    t.className="toolbar";
	break;
  case 2: //����
    t.className="toolbarhide";
    break;
  case 3: //���
    t.className="toolbargray";
	break;
  }
}

function mover(t){//�����ͣ
  if(t.className!="toolbargray")
    t.className="toolbarmover";
}
function mout(t){//����뿪
  if(t.className!="toolbargray"){
    t.className="toolbar";
  }
}

function mdown(t,i){//��갴��,���������ù���ģ��
 if(t.className!="toolbargray"){
  t.className="toolbarmdown";
  switch(i){
  case 0://��ѯ
    alt0();break;
  case 1: //��ӡ
    alt1();break;
  case 2: //ѡ������
    alt2();break;
  case 3: //ѡ�ջ���
    alt3();break;
  case 4: //ɾ��
    alt4();break;
  case 5:  //�༭
    alt5();break;
  case 6:  //�༭�ӵ�
    alt6();break;
  case 7: //���
    alt7();break;
  case 8: //�����
    alt8(); break;
  case 9: //����
    alt9();break;
  case 10: //������
    alt10();break;
  case 11: //�˳�
    exit();break;
  case 12:
    alt12();break;
  }
 }
}

function list(){//���������״̬
  var i;
  for(i=4;i<11;i++){
    eval("tbar"+i+".className='toolbargray'");	
  }
}

function edit(){//�������༭״̬
  var i;
  for(i=4;i<11;i++){
    if(!(i==4 || i==5 || i==6 || i==7))
      eval("tbar"+i+".className='toolbargray'");
	else
	  eval("tbar"+i+".className='toolbar'");
  }
}

function chksured(){//����˵�,������״̬
  var i;
  for(i=2;i<11;i++){
    if((i==4 || i==5 || i==6 || i==7))
      eval("tbar"+i+".className='toolbargray'");
	else
	  eval("tbar"+i+".className='toolbar'");
  }
}

function sured(){//�ѵ��ʵ�,������״̬
  var i;
  for(i=2;i<11;i++){
    if((i==4 || i==5 || i==6 || i==7 || i==8 || i==9))
      eval("tbar"+i+".className='toolbargray'");
	else
	  eval("tbar"+i+".className='toolbar'");
  }
}

function alt0(){//��ѯ
  document.form1.submit();
}

 function alt1(){//��ӡ
 	showModalDialog('f22_mx.asp?id='+top.id,'example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
 }

function alt2(){//ѡ������
  showModalDialog('selectdepot.asp?action=set&title=ѡ�񷢻���&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

function alt3(){//ѡ���ջ���
  showModalDialog('selectdepot.asp?action=get&title=ѡ���ջ���&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

function alt4(){//ɾ��
  if(trim(id)!=""){
    if(confirm("ȷ��Ҫɾ�� "+ id +" ��?")){
      var s=<%=alt4%>;
      if(s=="r"){
        altr();
      }else if(s=="0"){
	    alert("û�д˹��ܻ�����û�д˲���Ȩ�ޣ�");
	  }
	}
  }else{
    alert("����ѡ�񵥾�!");
  }
}

function alt5(){//�޸�
  if(trim(id)!=""){
    var s=<%=alt5%>;
    if(s=="r"){
      altr();
    }else if(s=="0"){
	  alert("û�д˹��ܻ�����û�д˲���Ȩ�ޣ�");
	}
  }else{
    alert("����ѡ�񵥾�!");
  }
}

function alt6(){//�༭��ϸ
  if(trim(id)!=""){
    var s=<%=alt6%>;
    if(s=="0"){
	  alert("û�д˹��ܻ�����û�д˲���Ȩ�ޣ�");
	}
  }else{
    alert("����ѡ�񵥾�!");
  }
}

function chksure(opt){
  if(id==""){
    alert("����ѡ�񵥾ݣ�");
	return;
  }
  switch(opt){
  case "chksure":
    str="���";
	break;
  case "unchksure":
    str="�����";
	break;
  case "sure":
    str="����";
	break;
  case "unsure":
    str="������";
	break;
  default:
    alert("��˵��ʲ�������ȷ��");
	return;
  } 
  showModalDialog('f22_DjOperation.asp?id='+id+'&opt='+opt+'&str='+str+'&Cfname=<%=Cfname%>&Cdname=<%=Cdname%>&Cuname=<%=Cuname%>&Dfname=<%=Dfname%>&Ddname=<%=Ddname%>&Duname=<%=Duname%>','a','dialogWidth:320px;dialogHeight:260px;dialogTop:200px;center: yes;help:no;resizable:no;status:no');
}

function alt7(){ //���
  chksure('chksure'); 
}

function alt8(){  //�����
  chksure('unchksure'); 
}

function alt9(){  //����
  chksure('sure');
}

function alt10(){  //������
  chksure('unsure');
}
	
function alt11(){//���
  var s=<%=alt11%>;
  if(s=="r"){
    altr();
  }else if(s=="0"){
	alert("û�д˹��ܻ�����û�д˲���Ȩ�ޣ�");
  }
}

function alt12(){//����
  if(trim(id)==""){
    alert("����ѡ�񵥾ݣ����ܸ���!");
  }else{
    var s=<%=alt12%>;
    if(s=="r"){
      altr();
    }else if(s=="0"){
	  alert("û�д˹��ܻ�����û�д˲���Ȩ�ޣ�");
    }
  }
}

function alt13(){//����
  var s=<%=alt13%>;
  if(s=="r"){
    altr();
  }else if(s=="0"){
	alert("û�д˹��ܻ�����û�д˲���Ȩ�ޣ�");
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
<!--��������ʼ-->
<table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#EDD8D3" bgcolor="#EDD8D3" class="bar">
  <tr>
    <td height="19" valign="bottom" class="f12">ҵ������ &gt;&gt; 
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
    ��ѯ</td>
    <td width="7%" class="toolbar" id="tbar1" onMouseDown="mdown(this,1);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/040.gif" width="16" height="16" border="0"><br>
    ��ӡ</td>
    <td width="8%" class="toolbar" id="tbar2" onMouseDown="mdown(this,2);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    ѡ������</td>
    <td width="8%" class="toolbar" id="tbar3" onMouseDown="mdown(this,3);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    ѡ�ջ���</td>
    <td width="8%" class="toolbar" id="tbar12" onMouseDown="mdown(this,12);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    ����</td>
    <!--
    <td width="66" class="toolbar" id="tbar2" onMouseDown="mdown(this,2);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    ����</td>
    <td width="66" class="toolbar" id="tbar3" onMouseDown="mdown(this,3);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    ���</td>-->
    <td width="8%" class="toolbar" id="tbar4" onMouseDown="mdown(this,4);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/132.gif" width="16" height="16" border="0"><br>
    ɾ��</td>
    <td width="8%" class="toolbar" id="tbar5" onMouseDown="mdown(this,5);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    �༭</td>
    <td width="8%" class="toolbar" id="tbar6" onMouseDown="mdown(this,6);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    �޸���ϸ</td>
    <td width="8%" class="toolbar" id="tbar7" onMouseDown="mdown(this,7);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    ���</td>
    <td width="8%" class="toolbar" id="tbar8" onMouseDown="mdown(this,8);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    ����</td>
    <td width="8%" class="toolbar" id="tbar9" onMouseDown="mdown(this,9);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>      
    ����</td>
    <td width="9%" class="toolbar" id="tbar10" onMouseDown="mdown(this,10);" onMouseUp="mover(this);" onMouseOver="mover(this);" onMouseOut="mout(this);"><img src="img/toolbar/004.gif" width="16" height="16" border="0"><br>
    ����</td>
  </tr>
</table>
<!--����������-->
<form name="form1" method="get" action="main.asp" target="is">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFBFF">
    <tr>
      <td width="91%"><table width="713"  border="0" cellspacing="0">
        <tr valign="middle" class="f12">
          <td width="58">��ѯ��ʽ:</td>
          <td width="123"><select name="stype" id="stype" style="height:18px; ">
              <option value="0">���Ƶ����ڲ�ѯ</option>
              <option value="1">���������ڲ�ѯ</option>
              <option value="2" <%if stype="2" then response.Write " selected" end if%>>�������ѯ</option>
          </select></td>
          <td width="58">��ѯ��Χ:</td>
          <td width="466"><input name="rq1" type="text" id="rq1" onFocus="setday(this)" value="<%=get_date(date-30)%>" size="10" maxlength="10" style="height:20px; ">
              <input name="rq2" type="text" id="rq2" size="10" maxlength="10" value="<%=get_date(date)%>" onFocus="setday(this)" style="height:20px; ">
              <input name="com" type="hidden" id="com" value="<%=request.querystring("com")%>">
              <input name="ext" type="hidden" id="ext" value="<%=request.querystring("ext")%>">
              <input name="ext" type="radio" value="0">
              ����
              <input name="ext" type="radio" value="1" checked>
              δ��
              <input type="radio" name="ext" value="2">
              ����
              <input type="radio" name="ext" value="3">
              δ��
              <input type="radio" name="ext" value="4">
            �ѵ�            </td>
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
