<%option explicit%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/class.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ޱ����ĵ�</title>

<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridedittable.js"></SCRIPT>
<SCRIPT language="JavaScript">
var rsta=-1;
function gtDoSelect(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	
	parent.id=id;//�ڿͻ��˹��õĵ���ID
	var sta=row.getElementsByTagName("input")[0];
	try{
		sta=parseInt(sta.value);
	}catch(ex){}
	if(rsta!=sta){
		switch(sta){
		case 0:
	  	  parent.edit();break;
		case 1:
	  	  parent.chksured();break;
		case 2:
	  	  parent.sured();break;
		default:
	  	  break;
		}
	    rsta=sta;
	}
}

function gtDoDblClick(t){
	var row = t.getSelectedRow();
	var id=row.cells[0].outerText;
	showModalDialog('f22_mx.asp?id='+id+'&pksname=<%=session("pksname")%>&ext=<%=ext%>','e','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

  function gtDoEnter(t){}
</SCRIPT>

</head>

<body>
<%
dim rs,ext,sql,t,rq1,rq2,stype,userid,tmp,typ,ss,seachid
Call getParam 'ȡ�ô���Ĳ���
seachid=trim(request.QueryString("seachid"))
ext = trim(request.QueryString("ext"))
rq1 = trim(request("rq1"))
rq2 = trim(request("rq2"))

typ=request("stype")
if rq1<>"" then rq1=get_datetime(rq1,1)
if rq2<>"" then rq2=get_datetime(rq2,2)
if ext="" then ext=1 else ext = cint(ext) end if
if typ=0  then ss="cr_date" else ss="sure_date" end if
if rq1<>"" and rq2<>"" and ext<>4 then ss=" and a."&ss&" between '"&rq1&"' and '"&rq2&"' " else ss="" end if

'de rq1
set t = new Table
  t.ActiveConnection =cn
  t.CommandType=1
  dim s
if seachid="" then
		sql="select a.outindentid,a.selltype,a.set_depotid,a.depotid,a.chk_sure,a.sure,a.chk_name,a.chk_date,a.sure_date,a.sure_name,"&_
		    "(select sum(b.nums) from d_outindentsetsub b where a.outindentid=b.outindentid) as nums,"& _
			"(select sum(c.nums*c.s_price) from d_outindentsetsub c where a.outindentid=c.outindentid) as sums,"& _
			"(select d.d_name from j_depot d where a.set_depotid=d.depotid ) as setdptname,"& _
			"(select e.d_name from j_depot e where a.depotid=e.depotid ) as getdptname, "&_
			"a.setdate,a.ov_sure,a.ov_name,a.ov_date,a.comment,a.cr_date,a.cr_name,"&_
			"case when isnull(a.backrate,0)=1 then '�����˻�' else '�����˻�' end as backrate,a.quotaid,"&_
                        "(select b.sure from d_outindent b where b.quotaid=a.outindentid) as get_sure,a.Taxonomy from d_outindentset a "&_
			"where a.set_depotid="&qts(session("dm").System_depotid)&ss
		select case ext
		case 0

		case 1
		  sql=sql&" and isnull(chk_sure,0)=0 "
		case 2
		  sql=sql&" and isnull(chk_sure,0)>0 and  isnull(sure,0)=0 "
		case 3
		  sql=sql&" and isnull(sure,0)>0 and  isnull(sure,0)=1 "
		case 4
		  sql=sql&" and isnull(sure,0)=0 "
		end select
else
		sql="select a.outindentid,a.selltype,a.set_depotid,a.depotid,a.chk_sure,a.sure,a.chk_name,a.chk_date,a.sure_date,a.sure_name,"&_
		    "(select sum(b.nums) from d_outindentsetsub b where a.outindentid=b.outindentid) as nums,"& _
			"(select sum(c.nums*c.s_price) from d_outindentsetsub c where a.outindentid=c.outindentid) as sums,"& _
			"(select d.d_name from j_depot d where a.set_depotid=d.depotid ) as setdptname,"& _
			"(select e.d_name from j_depot e where a.depotid=e.depotid ) as getdptname, "&_
			"a.setdate,a.ov_sure,a.ov_name,a.ov_date,a.comment,a.cr_date,a.cr_name,"&_
			"case when isnull(a.backrate,0)=1 then '�����˻�' else '�����˻�' end as backrate,a.quotaid,"&_
                        "(select b.sure from d_outindent b where b.quotaid=a.outindentid) as get_sure,a.Taxonomy from d_outindentset a "&_
			"where a.set_depotid="&qts(session("dm").System_depotid)&" and a.outindentid="&qts(seachid)
end if


	  t.SetField "outindentid","��ˮ��","140",2
	  t.SetField "backrate","�˻���ʽ","60",0
	  t.SetField "selltype","��������","80",2
	  t.SetField "Taxonomy","�����׼","80",2
	  t.SetField "set_depotid","������","60",2
	  t.SetField "setdptname","����������","150",2
	  t.SetField "depotid","�ջ���","60",2
	  t.SetField "getdptname","�ջ�������","150",2
	  t.SetField "nums","��������","50",1
		if psprice then t.SetField "sums","�������","50",1
		
		t.SetField "setdate","�˻�����","60",2
		
	  t.SetField "chk_sure","���","30",2
	  t.SetField "sure","����","30",2
	  t.SetField "get_sure","�ջ�����","50",2
  	  t.SetField "chk_name","�����","50",2
	  t.SetField "chk_date","�������","80",2
      t.SetField "sure_date","��������","80",2
      t.SetField "sure_name","������","50",2
	  t.SetField "ov_sure","�᰸","30",2
	  t.SetField "ov_name","�᰸��","50",2
	  t.SetField "ov_date","�᰸����","80",2
	  t.SetField "cr_name","�Ƶ���","50",2
	  t.SetField "cr_date","�Ƶ�����","80",2
	  t.SetField "comment","��ע","80",2
	  t.SetField "quotaid","���뵥��","140",2
	  t.CSureName="chk_sure"
      t.SureName="sure"
	  
t.CommandText = sql
t.Show
set rs = nothing
set t = nothing
%>

</body>
</html>
