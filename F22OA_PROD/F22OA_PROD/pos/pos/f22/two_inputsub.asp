<%Response.Expires=-1000%>
<%'on error resume next
dim opt,id,cd,sp,ds,numName
opt=trim(request("opt"))
id=trim(request("id"))
numName=trim(request("numName"))
dim ct,rc,xsums,sums
ct=0
rc=0
xsums=0
sums=0
dim styleid,act,boxid
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/two_input.css" rel="stylesheet" type="text/css">

<script language="javascript">
var id="<%=id%>";
var opt="<%=opt%>";
var numName="<%=numName%>";
var tmpstid="";
var tmpboxid="";
function dsub(stid,boxid){
  if(tmpstid!=stid || tmpboxid!=boxid){
    tmpstid=stid;
	tmpboxid=boxid;
    window.parent.mainFrame.location.href="two_inputsubsub.asp?id="+id+"&styleid="+stid+"&opt="+opt+"&numName="+numName+"&boxid="+boxid;
  }
}
var tmptd=null;
function tdoc(t){
  if(t!=tmptd){
    t.style.backgroundColor="#316AC5";
    t.style.color="#FFFFFF";
    if(tmptd!=null){
	  tmptd.style.backgroundColor="#FFFFFF";
	  tmptd.style.color="#000000";
	}
  tmptd=t;
  }
}
function tdocAdd(t){
  if(t!=tmptd){
    t.style.backgroundColor="#316AC5";
    t.style.color="#FFFFFF";
    if(tmptd!=null){
	  tmptd.style.backgroundColor="#FFFFFF";
	  tmptd.style.color="#000000";
	}
  tmptd=t;
  }
}
function tdipoc(t){
  if(t!=tmptd){
    //t.style.backgroundColor="#316AC5";
    //t.style.color="#FFFFFF";
    if(tmptd!=null){
	  tmptd.style.backgroundColor="#FFFFFF";
	  tmptd.style.color="#000000";
	}
  tmptd=t;
  }
}

function addStyleid(t){
 var styleid=t.value;
 var k=event.keyCode;
 if(k==13){
   if(styleid!=""){
     var sm=showModalDialog("two_input_cs.asp?styleid="+styleid+"&id="+id+"&act=add&opt="+opt+"&numName="+numName,window,"dialogWidth:400px;dialogHeight:200px;center:yes;help:no;resizable:yes;status:no");
     if(sm){
	   window.location.reload();
	   document.frm_tmp.submit();
	  }
   }
 }
}

function subSave(t,act,id,styleid){
  var v=t.value;
  var k=event.keyCode;
  var tmp;
  //alert(k);
  if((k>=48 && k <=57)||(k>=96 && k <=105)){
    //alert(event.keyCode);
  }else if(k==8 || k ==46 || k==189 || k==190 || k==110){
    //return event.keyCode;
  }else if(k==13){
   if(v!=""){
     tmp="two_inputsub_save.asp?v="+v+"&styleid="+styleid+"&id="+id+"&act="+act+"&opt="+opt+"&numName="+numName;
	 //alert(tmp);
	 showModalDialog(tmp,window,"dialogWidth:1px;dialogHeight:1px;center:yes;help:no;resizable:yes;status:no");
	 
   }
  }else{
    //alert(event.keyCode);
    return false;
  }
}

function tdok(){
  var k=event.keyCode;
  //alert(k);
  switch(k){
  case 46://删除键
    if(tmpstid!="" && tmpboxid!=""){
	  tmp="two_inputsub_save.asp?styleid="+tmpstid+"&id="+id+"&act=del&opt="+opt+"&numName="+numName+"&boxid="+tmpboxid;
	  //alert(tmp);
      showModalDialog(tmp,window,"dialogWidth:1px;dialogHeight:1px;dialogTop:0px;dialogLeft:0px;help:no;resizable:yes;status:no");
	  document.frm_tmp.submit();
	}
  }
}
</script>
</head>

<body onLoad="window.document.all.addStyleid.focus();" onKeyDown="tdok();">
<!--#include file="inc/function.asp" -->
<%
set cd = server.CreateObject("ADODB.Command")
cd.ActiveConnection = cn
cd.CommandType = 4
select case opt
case "indent"
  sql="t18_lrindent"
case "quota"
  sql="t18_lrquota"
case "sell"
  sql="t18_lrsell"
case "move"
  sql="t18_lrmove"
case "retail"
  sql="t18_lrretail"
case "outindent"
  sql="t18_lroutindent"
case "outindentsq"
  sql="f22_lroutindentsq"
case "outindentPRO"
  sql="f22_lroutindentPro"
case "outindentCHK"
  sql="f22_lroutindentCHK"
case "outindentset"
  sql="f22_lroutindentset"
case "inventory"
  sql="t18_lrinventory"
case "msell"
  sql="t18_lrmsell"
case else
  call close("opt= "&opt&" 参数错误!")
end select
'de sql
  'set ds = Server.CreateObject("ADODB.Recordset")
  'ds.ActiveConnection = cn
  
  cd.CommandText = sql
  cd.Parameters.Append cd.CreateParameter("@id",adVarchar,adParamInput,32,id)
  set ds = cd.Execute
  cd.Parameters.Delete 0
  
dim tdw(8),tdws
tdw(0)=30
tdw(1)=80
tdw(2)=80
tdw(3)=60
tdw(4)=40
tdw(5)=50
tdw(6)=30
tdw(7)=55
tdw(8)=70

tdws=0
for i=0 to 8
  tdws=tdws+tdw(i)
next
'de sql
%>
	<div id="left">
	<table width="<%=tdws%>"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <th width="<%=tdw(1)%>">款式编号</th>
        <th width="<%=tdw(2)%>">款式名称</th>
        <%if pxprice then%>
        <th width="<%=tdw(3)%>">现价</th>
        <%end if%>
        <%if pxprice and psprice then%>
        <th width="<%=tdw(4)%>">折扣</th>
        <%end if%>
        <%if psprice then%>
        <th width="<%=tdw(5)%>">结算价</th>
        <%end if%>
        <th width="<%=tdw(6)%>">数量</th>
        <%if pxprice then%>
        <th width="<%=tdw(7)%>">现价金额</th>
        <%end if%>
        <%if psprice then%>
        <th width="<%=tdw(8)%>">结算价金额</th>
        <%end if%>
		<th width="<%=tdw(0)%>">序号</th>
      </tr>
	  </table>
		<div><table width="<%=tdws%>"  border="0" cellpadding="0" cellspacing="0">
		<%while not ds.eof
		ct=ct+1
		if ct=1 then
		  styleid=ds("styleid")
		  boxid=ds("boxid")
		end if
		%>
      <tr onClick="dsub('<%=ds("styleid")%>','<%=ds("boxid")%>');">
        <td width="<%=tdw(1)%>" onClick="tdoc(this);" onKeyDown="tdok('','');"><%=ds("styleid")%></td>
        <td width="<%=tdw(2)%>" onClick="tdoc(this);"><%=ds("s_name")%>&nbsp;</td>
        <%if pxprice then%>
        <td width="<%=tdw(3)%>" onClick="tdoc(this);"><%=ds("x_price")%></td>
        <%end if%>
        <%if pxprice and psprice then%>
          <td width="<%=tdw(4)%>" onClick="tdoc(this);">
          	<%if session("rgDiscount")="" then%>
            	<%=ds("x_discount")%>
            <%else%>
            	<input name="discount" type="text" id="discount" value="<%=ds("x_discount")%>" size="4" maxlength="5"
              	 			onKeyDown="return subSave(this,'discount','<%=id%>','<%=ds("styleid")%>');">
						<%end if%>
          </td>
        <%end if%>
        <%if psprice then%>
          <td width="<%=tdw(5)%>" onClick="tdoc(this);">
						<%if session("rgS_price")<>"" then%>
            	<%=cdbl(ds("x_price"))*cdbl(ds("x_discount"))%>
            <%else%>
			    <% if session("formid")=2071 then %>
				      <%=ds("s_price")%>
              	<% else %>
            	<input name="s_price" type="text" id="s_price" value="<%=ds("s_price")%>" size="5" maxlength="5"
              			 onfocus="this.select();" onKeyDown="return subSave(this,'s_price','<%=id%>','<%=ds("styleid")%>');">
				<% end if %>		 
						<%end if%>
          </td>
        <%end if%>
          <td width="<%=tdw(6)%>" onClick="tdoc(this);"> 
            <%=reNull(ds("nums")) %>
            <%rc = rc + reNull(ds("nums"))%>
          </td>
        <%if pxprice then%>
          <td width="<%=tdw(7)%>" onClick="tdoc(this);">
            <%=reNull(ds("xpricesums")) %>
            <%xsums = xsums + reNull(ds("xpricesums"))%>
          </td>
        <%end if%>
				<%if psprice then%>
       		<td width="<%=tdw(8)%>" onClick="tdoc(this);">
            <%=reNull(ds("sums")) %>
            <%sums= sums + reNull(ds("sums"))%>
          </td>
        <%end if%>
		<td width="<%=tdw(0)%>" onClick="tdoc(this);"><%=left(trim(ds("boxid")),5)%></td>
      </tr>
		<%ds.moveNext
		wend
		ds.close%>
    </table>
	</div>
	<table width="<%=tdws%>"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="10">
        <input name="addStyleid" type="text" id="addStyleid" size="30" maxlength="30"
         class="input" onKeyDown="addStyleid(this);"></td>
      </tr>
	  <tr bgcolor="#A6CAF0">
        <td width="<%=tdw(1)%>"><%=ct%></td>
        <td width="<%=tdw(2)%>">&nbsp;</td>
        <%if pxprice then%><td width="<%=tdw(3)%>">&nbsp;</td><%end if%>
        <%if pxprice and psprice then%><td width="<%=tdw(4)%>">&nbsp;</td><%end if%>
        <%if psprice then%><td width="<%=tdw(5)%>">&nbsp;</td><%end if%>
        <td width="<%=tdw(6)%>"><%=rc%></td>
        <%if pxprice then%><td width="<%=tdw(7)%>"><%=xsums%></td><%end if%>
        <%if psprice then%><td width="<%=tdw(8)%>"><%=sums%></td><%end if%>
		<td width="<%=tdw(0)%>">&nbsp;</td>
      </tr>
    </table>
</div>
<script language="javascript">
function init(){
  var stid="<%=styleid%>";
  var numName="<%=numName%>";
  var boxid="<%=boxid%>";
  window.parent.mainFrame.location.href="two_inputsubsub.asp?id="+id+"&styleid="+stid+"&opt="+opt+"&numName="+numName+"&boxid="+boxid;
}
init();
</script>
<form name="frm_tmp" method="get" action="">
  <input name="id" type="hidden" id="id" value="<%=id%>">
  <input name="opt" type="hidden" id="opt" value="<%=opt%>">
  <input name="numName" type="hidden" id="numName" value="<%=numName%>">
</form>
</body>
</html>
