<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP��Ϣ��ʾ</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
<link href="../f22/css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../f22/report/inc/gridtable.js"></SCRIPT>
<%
Response.cachecontrol = "no-cache"
response.Charset = "gb2312"
Response.Buffer=True
set cn=server.CreateObject("adodb.connection")
cn.open session("cn")

id = request("vipid")

if id="" then 
response.write "ȱ�ٲ���!��<a href="""&request.ServerVariables("HTTP_REFERER")&""">���</a>����!"
response.End()
end if
id = replace(id,", ","','")
depotid = session("dm").System_DepotID
username = session("dm").System_UserName
sql="select a.vipid,a.depotid,b.d_name,a.vipcode,a.vipname,vipsex,a.vipbirth,a.mobtel,"&_
		"isnull(a.centum,0)+isnull(c.starcentum,0) as centum,"&_
		"isnull(a.sums,0)+isnull(c.starsums,0) as sums,"&_
		"a.crdate,a.viplastdate "&_
		"from vip_user a,j_depot b,vip_cardvip c "&_
		"where a.depotid*=b.depotid and a.vipcode=c.vipcardid  and A.depotid ='"&depotid&"'"&_
		"and a.vipid in ('"&id&"')"

function renull(str)
	if isnull(str) or isempty(str) or str="" then
		renull = "[δ֪]"
	else
		renull = str
	end if
end function

if request("act")="1" then
remsg = trim(request("msg"))
remsg = replace(remsg,"'","��")
estr = ""
if remsg="" then response.Redirect("vip_tips.asp")
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,cn,1,1
		do while not rs.eof
		msg = remsg
			msg = replace(msg,"[$���]",renull(rs("vipid")))
			msg = replace(msg,"[$����]",renull(rs("vipcode")))
			msg = replace(msg,"[$�ֻ���]",renull(rs("mobtel")))
			msg = replace(msg,"[$����]",renull(rs("vipname")))
			msg = replace(msg,"[$����]",renull(rs("vipbirth")))
			msg = replace(msg,"[$��������]",renull(rs("crdate")))
			msg = replace(msg,"[$�ϴ�����]",renull(rs("viplastdate")))
			msg = replace(msg,"[$�ܻ���]",renull(rs("centum")))
			msg = replace(msg,"[$�ܴ�ֵ]",renull(rs("sums")))
			if renull(rs("mobtel"))="" then
				estr = estr&"<span style='color:red'>��Ա��"&renull(rs("vipname"))&"��"&renull(rs("vipcode"))&"����ȱ���ֻ����룬����ʧ�ܣ�</span><br />"
			elseif len(msg)>1000 then 
				estr = estr&"<span style='color:red'>��Ա��"&renull(rs("vipname"))&"��"&renull(rs("vipcode"))&"������Ϣ���ݳ���1000�ַ�������ʧ�ܣ�</span><br>"
			else
			 s1="insert into vip_message (msg,setdate,sure,tel,crdate,crname) values "&_
				"('"&msg&"',getdate()+0.005,0,'"&renull(rs("mobtel"))&"',getdate(),'"&username&"')"
			 cn.execute s1
				estr = estr&"<span style='color:green'>��Ա��"&renull(rs("vipname"))&"��"&renull(rs("vipcode"))&"�������ŷ��ͳɹ���</span><br />"
			end if
		rs.movenext
		loop
	rs.close
	set rs=nothing
	response.write estr
	response.End()
end if

%>

<!--#include file="../f22/report/inc/Class.asp" -->

<style type="text/css">
body{
	
	padding:10px;}
a{
	text-decoration:none;
	color:#000;
	}
a img{
	border:none;
	}
a:hover{
	color:#333;
	}
h2{
	font-size:18px;
}
textarea,input,table,body
{
	font-size:12px;
	}
table{
	border:none;
	background:#d5d5d5;
}
table td{
	background:#fff;
}
</style>
<script type="text/javascript">
function addText(text)
{
	document.getElementById("msg").value += '[$'+text.toString()+']';
}
function vip(id)
{
	if(id){
  	var m=showModalDialog('vip_xf.asp?id='+id,'vipdetail','dialogWidth:800px;dialogHeight:600px;center: yes;help:no;status:no;resize:yes');
	}
}
function gtDoDblClick(t)
{
	var row = t.getSelectedRow();
	var id=row.cells[1].outerText;
  vip(id);
}
function gtDoSelect(t)
{
	var row = t.getSelectedRow();
	var id=row.cells[1].outerText;
	var ck=row.cells[0].getElementsByTagName("input")[0];
	if(ck) ck.checked = !ck.checked; 
	
}
function chkform(t)
{
	if(t.msg.value.length==0)
	{
		alert('����д�������ݡ�')
		return false;
	}else{
		var tab = gtTables.getTable("gt1");
		//�ύǰ�ȰѾɵ�FORMȥ��
		for(i=0;i<tab.oldTable.tBodies[0].rows.length;i++)
		{
				var c = tab.oldTable.tBodies[0].rows[i].cells[0];
				var v = c.getElementsByTagName("input")[0];
				if(v){
					v.checked=false;
				}
		}
	}
}
function choall()
{
	var oc = document.getElementsByName("vipid");
	for(i=0;i<oc.length;i++){ oc[i].checked = !oc[i].checked;}
}
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="?act=1" onSubmit="return chkform(this)">
<h2>����Ա�����ֻ�����</h2>

    <%
set t=new Table
t.ActiveConnection = cn
t.CommandType = 1
t.commandText = sql
	t.SetField 0,"�˿ͱ��","150",0
	't.SetField 1,"���̱��","60",0
	't.SetField 2,"��������","80",0
	t.SetField 3,"����","120",0
	t.SetField 4,"����","60",0
	t.SetField 5,"�Ա�","30",0
	t.SetField 6,"����","80",0
	t.SetField 7,"�ֻ�","80",0
	t.SetField 8,"�ܻ���","60",0
	t.SetField 9,"�ܴ�ֵ","60",0
	t.SetField 10,"��������","120",0
	t.SetField 11,"�����������","120",0

	t.height="35%"
	t.width="95%"
	t.Mselect=true	'��ѡ
	t.MselectValue="vipid"	'ָ��ѡ��checkbox��ֵ
	t.MSDefCheck=true		'Ĭ���Ǵ򹳻��ǲ���
  t.Show()
  set t=Nothing
		%>
<script language="javascript">
	try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
<br /><br />
<table width="100%" cellpadding="5" cellspacing="1">
  <tr>
    <td valign="top">���û�Ա���ϣ�</td>
    <td>[<a href="javascript:;" onClick="addText(this.innerText)" >���</a>]
     [<a href="javascript:;" onClick="addText(this.innerText)">����</a>]      [<a href="javascript:;" onClick="addText(this.innerText)">�ֻ���</a>] [<a href="javascript:;" onClick="addText(this.innerText)">����</a>] 
      [<a href="javascript:;" onClick="addText(this.innerText)">����</a>] [<a href="javascript:;" onClick="addText(this.innerText)">��������</a>]  [<a href="javascript:;" onClick="addText(this.innerText)">�ϴ�����</a>] [<a href="javascript:;" onClick="addText(this.innerText)">�ܻ���</a>] [<a href="javascript:;" onClick="addText(this.innerText)">�ܴ�ֵ</a>]</td>
  </tr>
  <tr>
    <td valign="top"><br />
      ��Ϣ���ݣ�</td>
    <td><textarea name="msg" cols="70" rows="8" id="msg" onKeyDown="return !(event.keyCode==13)"></textarea></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
      <input type="submit" name="sendsmt" id="sendsmt" value="������" />
      <input type="button" value="ȫѡ/��ѡ" onClick="choall()" />
      <input type="button" name="button2" id="button2" value="������" onClick="if(confirm('���ز�������ʧ��ǰ�༭����Ϣ���ݣ�ȷ����'))self.history.go(-1)" />
      
      </td>
    </tr>
</table>
  </form>
</body>
</html>