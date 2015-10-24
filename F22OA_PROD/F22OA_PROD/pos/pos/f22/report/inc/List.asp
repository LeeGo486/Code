<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
}
function ltrs(){//输入从左到右
  var s1=document.form1.s1;
  var s2=document.form2.s1;
  var t=document.form1.t1;
  var tv,j,i,sv;
  tv=trim(t.value);
  j=s1.length-1;
  if(tv.length>0){
    for(i=j;i>-1;i--){
      sv=s1.options[i].text;
	  if(sv.indexOf(tv)!=-1){
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
  j=s2.length-1;
  if(tv.length>0){
    for(i=j;i>-1;i--){
      sv=s2.options[i].text;
	  if(sv.indexOf(tv)!=-1){
	    s2.options[i].selected=true;
		rtl();
	  }
    }
  }
  t.select();
}
function alty(){
  var s1=document.form2.s1
  var l=s1.length;
  var i;
  var s;
  for(i=0;i<l;i++)
    s1.options[i].selected=true;
  //return true;
  //window.open('sdsave.asp','new','width=505,height=500');
  document.form2.submit();
}
</SCRIPT>

<%
Sub save
  dim depotid,i,userid,dcount,action,ispost,con
  dcount=request.Form("s1").count
  userid=trim(session("dm").System_Userid)
  ispost=lcase(trim(request.Form("ispost")))
  set con=server.CreateObject("ADODB.Connection")
  con.open cn
  if ispost="set" then
    if dcount<1 then
      sql="UPDATE sys_depotpower18ql SET selection=0 WHERE userid ="&qts(userid)
      con.execute sql
    else
      depotid=qts(request.Form("s1")(1))
      for i=2 to dcount
        depotid=depotid&","&qts(request.Form("s1")(i))
      next

      sql="UPDATE sys_depotpower18ql SET selection=0 WHERE userid ="&qts(userid)
      con.execute sql
      sql="UPDATE sys_depotpower18ql SET selection=1 WHERE userid = "&qts(userid) & _
        "and depotid in ("&depotid&")"
      con.execute sql
    end if
    set con=Nothing
    response.Write("<script language='javascript'>window.close();</script>")
    response.End()
  elseif ispost="get" then
    if dcount<1 then
      sql="UPDATE sys_depotSetpower18ql SET selection=0 WHERE userid ="&qts(userid)
      con.execute sql
    else
      depotid=qts(request.Form("s1")(1))
      for i=2 to dcount
        depotid=depotid&","&qts(request.Form("s1")(i))
      next

      sql="UPDATE sys_depotSetpower18ql SET selection=0 WHERE userid ="&qts(userid)
      con.execute sql
      sql="UPDATE sys_depotSetpower18ql SET selection=1 WHERE userid = "&qts(userid) & _
          "and depotid in ("&depotid&")"
      con.execute sql
    end if
     set con=Nothing
    response.Write("<script language='javascript'>window.close();</script>")
    response.End()
  end if
End sub
call save
%>

<%dim ds,sql1,sql2,FQM_Type,userid,count,vid,vname,i,action
FQM_Type="0,1,2,3,4,5,6,7,8,9,10,11,12,13,80,81,82,83,84,85,90,91,92,93,94,95,96"
userid=session("dm").System_userid
action=trim(request.QueryString("action"))
select case action
case "set"
  sql1= " select depotid,dptname,Parentid,ParentName,Merchantid,Jmshutname, "& _
            " Areaid,AreaName,dptM_type "& _
	        " from v22p_setmerchant where userid="&qts(userid)& _
                          " and isnull(access,0)=1  "& _
                          " and dptM_type in ("&FQM_Type&") "& _
                          " and isnull(selection,0) = 0 "
  sql2= " select depotid,dptname,Parentid,ParentName,Merchantid,Jmshutname, "& _
            " Areaid,AreaName,dptM_type "& _
	        " from v22p_setmerchant where userid="&qts(userid)& _
                          " and isnull(access,0)=1  "& _
                          " and dptM_type in ("&FQM_Type&") "& _
                          " and isnull(selection,0) = 1 "
case "get"
  sql1= " select depotid,dptname,Parentid,ParentName,Merchantid,Jmshutname, "& _
            " Areaid,AreaName,dptM_type "& _
	        " from v22p_getmerchant where userid="&qts(userid)& _
                          " and isnull(access,0)=1  "& _
                          " and dptM_type in ("&FQM_Type&") "& _
                          " and isnull(selection,0) = 0 "
  sql2= " select depotid,dptname,Parentid,ParentName,Merchantid,Jmshutname, "& _
            " Areaid,AreaName,dptM_type "& _
	        " from v22p_getmerchant where userid="&qts(userid)& _
                          " and isnull(access,0)=1  "& _
                          " and dptM_type in ("&FQM_Type&") "& _
                          " and isnull(selection,0) = 1 "
case else
  err.raise 50001,"List","没有为对象设置命令!"
end select

set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn%>
<table width="575" border="0" class="tcontent">
  <tr>
    <td width="67">选择仓店</td>
    <td width="67">&nbsp;</td>
    <td width="67">&nbsp;</td>
    <td width="67">&nbsp;</td>
    <td width="67">&nbsp;</td>
    <td width="67">&nbsp;</td>
    <td width="67">&nbsp;</td>
    <td width="72">&nbsp;</td>
  </tr>
</table>
<table width="200" border="0" align="left" class="bk">
  <tr><form name="form1" method="post" action="">
    <td>
	<div id="d1" style="height:350px;">
      <select name="s1" size="20" multiple id="s1" style="width:250px;height:100%;margin: 0px;padding:0px; " onDblClick="ltr();">
	  <%
	  ds.Source=sql1
      ds.open
	  count=0
      while not ds.eof
	   count=count+1
	   vid=ds("depotid")
	   vname=ds("dptname")%>
        <option value="<%=vid%>"><%=StrFormat(vid,12)%> <%=vname%></option>
		<%ds.movenext:wend:ds.close%>
          </select></div>
      <table width="100%" border="0" cellspacing="0" class="f12">
        <tr>
          <td width="57%"><input name="t1" type="text" id="t1" size="10" maxlength="10" onKeyDown="if(event.keyCode==13)ltrs();"></td>
          <td width="43%" align="center" id="count1">
            共:
              <input name="count1" type="text" id="count1" value="<%=count%>" size="4" maxlength="5" style="border-width:0px; " readonly="true">
            条</td>
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
<table width="200" border="0" class="bk">
  <tr><form name="form2" method="post" action="" target="">
    <td>
      <div id="d2" style="height:350px;margin: 0px; ">
        <select name="s1" size="20" multiple id="s1" style="width:250px;height:100% " onDblClick="rtl();">
          <%
		  ds.Source=sql2
      ds.open
	  count=0
      while not ds.eof
	    count=count+1
	   vid=ds("depotid")
	   vname=ds("dptname")%>
        <option value="<%=vid%>"><%=StrFormat(vid,12)%> <%=vname%></option>
          <%ds.movenext:wend:ds.close%>
        </select>
      </div>
	  <input name="ispost" type="hidden" id="action" value="<%=action%>">
	  <table width="100%" border="0" cellspacing="0" class="f12">
        <tr>
          <td width="61%"><input name="t2" type="text" id="t2" size="10" maxlength="10" onKeyDown="if(event.keyCode==13)rtls();"></td>
          <td width="39%" align="right" id="count2">共:
            <input name="count2" type="text" id="count2" value="<%=count%>" size="4" maxlength="5" style="border-width:0px; " readonly="true">
            条</td>
        </tr>
      </table>
	  
    </td></form>
  </tr>
</table>
<table width="575" border="0" align="left" cellspacing="0" class="tcontent">
  <tr>
    <td align="center"><input type="button" name="Submit" value="确定(Y)" onClick="alty();">
    <input type="button" name="Submit" value="取消(X)" onClick="window.close();"></td>
  </tr>
</table>
<%set ds=nothing
Set cn=nothing%>
