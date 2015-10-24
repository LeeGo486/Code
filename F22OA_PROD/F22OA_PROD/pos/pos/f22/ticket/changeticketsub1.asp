<!--#include file="../../f22/inc/function.asp"-->
<!--#include file="../report/inc/Class.asp" -->
<%
vipid=trim(request("vipid"))
VerifyMsg=trim(request("VerifyMsg"))

%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>积分兑换券</title>
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
        { alert("请选择兑换方案！");return false;}
        else{
            if ('<%=VerifyMsg %>' == "True") {
                //短信验证后才能兑换
                parent.showMsgDilog();
            } else {
                if (confirm("确定兑换吗？")) {
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
        { alert("请选择兑换方案！"); return false; }

         window.parent.location.href = "changeticketsave.asp?vipid=<%=vipid%>&chgid=" + chgid + "&bs=" + bs + "&msg=" + msg + "&hid=" + document.getElementById("hid_kg").value;
    }

    function chkkp() {
        if (event.keyCode < 45 || event.keyCode > 57) { event.returnValue = false; }
    }

    function chkblur() {
        var obj = document.form1.bs;
        if (isNaN(obj.value))
        { alert('数据类型错误！'); obj.focus(); }
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
                积分换购方式：
                <input id="rd_tot" type="radio" name="rd" checked="checked" />总积分
                <input id="rd_shang" type="radio" name="rd" />上季积分
                <input id="hid_kg" name="hid_kg" type="hidden" />
            </td>
            <td>
                可以兑换的方案：
            </td>
            <td align="right">
                倍数：<input type="text" name="bs" value="1" size="5" readonly onkeypress="chkkp()"
                    onblur="chkblur()" onfocus="this.select()">
                <%if  session("CF_Pos_SendMas")<>1 and session("psendmsg1")=true then %>
                <input type="checkbox" name="sendmsg" value="Y" checked>
                短信通知
                <% end if %>
                <input type="button" name="send" value=" 兑 换 " onclick="change()">
            </td>
        </tr>
        </form>
    </table>
    <%
sql="select rtrim(cast(a.chgid as varchar(2)))+'.'+cast(a.sureup as varchar(1)) as chgid,"&_
    "a.chgname,a.tictypeid,d.tictypename,d.ticketpre,a.jf,a.sums,"&_
    "case when a.ttype=0 then '抵值券' when a.ttype=1 then  '现金券' else '折扣券' end ttype,case when a.sureup=1 then '翻倍' else '' end sureup,"&_
	"case when a.acttype=0 then '按有效天数' else case when a.acttype=1 then '按截止日期' else '按日期段' end end as acttype,"&_
	"a.days,a.closedate,a.begdate,a.enddate "&_
    "from vip_ticketchange a,vip_cardvip b,vip_user c,vip_tictype d "&_
    "where a.viptypeid=b.viptypeid and b.vipcardid=c.vipcode and c.vipid='"&vipid&"' and a.tictypeid=d.tictypeid "&_
    "and a.sure=1 and isnull(c.pcentum,0)+isnull(c.centum,0)+isnull(b.starcentum,0)>=a.jf order by a.chgid"
    
    
set t=new Table
t.Activeconnection = cn
t.Commandtype=1
t.CommandText=sql
t.SetField "chgid","编号","30",3
t.SetField "chgname","方案名称","140",0
t.SetField "tictypename","券类型","60",4
t.SetField "ttype","券种类","50",4
t.SetField "jf","所需积分","50",4
t.SetField "sums","兑换面额","50",4
t.SetField "sureup","允许翻倍","50",4
t.SetField "acttype","生效方式","70",4
t.SetField "days","有效天数","50",4
t.SetField "closedate","截止日期","60",4
t.SetField "begdate","生效日期","60",4
t.SetField "enddate","失效日期","60",4
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
