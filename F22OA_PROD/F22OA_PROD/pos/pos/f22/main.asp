<%option explicit
'on error resume next
'Response.Expires=-1000%>
<!--#include file="inc/function.asp" -->
<!--#include file="inc/Class.asp" -->
<%dim ext
ext=trim(request.QueryString("ext"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
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
	showModalDialog('f22_mx.asp?id='+id+'&pksname=<%=session("pksname")%>&ext=<%=ext%>','example04','dialogWidth:'+screen.availwidth+'px;dialogHeight:'+screen.availHeight+'px;dialogLeft:0px;dialogTop:150px;center: yes;help:no;resizable:yes;status:no');
}

  function gtDoEnter(t){}
</SCRIPT>
</head>

<body>
<%dim rq1,rq2,Userid,stype,com,i

Call getParam 'ȡ�ô���Ĳ���

  if trim(request("com"))<>"" then
    session("com")=request("com")
  end if
  com=session("com")
  
  Call getGant("search",1)

if rq1<>"" then
  dim t,sql
  set t=New Table
  t.ActiveConnection =cn
  t.CommandType=4

  select case com
    case "2005" '���ܹ�˾����
	  
	  sql="webqry_indentdh"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "indentid","��ˮ��","140"
	  t.SetField "phcnt","���","30"
 	  t.SetField "fhcnt","����","30"
	  t.SetField "getdepotid","�ջ���","70"
	  t.SetField "getdptname","�ջ�������","80"
	  t.SetField "selltype","��������","60"
	  t.SetField "getdate","�ƻ���������","80"
	  t.SetField "dhnums","��������","50"
	  t.SetField "dhjpsums","�������","60"
	  t.SetField "phnums","�������","50"
	  t.SetField "phjpsums","������","60"
	  t.SetField "fhnums","��������","50"
	  t.SetField "fhjpsums","�������","60"
	  t.SetField "sure","����","30"
	  t.SetField "sure_date","��������","60"
	  t.SetField "sure_name","������","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "setdepotid","������","50"
	  t.SetField "setdptname","����������","80"
      t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "chk_sure","���","30"
	  t.SetField "chk_name","�����","50"
      t.SetField "cr_date","�Ƶ�����","60"
	  t.SetField "ov_sure","�᰸","30"
	  t.SetField "ov_date","�᰸����","60"
	  t.SetField "backrate","�����ۿ�","60"
	  t.SetField "backdate","��������","60"
	  t.SetField "indent","������","140"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	  't.height="100%"
    case "2006" '���ܹ�˾����
	  sql="webqry_indentbh"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "indentid","��ˮ��","140"
	  t.SetField "phcnt","���","30"
	  t.SetField "indent","������","140"
	  t.SetField "Getdepotid","�ջ���","50"
	  t.SetField "GetdptName","�ջ�������","100"
	  t.SetField "selltype","��������","50"
	  t.SetField "getdate","�ƻ���������","80"
	  t.SetField "dhnums","��������","50"
	  t.SetField "dhjpsums","�������","60"
	  t.SetField "phnums","�������","50"
	  t.SetField "phjpsums","������","60"
	  t.SetField "fhnums","��������","50"
	  t.SetField "fhjpsums","�������","60"
	  t.SetField "sure","����","30"
	  t.SetField "sure_name","������","50"
	  t.SetField "sure_date","��������","80"
	  t.SetField "comment","��ע","80"
	  t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "chk_sure","���","30"
	  t.SetField "chk_name","�����","50"
	  t.SetField "chk_date","�������","80"
	  t.SetField "ov_sure","�᰸","30"
      t.SetField "ov_name","�᰸��","50"
      t.SetField "ov_date","�᰸����","80"
      t.SetField "setdate","��������","80"
	  t.SetField "backrate","�����ۿ�","50"
      t.SetField "backdate","��������","80"
      t.SetField "setdptname","����������","100"
 	  t.SetField "Setdepotid","������","50"    
	  t.SetField "cr_date","�Ƶ�����","80"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  t.width="100%"
	  
	case "2010" '�ջ�	  
	  if stype="0" then
        sql="select a.sellid, a.sell, a.setdepotid, a.merchantid, a.getdate,a.GetDptname,a.SetDptname, "& _
        " a.backrate, a.selltype, a.backdate,a.quotaid,a.getsure_name, a.getsure_date, a.Set_SumS,"& _
        " a.getchk_sure, a.getchk_name, a.getchk_date,a.get_comment,c.dptname as getdptname,"& _
        " b.dptname as setdptname,a.set_comment, a.cwpz, a.getdepotid,a.parentid, a.get_sure, "& _
		" a.setdate,a.set_nums,a.setcr_date,a.setcr_name,a.setchk_name,a.setchk_date,setsure_name, "& _
		" a.setsure_date,crdate,a.autoid,setchk_sure,set_sure "& _
        " from v22d_sell a,v22p_setdepot b,v22p_getdepot c "& _
	    " where  a.set_sure=1 and ((a.get_sure=0) or (a.get_sure is null)) "& _
        " and a.setdepotid=b.depotid and a.getdepotid=c.depotid "& _
        " and c.userid=b.userid and c.userid="&qts(UserId) & _
		" and a.setcr_date between "& qts(rq1) &" and "&qts(rq2)
      else
        sql="select a.sellid, a.sell, a.setdepotid, a.merchantid, a.getdate,a.GetDptname,a.SetDptname, "& _
        " a.backrate, a.selltype, a.backdate,a.quotaid,a.getsure_name, a.getsure_date,a.Set_SumS, "& _
        " a.getchk_sure, a.getchk_name, a.getchk_date,a.get_comment,c.dptname as getdptname,"& _
        " b.dptname as setdptname,a.set_comment, a.cwpz, a.getdepotid,a.parentid, a.get_sure, "& _
		" a.setdate,a.set_nums,a.setcr_date,a.setcr_name,a.setchk_name,a.setchk_date,setsure_name, "& _
		" a.setsure_date,crdate,a.autoid,setchk_sure,set_sure "& _
        " from v22d_sell a,v22p_setdepot b,v22p_getdepot c "& _
	    " where  a.set_sure=1 and ((a.get_sure=0) or (a.get_sure is null)) "& _
        " and a.setdepotid=b.depotid and a.getdepotid=c.depotid "& _
        " and c.userid=b.userid and c.userid="&qts(UserId) & _
		" and a.setsure_date between "& qts(rq1) &" and "&qts(rq2)
      end if
      't.CommandType=1
      't.SetField "sellid","��������","140"
	  't.SetField "setdepotid","������","50"
	  't.SetField "setdptname","�����ؼ��","80"
	  't.SetField "getdepotid","�ջ���","50"
	  't.SetField "getdptname","�ջ��ؼ��","80"
	  't.SetField "setdate","��������","80"
	 ' t.SetField "getdate","�ջ�����","80"
	 ' t.SetField "set_nums","����","40"
	  't.SetField "set_sums","���","40"
	  't.SetField "setcr_name","�Ƶ���","50"
      't.SetField "setcr_date","�Ƶ�����","80"
	  ''t.SetField "getchk_name","�����","50"
	  't.SetField "getchk_date","�������","80"
	  't.SetField "getsure_name","������","50"
	  't.SetField "getsure_date","��������","80"
      't.SetField "sell","�û��Ա��","140"
      't.SetField "get_mchid","������","50"
	 't.SetField "backrate","�˻���","40"
	 ' t.SetField "backdate","�����˻�����","90"
     ' t.SetField "selltype","��������","50"
      't.SetField "set_comment","������ע","150"
      't.CSureName="getchk_sure"
      't.SureName="get_sure"
	  't.width="100%"
	  
	  sql="webqry_getsell"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "sellid","��ˮ��","140"
	  t.SetField "sell","��������","140"
	  t.SetField "get_depotid","�ջ���","60"
	  t.SetField "getdptName","�ջ�������","100"
	  t.SetField "selltype","��������","50"
	  t.SetField "fhnums","��������","50"
	  t.SetField "fhjpsums","�������","60"
	  t.SetField "indentsums","������","60"
	  t.SetField "setdate","��������","80"
	  t.SetField "get_sure","�ջ�","30"
	  t.SetField "getsure_date","��������","80"
	  t.SetField "getchk_sure","���","30"
	  't.SetField "set_sure","����","30" 
      t.SetField "setcr_name","�Ƶ���","50"
	  t.SetField "setcr_date","�Ƶ�����","80"
	  t.SetField "getchk_name","�����","50"
	  t.SetField "getchk_date","�������","80"
	  t.SetField "set_depotid","������","50"
	  t.SetField "setdptname","����������","100"
	  t.SetField "set_comment","������ע","80"
	  t.SetField "quotaid","�������","140"
      t.SetField "get_mchid","������","50"
	  t.SetField "get_comment","�ջ���ע","80"
	  t.SetField "backrate","������","40"
      t.SetField "backdate","��������","80"
      't.SetField "getdate","��������","80"
      't.SetField "numrate","����","50"
      't.SetField "styrate","���","50"
      t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  
	case "2050" '���˶���
	  sql="webqry_indentdh"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,cint(stype)+10
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "indentid","��ˮ��","140"
	  t.SetField "phcnt","���","30"
 	  t.SetField "fhcnt","����","30"
	  t.SetField "getdepotid","�ջ���","70"
	  t.SetField "getdptname","�ջ�������","80"
	  t.SetField "selltype","��������","60"
	  t.SetField "getdate","�ƻ���������","80"
	  t.SetField "dhnums","��������","50"
	  t.SetField "dhjpsums","�������","60"
	  t.SetField "phnums","�������","50"
	  t.SetField "phjpsums","������","60"
	  t.SetField "fhnums","��������","50"
	  t.SetField "fhjpsums","�������","60"
	  t.SetField "sure","����","30"
	  t.SetField "sure_date","��������","60"
	  t.SetField "sure_name","������","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "setdepotid","������","50"
	  t.SetField "setdptname","����������","80"
      t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "chk_sure","���","30"
	  t.SetField "chk_name","�����","50"
      t.SetField "cr_date","�Ƶ�����","60"
	  t.SetField "ov_sure","�᰸","30"
	  t.SetField "ov_date","�᰸����","60"
	  t.SetField "backrate","�����ۿ�","60"
	  t.SetField "backdate","��������","60"
	  t.SetField "indent","������","140"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	  t.height="100%"
	  
	case "2051" '���˲���
	
	  sql="webqry_indentbh"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,cint(stype)+10
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "indentid","��ˮ��","140"
	  t.SetField "phcnt","���","30"
 	  t.SetField "fhcnt","����","30"
	  t.SetField "getdepotid","�ջ���","70"
	  t.SetField "getdptname","�ջ�������","80"
	  t.SetField "selltype","��������","60"
	  t.SetField "getdate","�ƻ���������","80"
	  t.SetField "dhnums","��������","50"
	  t.SetField "dhjpsums","�������","60"
	  t.SetField "phnums","�������","50"
	  t.SetField "phjpsums","������","60"
	  t.SetField "fhnums","��������","50"
	  t.SetField "fhjpsums","�������","60"
	  t.SetField "sure","����","30"
	  t.SetField "sure_date","��������","60"
	  t.SetField "sure_name","������","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "setdepotid","������","50"
	  t.SetField "setdptname","����������","80"
      t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "chk_sure","���","30"
	  t.SetField "chk_name","�����","50"
      t.SetField "cr_date","�Ƶ�����","60"
	  t.SetField "ov_sure","�᰸","30"
	  t.SetField "ov_date","�᰸����","60"
	  t.SetField "backrate","�����ۿ�","60"
	  t.SetField "backdate","��������","60"
	  t.SetField "indent","������","140"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="100%"
	  
	case "2052","2008" '�������
	  
	  sql="webqry_quota"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "quotaid","��ˮ��","140"
	  t.SetField "fhcnt","����","30"
	  t.SetField "quota","�������","140"
	  t.SetField "get_depotid","�ջ���","50"
      t.SetField "getdptName","�ջ�������","100"
	  t.SetField "selltype","��������","40"
	  t.SetField "phnums","�������","50"
	  t.SetField "phjpsums","������","60"
	  t.SetField "fhnums","��������","50"
	  t.SetField "fhjpsums","�������","60"
	  t.SetField "setdate","�������","80"
	  t.SetField "getdate","��������","80"
	  t.SetField "sure","����","30"
	  t.SetField "chk_sure","���","30"
	  t.SetField "sure_date","��������","80"
	  t.SetField "chk_date","�������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "sure_name","������","50"
	  t.SetField "ov_date","�᰸����","80"
	  t.SetField "ov_name","�᰸��","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "backrate","������","30"
	  t.SetField "backdate","��������","80"
	  t.SetField "indentid","������","140"
 	  t.SetField "set_depotid","������","50"
      t.SetField "setdptname","����������","100"
      t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "cr_date","�Ƶ�����","80"
          
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="2000px"
	case "2053","2009" '���˷���
	  
	  sql="webqry_setsell"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "sellid","��ˮ��","140"
	  t.SetField "cwpz","״̬","30"
	  t.SetField "sell","��������","140"
      t.SetField "get_depotid","�ջ���","60"
      t.SetField "getdptName","�ջ�������","100"
	  t.SetField "selltype","��������","50"
	  t.SetField "fhnums","��������","50"
	  t.SetField "fhjpsums","�������","60"
	  t.SetField "indentsums","������","60"
	  t.SetField "set_sure","����","30"
	  t.SetField "setsure_date","��������","80"
	  t.SetField "get_sure","�ջ�","30"
	  t.SetField "getsure_date","�ջ�����","80"
	  t.SetField "setchk_sure","���","30"
	  t.SetField "setcr_name","�Ƶ���","50"
	  t.SetField "setcr_date","�Ƶ�����","80"
	  t.SetField "setchk_name","�����","50"
	  t.SetField "setchk_date","�������","80"
	  t.SetField "setsure_name","������","50"
	  t.SetField "set_depotid","������","50"
      t.SetField "setdptname","����������","100"
	  t.SetField "set_comment","������ע","80"
	  t.SetField "quotaid","�������","140"
      't.SetField "setdate","��������","80"
      't.SetField "getdate","��������","80"
      t.SetField "get_mchid","������","50"
      t.SetField "get_comment","�ջ���ע","80"
      t.SetField "backrate","������","40"
      t.SetField "backdate","��������","80"
      t.CSureName="setchk_sure"
      t.SureName="set_sure"
	  't.width="2150px"
	case "2054","2010" '�����ջ�
	  
	  sql="webqry_getsell"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,cint(stype)+10
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "sellid","��ˮ��","140"
	  t.SetField "sell","��������","140"
	  t.SetField "get_depotid","�ջ���","60"
	  t.SetField "getdptName","�ջ�������","100"
	  t.SetField "selltype","��������","50"
	  t.SetField "fhnums","��������","50"
	  t.SetField "fhjpsums","�������","60"
	  t.SetField "indentsums","������","60"
	  t.SetField "setdate","��������","80"
	  t.SetField "get_sure","�ջ�","30"
	  t.SetField "getsure_date","��������","80"
	  t.SetField "getchk_sure","���","30"
	  't.SetField "set_sure","����","30" 
      t.SetField "setcr_name","�Ƶ���","50"
	  t.SetField "setcr_date","�Ƶ�����","80"
	  t.SetField "getchk_name","�����","50"
	  t.SetField "getchk_date","�������","80"
	  t.SetField "set_depotid","������","50"
	  t.SetField "setdptname","����������","100"
	  t.SetField "set_comment","������ע","80"
	  t.SetField "quotaid","�������","140"
      t.SetField "get_mchid","������","50"
	  t.SetField "get_comment","�ջ���ע","80"
	  t.SetField "backrate","������","40"
      t.SetField "backdate","��������","80"
      't.SetField "getdate","��������","80"
      't.SetField "numrate","����","50"
      't.SetField "styrate","���","50"
      t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  't.width="1900px"

	  
	case "2055" '�����˻�����
	
	  sql="webqry_outindentset"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,cint(stype)+10
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","��ˮ��","140"
	  t.SetField "outindent","���뵥��","140"
	  t.SetField "set_depotid","������","100"
	  t.SetField "setdptname","����������","100"
	  t.SetField "sqnums","��������","50"
	  t.SetField "sqjpsums","������","60"
	  t.SetField "chknums","�������","50"
	  t.SetField "chkjpsums","��˽��","60"
	  t.SetField "setnums","��������","50"
	  t.SetField "setjpsums","�������","60"
	  t.SetField "getnums","�ջ�����","50"
	  t.SetField "getjpsums","�ջ����","60"
	  t.SetField "prop_sure","�ύ","30"
	  t.SetField "ass_sure","�����","40"
	  t.SetField "get_sure","����","30"
	  t.SetField "sure","�ջ�","30"
	  t.SetField "chk_sure","�ջ����","50" 
      t.SetField "setdate","��������","80"
	  t.SetField "propdate","��������","80"
	  t.SetField "propName","������","50"
	  t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "cr_date","��������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "chk_date","�������","80"
      t.SetField "sure_date","�ջ�����","80"
      t.SetField "sure_name","�ջ���","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "backrate","�����˻�","50"
	  t.SetField "getchk_sure","�������","50"
	  t.SetField "getsure_date","��������","80"
	  t.SetField "getchk_suredate","�����������","80"
	  t.SetField "getchk_name","���������","65"
	  t.SetField "getsure_name","����������","65"
	  t.SetField "assName","�����","60"
	  t.SetField "assdate","�������","80"
	  t.SetField "depotid","�ջ���","80"
	  t.SetField "getdptname","�ջ�������","100"
	  't.SetField "per_date","�ֿ��������","80"
	  't.SetField "per_sure","�ֿ����","30"
	  t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  't.width="2700px"
	  
	case "2056" '�����˻��ջ�
	
	  sql="f22qry_outindentget"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","��ˮ��","140"
	  t.SetField "outindent","���뵥��","140"
	  t.SetField "set_depotid","������","100"
	  t.SetField "setdptname","����������","100"
	  t.SetField "sqnums","��������","50"
	  t.SetField "sqjpsums","������","60"
	  t.SetField "chknums","�������","50"
	  t.SetField "chkjpsums","��˽��","60"
	  t.SetField "setnums","��������","50"
	  t.SetField "setjpsums","�������","60"
	  t.SetField "getnums","�ջ�����","50"
	  t.SetField "getjpsums","�ջ����","60"
	  t.SetField "prop_sure","�ύ","30"
	  t.SetField "ass_sure","�����","40"
	  t.SetField "get_sure","����","30"
	  t.SetField "sure","�ջ�","30"
	  t.SetField "chk_sure","�ջ����","50" 
      t.SetField "setdate","��������","80"
	  t.SetField "propdate","��������","80"
	  t.SetField "propName","������","50"
	  t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "cr_date","��������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "chk_date","�������","80"
      t.SetField "sure_date","�ջ�����","80"
      t.SetField "sure_name","�ջ���","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "backrate","�����˻�","50"
	  t.SetField "getchk_sure","�������","50"
	  t.SetField "getsure_date","��������","80"
	  t.SetField "getchk_suredate","�����������","80"
	  t.SetField "getchk_name","���������","65"
	  t.SetField "getsure_name","����������","65"
	  t.SetField "assName","�����","60"
	  t.SetField "assdate","�������","80"
	  t.SetField "depotid","�ջ���","80"
	  t.SetField "getdptname","�ջ�������","100"
	  't.SetField "per_date","�ֿ��������","80"
	  't.SetField "per_sure","�ֿ����","30"
	  t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	  
	case "2017" '���η���
	  
      sql="f22qry_setmove"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
      t.SetField "moveid","��ˮ��","140"
      t.SetField "move","��������","140"
      t.SetField "setdepotid","������","50"
      t.SetField "dptname","����������","100"
      t.SetField "getdepotid","�ջ���","50"
      t.SetField "getdptname","�ջ�������","100"
      t.SetField "nums","��������","50"
      t.SetField "jpsums","�������","60"
      t.SetField "getnums","�ջ�����","50"
      t.SetField "getjpsums","�ջ����","60"
      t.SetField "setchk_name","���������","50"
      t.SetField "setcr_date","�Ƶ�����","80"
      t.SetField "setsure_name","������","50"
      t.SetField "setcr_name","�Ƶ���","50"
      t.SetField "set_sure","����","30"
      t.SetField "setchk_sure","���","30"
      t.SetField "setsure_date","��������","80"
      t.SetField "setchk_date","�������","80"
      t.SetField "set_comment","������ע","80"
      t.SetField "get_sure","�ջ�����","50"
      t.SetField "getsure_date","�ջ���������","80"
      t.SetField "get_comment","�ջ���ע","80"
      t.CSureName="setchk_sure"
      t.SureName="set_sure"
	  't.width="1600px"
	  
	case "2018" '�����ջ�
	  if session("dm").System_UserType=4 then
	    t.CommandType = 1
	    sql=" select a.moveid,a.move,a.setdepotid,a.dptname,a.getdepotid,getdptname,a.nums,a.jpsums,"& _
			" a.getnums,a.getjpsums,a.getchk_name,a.setcr_date,a.getsure_name,a.getcr_name,a.get_sure,a.getchk_sure,"& _
			" a.getsure_date,a.setsure_date,a.getchk_date,a.set_comment,a.get_comment"& _
			" from v22d_move a where a.set_sure>0 and a.getdepotid="&qts(session("dm").System_depotid)
	  else
	  sql="f22qry_getmove"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  end if
	  'de sql
	  t.SetField "moveid","��ˮ��","140"
	  t.SetField "move","��������","140"
	  t.SetField "setdepotid","������","50"
 	  t.SetField "dptname","����������","100"
	  t.SetField "getdepotid","�ջ���","50" 
      t.SetField "getdptname","�ջ�������","100"
	  t.SetField "nums","��������","50"
      t.SetField "jpsums","�������","60"
	  t.SetField "getnums","�ջ�����","50"
	  t.SetField "getjpsums","�ջ����","60"
	  t.SetField "getchk_name","�����","50"
      t.SetField "setcr_date","�Ƶ�����","80"
	  t.SetField "getsure_name","������","50"
	  t.SetField "getcr_name","�Ƶ���","50"
	  t.SetField "get_sure","����","30"
	  t.SetField "getchk_sure","���","30"
      t.SetField "getsure_date","��������","80"
	  t.SetField "setsure_date","������������","80"
      t.SetField "getchk_date","�������","80"
      t.SetField "set_comment","������ע","100"
      t.SetField "get_comment","�ջ���ע","100"
	  
	  t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  't.width="1600px"
	case "2019" '����
	  if session("dm").System_UserType=4 then
	    t.CommandType = 1
		sql="select * from vd_retail where depotid="&qts(session("dm").System_depotid)& _
		" and setdate between "& qts(rq1) &" and "&qts(rq2)
		'de sql
	  t.SetField "retailid","��ˮ��","140"
	  't.SetField "retail","���۵���","140"
	  t.SetField "depotid","���̱��","50"
	  t.SetField "d_name","��������","60"
 	  t.SetField "vipcode","�������","100"
	  't.SetField "jpsums","ԭ�۽��","60"
	  't.SetField "xpsums","�ּ۽��","60"
	  t.SetField "sums","������","60"
	  t.SetField "nums","����","50"
      t.SetField "s_sums","���տͻ����","80"
	  t.SetField "z_sums","���ҿͻ�","60"
      t.SetField "s_name","����Ա","50"
	  t.SetField "x_name","�ۻ�Ա","50"
	  t.SetField "setdate","��������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "sure_date","��������","80"
      t.SetField "sure","����","30"
	  t.SetField "sure_name","������","50"
	  t.SetField "chk_sure","���","30"
	  t.SetField "cr_date","��������","80"
	  't.SetField "comment","��ע","80"
      t.SetField "cr_date","ϵͳ��������","80"
	  t.SetField "cr_name","������","50"
      t.SetField "daystat","�������","100"
      t.SetField "chk_date","�������","80"
	  t.SetField "discount","�����ۿ�","50" 
          '�ջ���ע
      t.CSureName="chk_sure"
      t.SureName="sure"
	  else
	  sql="f22qry_retail"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "retailid","��ˮ��","140"
	  t.SetField "retail","���۵���","140"
	  t.SetField "depotid","���̱��","50"
	  t.SetField "dptname","��������","60"
 	  t.SetField "vipcode","�������","100"
	  t.SetField "jpsums","ԭ�۽��","60"
	  t.SetField "xpsums","�ּ۽��","60"
	  t.SetField "spsums","������","60"
	  t.SetField "nums","����","50"
      t.SetField "s_sums","���տͻ����","80"
	  t.SetField "z_sums","���ҿͻ�","60"
      t.SetField "s_name","����Ա","50"
	  t.SetField "x_name","�ۻ�Ա","50"
	  t.SetField "chk_name","�����","50"
	  t.SetField "sure_date","��������","80"
      t.SetField "sure","����","30"
	  t.SetField "sure_name","������","50"
	  t.SetField "chk_sure","���","30"
	  t.SetField "cr_date","��������","80"
	  t.SetField "comment","��ע","80"
      t.SetField "crdate","ϵͳ��������","80"
	  t.SetField "cr_name","������","50"
      't.SetField "setdate","��������","80"
      t.SetField "daystat","�������","100"
      t.SetField "chk_date","�������","80"
	  t.SetField "discount","�����ۿ�","50" 
          '�ջ���ע
      t.CSureName="chk_sure"
      t.SureName="sure"
	  end if
	  't.width="1900px"
	  
	case "2020" '�̵�
	
	  select case ext
	  case "0"
	    sql="f22qry_inventory"
	  case "1"
	    sql="f22qry_inventorycy"
	  case else
	    Err.Raise 50001,"main.select.3-2-4","û��ΪSQL��������!"
	  end select
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "inventoryid","��ˮ��","140"
	  t.SetField "depotid","���̱��","60"
	  t.SetField "dptname","��������","100"
	  t.SetField "nums","����","50"
	  t.SetField "jpsums","ԭ�۽��","60"
	  t.SetField "cynums","��������","50"
	  t.SetField "cysums","������","60"
	  t.SetField "d_type","�̵�����","50"
	  t.SetField "setdate","�̵�����","80"
	  t.SetField "sure_date","��������","80" 
      t.SetField "sure","����","30"
	  t.SetField "chk_name","�����","50"
	  t.SetField "sure_name","������","50"
	  t.SetField "chk_date","�������","80"
	  t.SetField "chk_sure","���","30"
	  t.SetField "cr_date","��������","80"
	  t.SetField "comment","��ע","80"
	  t.SetField "cr_name","������","50"
	  t.SetField "diff","��������","50"
	  t.SetField "inventory","�̵㵥��","140"
	  't.SetField "ov_date","�᰸����","80"
      't.SetField "ov_sure","�᰸","30"
      't.SetField "ov_name","�᰸��","50"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1600px"
	  
	case "2011" '�����˻�����
	  
	  sql="webqry_outindentzcsq"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","��ˮ��","140"
	  t.SetField "outindent","���뵥��","140"
	  t.SetField "set_depotid","������","100"
	  t.SetField "setdptname","����������","100"
	  t.SetField "sqnums","��������","50"
	  t.SetField "sqjpsums","������","60"
	  t.SetField "chknums","�������","50"
	  t.SetField "chkjpsums","��˽��","60"
	  t.SetField "setnums","��������","50"
	  t.SetField "setjpsums","�������","60"
	  t.SetField "getnums","�ջ�����","50"
	  t.SetField "getjpsums","�ջ����","60"
	  t.SetField "prop_sure","�ύ","30"
	  t.SetField "ass_sure","�����","40"
	  t.SetField "get_sure","����","30"
	  t.SetField "sure","�ջ�","30"
	  t.SetField "chk_sure","�ջ����","50" 
      t.SetField "setdate","��������","80"
	  t.SetField "propdate","��������","80"
	  t.SetField "propName","������","50"
	  t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "cr_date","��������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "chk_date","�������","80"
      t.SetField "sure_date","�ջ�����","80"
      t.SetField "sure_name","�ջ���","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "backrate","�����˻�","50"
	  t.SetField "getchk_sure","�������","50"
	  t.SetField "getsure_date","��������","80"
	  t.SetField "getchk_suredate","�����������","80"
	  t.SetField "getchk_name","���������","65"
	  t.SetField "getsure_name","����������","65"
	  t.SetField "assName","�����","60"
	  t.SetField "assdate","�������","80"
	  t.SetField "depotid","�ջ���","80"
	  t.SetField "getdptname","�ջ�������","100"
	  't.CSureName="getchk_sure"
      't.SureName="get_sure"
	  t.CSureName="prop_sure"
      t.SureName="prop_sure"
	  't.width="2700px"
	case "2012" '�����˻�����
	  
	  sql="webqry_outindenttssq"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","��ˮ��","140"
	  t.SetField "outindent","���뵥��","140"
	  t.SetField "set_depotid","������","100"
	  t.SetField "setdptname","����������","100"
	  t.SetField "sqnums","��������","50"
	  t.SetField "sqjpsums","������","60"
	  t.SetField "chknums","�������","50"
	  t.SetField "chkjpsums","��˽��","60"
	  t.SetField "setnums","��������","50"
	  t.SetField "setjpsums","�������","60"
	  t.SetField "getnums","�ջ�����","50"
	  t.SetField "getjpsums","�ջ����","60"
	  t.SetField "prop_sure","�ύ","30"
	  t.SetField "ass_sure","�����","40"
	  t.SetField "get_sure","����","30"
	  t.SetField "sure","�ջ�","30"
	  t.SetField "chk_sure","�ջ����","50" 
      t.SetField "setdate","��������","80"
	  t.SetField "propdate","��������","80"
	  t.SetField "propName","������","50"
	  t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "cr_date","��������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "chk_date","�������","80"
      t.SetField "sure_date","�ջ�����","80"
      t.SetField "sure_name","�ջ���","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "backrate","�����˻�","50"
	  t.SetField "getchk_sure","�������","50"
	  t.SetField "getsure_date","��������","80"
	  t.SetField "getchk_suredate","�����������","80"
	  t.SetField "getchk_name","���������","65"
	  t.SetField "getsure_name","����������","65"
	  t.SetField "assName","�����","60"
	  t.SetField "assdate","�������","80"
	  t.SetField "depotid","�ջ���","80"
	  t.SetField "getdptname","�ջ�������","100"
	  t.CSureName="prop_sure"
      t.SureName="prop_sure"
	  't.width="2700px"
	case "5-1-3" '�˻����
	  
	  sql="f22qry_outindentchk"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","��ˮ��","140"
	  t.SetField "outindent","���뵥��","140"
	  t.SetField "depotid","�ջ���","140"
 	  t.SetField "sure","�ջ�","50"
	  t.SetField "chk_sure","�ջ����","30" 
          t.SetField "setdate","��������","80"
	  t.SetField "cr_name","�Ƶ���","50"
          t.SetField "cr_date","��������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "chk_date","�������","80"
          t.SetField "sure_date","�ջ�����","80"
          t.SetField "sure_name","�ջ���","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "backrate","�����˻�","30"
	  t.SetField "per_date","�ֿ��������","80"
	  t.SetField "per_sure","�ֿ����","30"
	  t.SetField "set_depotid","������","100"
          t.SetField "getchk_sure","�ջ����","30"
          t.SetField "get_sure","����","30"
          t.SetField "getsure_date","��������","80"
          t.SetField "getchk_suredate","�����������","80"
          t.SetField "getchk_name","���������","50"
          t.SetField "getsure_name","����������","50"
          t.SetField "assName","�����","60"
          t.SetField "assdate","�������","80"
          t.SetField "ass_sure","�����","30"
          t.SetField "propName","������","50"
          t.SetField "propdate","��������","80"
          t.SetField "prop_sure","�ύ","30"
          t.SetField "getdptname","�ջ�������","100"
          t.SetField "setdptname","����������","100"
          t.SetField "sqipsums","������","60"
          t.SetField "sqnums","��������","50"
          t.SetField "chkipsums","��˽��","60"
          t.SetField "chknums","�������","50"
          t.SetField "setipsums","�������","60"
          t.SetField "setnums","��������","50"
          t.SetField "getipsums","�ջ���","60"
          t.SetField "getnums","�ջ�����","50"
	  t.CSureName="ass_sure"
      t.SureName="ass_sure"
	  't.width="2700px"
	  
	case "2014" '�˻�����
	  
	  sql="webqry_outindentset"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","��ˮ��","140"
	  t.SetField "outindent","���뵥��","140"
	  t.SetField "set_depotid","������","100"
	  t.SetField "setdptname","����������","100"
	  t.SetField "sqnums","��������","50"
	  t.SetField "sqjpsums","������","60"
	  t.SetField "chknums","�������","50"
	  t.SetField "chkjpsums","��˽��","60"
	  t.SetField "setnums","��������","50"
	  t.SetField "setjpsums","�������","60"
	  t.SetField "getnums","�ջ�����","50"
	  t.SetField "getjpsums","�ջ����","60"
	  t.SetField "prop_sure","�ύ","30"
	  t.SetField "ass_sure","�����","40"
	  t.SetField "get_sure","����","30"
	  t.SetField "sure","�ջ�","30"
	  t.SetField "chk_sure","�ջ����","50" 
      t.SetField "setdate","��������","80"
	  t.SetField "propdate","��������","80"
	  t.SetField "propName","������","50"
	  t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "cr_date","��������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "chk_date","�������","80"
      t.SetField "sure_date","�ջ�����","80"
      t.SetField "sure_name","�ջ���","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "backrate","�����˻�","50"
	  t.SetField "getchk_sure","�������","50"
	  t.SetField "getsure_date","��������","80"
	  t.SetField "getchk_suredate","�����������","80"
	  t.SetField "getchk_name","���������","65"
	  t.SetField "getsure_name","����������","65"
	  t.SetField "assName","�����","60"
	  t.SetField "assdate","�������","80"
	  t.SetField "depotid","�ջ���","80"
	  t.SetField "getdptname","�ջ�������","100"
	  't.SetField "per_date","�ֿ��������","80"
	  't.SetField "per_sure","�ֿ����","30"
	  t.CSureName="getchk_sure"
      t.SureName="get_sure"
	  't.width="2700px"
	case "5-1-5" '�˻��ջ�
	  
	  sql="f22qry_outindentget"
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "outindentid","��ˮ��","140"
	  t.SetField "outindent","���뵥��","140"
	  t.SetField "depotid","�ջ���","140"
 	  t.SetField "sure","�ջ�","50"
	  t.SetField "chk_sure","�ջ����","30" 
          t.SetField "setdate","��������","80"
	  t.SetField "cr_name","�Ƶ���","50"
          t.SetField "cr_date","��������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "chk_date","�������","80"
          t.SetField "sure_date","�ջ�����","80"
          t.SetField "sure_name","�ջ���","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "backrate","�����˻�","30"
	  t.SetField "per_date","�ֿ��������","80"
	  t.SetField "per_sure","�ֿ����","30"
	  t.SetField "set_depotid","������","100"
          t.SetField "getchk_sure","�ջ����","30"
          t.SetField "get_sure","����","30"
          t.SetField "getsure_date","��������","80"
          t.SetField "getchk_suredate","�����������","80"
          t.SetField "getchk_name","���������","50"
          t.SetField "getsure_name","����������","50"
          t.SetField "assName","�����","60"
          t.SetField "assdate","�������","80"
          t.SetField "ass_sure","�����","30"
          t.SetField "propName","������","50"
          t.SetField "propdate","��������","80"
          t.SetField "prop_sure","�ύ","30"
          t.SetField "getdptname","�ջ�������","100"
          t.SetField "setdptname","����������","100"
          t.SetField "sqipsums","������","60"
          t.SetField "sqnums","��������","50"
          t.SetField "chkipsums","��˽��","60"
          t.SetField "chknums","�������","50"
          t.SetField "setipsums","�������","60"
          t.SetField "setnums","��������","50"
          t.SetField "getipsums","�ջ���","60"
          t.SetField "getnums","�ջ�����","50"
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	case "2060"
	  if session("dm").System_UserType=4 then
	    t.CommandType = 1
		select case ext
		case 0
		  sql="select * from v22d_indent where d_type=1 and  getdepotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select * from v22d_indent where d_type=1 and isnull(chk_sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select * from v22d_indent where d_type=1 and isnull(chk_sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select * from v22d_indent where d_type=1 and isnull(chk_sure,0)>0 and isnull(sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select * from v22d_indent where d_type=1 and isnull(sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		end select
		
	  t.SetField "indentid","��ˮ��","140"
	  't.SetField "phcnt","���","30"
 	  't.SetField "fhcnt","����","30"
	  t.SetField "getdepotid","�ջ���","70"
	  t.SetField "getdptname","�ջ�������","80"
	  t.SetField "selltype","��������","60"
	  t.SetField "getdate","�ƻ���������","80"
	  t.SetField "nums","��������","50"
	  t.SetField "sums","�������","60"
	  't.SetField "phnums","�������","50"
	  't.SetField "phjpsums","������","60"
	  't.SetField "fhnums","��������","50"
	  't.SetField "fhjpsums","�������","60"
	  t.SetField "sure","����","30"
	  t.SetField "sure_date","��������","60"
	  t.SetField "sure_name","������","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "setdepotid","������","50"
	  t.SetField "setdptname","����������","80"
      t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "chk_sure","���","30"
	  t.SetField "chk_name","�����","50"
      t.SetField "cr_date","�Ƶ�����","60"
	  t.SetField "ov_sure","�᰸","30"
	  t.SetField "ov_date","�᰸����","60"
	  t.SetField "backrate","�����ۿ�","60"
	  t.SetField "backdate","��������","60"
	  t.SetField "indent","������","140"
	  end if
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	  t.height="100%"
	case "2061"
	  if session("dm").System_UserType=4 then
	    t.CommandType = 1
		select case ext
		case 0
		  sql="select * from v22d_indent where d_type=2 and  getdepotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select * from v22d_indent where d_type=2 and isnull(chk_sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select * from v22d_indent where d_type=2 and isnull(chk_sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select * from v22d_indent where d_type=2 and isnull(chk_sure,0)>0 and isnull(sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select * from v22d_indent where d_type=2 and isnull(sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		end select
	  t.SetField "indentid","��ˮ��","140"
	  't.SetField "phcnt","���","30"
 	  't.SetField "fhcnt","����","30"
	  t.SetField "getdepotid","�ջ���","70"
	  t.SetField "getdptname","�ջ�������","80"
	  t.SetField "selltype","��������","60"
	  t.SetField "getdate","�ƻ���������","80"
	  t.SetField "nums","��������","50"
	  t.SetField "sums","�������","60"
	  't.SetField "phnums","�������","50"
	  't.SetField "phjpsums","������","60"
	  't.SetField "fhnums","��������","50"
	  't.SetField "fhjpsums","�������","60"
	  t.SetField "sure","����","30"
	  t.SetField "sure_date","��������","60"
	  t.SetField "sure_name","������","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "setdepotid","������","50"
	  t.SetField "setdptname","����������","80"
      t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "chk_sure","���","30"
	  t.SetField "chk_name","�����","50"
      t.SetField "cr_date","�Ƶ�����","60"
	  t.SetField "ov_sure","�᰸","30"
	  t.SetField "ov_date","�᰸����","60"
	  t.SetField "backrate","�����ۿ�","60"
	  t.SetField "backdate","��������","60"
	  t.SetField "indent","������","140"
	  end if
      t.CSureName="chk_sure"
      t.SureName="sure"
	  't.width="1800px"
	  t.height="100%"
	case "2062"
	    t.CommandType = 1
		select case ext
		case 0
		  sql="select * from v22d_move where  getdepotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select * from v22d_move where  isnull(getchk_sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select * from v22d_move where  isnull(getchk_sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select * from v22d_move where  isnull(getchk_sure,0)>0 and isnull(get_sure,0)=0 and  getdepotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select * from v22d_move where  isnull(get_sure,0)>0 and  getdepotid="&qts(session("dm").System_depotid)
		end select
	  t.SetField "moveid","��ˮ��","140"
	  t.SetField "move","��������","140"
	  t.SetField "setdepotid","������","50"
 	  t.SetField "dptname","����������","100"
	  t.SetField "getdepotid","�ջ���","50" 
      t.SetField "getdptname","�ջ�������","100"
	  t.SetField "nums","��������","50"
      t.SetField "jpsums","�������","60"
	  t.SetField "getnums","�ջ�����","50"
	  t.SetField "getjpsums","�ջ����","60"
	  t.SetField "getchk_name","�����","50"
      t.SetField "setcr_date","�Ƶ�����","80"
	  t.SetField "getsure_name","������","50"
	  t.SetField "getcr_name","�Ƶ���","50"
	  t.SetField "get_sure","����","30"
	  t.SetField "getchk_sure","���","30"
      t.SetField "getsure_date","��������","80"
	  t.SetField "setsure_date","������������","80"
      t.SetField "getchk_date","�������","80"
      t.SetField "set_comment","������ע","100"
      t.SetField "get_comment","�ջ���ע","100"
	  
	  t.CSureName="getchk_sure"
      t.SureName="get_sure"
	case "2063" '��������
	    t.CommandType = 1
		dim s
		s=",(select sum(nums) from d_outindentPROsub b where a.outindentid=b.outindentid)as sqnums,"& _
			"(select sum(nums) from d_outindentCHKsub b where a.outindentid=b.outindentid)as chknums,"& _
			"(select sum(nums) from d_outindentSETsub b where a.outindentid=b.outindentid)as setnums,"& _
			"(select sum(nums) from d_outindentsub b where a.outindentid=b.outindentid)as getnums,"& _
			"(select b.d_name from j_depot b where a.set_depotid=b.depotid )as setdptname,"& _
			"(select b.d_name from j_depot b where a.depotid=b.depotid )as getdptname "
		select case ext
		case 0
		  sql="select a.* "&s&" from d_outindentpro a where set_depotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select a.* "&s&" from d_outindentpro a where  isnull(getchk_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select a.* "&s&" from d_outindentpro a where  isnull(getchk_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select a.* "&s&" from d_outindentpro a where  isnull(getchk_sure,0)>0 and isnull(get_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select a.* "&s&" from d_outindentpro a where  isnull(get_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		end select
	  t.SetField "outindentid","��ˮ��","140"
	  't.SetField "outindent","���뵥��","140"
	  t.SetField "set_depotid","������","100"
	  t.SetField "setdptname","����������","100"
	  t.SetField "sqnums","��������","50"
	  't.SetField "sqjpsums","������","60"
	  t.SetField "chknums","�������","50"
	  't.SetField "chkjpsums","��˽��","60"
	  t.SetField "setnums","��������","50"
	  't.SetField "setjpsums","�������","60"
	  t.SetField "getnums","�ջ�����","50"
	  't.SetField "getjpsums","�ջ����","60"
	  t.SetField "prop_sure","�ύ","30"
	  t.SetField "ass_sure","�����","40"
	  t.SetField "get_sure","����","30"
	  t.SetField "sure","�ջ�","30"
	  t.SetField "chk_sure","�ջ����","50" 
      t.SetField "setdate","��������","80"
	  t.SetField "propdate","��������","80"
	  t.SetField "propName","������","50"
	  t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "cr_date","��������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "chk_date","�������","80"
      t.SetField "sure_date","�ջ�����","80"
      t.SetField "sure_name","�ջ���","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "backrate","�����˻�","50"
	  t.SetField "getchk_sure","�������","50"
	  t.SetField "getsure_date","��������","80"
	  t.SetField "getchk_suredate","�����������","80"
	  t.SetField "getchk_name","���������","65"
	  t.SetField "getsure_name","����������","65"
	  t.SetField "assName","�����","60"
	  t.SetField "assdate","�������","80"
	  t.SetField "depotid","�ջ���","80"
	  t.SetField "getdptname","�ջ�������","100"
	  't.CSureName="getchk_sure"
      't.SureName="get_sure"
	  t.CSureName="prop_sure"
      t.SureName="prop_sure"
	case "2064" '��������
	    t.CommandType = 1
		s=",(select sum(nums) from d_outindentPROsub b where a.outindentid=b.outindentid)as sqnums,"& _
			"(select sum(nums) from d_outindentCHKsub b where a.outindentid=b.outindentid)as chknums,"& _
			"(select sum(nums) from d_outindentSETsub b where a.outindentid=b.outindentid)as setnums,"& _
			"(select sum(nums) from d_outindentsub b where a.outindentid=b.outindentid)as getnums,"& _
			"(select b.d_name from j_depot b where a.set_depotid=b.depotid )as setdptname,"& _
			"(select b.d_name from j_depot b where a.depotid=b.depotid )as getdptname "
		select case ext
		case 0
		  sql="select a.* "&s&" from d_outindent a where set_depotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)>0 and isnull(get_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select a.* "&s&" from d_outindent a where  isnull(get_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		end select
	  t.SetField "outindentid","��ˮ��","140"
	  't.SetField "outindent","���뵥��","140"
	  t.SetField "set_depotid","������","100"
	  t.SetField "setdptname","����������","100"
	  t.SetField "sqnums","��������","50"
	  't.SetField "sqjpsums","������","60"
	  t.SetField "chknums","�������","50"
	  't.SetField "chkjpsums","��˽��","60"
	  t.SetField "setnums","��������","50"
	  't.SetField "setjpsums","�������","60"
	  t.SetField "getnums","�ջ�����","50"
	  't.SetField "getjpsums","�ջ����","60"
	  t.SetField "prop_sure","�ύ","30"
	  t.SetField "ass_sure","�����","40"
	  t.SetField "get_sure","����","30"
	  t.SetField "sure","�ջ�","30"
	  t.SetField "chk_sure","�ջ����","50" 
      t.SetField "setdate","��������","80"
	  t.SetField "propdate","��������","80"
	  t.SetField "propName","������","50"
	  t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "cr_date","��������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "chk_date","�������","80"
      t.SetField "sure_date","�ջ�����","80"
      t.SetField "sure_name","�ջ���","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "backrate","�����˻�","50"
	  t.SetField "getchk_sure","�������","50"
	  t.SetField "getsure_date","��������","80"
	  t.SetField "getchk_suredate","�����������","80"
	  t.SetField "getchk_name","���������","65"
	  t.SetField "getsure_name","����������","65"
	  t.SetField "assName","�����","60"
	  t.SetField "assdate","�������","80"
	  t.SetField "depotid","�ջ���","80"
	  t.SetField "getdptname","�ջ�������","100"
	  't.CSureName="getchk_sure"
      't.SureName="get_sure"
	  t.CSureName="prop_sure"
      t.SureName="prop_sure"
	case "2065" '�˻�����
	    t.CommandType = 1
		s=",(select sum(nums) from d_outindentPROsub b where a.outindentid=b.outindentid)as sqnums,"& _
			"(select sum(nums) from d_outindentCHKsub b where a.outindentid=b.outindentid)as chknums,"& _
			"(select sum(nums) from d_outindentSETsub b where a.outindentid=b.outindentid)as setnums,"& _
			"(select sum(nums) from d_outindentsub b where a.outindentid=b.outindentid)as getnums,"& _
			"(select b.d_name from j_depot b where a.set_depotid=b.depotid )as setdptname,"& _
			"(select b.d_name from j_depot b where a.depotid=b.depotid )as getdptname "
		select case ext
		case 0
		  sql="select a.* "&s&" from d_outindent a where set_depotid="&qts(session("dm").System_depotid)
		case 1
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 2
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		case 3
		  sql="select a.* "&s&" from d_outindent a where  isnull(getchk_sure,0)>0 and isnull(get_sure,0)=0 and  set_depotid="&qts(session("dm").System_depotid)
		case 4
		  sql="select a.* "&s&" from d_outindent a where  isnull(get_sure,0)>0 and  set_depotid="&qts(session("dm").System_depotid)
		end select
	  t.SetField "outindentid","��ˮ��","140"
	  't.SetField "outindent","���뵥��","140"
	  t.SetField "set_depotid","������","100"
	  t.SetField "setdptname","����������","100"
	  t.SetField "sqnums","��������","50"
	  't.SetField "sqjpsums","������","60"
	  t.SetField "chknums","�������","50"
	  't.SetField "chkjpsums","��˽��","60"
	  t.SetField "setnums","��������","50"
	  't.SetField "setjpsums","�������","60"
	  t.SetField "getnums","�ջ�����","50"
	  't.SetField "getjpsums","�ջ����","60"
	  t.SetField "prop_sure","�ύ","30"
	  t.SetField "ass_sure","�����","40"
	  t.SetField "get_sure","����","30"
	  t.SetField "sure","�ջ�","30"
	  t.SetField "chk_sure","�ջ����","50" 
      t.SetField "setdate","��������","80"
	  t.SetField "propdate","��������","80"
	  t.SetField "propName","������","50"
	  t.SetField "cr_name","�Ƶ���","50"
	  t.SetField "cr_date","��������","80"
	  t.SetField "chk_name","�����","50"
	  t.SetField "chk_date","�������","80"
      t.SetField "sure_date","�ջ�����","80"
      t.SetField "sure_name","�ջ���","50"
	  t.SetField "comment","��ע","80"
	  t.SetField "backrate","�����˻�","50"
	  t.SetField "getchk_sure","�������","50"
	  t.SetField "getsure_date","��������","80"
	  t.SetField "getchk_suredate","�����������","80"
	  t.SetField "getchk_name","���������","65"
	  t.SetField "getsure_name","����������","65"
	  t.SetField "assName","�����","60"
	  t.SetField "assdate","�������","80"
	  t.SetField "depotid","�ջ���","80"
	  t.SetField "getdptname","�ջ�������","100"
	  't.CSureName="getchk_sure"
      't.SureName="get_sure"
	  t.CSureName="chk_sure"
      t.SureName="sure"
	case "2066" 'POS�̵�
	  t.CommandType = 1
	  select case ext
	  case "0"
	    'sql="f22qry_inventory"
	sql="SELECT TOP 100 PERCENT d_inventory.inventoryid,"& _
		 "MAX(d_inventory.inventory) AS inventory,"& _
		 "MAX(d_inventory.depotid) AS depotid, "& _
		 "MAX(j_depot.d_name) AS d_name,"& _
		 "MAX(d_inventory.setdate) AS setdate, "& _
		 "MAX(d_inventory.d_type) AS d_type,"& _
		 "MAX(d_inventory.sure_name) AS sure_name,"& _
		 "MAX(d_inventory.ov_date) AS ov_date, "& _
		 "MAX(d_inventory.ov_sure) AS ov_sure,"& _
		 "MAX(d_inventory.ov_name) AS ov_name, "& _
		 "MAX(d_inventory.sure) AS sure, "& _
		 "MAX(d_inventory.chk_sure) AS chk_sure, "& _
		 "MAX(d_inventory.cr_date) AS cr_date, "& _
		 "MAX(d_inventory.cr_name) AS cr_name,"& _
		 "MAX(d_inventory.chk_name) AS chk_name, "& _
		 "MAX(d_inventory.chk_date) AS chk_date, "& _
		 "MAX(d_inventory.sure_date) AS sure_date,"& _
		 "MAX(d_inventory.comment) AS comment, MAX(d_inventory.crdate) AS crdate,"& _
		 "SUM(d_inventorysub.nums) AS nums,"& _
		 "SUM(ISNULL(d_inventorysub.s_price,0) * ISNULL(d_inventorysub.nums, 0)) AS SumS,"& _
		 "MIN(d_inventory.diff) AS diff"& _
		 "FROM d_inventory LEFT OUTER JOIN"& _
		 "j_depot ON d_inventory.depotid = j_depot.depotid LEFT OUTER JOIN"& _
		 "d_inventorysub ON"& _
		 "d_inventory.inventoryid = d_inventorysub.inventoryid"& _
		 "GROUP BY d_inventory.inventoryid "

	  case "1"
	    sql="f22qry_inventorycy"
	 sql="SELECT TOP 100 PERCENT d_inventory.inventoryid,"& _
		 "MAX(d_inventory.inventory) AS inventory,"& _
		 "MAX(d_inventory.depotid) AS depotid, "& _
		 "MAX(j_depot.d_name) AS dptname,"& _
		 "MAX(d_inventory.setdate) AS setdate, "& _
		 "MAX(d_inventory.d_type) AS d_type,"& _
		 "MAX(d_inventory.sure_name) AS sure_name,"& _
		 "MAX(d_inventory.ov_date) AS ov_date, "& _
		 "MAX(d_inventory.ov_sure) AS ov_sure,"& _
		 "MAX(d_inventory.ov_name) AS ov_name, "& _
		 "MAX(d_inventory.sure) AS sure, "& _
		 "MAX(d_inventory.chk_sure) AS chk_sure, "& _
		 "MAX(d_inventory.cr_date) AS cr_date, "& _
		 "MAX(d_inventory.cr_name) AS cr_name,"& _
		 "MAX(d_inventory.chk_name) AS chk_name, "& _
		 "MAX(d_inventory.chk_date) AS chk_date, "& _
		 "MAX(d_inventory.sure_date) AS sure_date,"& _
		 "MAX(d_inventory.comment) AS comment, MAX(d_inventory.crdate) AS crdate,"& _
		 "SUM(d_inventorysub.nums) AS nums,"& _
		 "SUM(ISNULL(d_inventorysub.s_price,0) * ISNULL(d_inventorysub.nums, 0)) AS sums,"& _
		 "SUM(ISNULL(d_inventorysub.d_nums,0)) AS cynums,"& _
		 "SUM(ISNULL(d_inventorysub.s_price,0) * ISNULL(d_inventorysub.d_nums, 0)) AS cysums,"& _
		 "MIN(d_inventory.diff) AS diff "& _
		 " FROM d_inventory LEFT OUTER JOIN"& _
		 " j_depot ON d_inventory.depotid = j_depot.depotid LEFT OUTER JOIN"& _
		 " d_inventorysub ON"& _
		 " d_inventory.inventoryid = d_inventorysub.inventoryid "& _
		 " JOIN j_style ON d_inventorysub.styleid=j_style.styleid "& _
		 " GROUP BY d_inventory.inventoryid "
	  case else
	    Err.Raise 50001,"main.select.3-2-4","û��ΪSQL��������!"
	  end select
      t.setParam "@rq1",adVarchar,30,rq1
      t.setParam "@rq2",adVarchar,30,rq2
      t.setParam "@userid",adVarchar,10,UserId
      t.setParam "@type",adInteger,4,stype
	  t.setParam "@worktype",adVarChar,20,ext
	  t.SetField "inventoryid","��ˮ��","140"
	  t.SetField "depotid","���̱��","60"
	  t.SetField "dptname","��������","100"
	  t.SetField "nums","����","50"
	  t.SetField "Sums","ԭ�۽��","60"
	  t.SetField "cynums","��������","50"
	  t.SetField "cysums","������","60"
	  t.SetField "d_type","�̵�����","50"
	  t.SetField "setdate","�̵�����","80"
	  t.SetField "sure_date","��������","80" 
      t.SetField "sure","����","30"
	  t.SetField "chk_name","�����","50"
	  t.SetField "sure_name","������","50"
	  t.SetField "chk_date","�������","80"
	  t.SetField "chk_sure","���","30"
	  t.SetField "cr_date","��������","80"
	  t.SetField "comment","��ע","80"
	  t.SetField "cr_name","������","50"
	  t.SetField "diff","��������","50"
	  t.SetField "inventory","�̵㵥��","140"
	  't.SetField "ov_date","�᰸����","80"
      't.SetField "ov_sure","�᰸","30"
      't.SetField "ov_name","�᰸��","50"
      t.CSureName="chk_sure"
      t.SureName="sure"
	case else  
      Err.Raise 50001,"main.select.else","û��Ϊcom��������!"
  end select
  
  t.CommandText=sql
  t.Show
  set t=Nothing
else%>
  <div id="gt1" style="width:100%;height:100%">
  <table><thead><tr>
  <th width="140">��ˮ��</th>
  <th width="140">��������</th>
  <th width="50">������</th>
  <th width="100">����������</th>
  <th width="50">�ջ���</th>
  <th width="100">�ջ�������</th>
  <th width="50">����</th>
  <th width="60">���</th>
  </tr></thead></table>
<%end if%>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><input type="hidden" name="te" value=""/></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td>&nbsp;</td>
  </tr>
</table>
</div>
  <script language="javascript">
    try{
	 gt = new GtEditTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
<form name="formtmp" method="post" action=""></form>
</body>
</html>
<!--#include file="inc/foot.asp" -->