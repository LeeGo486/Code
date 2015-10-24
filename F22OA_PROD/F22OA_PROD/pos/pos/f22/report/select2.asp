<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>选择款式</title>

<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="../css/webfxtab.css" disabled="disabled" />
<style type="text/css">
.dynamic-tab-pane-control .tab-page {height:200px;}
.dynamic-tab-pane-control .tab-page .dynamic-tab-pane-control .tab-page {height:100px;}
html, body {background:	ThreeDFace;}
form {margin:0;
	  padding:0;}
body {margin:		10px;
	  width:		auto;
	  height:		auto;}
.dynamic-tab-pane-control h2 {
	text-align:	center;
	width:		auto;}

.dynamic-tab-pane-control h2 a {
	display:	inline;
	width:		auto;}
.dynamic-tab-pane-control a:hover {	background: transparent;}
</style>
<script type="text/javascript" src="../css/tabpane.js"></script>

<script language="javascript" src="abc.js"></script>
<base target="_self">
<SCRIPT LANGUAGE="JScript">
function ltra(){//全部从左到右
  var s1=document.form1.s1;
  var s2=document.form2.s1;
  var c=s1.length;
  var tmp;
  var s="<select name='s1' size=\"20\" multiple id=\"s1\" style=\"width:250px;height:100% \">";
  s=s+s2.innerHTML+s1.innerHTML+"</select>"
  d2.innerHTML=s;
  s1.innerHTML="";
  tmp=document.form1.count1.value;
  tmp=parseInt(tmp)
  document.form2.count2.value=parseInt(document.form2.count2.value)+tmp;
  document.form1.count1.value="0";
  document.form2.count1.value="0";
}
function rtla(){//全部从右到左
  var s1=document.form1.s1;
  var s2=document.form2.s1;
  var c=s2.length;
  var tmp,v1,v2;
  var s="<select name='s1' size=\"20\" multiple id=\"s1\" style=\"width:250px;height:100% \">";
  s=s+s1.innerHTML+s2.innerHTML+"</select>"
  d1.innerHTML=s;
  s2.innerHTML="";
  tmp=document.form2.count2.value;
  tmp=parseInt(tmp)
  document.form1.count1.value=parseInt(document.form1.count1.value)+tmp;
  document.form2.count2.value="0";
  document.form2.count1.value=parseInt(document.form1.count1.value);
}
function ltr(){//选定从左到右
  var s1=document.form1.s1;
  var s2=document.form2.s1;
  var sv,so,str2,j,count,v1,v2;
  j=s1.length-1;
  count=0;
  for(i=j;i>-1;i--){
    if(s1.options[i].selected){
      str2 = document.createElement("OPTION");
	  sv=s1.options[i].value;
	  so=s1.options[i].outerText;
      str2.value=sv;
      str2.text=so;
      s2.options.add(str2);
	  s1.remove(i);
	  count=count+1;
	}
  }
  v1=document.form1.count1.value;
  v2=document.form2.count2.value;
  v1=parseInt(v1);
  v2=parseInt(v2);
  v1=v1-count;
  v2=v2+count;
  document.form1.count1.value=v1;
  document.form2.count2.value=v2;
  document.form2.count1.value=v1;
}
function rtl(){//选定从右到左
  var s1=document.form1.s1;
  var s2=document.form2.s1;
  var sv,so,str2,i,j,count,v1,v2;
  j=s2.length-1;
  count=0;
  for(i=j;i>-1;i--){
    if(s2.options[i].selected){
      str2 = document.createElement("OPTION");
	  sv=s2.options[i].value;
	  so=s2.options[i].outerText;
      str2.value=sv;
      str2.text=so;
      s1.options.add(str2);
	  s2.remove(i);
	  count=count+1;
	}
  }
  v1=document.form1.count1.value;
  v2=document.form2.count2.value;
  v1=parseInt(v1);
  v2=parseInt(v2);
  v1=v1+count;
  v2=v2-count;
  document.form1.count1.value=v1;
  document.form2.count2.value=v2;
  document.form2.count1.value=v1;
}
function ltrs(){//输入从左到右
  var s1=document.form1.s1;
  var s2=document.form2.s1;
  var t=document.form1.t1;
  var tv,j,i,sv;
  tv=trim(t.value);
  var len=tv.replace(/[^\x00-\xff]/gi,'hi').length;
  var beg=Number(document.form1.l1.value)-1;
  j=s1.length-1;
  if(tv.length>0){
    for(i=j;i>-1;i--){
      sv=s1.options[i].text;
	  //if(sv.indexOf(tv)!=-1){
	  if(sv.substr(beg,len)==tv){
	    s1.options[i].selected=true;
		ltr();
	  }
    }
  }
  t.select();
}
function rtls(){//输入从右到左
  var s1=document.form1.s1;
  var s2=document.form2.s1;
  var t=document.form2.t2;
  var tv,j,i,sv;
  tv=trim(t.value);
  var len=tv.replace(/[^\x00-\xff]/gi,'hi').length;
  var beg=Number(document.form2.l2.value)-1;
  j=s2.length-1;
  if(tv.length>0){
    for(i=j;i>-1;i--){
      sv=s2.options[i].text;
	  //if(sv.indexOf(tv)!=-1){
	  if(sv.substr(beg,len)==tv){
	    s2.options[i].selected=true;
		rtl();
	  }
    }
  }
  t.select();
}
function alty(){
  var s1=document.form2.s1
  var i;
  var s;
  for(i=0;i<s1.length;i++){
    s1.options[i].selected=true;
	}
  //return true;
  //window.open('sdsave.asp','new','width=505,height=500');
  document.getElementById('style_submit').disabled=true;
  document.getElementById('style_submit').value='请稍等...';
  document.getElementById('other_submit').disabled=true;
  document.getElementById('other_submit').value='请稍等...';
  document.form2.submit();
}
function getd(){
  rtl();
}
function setd(){
  ltr();
}

</SCRIPT>
</head>
<body>

<%
Dim act
act=request("act")
id=trim(request("id"))
formid=trim(request("formid"))

if act="style" then
	call save1
	if formid<>"" and id<>"" then
		response.Redirect("../AddStyleToDj.asp?formid="&formid&"&id="&id)
	else
		response.Write("<script language='javascript'>window.close();</script>")
		response.End()
	end if
elseif act="other" then
	call save2
	if formid<>"" and id<>"" then
		response.Redirect("../AddStyleToDj.asp?formid="&formid&"&id="&id)
	else
		response.Write("<script language='javascript'>window.close();</script>")
		response.End()
	end if
end if


Sub save1
  dim depotid,i,userid,dcount,action,ispost,con,s1count
  dcount=request.Form("s1").count
  s1count=cdbl(request.Form("count1"))
  userid=trim(session("dm").System_Userid)
  ispost=lcase(trim(request.Form("ispost")))
  'de dcount&"-"&s1count&"-"&ispost
  if ispost="set" then
    if s1count<1 then
      sql="UPDATE sys_stylepower18ql SET selection=1 WHERE userid ="&qts(userid)
      cn.execute sql
    elseif dcount<1 then
      sql="UPDATE sys_stylepower18ql SET selection=0 WHERE userid ="&qts(userid)
      cn.execute sql
    else
      styleid=qts(request.Form("s1")(1))
      for i=2 to dcount
        styleid=styleid&","&qts(request.Form("s1")(i))
      next

      sql="UPDATE sys_stylepower18ql SET selection=0 WHERE userid ="&qts(userid)
      cn.execute sql
      sql="UPDATE sys_stylepower18ql SET selection=1 WHERE userid = "&qts(userid) & _
        "and styleid in ("&styleid&")"
      cn.execute sql
	  'de sql
    end if
    set cn=Nothing
  end if
End Sub

Sub save2
Dim years,months,zl,dl,xl,years1,months1,zl1,dl1,xl1,years2,months2,zl2,dl2,xl2,i
years1=trim(request("years"))
months1=trim(request("months"))
zl1=trim(request("zl"))
dl1=trim(request("dl"))
xl1=trim(request("xl"))
if years1<>"" then 
   years2=split(years1,",") 
   for i=0 to ubound(years2)
     years=years&trim(years2(i))&","
   next
   years=" and isnull(b.st_year,0) in ("&left(years,len(years)-1)&")"
else
   years=""
end if
if months1<>"" then 
   months2=split(months1,",") 
   for i=0 to ubound(months2)
     months=months&"'"&trim(months2(i))&"',"
   next
   months=" and isnull(b.st_month,'') in ("&left(months,len(months)-1)&")"
else
   months=""
end if
if zl1<>"" then 
   zl2=split(zl1,",") 
   for i=0 to ubound(zl2)
     zl=zl&"'"&trim(zl2(i))&"',"
   next
   zl=" and isnull(b.st_xl,'') in ("&left(zl,len(zl)-1)&")"
else
   zl=""
end if
if dl1<>"" then 
   dl2=split(dl1,",") 
   for i=0 to ubound(dl2)
     dl=dl&"'"&trim(dl2(i))&"',"
   next
   dl=" and isnull(b.st_dl,'') in ("&left(dl,len(dl)-1)&")"
else
   dl=""
end if
if xl1<>"" then 
   xl2=split(xl1,",") 
   for i=0 to ubound(xl2)
     xl=xl&"'"&trim(xl2(i))&"',"
   next
   xl=" and isnull(b.st_xz,'') in ("&left(xl,len(xl)-1)&")"
else
   xl=""
end if

sql="update sys_stylepower18ql SET selection=0 WHERE userid ="&qts(trim(session("dm").System_Userid))
cn.execute sql
sql=" update a set a.selection=1,a.s_name=b.s_name from sys_stylepower18ql a,j_style b where a.userid="&qts(trim(session("dm").System_Userid))&_
    " and a.styleid=b.styleid "&years&months&zl&dl&xl
cn.execute sql
set cn=nothing
End Sub
%>

<script type="text/javascript">
document.getElementById( "luna-tab-style-sheet" ).disabled = "luna" != "luna";
document.documentElement.style.background ="";
document.body.style.background = "luna" == "webfx" ? "white" : "ThreeDFace";	
</script>

<div class="tab-pane" id="tabPane1">
<script type="text/javascript">
tp1 = new WebFXTabPane( document.getElementById( "tabPane1" ) );
</script>

<div class="tab-page" id="tabPage1">
<h2 class="tab">按款式</h2>
<script type="text/javascript">tp1.addTabPage( document.getElementById( "tabPage1" ) );</script>
<%dim ds,sql1,sql2,FQM_Type,userid,count,vid,vname,i,action
userid=session("dm").System_Userid
  sql1= " select styleid,s_name from sys_stylepower18ql where userid="&qts(userid)&" and isnull(access,0)=1 and isnull(selection,0) = 0 "
  sql2= " select styleid,s_name from sys_stylepower18ql where userid="&qts(userid)&" and isnull(access,0)=1 and isnull(selection,0) = 1 "

set ds=server.CreateObject("ADODB.Recordset")
'de sql1
ds.open sql1,cn%>
<table width="150" border="0" align="left" class="bk">
  <tr><form name="form1" method="post" action="">
<input type="hidden" name="formid" value="<%=formid%>">
<input type="hidden" name="id" value="<%=id%>">
    <td>
	<div id="d1" style="height:330px;">
      <select name="s1" size="20" multiple id="s1" style="width:230px;height:100%;margin: 0px;padding:0px; " onDblClick="setd();">
	  <%
	  count=0
      while not ds.eof
	   count=count+1
	   vid=ds("styleid")
	   vname=ds("s_name")%>
        <option value="<%=vid%>"><%=vid&"　"&vname%></option>
		<%ds.movenext:wend:ds.close
		tmpcount=count%>
          </select></div>
      <table width="100%" border="0" cellspacing="0" class="f12">
        <tr>
          <td width="60%"><input name="t1" type="text" id="t1" size="7" onKeyDown="if(event.keyCode==13)ltrs();"> <font size=2>开始位</font><input name="l1" type="text" id="l1" size="1" value="1" onKeyDown="if(event.keyCode==13)ltrs();"></td>
          <td width="40%" align="center" id="count1"><input name="count1" type="text" id="count1" value="<%=count%>" size="4" maxlength="5" style="border-width:0px; " readonly="true"><font size=2>条</font></td>
        </tr>
      </table>
	  
    </td></form>
  </tr>
</table>
<table width="56" border="0" align="left">
  <tr>
    <td width="46" height="261"><input type="button" name="Submit" value="&gt;" onClick="ltr();" style="width:50px; ">
      <br>
      <input type="button" name="Submit" value="&lt;" onClick="rtl();" style="width:50px; ">
      <br>
    <input type="button" name="Submit" value="&gt;&gt;" onClick="ltra();" style="width:50px; ">
    <br>
    <input type="button" name="Submit" value="&lt;&lt;" onClick="rtla();" style="width:50px; "></td>
  </tr>
</table>
<table width="150" border="0" class="bk">
  <tr><form name="form2" method="post" action="">
      <input type="hidden" name="act" value="style">
    <td>
      <div id="d2" style="height:330px;margin: 0px; ">
        <select name="s1" size="20" multiple id="s1" style="width:230px;height:100% " onDblClick="getd();">
          <%
		  ds.Source=sql2
      ds.open
	  count=0
      while not ds.eof
	    count=count+1
	   vid=ds("styleid")
	   vname=ds("s_name")%>
        <option value="<%=vid%>"><%=vid&"　"&vname%></option>
          <%ds.movenext:wend:ds.close%>
        </select>
      </div>
	  <input name="ispost" type="hidden" id="action" value="set">
	  <table width="100%" border="0" cellspacing="0" class="f12">
        <tr>
          <td width="60%"><input name="t2" type="text" id="t2" size="7" onKeyDown="if(event.keyCode==13)rtls();"> <font size=2>开始位</font><input name="l2" type="text" id="l2" size="1" value="1" onKeyDown="if(event.keyCode==13)rtls();"></td>
          <td width="40%" align="right" id="count2"><input name="count2" type="text" id="count2" value="<%=count%>" size="4" maxlength="5" style="border-width:0px; " readonly="true"><font size=2>条</font></td>
        </tr>
      </table>
    </td><input name="count1" type="hidden" id="count1" value="<%=tmpcount%>"></form>
  </tr>
</table>
<table width="500" border="0" align="left" cellspacing="0" class="tcontent">
  <tr>
    <td align="center"><input type="button" name="Submit" id="style_submit" value="确定(Y)" onClick="alty();window.returnValue=1;">
    <input type="button" name="Submit" value="取消(X)" onClick="window.close();"></td>
  </tr>
</table>
</div>

<div class="tab-page" id="tabPage2">
<h2 class="tab">其它方式</h2>
<script type="text/javascript">tp1.addTabPage( document.getElementById( "tabPage2" ) );</script>
<script language="Javascript">
function SelectAll(thesel){
for(var i=0;i<thesel.length;i++){
thesel.options[i].selected=true;}
}
function UnSelectAll(thesel){
for(var i=0;i<thesel.length;i++){
thesel.options[i].selected=false;}
}
</script>
<table width="500" border="0" cellspacing="0">
<form name="otherform" method="post" action="">
<input type="hidden" name="act" value="other">
<input type="hidden" name="formid" value="<%=formid%>">
<input type="hidden" name="id" value="<%=id%>">
<tr height="20" align="center">
  <td><font size="2">年份</font></td>
  <td><font size="2">季节</font></td>
  <td><font size="2">种类</font></td>
  <td><font size="2">大类</font></td>
  <td><font size="2">小类</font></td>
</tr> 
<tr height="320">
  <td><select name="years" multiple size="15" style="width:100px;height:100% "><%Getlb("st_year")%></select></td>
  <td><select name="months" multiple size="15" style="width:100px;height:100% "><%Getlb("st_month")%></select></td>
  <td><select name="zl" multiple size="15" style="width:100px;height:100% "><%Getlb("st_xl")%></select></td>
  <td><select name="dl" multiple size="15" style="width:100px;height:100% "><%Getlb("st_dl")%></select></td>
  <td><select name="xl" multiple size="15" style="width:100px;height:100% "><%Getlb("st_xz")%></select></td>
</tr>
<tr height="20" align="center">
  <td><font size="2"><a href="javascript:SelectAll(document.otherform.years)">全选</a> <a href="javascript:UnSelectAll(document.all.otherform.years)">取消</a></font></td>
  <td><font size="2"><a href="javascript:SelectAll(document.otherform.months)">全选</a> <a href="javascript:UnSelectAll(document.all.otherform.months)">取消</a></font></font></td>
  <td><font size="2"><a href="javascript:SelectAll(document.otherform.zl)">全选</a> <a href="javascript:UnSelectAll(document.all.otherform.zl)">取消</a></font></font></td>
  <td><font size="2"><a href="javascript:SelectAll(document.otherform.dl)">全选</a> <a href="javascript:UnSelectAll(document.all.otherform.dl)">取消</a></font></font></td>
  <td><font size="2"><a href="javascript:SelectAll(document.otherform.xl)">全选</a> <a href="javascript:UnSelectAll(document.all.otherform.xl)">取消</a></font></font></td>
</tr>
<tr height="40"><td colspan="6" align="center"><input type="submit" id="other_submit" name="subm" value="确定(Y)">
<input type="button" name="Submit" value="取消(X)" onClick="window.close();"></td>
</tr>
</form>
</table>
<%Sub Getlb(typ)
ds.open " select isnull("&typ&",'') from j_style group by "&typ&" order by "&typ,cn
while not ds.eof
  response.write("<option value='"&ds(0)&"'>"&ds(0)&"</option>")
  ds.movenext
wend
ds.close
End Sub%>
</div>

</div>
</body>
</html>

<%set ds=nothing
Set cn=nothing%>
