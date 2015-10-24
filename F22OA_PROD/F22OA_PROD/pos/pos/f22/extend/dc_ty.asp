<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
</head>

<body>
<%dim id,sql,ds,ds1,tname,i,userid
id=trim(request.QueryString("id"))
userid=trim(session("dm").System_UserId)

select case id
case "1"
  id="8002"
  tname="新产品调查"
case "2"
  id="8003"
  tname="竞争品牌调查"
case "3"
  id="8004"
  tname="促销效果调查"
case else
  id="8002"
  tname="通用调查"
end select%>
<table width="100%"  border="0" bordercolor="#C6AEA5" background="../img/smbg_b.gif" class="bk">
  <tr>
    <td height="21" class="f14"> 业务中心 &gt;&gt; 扩展功能 &gt;&gt; <%=tname%></td>
  </tr>
</table>
<table width="100"  border="0">
    <tr>
      <td></td>
    </tr>
</table>
<%set ds=server.CreateObject("ADODB.Recordset")
ds.Activeconnection = cn
ds.source="select pid,pname,sdate,edate from web_product where enable=1 "'and cid="&id
ds.open
if ds.eof then
  pid=-1
else
  pid=ds("pid")
  pname=ds("pname")
  sdate=ds("sdate")
  edate=ds("edate")
end if
%>
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr>
    <td class="f14">调查项目: <span class="notice"></span> </td>
    <td colspan="5" class="f14"><span class="notice"><font size="3"><%=pname%>&nbsp;</font></span></td>
  </tr>
  <tr>
    <td width="11%" class="f14">店铺:</td>
    <td width="16%" class="f14"><select name="depotid" id="depotid" onChange="jump(this);">
      <%
set ds1=server.CreateObject("ADODB.Recordset")
ds1.ActiveConnection = cn
sql="select depotid,d_name from webp_depot where userid="&qts(userid)
ds1.Source = sql
ds1.Open
while not ds1.eof%>
      <option value="<%=ds1(0)%>" <%if depotid=trim(ds1(0)) then response.Write "selected" end if%>><%=ds1(1)%></option>
      <%ds1.movenext
		wend
		ds1.Close%>
    </select></td>
    <td width="9%" class="f14">调查人:</td>
    <td width="24%" class="f14"><%=session("dm").System_UserName%>
    <input name="cr_name" type="hidden" id="cr_name" value="<%=session("dm").System_UserName%>"></td>
    <td width="10%" class="f14">调查时间:</td>
    <td width="30%" class="f14"><%=sdate%> 到 <%=edate%></td>
  </tr>
</table>
<table width="100" border="0">
  <tr>
    <td></td>
  </tr>
</table>
<form name="form1" method="post" action="dc_ty_save.asp">
<%
sql="select qid,title from web_quest where pid="&pid
ds.close
ds.Source = sql
ds.open
i=-1%>
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
<%while not ds.eof
i=i+1%>
  <tr>
    <td height="28" bgcolor="#FFF7F7" class="f14"><%=i+1%>、<%=ds("title")%>
      <input name="qid<%=i%>" type="hidden" id="qid<%=i%>" value="<%=ds("qid")%>">
      </td>
  </tr>
  <tr>
    <td height="54" class="f14">
  <table border="0">
      <tr><%ds1.source="select aid,title,score from web_answer where qid='"&ds("qid")&"'"
  ds1.open
  
  while not ds1.eof%>
        <td>
          <table  border="0" class="f12">
            <tr>
              <td height="24"><input type="radio" name="aid<%=i%>" value="<%=ds1("score")%>,<%=ds1("title")%>">
                  <%=ds1("title")%> </td>
            </tr>
			<%ds1.movenext
			if not ds1.eof then
			%>
            <tr>
              <td height="24"><input type="radio" name="aid<%=i%>" value="<%=ds1("score")%>,<%=ds1("title")%>">
                  <%=ds1("title")%>
                 </td>
            </tr>
			<%end if%>
          </table>
          </td><%if not ds1.eof then
			ds1.movenext
			end if
	wend
	ds1.close%>
      </tr>
    </table>
</td>
  </tr>

<%ds.movenext
wend
ds.close
set ds1=nothing
set ds=nothing%>
</table>

<input name="count" type="hidden" id="count" value="<%=i%>">
<table width="100%" border="1" cellspacing="0" bordercolor="#C6AEA5" bordercolorlight="#C6AEA5" bordercolordark="#FFFFFF">
  <tr>
    <td align="center"><input type="submit" name="Submit" value="完成调查">
      </td>
  </tr>
</table>
</form>
</body>
</html>
