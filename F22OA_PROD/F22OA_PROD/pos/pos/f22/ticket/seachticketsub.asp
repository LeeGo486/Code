<!--#include file="../../f22/inc/function.asp"-->
<!--#include file="../report/inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ѯȯ</title>
<link href="../report/css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../report/inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../report/inc/gridtable.js"></SCRIPT>
</head>

<body>
<% 
id=request("id")
act=request("act")
if act="" then
	if id<>"" then act=0 else act=1 end if
end if

ticketid=trim(request("ticketid"))
depotid=trim(session("dm").system_depotid)

%>


<%if id="" then%>
  <table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
  <form action="?" method="post" name="form1">
      <tr>
        <td>
          <input type="hidden" value="<%=id%>" name="id" id="id" />
          <label><input type="radio" name="act" value="0" 
          onClick="document.form1.submit()" <%if act=0 then response.write("checked") end if%> />����ȯ</label>
          <label><input type="radio" name="act" value="1" 
          onClick="document.form1.submit()" <%if act=1 then response.write("checked") end if%> />δǩ��</label>
          <label><input type="radio" name="act" value="2"
           onClick="document.form1.submit()" <%if act=2 then response.write("checked") end if%> />��ǩ��δ����</label>
          <label><input type="radio" name="act" value="3" 
          onClick="document.form1.submit()" <%if act=3 then response.write("checked") end if%> />�ѷ���δ����</label>
          <label><input type="radio" name="act" value="4" 
          onClick="document.form1.submit()" <%if act=4 then response.write("checked") end if%> />�ѻ���</label>
          <label><input type="radio" name="act" value="5" 
          onClick="document.form1.submit()" <%if act=5 then response.write("checked") end if%> />ָ��ȯ��</label>
          <input type="text" name="ticketid" size="25">
          <input type="submit" name="submit1" value=" �� ѯ ">
      </td>
      </tr>
  </form>
  </table>
<%else%>
<!--#��Ч����Ч�ģ�-->
<%end if%>
<%

select case act
case 0 tj=" and ((a.setdepotid='"&depotid&"' and a.setsure>0) or (a.getsure>0 and a.getdepotid='"&depotid&"')) "
case 1 tj=" and a.setsure>0 and a.signsure=0 and a.setdepotid='"&depotid&"' "
case 2 tj=" and a.signsure>0 and a.sellsure=0 and a.setdepotid='"&depotid&"' "
case 3 tj=" and a.sellsure>0 and a.getsure=0 and a.setdepotid='"&depotid&"' "
case 4 tj=" and a.getsure>0 and a.getdepotid='"&depotid&"' "
case 5 tj=" and a.ticketid='"&ticketid&"' "
end select

'VIP
if id<>"" then tj=tj&" and a.vipid='"&id&"'"

sql="select a.ticket,a.ticketid,a.tckname,b.tictypename,"&_
    "case when a.dtype=0 then '�����û�' else case when dtype=1 then '��ͨ�û�' else 'VIP�û�' end end as dtype,"&_
    "case when a.ttype=0 then '��ֵȯ' when a.ttype=1 then  '�ֽ�ȯ' else '�ۿ�ȯ' end ttype,a.sums,a.sellsums,a.fbegdate,a.fenddate,"&_
    "case when a.acttype=0 then '����Ч����' else case when acttype=1 then '����ֹ����' else '�����ڶ�' end end acttype,"&_
    "a.days,a.closedate,a.begdate,a.enddate,a.setdepotid,c.d_name as setdptname,a.signsure,a.signdate,a.signname,"&_
	"a.sellsure,a.selldate,a.sellname,a.getsure,a.getdate,a.getname "&_
	"from vip_ticket a inner join vip_tictype b on a.tictypeid=b.tictypeid left join j_depot c on a.setdepotid=c.depotid "&_
	"where a.freeze=0 "&tj&" order by a.ticket"
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
t.SetField "ticket","ȯ��ˮ��","120",3
t.SetField "ticketid","ȯ��","120",3
t.SetField "tckname","ȯ����","80",0
t.SetField "tictypename","ȯ����","60",4
t.SetField "dtype","ʹ�÷�Χ","60",4
t.SetField "ttype","ȯ����","60",4
t.SetField "sums","��ֵ���","50",1
t.SetField "sellsums","������","50",1
t.SetField "fbegdate","���ſ�ʼ����","80",4
t.SetField "fenddate","���Ž�������","80",4
t.SetField "acttype","��Ч��ʽ","70",4
t.SetField "days","��Ч����","50",4
t.SetField "closedate","��ֹ����","60",4
t.SetField "begdate","��Ч����","60",4
t.SetField "enddate","ʧЧ����","60",4
t.SetField "setdepotid","���ŵ���","50",4
t.SetField "setdptname","���ŵ�������","80",4
t.SetField "signsure","ǩ��","30",4
t.SetField "signdate","ǩ������","80",4
t.SetField "signname","ǩ����","50",4
t.SetField "sellsure","����","30",4
t.SetField "selldate","��������","80",4
t.SetField "sellname","������","50",4
t.SetField "getsure","����","30",4
t.SetField "getdate","��������","80",4
t.SetField "getname","������","50",4
t.height="93%"
t.show
set t=nothing
%>
</body>
</html>
<script language="javascript">
try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>