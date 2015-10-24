<!--#include file="inc_config.asp"-->
<%
act=request("act")
key=request("key")
depotid=request.form("depotid")
if act="submit" and key="" then

	response.write "<script type=text/javascript>"
	response.write "parent.returnValue='"&depotid&"';"
	response.write "window.close();"
	response.write "</script>"
	response.end
end if

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../OA/css/project.css" rel="stylesheet" type="text/css" />
<title>选择调查题目</title>
<style type="text/css">
body{
margin:0;
overflow:hidden;
width:280px;
}
tr{
cursor:pointer;
font-size:12px;
}
tr td{
border-bottom:solid 1px #ccf;
}
.cksel td{
background:#cdf;
}
</style>
<script type="text/javascript">

returnValue='';

function ckall(t,i){
	var form = document.forms[i];
	var checkbox = form.getElementsByTagName("INPUT");
	var tr = form.getElementsByTagName("TR");
	var cname="";
		if(t.checked){
			cname="cksel";
		}
		for(c=0;c<checkbox.length;c++){
			if(checkbox[c].type=="checkbox"){
				checkbox[c].checked=t.checked;
			}
		}
		for(n=0;n<tr.length;n++){
			tr[n].className=cname;
		}
		
}

function ck(t,i){
	if(i==0){
		if(t.type=="checkbox"){
			if(t.checked==true){t.checked=false}else{t.checked=true}
		}else{
			var checkbox = t.getElementsByTagName("INPUT")
			if(checkbox[0]){
				if(checkbox[0].checked==true){
					checkbox[0].checked=false;
					t.className="";
				}else{
					checkbox[0].checked=true;
					t.className="cksel";
				}
			}
		}
	}else if(i==1&&t.className!="cksel"){
		t.style.background="#cdf";
	}else if(i==2&&t.className!="cksel"){
		t.style.background="#fff";
	}
}
</script>
</head>

<body>

<table width="270" border="0" cellpadding="3" cellspacing="0" align="center" style="background:#FFF;">
  <tr>
    <td  colspan="3" align="right"><label>
      <input type="submit" name="button" id="button" value="确定" class="btn" onclick="document.forms[0].submit()" />&nbsp;
      <input type="button" name="button" id="button" value="取消 "class="btn" onclick="window.close()"  />
    </label></td>
  </tr>
  <tr>
    <td width="60" align=center><label>
      <input type="checkbox" name="checkbox" id="checkbox" onclick="ckall(this,0)" /> 
      全选</label></td>
    <td align=center><strong>编号</strong></td>
    <td align=center><strong>店铺名称</strong></td>
  </tr>
<form id="form1" name="form1" method="post" action="?act=submit" target="hf">
<%
set rs=server.CreateObject("adodb.recordset")
if key<>"" then sqlstr=" where depotid like '%"&key&"%' or d_name like '%"&key&"%' "
sql="select depotid,d_name from j_depot "&sqlstr&" order by depotid"
rs.open sql,cn,1,1
do while not rs.eof
depotid=rs(0)
%>
  <tr onclick="ck(this,0)" onmouseover="ck(this,1)" onmouseout="ck(this,2)">
    <td align=center><label>
      <input type="checkbox" name="depotid" id="depotid" value="<%=depotid%>" 
       onclick="ck(this,0)"/>
    </label></td>
    <td><%=depotid%></td>
    <td><%=rs(1)%></td>
  </tr>
<%
rs.movenext
loop
rs.close

%>
</form>
  <tr>
    <td  colspan="3" align="right"><label>
      <input type="submit" name="button" id="button" value="确定" class="btn" onclick="document.forms[0].submit()" />&nbsp;
      <input type="button" name="button" id="button" value="取消 "class="btn" onclick="window.close()"  />
    </label></td>
  </tr>
</table>
<iframe src="about:blank" style="display:none" name="hf"></iframe>
</body>
</html>
