<%option explicit
session("formid")=6101026%>
<!--#include file="../f22/report/inc/function.asp" -->
<!--#include file="../f22/report/inc/Class.asp" -->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP��Ϣ��ʾ</title>
<link href="../f22/css/f22.css" rel="stylesheet" type="text/css">
<link href="../f22/css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="../f22/report/inc/gridtable.js"></SCRIPT>
<script type="text/javascript">
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
	var ck=row.cells[0].getElementsByTagName("input")[0];
	if(ck)
	{
		ck.checked = !ck.checked;
/*		if(ck.checked)
		{
			row.style.color="#000";
		}else{
			row.style.color="#d5d5d5";
		}
*/	}
}

function renull(val)
{
	val=parseFloat(val).toString();
	if(val=="NaN") val = 0;
	return val
}

</script>
<style type="text/css">
#tipsmenu{
	clear:both;
	height:29px;
}
#tipsmenu ul{
	margin:0;
	clear:both;
	list-style:none;
}
#tipsmenu ul li{
	clear:right;float:left;width:100px;
	line-height:30px;height:30px;
	overflow:hidden;
}
#tipsmenu ul li a{
	display:block;
	text-align:center;
	text-decoration:none;
	background:#FFF;
}
#tipsmenu ul li a:hover{
	color:#F00}
</style>
</head>

<body>
<table width="100%"  border="0" class="bar">
  <tr>
    <td align="center">VIP��Ϣ��ʾ</td>
  </tr>
</table>
<form name="form1" method="post" action="?" onSubmit="return chkform(this)">
<table  border="0" width="100%">
<%
dim ds,sql,depotid,typ,val,ss,updatecheck,vipstate,tempcard,where
typ=request("typ")
val=request("val")
if val="" then val=1000
%>
  <tr>
    <td>������
      <label for="typ">��ѡ���ѯ���ͣ�</label>
      <select name="typ" id="typ" 
      onChange="if(this.value==1){
            this.form.val.value=1000;document.getElementById('valText').innerText='��'
            }else{
            this.form.val.value=30;document.getElementById('valText').innerText='��'
            }">
      <option value="1" <%if typ=1 then response.write " selected='selected'"%>>�����ֹ˿�</option>
      <option value="2" <%if typ=2 then response.write " selected='selected'"%>>�ٽ����չ˿�</option>
      <option value="3" <%if typ=3 then response.write " selected='selected'"%>>�������ڹ˿�</option>
      <option value="4" <%if typ=4 then response.write " selected='selected'"%>>δ���ѹ˿�</option>
      <option value="5" <%if typ=5 then response.write " selected='selected'"%>>VIP������˹���</option>
      </select>
  <input type="text" name="val" id="val" style="width:100px; border:solid 1px #d5d5d5;" value="<%=val%>" onChange="this.value=renull(this.value)" />
  <label for="val" id="valText"><%
		if typ=1 or typ="" then
			response.Write("��")
		else
			response.Write("��")
		end if
	
	%></label>
  <input type="submit" value="��ѯ" />
  <input type="button" value="ȫѡ/��ѡ" onClick="choall()" />
  <% if session("CF_Pos_SendMas")<>1 and  session("psendmsg1")=true then %>
  <input type="button" value="���Ͷ���" onClick="this.form.action='vip_SMSSender.asp';this.form.submit()" />
  <% end if %>
  </td>
  </tr>
</table>
<%
if typ="" then response.End()  

dim t
'ȡϵͳ����
depotid = session("dm").System_DepotID
if session("vip_lookunit") then
	where=" and a.depotid in (select b.depotid from j_depot a,j_depot b where a.unitid=b.unitid and a.depotid="&qts(depotid)&") "
else
	where=" and a.depotid="&qts(depotid)
end if


set t=new Table
t.ActiveConnection = cn
t.CommandType = 1
	select case typ
	case 1
	'��������ʾ
		sql=" select a.vipid, a.depotid,b.d_name, a.vipcode, a.vipname, a.vipsex, "&_
				" isnull(a.centum,0)+isnull(c.starcentum,0) as centum, "&_
				" isnull(a.sums,0)+isnull(c.starsums,0) as sums,a.vipbirth,a.vippaper, "&_
				" a.vippassport,a.vipapply,  a.country, "&_
				" a.people, a.stature, a.waistline, a.city, a.vipemail, a.viptel,  a.mobtel, a.vipadd, a.vippostalcode,a.vipgrab, "&_
				" a.vipstyle, a.vipcolor, a.vipsize, a.vipmin, a.vipmax, a.viplove, a.vipoccupation,a.vippay,"&_
				" a.crdate,a.crname, a.vipup, a.vipuse, a.validate,a.comment,vipcodejm='*' "&_
				" from vip_user a,j_depot b,vip_cardvip c "&_
				" where a.depotid*=b.depotid and isnull(a.centum,0)+isnull(c.starcentum,0)>= "&val&" "&_
				" and a.vipcode=c.vipcardid "&where
	case 2
	'������ʾ
		sql=" select a.vipid, a.depotid,b.d_name, a.vipcode, a.vipname, a.vipsex, "&_
				" isnull(a.centum,0)+isnull(c.starcentum,0) as centum, "&_
				" isnull(a.sums,0)+isnull(c.starsums,0) as sums,a.vipbirth,a.vippaper, "&_
				" a.vippassport,a.vipapply,  a.country, "&_
				" a.people, a.stature, a.waistline, a.city, a.vipemail, a.viptel,  a.mobtel, a.vipadd, a.vippostalcode,a.vipgrab, "&_
				" a.vipstyle, a.vipcolor, a.vipsize, a.vipmin, a.vipmax, a.viplove, a.vipoccupation,a.vippay,"&_
				" a.crdate,a.crname, a.vipup, a.vipuse, a.validate,a.comment,vipcodejm='*' "&_
				" from vip_user a "&_
				" left join j_depot b  on a.depotid=b.depotid "&_
				" left join vip_cardvip c on a.vipcode=c.vipcardid"&_
				" where dbo.FN_GetNextBirthday(a.vipbirth,getdate())<="&val&" "&where
	case 3
	'������ʾ
		sql=" select a.vipid, a.depotid,b.d_name, a.vipcode, a.vipname, a.vipsex, "&_
				" isnull(a.centum,0)+isnull(c.starcentum,0) as centum, "&_
				" isnull(a.sums,0)+isnull(c.starsums,0) as sums,a.vipbirth,a.vippaper, "&_
				" a.vippassport,a.vipapply,  a.country, "&_
				" a.people, a.stature, a.waistline, a.city, a.vipemail, a.viptel,  a.mobtel, a.vipadd, a.vippostalcode,a.vipgrab, "&_
				" a.vipstyle, a.vipcolor, a.vipsize, a.vipmin, a.vipmax, a.viplove, a.vipoccupation,a.vippay,"&_
				" a.crdate,a.crname, a.vipup, a.vipuse, a.validate,a.comment,vipcodejm='*' "&_
				" from vip_user a,j_depot b,vip_cardvip c "&_
				" where a.depotid*=b.depotid and a.vipcode=c.vipcardid "&_
				" and convert(char(10),c.vipemit+limitday-"&val&",126)<convert(char(10),getdate(),126) "&where
	
	case 4
	'δ������ʾ
		sql=" select a.vipid, a.depotid,b.d_name, a.vipcode, a.vipname, a.vipsex, "&_
				" isnull(a.centum,0)+isnull(c.starcentum,0) as centum, "&_
				" isnull(a.sums,0)+isnull(c.starsums,0) as sums,a.vipbirth,a.vippaper, "&_
				" a.vippassport,a.vipapply,  a.country, "&_
				" a.people, a.stature, a.waistline, a.city, a.vipemail, a.viptel,  a.mobtel, a.vipadd, a.vippostalcode,a.vipgrab, "&_
				" a.vipstyle, a.vipcolor, a.vipsize, a.vipmin, a.vipmax, a.viplove, a.vipoccupation,a.vippay,"&_
				" a.crdate,a.crname, a.vipup, a.vipuse, a.validate,a.comment,vipcodejm='*' "&_
				" from vip_user a,j_depot b,vip_cardvip c where a.depotid*=b.depotid and a.vipcode=c.vipcardid "&_
				" and convert(char(10),a.viplastdate+"&val&",126)<convert(char(10),getdate(),126) "&where
	
	case 5
	'������˹�����ʾ
		sql=" select a.vipid, a.depotid,b.d_name, a.vipcode, a.vipname, a.vipsex, a.vipbirth, "&_
				" a.vipemail, a.viptel,c.crdate, a.mobtel,isnull(a.sums,0)+isnull(c.starsums,0) as sums, "&_
				" isnull(a.centum,0)+isnull(c.starcentum,0) as centum, "&_
				" isnull(datediff(day,convert(char(10),c.crdate,126),getdate()),0)-isnull("&val&",0) as gq,vipcodejm='*' "&_
				" from vip_user a,j_depot b,vip_cardvip c "&_
				" where a.depotid*=b.depotid and a.vipcode=c.vipcardid and a.updatecheck>0 "&_
				" and datediff(day,convert(char(10),c.crdate,126),getdate())>"&val&" "&where
	
	end select
				'de sql
	t.commandText = sql
	if typ=5 then
		t.SetField 0,"�˿ͱ��","150",0
		't.SetField 1,"���̱��","60",0
		't.SetField 2,"��������","80",0
	    if session("pos_vipshow")=true then 
		  t.SetField 14,"����","120",0
		else
		  t.SetField 3,"����","120",0
		end if
		t.SetField 4,"����","60",0
		t.SetField 5,"�Ա�","60",0
		t.SetField 6,"����","60",0
		t.SetField 12,"�ܻ���","60",0
		t.SetField 11,"�ܴ�ֵ","60",0
		t.SetField 10,"�ֻ���","60",0
		t.SetField 9,"��������","120",0
		t.SetField 13,"������˹�������","120",0
	else
		t.SetField 0,"�˿ͱ��","150",0
		't.SetField 1,"���̱��","60",0
		't.SetField 2,"��������","80",0
  	    if session("pos_vipshow")=true then
		  t.SetField 37,"����","120",0
		else    
		  t.SetField 3,"����","120",0
		end if   
		t.SetField 4,"����","60",0
		t.SetField 5,"�Ա�","60",0
		t.SetField 6,"�ܻ���","60",0
		t.SetField 7,"�ܴ�ֵ","60",0
		t.SetField 8,"��������","80",0
		t.SetField 9,"֤������","60",0
		t.SetField 10,"֤����","120",0
		t.SetField 11,"��췽ʽ","60",0
		t.SetField 12,"����","60",0
		t.SetField 13,"����","60",0
		t.SetField 14,"���","60",0
		t.SetField 15,"��Χ","60",0
		t.SetField 16,"��������","60",0
		t.SetField 17,"��������","100",0
		t.SetField 18,"��ϵ�绰","60",0
		t.SetField 19,"�ƶ��绰","80",0
		t.SetField 20,"ͨѶ��ַ","120",0
		t.SetField 21,"��������","60",0
		t.SetField 22,"��װ���","60",0
		t.SetField 23,"ϲ����ʽ","60",0
		t.SetField 24,"ϲ����ɫ","60",0
		t.SetField 25,"ϲ������","60",0
		t.SetField 26,"�ɽ��ܼ�λ��Χ1","60",0
		t.SetField 27,"�ɽ��ܼ�λ��Χ2","60",0
		t.SetField 28,"����ϲ��","60",0
		t.SetField 29,"ְҵ","60",0
		t.SetField 30,"����","60",0
		t.SetField 31,"��������","120",0
		t.SetField 32,"�����","60",0
		t.SetField 33,"ͬ���ϴ�","60",0
		t.SetField 34,"ͬ��ʹ��","60",0
		t.SetField 35,"��Ч���","60",0
		t.SetField 36,"��ע","200",0
	end if
	t.height="88%"
	t.Mselect=true	'��ѡ
	t.MselectValue="vipid"	'ָ��ѡ��checkbox��ֵ
	t.MSDefCheck=false		'Ĭ���Ǵ򹳻��ǲ���
  t.Show()
  set t=Nothing
%>
</form>
<script language="javascript">
	try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
function choall()
{
	var oc = document.getElementsByName("vipid");
	for(i=0;i<oc.length;i++){ oc[i].checked = !oc[i].checked;}
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

</script>
</body>
</html>
