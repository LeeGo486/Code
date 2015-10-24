<%option explicit
Response.Expires=-1000%>
<!--#include file="../f22/inc/function.asp"-->
<!--#include file="../f22/inc/Class.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="../f22/css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../f22/inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../f22/inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript">
var id="";
function gtDoSelect(t){
	var row = t.getSelectedRow();
	id=row.cells[0].innerHTML;
}
function gtDoDblClick(t){
  try{
	var row = t.getSelectedRow();
	id=row.cells[0].innerText;
    window.returnValue=""+row.cells[0].innerText.replace(/^\s+|\s+$/g,"")+"";
    window.close();
  }catch(ex){
		alert(ex);
		}
}

function gtDoEnter(t){
}
</script>
</head>

<body>
<div id="">
<%dim sql,vipid,depotid, key, cond
depotid=trim(session("dm").System_depotid)
vipid = trim(request.QueryString("vipid"))
key = trim(request.QueryString("key"))

dim rs
set rs=server.CreateObject("adodb.recordset")
if key = "" then
    cond = ""
else
    cond = " and a.vipcardid = " &qts(key) 
end if

sql = "select a.vipcardid, b.viptypename from vip_cardvip a inner join vip_typevip b on a.viptypeid=b.viptypeid "&_
      " inner join vip_user c on a.viptypeid = c.viptypeid and c.vipid='"&vipid&"' "&_
      " left join vip_user d on a.vipcardid = d.vipcode "&_
      " where isnull(a.vipid,'')='' and vipemitadd="&qts(depotid)&" and d.vipcode is null "&cond

'de sql
dim t
set t = new Table
t.ActiveConnection = cn
t.CommandType = 1
t.CommandText = sql
t.IsAutoColor=1

t.setField "vipcardid","VIP卡号","80",2
t.setField "viptypename","VIP卡类型","120",2
t.Show

set t = nothing%>
</div>
</body>
</html>
