<%option explicit
session("formid")=2070%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../inc/js/setday.js"></script>
<script language="javascript" src="inc/abc.js"></script>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<script language="JavaScript" src="" id="aaa"></script>
<SCRIPT language="JavaScript">
var indentid="";
function gtDoSelect(t){
	var row = t.getSelectedRow();
	indentid=trim(row.cells[1].outerText);
}

function gtDoDblClick2(t){
	var row = t.getSelectedRow();
	var id=row.cells[1].outerText;
	showModalDialog('f22_mx.asp?id='+id+'&pksname=movenotice','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}


function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[1].outerText;
	iq.location.href="f22cz_movenotice_d_move.asp?action=cz_move&id="+id;
}


function gtDoEnter(t){
}
function mx(){
	if(indentid!=""){
	  showModalDialog('f22_mx.asp?id='+indentid+'&pksname=movenotice','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
	}else{
	  alert("����ѡ��֪ͨ��!");
	}
}

function createbill(i){
 var a;
 if(indentid!=""){
  
	if(confirm("�Ƿ�������ϸ��"))   
    {  
	 a=0;
	}   
  else   
    {
		a=1;
	}   
	
	showModalDialog("2067_movenotice_sub.asp?act=jump&typ="+i+"&id="+indentid+"&istrue="+a,window,'dialogWidth:1px;dialogHeight:1px;dialogLeft:0px;dialogTop:0px;center: yes;help:no;resizable:yes;status:no;scroll:no;');
	if(confirm('�Ƿ���ת����ѯ����?')){window.location.href="search_frame.asp?jh=''&pagename=%B2%E9%D1%AF%B5%F7%B0%CE%B7%A2%BB%F5%B5%A5"
	}
 }else{
    alert("����ѡ��֪ͨ��!");
 }
}

function editnotice(i){
  if(indentid!=""){
    //aaa.src="2067_movenotice_sub.asp?act=edit&typ="+i+"&id="+indentid; 
	showModalDialog("2067_movenotice_sub.asp?act=edit&typ="+i+"&id="+indentid,window,'dialogWidth:1px;dialogHeight:1px;dialogLeft:0px;dialogTop:0px;center: yes;help:no;resizable:yes;status:no;scroll:no;');
	location.href="2070_movenotice_seach.asp";  
  }else{
    alert("����ѡ��֪ͨ��!");
  }  
}
</script>
<base target="_self">
</head>

<body>
<table width="100%"  border="0" bgcolor="#FBFCFB" class="f12" >
<form name="form1" method="get" action="">
  <tr>
    <td>
	
	
	<input name="stype" type="radio" value="0" checked>����&nbsp;&nbsp;
    <input type="radio" name="stype" value="1" <%if request.QueryString("stype")="1" then response.Write("checked")%>>ָ������&nbsp;&nbsp; 
    ��ʼ����:<input name="sdate" type="text" id="sdate" value="<%=get_date(date()-30)%>" onFocus="setday(this);" size="8" tabindex="-1" readonly>&nbsp;&nbsp;
    ��������:<input name="edate" type="text" id="edate" value="<%=get_date(date())%>" onFocus="setday(this);" size="8" tabindex="-1" readonly>&nbsp;&nbsp;
	<input name="dtype" type="radio" value="1" <%if request.QueryString("dtype")="1" then response.Write("checked")%> >������&nbsp;&nbsp;
	<input name="dtype" type="radio" value="0" <%if request.QueryString("dtype")<>"1" then response.Write("checked")%>  >ȫ��״̬&nbsp;&nbsp;
   </td>
  </tr>
  <tr>
  <td>
  
    <input type="submit" name="Submit" value="�� ѯ(S)" accesskey="s">
	<input type="button" name="bu3" value="���ɵ�����" onClick="createbill(30)">
	 <input type="button" name="Submit" value="�鿴��ϸ(M)" onClick="mx();"></td>
    <input type="hidden" name="hiddenField">
  </td>
  </tr>
  </form>
</table>
<%dim t,t1,rq1,rq2,stype,UserId,ext,s,sql,dtype
rq1=trim(request.QueryString("sdate"))
rq2=trim(request.QueryString("edate"))
stype=trim(request.QueryString("stype"))
dtype=trim(request.QueryString("dtype"))
UserId=trim(session("dm").System_Userid)
if stype="" then
  stype=0
else
  stype=cint(stype)
end if

if dtype="" then
  dtype=0
else
  dtype=cint(dtype)
end if

set t=new Table
  t.ActiveConnection = cn

     if stype=0 then
	    s=""
	 else
	    s=" and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"'"
	 end if
	 
	 if dtype=0 then
	    s=""
	 else
	    s=" and isnull(cwpz,0)<>30 "
	 end if
	 
	  
	  t.CommandType = 1
		sql="SELECT case when isnull(cwpz,0)=10 then '��ȫû��' else "&_
             "case when isnull(cwpz,0)=20 then '�����л�' else "&_
             "case when isnull(cwpz,0)=30 then '�Ѵ���' else '�����С�' end end end as ctype "&_
		  ",a.noticeid,a.selltype,convert(char(10),a.setdate,126) as setdate,convert(char(10),a.getdate,126) as getdate,"&_
		  "a.chk_name,a.chk_date,a.sure_date,a.sure_name,"&_
          "(select sum(d.nums) from d_movenoticesub d where d.noticeid=a.noticeid) as nums,"&_
          "(select sum(d.nums*d.s_price1) from d_movenoticesub d where d.noticeid=a.noticeid) as sums,"&_
          "a.set_depotid,b.d_name as setdptname,a.get_depotid,c.d_name as getdptname,a.comment,a.chk_sure,a.sure "&_
          " from d_movenotice a,j_depot b,j_depot c where  a.set_depotid=b.depotid and a.get_depotid=c.depotid "&_
		  " and a.d_type=2 "&_
          " and isnull(a.sure,0)>0 and isnull(a.ov_sure,0)=0 and a.set_depotid='"&session("dm").System_DepotID&"' "&s

	  t.commandText = sql
	  t.SetField "ctype","״̬","60",2
	  t.SetField "noticeid","��ˮ��","150",0
	  t.SetField "selltype","��������","50",2
	  t.SetField "get_depotid","�ջ���","50",2
	  t.SetField "getdptname","�ջ�������","80",2
	  t.SetField "nums","����","40",1
	  t.SetField "sums","���","40",1
      t.SetField "setdate","��������","65",2
	  t.SetField "getdate","�ջ�����","65",2
	  t.SetField "comment","��ע","190",2
	  t.CSureName="chk_sure"
      t.SureName="sure"
  't.IsAutoColor=False
  't.ColorField="phcnt"
  t.height="40%"
  t.Show
  set t=Nothing
  set cn=nothing
%>

<iframe src="f22cz_movenotice_d_move.asp?act=seach" id="iq" name="iq" frameborder="0" height="48%" width="100%;"></iframe>
</body>
</html>
