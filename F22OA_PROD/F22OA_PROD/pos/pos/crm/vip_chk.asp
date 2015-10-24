<%option explicit%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridedittable.js"></SCRIPT>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
</head>
<%
dim ds,sql,depotid,t,str
dim vipcode
depotid=trim(session("dm").System_depotid)
set ds=server.createobject("adodb.recordset")
ds.activeconnection=cn
if trim(request.form("vipcode"))<>"" then
   vipcode=trim(request.form("vipcode"))
   
   if request.cookies("vipflash")("cut")=1 then
	  str=" substring('"&vipcode&"',"&request.cookies("vipflash")("beg")&","&request.cookies("vipflash")("cnt")&")=a.vipcode" 
   else
	  str=" a.vipcode='"&vipcode&"'"
   end if
   
   sql="select 1 from vip_user a,vip_cardvip b where "&str&" and a.vipcode=b.vipcardid "&_
             "and convert(char(10),b.begdate,126)<=convert(char(10),getdate(),126) "&_
             "and convert(char(10),getdate(),126)<=convert(char(10),b.enddate,126) "&_
             "and convert(char(10),isnull(b.viplastdate,getdate())+isnull(b.maxday,0),126)>=convert(char(10),getdate(),126)"
   'de sql
   ds.source=sql
   ds.open
   if ds.eof then
    response.write"<script>alert('此VIP不存在或还未发放或已过期，请重新输入！');</script>"
	else
	sql="select a.vipid,vipcodejm='*****',a.vipcode,a.vipname,isnull(a.sums,0)+isnull(b.starsums,0) as sums,isnull(a.centum,0)+isnull(b.starcentum,0) as centum,"&_
	    "a.vipbirth,a.vipsex,substring(convert(char(10),a.vipbirth,126),6,5) as sr,a.city,a.mobtel,a.vipadd,a.viptel "&_
		"from vip_user a,vip_cardvip b where "&str&" and a.vipcode=b.vipcardid"
   end if
end if
%>
<body>
<table width=100% height=150 border=0 bgcolor=#ffffff>
				<tr><form name="chkvip_form" method="post"><td width="41%" vAlign=top>
                  顾客VIP卡号:
                    <input name="vipcode" <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %> id="vipcode" size="20"> 
                    <input type="submit" name="Submit" value="查询">
                   </td></form>
				  <td width="59%" height="20" vAlign=top>备注：
                    <input type="text" name="textfield">
                    　
                    <input type="submit" name="Submit" value="  发放  "></td>
				</tr>
				<tr>
				  <td colspan="2" vAlign=top>
<%
if sql<>"" then
  set t=New Table
  t.ActiveConnection =cn
  t.CommandType=1
  'sql= "select vipid,vipname,vipsex,vipbirth,viptel,mobtel,vipemail,vipadd,vipcode from vip_user where isnull(vipcode,'')<>'' and depotid="&qts(depotid)
  t.SetField "vipid","编号","80"
  		  if session("pos_vipshow")=true then
		    t.SetField "vipcodejm","VIP卡","60"
		  else    
		    t.SetField "vipcode","VIP卡","60"
		  end if   
        
          t.SetField "vipname","姓名","50"
          t.SetField "sums","储值","60"
		  t.SetField "centum","积分","60"
		  t.SetField "sr","生日","60"
		  t.SetField "vipsex","性别","30"
		  t.SetField "vipbirth","出生日期","60"
		  t.SetField "city","所属区域","60"
		  t.SetField "mobtel","移动电话","60"
		  t.SetField "viptel","固定电话","60"
		  t.SetField "vipadd","联系地址","120"
		   t.width="98%"
		   t.height="100"
		    t.CommandText=sql
  t.Show
  set t=Nothing
%>
                    <%else%>
                    <div id="gt1" style="width:90%;height:100">
                      <table>
                        <thead>
                          <tr>
                            <th width="140">编号</th>
                            <th width="140">VIP卡</th>
                            <th width="50">姓名</th>
                            <th width="100">储值</th>
                            <th width="50">积分</th>
                            <th width="100">生日</th>
                            <th width="50">性别</th>
                            <th width="60">出生日期</th>
                            <th width="60">证件号</th>
                            <th width="60">所属区域</th>
                            <th width="60">电子邮件</th>
                            <th width="60">移动电话</th>
                            <th width="60">固定电话</th>
                            <th width="60">联系地址</th>
                          </tr>
                        </thead>
                      </table>
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
                    </div></td>
				  </tr>
				</table>
				<script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
</html>
