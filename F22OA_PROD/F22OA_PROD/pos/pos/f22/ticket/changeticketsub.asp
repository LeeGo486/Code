<!--#include file="../../f22/inc/function.asp"-->
<!--#include file="../report/inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���ֶһ�ȯ</title>
<link href="../report/css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../report/inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../report/inc/gridtable.js"></SCRIPT>
<script src="../../../../jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="../../../../b28web/Retail/Scripts/VipIdentify.js" type="text/javascript"></script>
<script src="../../../../b28web/Utility/jquery.blockUI.js" type="text/javascript"></script>
</head>

<body>
<%
act=request("act")
if act=""  then  act=0  
vipcode=trim(request("vipcode"))
'��ȡ
if request.cookies("vipflash")("cut")=1 and trim(request("id"))="" then
   vipcode=mid(vipcode,request.cookies("vipflash")("beg"),request.cookies("vipflash")("cnt"))
end if
%>
<table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
<form action="?" method="post" name="form1">
<input type="hidden" name="vipcode" value="<%=vipcode%>">
    <tr>
      <td>
        <label><input type="radio" name="act" value="0" 
        onClick="document.form1.submit()" <%if act=0 then response.write("checked") end if%>>�˿͵���</label>
        <label><input type="radio" name="act" value="1" 
        onClick="document.form1.submit()" <%if act=1 then response.write("checked") end if%>>δʹ�õĶһ�ȯ</label>
        <label><input type="radio" name="act" value="2" 
        onClick="document.form1.submit()" <%if act=2 then response.write("checked") end if%>>��ʹ�õĶһ�ȯ</label>
        </td>
    </tr>
</form>
</table>
<%set rs=server.CreateObject("adodb.recordset")
select case act
case 0 call vipda()
case 1 call ticketw()
case 2 call ticketo()
end select
set rs=nothing

sub vipda()
sql="select ISNULL(a.VerifyMsg,0) VerifyMsg,a.vipid,vipcodejm='*****',a.vipcode,a.vipname,a.vipsex,a.vipbirth,a.mobtel,isnull(a.centum,0)+isnull(b.starcentum,0) as centum ,isnull(a.pcentum,0) as pcentum "&_
    "from vip_user a,vip_cardvip b where a.vipcode=b.vipcardid and a.vipcode='"&vipcode&"' "&_ 
    "and convert(char(10),b.vipemit+isnull(b.limitday,0),126)>=convert(char(10),getdate(),126) "&_
    "and convert(char(10),isnull(b.viplastdate,getdate())+isnull(b.maxday,0),126)>=convert(char(10),getdate(),126)"
rs.open sql,cn
if rs.eof then
   ebox(vipcode&"�����ڻ�δ���Ż��ѹ��ڣ�")
else
   vipid=rs("vipid")
   VerifyMsg =rs("VerifyMsg")
end if
rs.close

set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
t.SetField "vipid","�˿ͱ��","140",3
t.SetField "vipname","�˿�����","60",0
if  session("pos_vipshow")=true then 
  t.SetField "vipcodejm","VIP��","80",4
else
  t.SetField "vipcode","VIP��","80",4
end  if 
t.SetField "vipsex","�Ա�","30",4
t.SetField "vipbirth","����","60",4
't.SetField "mobtel","�ֻ�","80",4
t.SetField "centum","�ܻ���","80",4
t.SetField "pcentum","�ϼ�����","80",4
t.height="30%"
t.show
set t=nothing%>
<iframe name="is" id="is" width="100%" height="62%" frameborder="0" src="changeticketsub1.asp?vipid=<%=vipid%>&VerifyMsg=<%=VerifyMsg %>"></iframe>
<%end sub

sub ticketw()
sql="select a.ticketid,a.tckname,b.tictypename,"&_
    "case when a.dtype=0 then '�����û�' else case when dtype=1 then '��ͨ�û�' else 'VIP�û�' end end as dtype,"&_
    "case when a.ttype=0 then '��ֵȯ' else '�ֽ�ȯ' end ttype,a.sums,a.sellsums,a.fbegdate,a.fenddate,"&_
    "case when a.acttype=0 then '����Ч����' else case when acttype=1 then '����ֹ����' else '�����ڶ�' end end acttype,"&_
    "a.days,a.closedate,a.begdate,a.enddate,a.setdepotid,c.d_name as setdptname,a.selldate,a.sellname,a.vipid "&_
	"from vip_ticket a inner join vip_tictype b on a.tictypeid=b.tictypeid left join j_depot c on a.setdepotid=c.depotid "&_
	"inner join vip_user d on a.vipid=d.vipid "&_
	"where a.freeze=0 and a.sellsure>0 and a.getsure=0 and d.vipcode='"&vipcode&"' order by a.ticketid"
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
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
t.SetField "selldate","��������","80",4
t.SetField "sellname","������","50",4
t.height="92%"
t.show
set t=nothing
end sub

sub ticketo()
sql="select a.ticketid,a.tckname,b.tictypename,"&_
    "case when a.dtype=0 then '�����û�' else case when dtype=1 then '��ͨ�û�' else 'VIP�û�' end end as dtype,"&_
    "case when a.ttype=0 then '��ֵȯ' else '�ֽ�ȯ' end ttype,a.sums,a.sellsums,a.fbegdate,a.fenddate,"&_
    "case when a.acttype=0 then '����Ч����' else case when acttype=1 then '����ֹ����' else '�����ڶ�' end end acttype,"&_
    "a.days,a.closedate,a.begdate,a.enddate,a.setdepotid,c.d_name as setdptname,a.selldate,a.sellname,"&_
	"a.getdepotid,e.d_name as getdptname,a.getdate,a.getname "&_
	"from vip_ticket a inner join vip_tictype b on a.tictypeid=b.tictypeid left join j_depot c on a.setdepotid=c.depotid "&_
	"inner join vip_user d on a.vipid=d.vipid inner join j_depot e on a.getdepotid=e.depotid "&_
	"where a.freeze=0 and a.getsure>0 and d.vipcode='"&vipcode&"' order by a.ticketid"
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
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
t.SetField "selldate","��������","80",4
t.SetField "sellname","������","50",4
t.SetField "setdepotid","���յ���","50",4
t.SetField "setdptname","���յ�������","80",4
t.SetField "selldate","��������","80",4
t.SetField "sellname","������","50",4
t.height="92%"
t.show
set t=nothing
end sub%>
<script language="javascript">
    //��ʾ���ŶԻ���
    function showMsgDilog() {
        SendVipMsg("change", "<%=vipcode%>", btnChange)
    }

    //ȷ�϶һ�
    function btnChange() {
        is.window.btnChange(); 
    }
try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
</html>
