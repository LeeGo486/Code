<!--#include file="../../f22/inc/function.asp"-->
<!--#include file="../report/inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ǩ��ȯ</title>
<link href="../report/css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../report/inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../report/inc/gridtable.js"></SCRIPT>
</head>

<%
act=request("act")
depotid=trim(session("dm").System_depotid)
username=trim(session("dm").System_Username)
 
 
if act="" then act=0 end if
select case act
case 0 call ticket1()
case 1 call ticket2()
end select



sub ticket1

types=request("types")
ticketid=trim(request("ticketid"))
'ǩ��
if types="sign" then
   set rs=server.CreateObject("adodb.recordset")
   sql="select ticketid from vip_ticket where ticketid='"&ticketid&"' and setdepotid='"&depotid&"' and setsure>0 and signsure=0 and freeze=0"
   'de sql
   rs.open sql,cn
   if rs.eof then
	  response.Write("<script>")
	  response.write("alert('"&ticketid&"ȯǩ��ʧ�ܣ�\n\n1����ȯ�Ų����ڻ����ڱ��ꣻ\n2����ȯ��ǩ�գ�');")
	  response.write("window.location.href='signticketsub.asp?act=0';")
	  response.write("</script>")
	  response.End()
   else
      sql="update vip_ticket set signsure=1,signdate=getdate(),signname='"&username&"' where ticketid='"&ticketid&"' "
      cn.execute sql
   end if
   rs.close
   set rs=nothing
end if 
%>
<body onLoad="document.all.ticketid.focus()">
<table width="100%"  border="0" cellpadding="0" cellspacing="1">
<form name="form1" method="post" action="?">
<input type="hidden" name="act" value="<%=act%>">
<input type="hidden" name="types" value="sign">
    <tr>
      <td>&nbsp;&nbsp;����ǩ�յ�ȯ�ţ�
	  <input type="text" name="ticketid" size="32" onFocus="this.select()">
	  </td>
    </tr>
</form>
</table>
<%
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
sql="select a.ticket,a.ticketid,a.tckname,a.tictypeid,b.tictypename,"&_
    "case when a.dtype=0 then '�����û�' else case when dtype=1 then '��ͨ�û�' else 'VIP�û�' end end as dtype,"&_
    "case when a.ttype=0 then '��ֵȯ' when a.ttype=1 then  '�ֽ�ȯ' else '�ۿ�ȯ' end ttype,a.sums,a.fbegdate,a.fenddate,"&_
    "case when a.acttype=0 then '����Ч����' else case when acttype=1 then '����ֹ����' else '�����ڶ�' end end acttype,"&_
    "a.days,a.closedate,a.begdate,a.enddate "&_
    "from vip_ticket a inner join vip_tictype b on a.tictypeid=b.tictypeid "&_
	"where a.freeze=0 and a.setsure>0 and a.signsure=0 and a.setdepotid='"&depotid&"' order by a.ticket"
t.CommandText=sql
t.SetField "ticket","ȯ��ˮ��","120",3
t.SetField "ticketid","ȯ��","120",3
t.SetField "tckname","ȯ����","80",0
t.SetField "tictypeid","ȯ����","45",4
t.SetField "tictypename","ȯ��������","70",4
t.SetField "dtype","ʹ�÷�Χ","60",4
t.SetField "ttype","ȯ����","50",4
t.SetField "sums","��ֵ���","50",1
t.SetField "fbegdate","���ſ�ʼ����","80",4
t.SetField "fenddate","���Ž�������","80",4
t.SetField "acttype","��Ч��ʽ","80",4
t.SetField "days","��Ч����","50",4
t.SetField "closedate","��ֹ����","60",4
t.SetField "begdate","��Ч����","60",4
t.SetField "enddate","ʧЧ����","60",4
t.height="95%"
t.show
set t=nothing%>

<script language="javascript">
try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
<%end sub

sub ticket2
uid=request("uid")
'ǩ��
if uid<>"" then
   tmpid=split(uid,",")
   if ubound(tmpid)<>2 then
      mbox("��������")
   end if
   tictypeid=trim(tmpid(0))
   ttype=trim(tmpid(1))
   sums=trim(tmpid(2))
   sql="update vip_ticket set signsure=1,signdate=getdate(),signname='"&username&"' "&_
       "where tictypeid='"&tictypeid&"' and ttype="&ttype&" and sums="&sums&" and freeze=0 and setsure>0 and signsure=0 "&_
	   "and setdepotid='"&depotid&"'"
   cn.execute sql
end if%>
<script type="text/javascript">
var uid="";

function gtDoSelect(t){
	var row = t.getSelectedRow();
	uid=row.cells[0].outerText;
}

function signticket()
{if(uid!="")
  { if(confirm('ȷ��ǩ����'))
     {window.location.href="signticketsub.asp?act=<%=act%>&uid="+uid;}
  }
  else
  {alert("��ѡ���¼��");}
}
</script>
<body>
<form name="form2" method="post" action="?">
<table width="100%"  border="0" cellpadding="0" cellspacing="1">
    <tr align="right">
      <td><input type="button" name="sign" value=" ǩ �� " onClick="signticket()"> </td>
    </tr>
</table>
<%
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
sql="select max(rtrim(a.tictypeid)+','+cast(a.ttype as varchar(2))+','+cast(a.sums as varchar(20))) as uid,"&_
    "a.tictypeid,max(b.tictypename) as tictypename,"&_
    "case when a.ttype=0 then '��ֵȯ' when a.ttype=1 then  '�ֽ�ȯ' else '�ۿ�ȯ' end ttype,a.sums,count(*) as cnt,sum(a.sums) as ssums "&_
    "from vip_ticket a inner join vip_tictype b on a.tictypeid=b.tictypeid "&_
	"where a.freeze=0 and a.setsure>0 and a.signsure=0 and a.setdepotid='"&depotid&"' "&_
	"group by a.tictypeid,case when a.ttype=0 then '��ֵȯ' when a.ttype=1 then  '�ֽ�ȯ' else '�ۿ�ȯ' end ,a.sums"
t.CommandText=sql
'de sql
t.SetField "uid","���","30",4
t.SetField "tictypename","ȯ��������","80",3
t.SetField "ttype","ȯ����","60",0
t.SetField "sums","��ֵ���","60",4
t.SetField "cnt","����","50",1
t.SetField "ssums","�ϼƽ��","80",1
t.height="95%"	
t.show()
set t=nothing%>
</form>
<script language="javascript">
try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
<%end sub%>

</html>
