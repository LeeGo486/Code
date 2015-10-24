<%option explicit
Response.Expires=-1000%>
<!--#include file="../f22/inc/function.asp"-->
<!--#include file="../f22/inc/Class.asp"-->
<%
dim f_date,l_date
f_date=trim(request.QueryString("f_date"))
if f_date="" then
   f_date=get_date(date)
end if
l_date=trim(request.QueryString("l_date"))
if l_date="" then
   l_date=get_date(date)
end if


dim lastdate
lastdate = date()-10
lastdate=get_date(lastdate)
 %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>无标题文档</title>
    <link href="css/gt.css" rel="stylesheet" type="text/css">
    <script language="javascript" src="../f22/inc/function.js"></script>
    <script language="javascript" src="../f22/inc/gridtable.js"></script>
        <script src="../inc/js/setday.js" type="text/javascript"></script>
    <script src="../../../jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script language="javascript">
        var id = "";
        function gtDoSelect(t) {
            var row = t.getSelectedRow();
            id = row.cells[0].innerHTML;
        }
        function gtDoDblClick(t) {
            try {
                var row = t.getSelectedRow();
                id = row.cells[1].innerText;
                if (id == '合计') { return false; }
                var dptname = row.cells[1].innerText;
                window.returnValue = id;
                window.close();
            } catch (ex) {
                alert(ex);
            }
        }
        function gtchkselect(t) {
            var val = "";
            var checks = document.getElementsByTagName("input");
            for (var i = 0; i < checks.length; i++) {
                if (checks[i].type == "checkbox") {
                    if (checks[i].checked) {
                        if (val != "") { val = val + ","; }
                        val = val + checks[i].value;
                    }
                }
                }
            window.returnValue = val;
            window.close();
        }


        $(function () {
            //     setTimeout(function () { $("#query").click(); }, 30);

            $("input[type='checkbox']").click(function () {
                if ($(this).attr("checked")) {
                    $("input[type='checkbox']").attr("checked", false);
                    $(this).attr("checked", true);
                }
            });
        });

        function chkdate() {
            var f_date = $("#f_date").val();
            var l_date = $("#l_date").val();

            var reg = /^(\d{4})-(\d{2})-(\d{2})$/;
            var r = f_date.match(reg);
            if (r == null || r == "") {
                alert("开始日期格式错误!");
                $("#f_date").focus();
                return false;
            }

            l = l_date.match(reg);
            if (l == null || l == "") {
                alert("结束日期格式错误!");
                $("#l_date").focus();
                return false;
            }

            if (f_date < '<%=lastdate %>') {
                alert("只能查询10天内的零售单！");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
  <table width="100%"  border="0" cellpadding="0" cellspacing="0" class="f12">
  <form name="form1" method="get" action="selectRetailSub.asp" target="sms">
    <tr>
      <td> 
       开始日期: <input  name="f_date" type="text" id="f_date" value="<%=f_date %>" maxlength="10" size="10" class="box"  onFocus="setday(this);"  onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
       结束日期: <input name="l_date" type="text" id="l_date" value="<%=l_date %>"  maxlength="10" size="10" class="box"  onFocus="setday(this);"  onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
      <input type="submit" name="Submit" value="查询(S)" accesskey="s" id="query" onclick="return chkdate()" />
      <input  type="text" id="id" style="display:none;" />
	 
	  </td>
    </tr></form>
  </table>

    <div id="">
<%dim sql,depotid,begdate,enddate
depotid=trim(session("dm").System_depotid)
 
if request("f_date") ="" then 
    begdate = get_date(date)
else 
    begdate = request("f_date") 
end if
if request("l_date") ="" then 
    enddate = get_date(date) 
else
    enddate = request("l_date") 
end if
 

begdate = begdate&" 00:00:00"
enddate = enddate&" 23:59:59"

 
    sql="  select   '<input type=""checkbox"" name=""ckdx"" value=""'+a.retailid+'"" />'  dx, "&_
        " a.retailid,convert(varchar(10),a.sure_date,126) sure_date,   "&_
        " a.zssums,a.FCalcSums,CASE WHEN ISNULL(a.zssums,0)=0 THEN 0 ELSE CAST((1.0*a.FCalcSums/ISNULL(a.zssums,0)) AS NUMERIC(12,2))  END  FCalcDisc "&_
        " from d_retail a left join vip_user b on a.retailid=b.FBuyID  "&_
        " where b.FBuyID is null and  a.sure>0 and a.depotid='"&depotid&"'  "&_
        " and a.sure_date  between '"&begdate&"' and '"&enddate&"'   "&_
        " AND ISNULL(a.vipcode,'') = ''"


dim t
set t = new Table
t.ActiveConnection = cn
t.CommandType = 1
t.CommandText = sql
t.IsAutoColor=1
t.setField "dx","选择","30",2
t.setField "retailid","销售单号","160",2
t.setField "sure_date","销售日期","100",2
t.setField "zssums","结算金额","80",2
t.setField "FCalcSums","实销金额","80",2
t.Show
set t = nothing
        %>
    </div>
</body>
</html>
