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
if typ=0  then ss="setcr_date" else ss="setsure_date" end if
if rq1<>"" and rq2<>"" and (ext<>4 and ext<>5) then  ss=" and a."&ss&" between '"&rq1&"' and '"&rq2&"' " else ss="" end if



'de rq1
set t = new Table
  t.ActiveConnection =cn
  t.CommandType=1
  dim s
if seachid="" then
		sql="select a.msellid,a.selltype,a.set_depotid,a.get_depotid,a.setchk_sure,a.set_sure,a.setchk_name,a.setchk_date,a.setsure_date,a.setsure_name,"&_
		    "(select sum(b.set_nums) from d_msellsub b where a.msellid=b.msellid) as nums,"& _
			"(select sum(c.set_nums*c.s_price1) from d_msellsub c where a.msellid=c.msellid) as sums,"& _
			"(select d.d_name from j_depot d where a.set_depotid=d.depotid ) as setdptname,"& _
			"(select e.d_name from j_depot e where a.get_depotid=e.depotid ) as getdptname, "&_
			"a.setdate,a.set_comment,a.setcr_date,a.setcr_name,"&_
			" a.noticeid,a.get_sure,a.fmscash,a.fmsinfo, "&_
			" case when isnull(a.fmstype,0)=1 then '�ĸ�' else  case when isnull(a.fmstype,0)=2 then '����' else '' end  end as fmstyp "&_
			" from d_msell a "&_
			"where a.set_depotid="&qts(session("dm").System_depotid)&ss
		select case ext
		case 0

		case 1
		  sql=sql&" and isnull(setchk_sure,0)=0 "
		case 2
		  sql=sql&" and isnull(setchk_sure,0)>0 and  isnull(set_sure,0)=0 "
		case 3
		  sql=sql&" and isnull(set_sure,0)>0 "
		case 4
		  sql=sql&" and isnull(set_sure,0)=0 "
		case 5
		  sql=sql&" and isnull(set_sure,0)=1 and isnull(get_sure,0)=0"  
		end select
else
		sql="select a.msellid,a.selltype,a.set_depotid,a.get_depotid,a.setchk_sure,a.set_sure,a.setchk_name,a.setchk_date,a.setsure_date,a.setsure_name,"&_
		    "(select sum(b.set_nums) from d_msellsub b where a.msellid=b.msellid) as nums,"& _
			"(select sum(c.set_nums*c.s_price1) from d_msellsub c where a.msellid=c.msellid) as sums,"& _
			"(select d.d_name from j_depot d where a.set_depotid=d.depotid ) as setdptname,"& _
			"(select e.d_name from j_depot e where a.get_depotid=e.depotid ) as getdptname, "&_
			"a.setdate,a.set_comment,a.setcr_date,a.setcr_name,"&_
			" a.noticeid,a.get_sure,a.fmscash,a.fmsinfo, "&_
			" case when isnull(a.fmstype,0)=1 then '�ĸ�' else  case when isnull(a.fmstype,0)=2 then '����' else '' end  end as fmstyp "&_
			" from d_msell a "&_
			" where a.set_depotid="&qts(session("dm").System_depotid)&" and a.msellid="&qts(seachid)
end if

			t.SetField "msellid","��ˮ��","140",2
			t.SetField "selltype","��������","80",2
			t.SetField "set_depotid","������","60",2
			t.SetField "setdptname","����������","150",2
			t.SetField "get_depotid","�ջ���","60",2
			t.SetField "getdptname","�ջ�������","150",2
			t.SetField "nums","��������","50",1
			if psprice then  t.SetField "sums","�������","50",1
			
			
			
			'�¼� 2009-02-17 start
			t.SetField "fmscash","�˷�","50",1
			t.SetField "fmstyp","���ʽ","50",2
			t.SetField "fmsinfo","������Ϣ","150",2
			'�¼� 2009-02-17 end
			t.SetField "setchk_sure","���","30",2
			t.SetField "set_sure","����","30",2
			t.SetField "get_sure","�ջ�����","50",2
			t.SetField "setchk_name","�����","50",2
			t.SetField "setchk_date","�������","80",2
			t.SetField "setsure_date","��������","80",2
			t.SetField "setsure_name","������","50",2
			t.SetField "setcr_name","�Ƶ���","50",2
			t.SetField "setcr_date","�Ƶ�����","80",2
			t.SetField "set_comment","��ע","140",2
			t.SetField "noticeid","֪ͨ����","80",2
			t.CSureName="setchk_sure"
			t.SureName="set_sure"
	'de sql  
t.CommandText = sql
t.Show
set rs = nothing
set t = nothing
%>

</body>
</html>
