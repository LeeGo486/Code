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
if typ=0  then ss="setcr_date" else ss="getsure_date" end if
if rq1<>"" and rq2<>"" and ext<>4 then  ss=" and a."&ss&" between '"&rq1&"' and '"&rq2&"' " else ss="" end if

'de rq1
set t = new Table
  t.ActiveConnection =cn
  t.CommandType=1
if seachid="" then
        sql="select a.msellid, a.msell, a.set_depotid as setdepotid,b.d_name as setdptname,a.getdate,a.get_depotid as GetDepotid,"&_
		" c.d_name as GetDptname,a.setsure_date,a.selltype,a.getchk_sure,a.getchk_sure,a.get_sure,a.getchk_name,a.getchk_date,"& _
        " a.getsure_name,a.getsure_date,a.getcr_date,a.getcr_name,a.set_comment,a.get_comment,a.backrate,a.backdate,a.noticeid,"&_
		" (select sum(set_nums) from d_msellsub where d_msellsub.msellid=a.msellid) as set_nums,"&_
		" (select sum(set_nums*s_price) from d_msellsub where d_msellsub.msellid=a.msellid) as set_sums,"&_
		" a.noticeid,a.get_sure,a.fmscash,a.fmsinfo, "&_
			" case when isnull(a.fmstype,0)=1 then '�ĸ�' else  case when isnull(a.fmstype,0)=2 then '����' else '' end  end as fmstyp "&_
        " from d_msell a ,j_depot b,j_depot c"& _
	    " where  isnull(a.set_sure,0)>0 and a.get_depotid="&qts(session("dm").System_depotid) & _
        " and a.set_depotid=b.depotid and a.get_depotid=c.depotid "&ss
		select case ext
		case 0
		
		case 1
		  tmp=" and isnull(a.getchk_sure,0)=0 and isnull(a.get_sure,0)=0"
		case 2
		  tmp=" and isnull(a.getchk_sure,0)>0 and isnull(a.get_sure,0)=0"
		case 3
		  tmp=" and isnull(a.get_sure,0)>0 "
		case 4
		  tmp=" and isnull(a.get_sure,0)=0 "
		end select
	  sql = sql & tmp
else
        sql="select a.msellid, a.msell, a.set_depotid as setdepotid,b.d_name as setdptname,a.getdate,a.get_depotid as GetDepotid,"&_
		" c.d_name as GetDptname,a.setsure_date,a.selltype,a.getchk_sure,a.getchk_sure,a.get_sure,a.getchk_name,a.getchk_date,"& _
        " a.getsure_name,a.getsure_date,a.getcr_date,a.getcr_name,a.set_comment,a.get_comment,a.backrate,a.backdate,a.noticeid,"&_
		" (select sum(set_nums) from d_msellsub where d_msellsub.msellid=a.msellid) as set_nums,"&_
		" (select sum(set_nums*s_price) from d_msellsub where d_msellsub.msellid=a.msellid) as set_sums"&_
			" a.noticeid,a.get_sure,a.fmscash,a.fmsinfo, "&_
			" case when isnull(a.fmstype,0)=1 then '�ĸ�' else  case when isnull(a.fmstype,0)=2 then '����' else '' end  end as fmstyp "&_
			" from d_msell a, j_depot b,j_depot c"& _
	    " where  isnull(a.set_sure,0)>0 and a.get_depotid="&qts(session("dm").System_depotid) & _
        " and a.set_depotid=b.depotid and a.get_depotid=c.depotid and a.msellid="&qts(seachid)
end if
	  t.SetField "msellid","��ˮ��","140",2
	  t.SetField "selltype","��������","50",0
	  t.SetField "setdepotid","������","50",2
	  t.SetField "setdptname","����������","100",2
	  t.SetField "getdepotid","�ջ���","60",2
	  t.SetField "getdptName","�ջ�������","100",2
	  t.SetField "set_nums","��������","50",1
	  t.SetField "set_sums","�������","60",1
	  t.SetField "setsure_date","��������","80",2
		'�¼� 2009-02-17 start
		t.SetField "fmscash","�˷�","50",1
		t.SetField "fmstyp","���ʽ","50",2
		t.SetField "fmsinfo","������Ϣ","150",2
		'�¼� 2009-02-17 end


	  t.SetField "getchk_sure","�ջ����","50",2
	  t.SetField "get_sure","�ջ�����","50",2
	  t.SetField "getchk_name","�ջ������","50",2
	  t.SetField "getchk_date","�ջ��������","80",2
	  t.SetField "getsure_name","�ջ�������","80",2
	  t.SetField "getsure_date","�ջ���������","80",2
      t.SetField "getcr_name","�ջ��Ƶ���","50",2
	  t.SetField "getcr_date","�ջ��Ƶ�����","80",2
	  t.SetField "set_comment","������ע","80",2
	  t.SetField "get_comment","�ջ���ע","80",2
	  t.SetField "backrate","������","40",2
      t.SetField "backdate","��������","80",2
      t.SetField "getdate","�ƻ���������","80",2
	  t.SetField "noticeid","֪ͨ����","140",2
	  t.SetField "msell","��������","140",2
      t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  
t.CommandText = sql
t.Show
set rs = nothing
set t = nothing
%>

</body>
</html>
