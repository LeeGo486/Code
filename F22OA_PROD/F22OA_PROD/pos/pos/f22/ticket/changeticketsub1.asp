<!--#include file="../../f22/inc/function.asp"-->
<!--#include file="../report/inc/Class.asp" -->
<%
vipid=trim(request("vipid"))
VerifyMsg=trim(request("VerifyMsg"))

%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>���ֶһ�ȯ</title>
    <link href="../report/css/gt.css" rel="stylesheet" type="text/css">

    <script language="JavaScript" src="../report/inc/function.js"></script>

    <script language="JavaScript" src="../report/inc/gridtable.js"></script>

</head>

<script type="text/javascript">
    var chgid = ""

    function gtDoSelect(t) {
        var row = t.getSelectedRow();
        var tmpid = row.cells[0].outerText;
        var ss = tmpid.split(".");
        chgid = ss[0];
        if (ss[1] == 0)
        { document.form1.bs.readOnly = true; }
        else
        { document.form1.bs.readOnly = false; }
    }

    function change() {
        var bs = document.form1.bs.value;
        var msg = false;
        var psendmsg = '<%=session("psendmsg1")%>';
        var SendMas = '<%=session("CF_Pos_SendMas")%>';
        if ((psendmsg.toLowerCase() == 'true') && (SendMas != '1')) {
            msg = document.form1.sendmsg.checked;
        }
        chkradio();
        if (chgid == "")
        { alert("��ѡ��һ�������");return false;}
        else{
            if ('<%=VerifyMsg %>' == "True") {
                //������֤����ܶһ�
                parent.showMsgDilog();
            } else {
                if (confirm("ȷ���һ���")) {
                    window.parent.location.href = "changeticketsave.asp?vipid=<%=vipid%>&chgid=" + chgid + "&bs=" + bs + "&msg=" + msg + "&hid=" + document.getElementById("hid_kg").value;
                }
            }
        }
    }

    function btnChange() {
        var bs = document.form1.bs.value;
        var msg = false;
        var psendmsg = '<%=session("psendmsg1")%>';
        var SendMas = '<%=session("CF_Pos_SendMas")%>';
        if ((psendmsg.toLowerCase() == 'true') && (SendMas != '1')) {
            msg = document.form1.sendmsg.checked;
        }
        chkradio();
        if (chgid == "")
        { alert("��ѡ��һ�������"); return false; }

         window.parent.location.href = "changeticketsave.asp?vipid=<%=vipid%>&chgid=" + chgid + "&bs=" + bs + "&msg=" + msg + "&hid=" + document.getElementById("hid_kg").value;
    }

    function chkkp() {
        if (event.keyCode < 45 || event.keyCode > 57) { event.returnValue = false; }
    }

    function chkblur() {
        var obj = document.form1.bs;
        if (isNaN(obj.value))
        { alert('�������ʹ���'); obj.focus(); }
        obj.value = Math.floor(obj.value);
        if (obj.value <= 0)
        { obj.value = 1; }
    }

    function chkradio() {
        var k = document.getElementById("rd_tot").checked;
        if (k == 0) {
            document.getElementById("hid_kg").value = 1;
        } else {
            document.getElementById("hid_kg").value = 0;
        }
    }
</script>

<body>
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="bar">
        <form action="changeticketsub.asp" method="post" name="form1" target="is">
        <tr>
            <td>
                ���ֻ�����ʽ��
                <input id="rd_tot" type="radio" name="rd" checked="checked" />�ܻ���
                <input id="rd_shang" type="radio" name="rd" />�ϼ�����
                <input id="hid_kg" name="hid_kg" type="hidden" />
            </td>
            <td>
                ���Զһ��ķ�����
            </td>
            <td align="right">
                ������<input type="text" name="bs" value="1" size="5" readonly onkeypress="chkkp()"
                    onblur="chkblur()" onfocus="this.select()">
                <%if  session("CF_Pos_SendMas")<>1 and session("psendmsg1")=true then %>
                <input type="checkbox" name="sendmsg" value="Y" checked>
                ����֪ͨ
                <% end if %>
                <input type="button" name="send" value=" �� �� " onclick="change()">
            </td>
        </tr>
        </form>
    </table>
    <%
sql="select rtrim(cast(a.chgid as varchar(2)))+'.'+cast(a.sureup as varchar(1)) as chgid,"&_
    "a.chgname,a.tictypeid,d.tictypename,d.ticketpre,a.jf,a.sums,"&_
    "case when a.ttype=0 then '��ֵȯ' when a.ttype=1 then  '�ֽ�ȯ' else '�ۿ�ȯ' end ttype,case when a.sureup=1 then '����' else '' end sureup,"&_
	"case when a.acttype=0 then '����Ч����' else case when a.acttype=1 then '����ֹ����' else '�����ڶ�' end end as acttype,"&_
	"a.days,a.closedate,a.begdate,a.enddate "&_
    "from vip_ticketchange a,vip_cardvip b,vip_user c,vip_tictype d "&_
    "where a.viptypeid=b.viptypeid and b.vipcardid=c.vipcode and c.vipid='"&vipid&"' and a.tictypeid=d.tictypeid "&_
    "and a.sure=1 and isnull(c.pcentum,0)+isnull(c.centum,0)+isnull(b.starcentum,0)>=a.jf order by a.chgid"
    
    
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
t.SetField "chgid","���","30",3
t.SetField "chgname","��������","140",0
t.SetField "tictypename","ȯ����","60",4
t.SetField "ttype","ȯ����","50",4
t.SetField "jf","�������","50",4
t.SetField "sums","�һ����","50",4
t.SetField "sureup","������","50",4
t.SetField "acttype","��Ч��ʽ","70",4
t.SetField "days","��Ч����","50",4
t.SetField "closedate","��ֹ����","60",4
t.SetField "begdate","��Ч����","60",4
t.SetField "enddate","ʧЧ����","60",4
t.height="88%"
t.show
set t=nothing%>

    <script language="javascript">
        try {
            gt = new GtTable("gt1");
            gtTables.addTable(gt);
            gt.loadTable();
        } catch (ex) { }
    </script>

</body>
</html>
