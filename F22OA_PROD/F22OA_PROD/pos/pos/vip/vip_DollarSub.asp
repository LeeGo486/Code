<!--#include file="../f22/inc/function.asp"-->
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ѡ��ɻ�����Ʒ</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../f22/inc/jsgrid.js"></script>
<script src="../../../Scripts/jquery-1.2.6.min.js"></script>
<script type="text/javascript">
function chkform(t){
if(t.key.value.length<=0){
return false;
}
return true;
}
function ck(t){
	if(t){
		var tc=t.getElementsByTagName("INPUT");
			for(i=0;i<tc.length;i++){
				if(tc[i].checked==true){
					tc[i].checked=false;
					t.className="";
				}else{
					tc[i].checked=true;
					t.className="gridSel";
				}
			}
	}else{
		var ts=document.getElementsByTagName("INPUT");
		var str="";
		for(i=0;i<ts.length;i++){
			if(ts[i].name=="cid"){
				if(ts[i].checked==true){
					str+=ts[i].value+",";
				}
			}
		}
		if(str.length>1){ window.returnValue=str; }
		window.close();
	}
}
$(function(){
	$("#grid_body li").each(function(i){
			$(this).click(function(){
				var ipt = $(this).find("input[type='checkbox']");
					if($(ipt).attr('chk')=='yes'){
						$(this).css('background','');
						$(this).css('font-weight','');
						$(ipt).attr('checked','');
						$(ipt).attr('chk','no');
					}else{
						$(this).css('background','#efefef');
						$(this).css('font-weight','bold');
						$(ipt).attr('checked','checked');
						$(ipt).attr('chk','yes');
					}
				})
		});
})

</script>
</head>
<body>
<%
hgfs=request("hgfs")

%>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="bar">
  <tr>
    <td align="center">ѡ��ɻ�����Ʒ</td>
  </tr>
</table>
<form name="form1" method="post" action="?" onSubmit="return chkform(this)">
  <table width="100%"  border="0" cellpadding="0" cellspacing="0"> 
  <tr>
    <td height="300" valign="top" align="center" style="padding:0 0 0 10px;">
<%
set rs=server.CreateObject("adodb.recordset")
sql = "select a.clothingid,b.styleid,d.s_name,b.colorid,a.sizeid,isnull(b.buycentum,0) as buycentum,isnull(b.dcentum,0) as dcentum,"&_
			" isnull(b.price,0) as price,b.begdate,b.enddate,isnull(c.k_num,0) as k_num from j_clothing a,vip_stycentum b,j_stock c,j_style d "&_ 
			" where a.styleid=b.styleid and a.colorid=b.colorid and b.depotid="&qts(session("dm").System_DepotId)&" and a.styleid=d.styleid "&_
			" and convert(char(10),getdate(),126)>=convert(char(10),b.begdate,126) "&_
			" and convert(char(10),getdate(),126)< convert(char(10),b.enddate,126) "&_
			" and "&hgfs&">=isnull(b.dcentum,0) and isnull(b.dcentum,0)<>0 "&_
			" and a.clothingid*=c.clothingid and c.depotid="&qts(session("dm").System_DepotId)
			rs.open sql,cn,1,1
			if rs.eof and rs.bof then
				response.write "<p>&nbsp;</p>"
				response.write "<p>&nbsp;</p>"
				response.write "<p style=color:red>��ǰ���֣�"&hgfs&"�������û�пɻ�����Ʒ</p>"
			else
				%>
				<div id="grid">
					<div id="grid_header">
						<ul>
							<li>
							<div>&nbsp;</div>
                            <div>���</div>
                            <div>��ʽ</div>
                            <div>��ʽ����</div>
                            <div>��ɫ</div>
                            <div>����</div>
                            <div>����</div>
                            <div>��Ǯ</div>
                            <div>��ʼ����</div>
                            <div>��������</div>
							</li>
						</ul>
					</div>
					<div id="grid_body">
						<ul>
				<%
			do while not rs.eof
			i=i+1
				%>
				  <li>
					<div><input type="checkbox" name="cid" id="cid<%=i%>" value="<%=rs(0)%>" /></div>
					<div><%=rs(0)%></div>
					<div><%=rs(1)%></div>
					<div><%=rs(2)%></div>
					<div><%=rs(3)%></div>
					<div><%=rs(4)%></div>
					<div><%=rs(6)%></div>
					<div><%=rs(7)%></div>
					<div><%=rs(8)%></div>
					<div><%=rs(9)%></div>
				  </li>
				<%
			rs.movenext
			loop
				%>
						</ul>
					</div>
				</div>
				<script type="text/javascript">
				jsGrid('grid','6%|20%|15%|10%|10%|5%|5%|5%|11%|11%|','left|left|left|center|center|center|center|center|center|center|');
				</script>
				<%
			end if
			rs.close
	set rs=nothing

%>
    </td>
   </tr>
	</table>
	<table width="100%"  border="1" cellpadding="0" cellspacing="1" bordercolor="#F0DEDA" class="f12"> 
    <tr>
      <td align="center">
      <input type="button" name="Submit" value="ȷ����" onClick="ck()">
      <input type="button" name="Submit" value="�ء���" onClick="window.close()"></td>
    </tr>
  </table>
</form>
</body>
</html>
