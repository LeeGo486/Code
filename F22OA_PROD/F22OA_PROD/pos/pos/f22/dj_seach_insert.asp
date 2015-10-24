<!--#include file="inc/function.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
userid=session("dm").System_userid
names=request("names")
mobel=request("mobel")
tel=request("tel")
styleid=request("styleid")
nums=request("nums")
fullprice=request("fullprice")
djprice=request("djprice")
setdate=request("setdate")
getdate=request("getdate")
adds=request("adds")
comment=request("comment")
depotid=session("dm").System_depotid

if request("act")=1 then
  id=getid("d_retaildj","retaildjid","DJ",""&userid&"")
  sql="insert into d_retaildj (retaildjid,retaildj,depotid,names,mobel,tel,styleid,nums,fullprice,djprice,setdate,getdate,adds,comment,cr_date,cr_name) values "&_
      "('"&id&"','"&id&"','"&depotid&"','"&names&"','"&mobel&"','"&tel&"','"&styleid&"',"&nums&","&fullprice&","&djprice&",'"&setdate&"','"&getdate&"','"&adds&"','"&comment&"',getdate(),'"&na&"')"
  cn.execute sql
  response.Write("<script language=javascript>alert('添加成功！');window.returnValue='true';window.close();</script>")
else
  id=request("id")
  sql="update d_retaildj set names='"&names&"',mobel='"&mobel&"',tel='"&tel&"',styleid='"&styleid&"',nums="&nums&",fullprice="&fullprice&_
      ",djprice="&djprice&",setdate='"&setdate&"',getdate='"&getdate&"',adds='"&adds&"',comment='"&comment&"' where retaildjid='"&id&"'"
  cn.execute sql
  response.Write("<script language=javascript>alert('修改成功！');window.returnValue='true';window.close();</script>")
end if
cn.close
set cn=nothing%>