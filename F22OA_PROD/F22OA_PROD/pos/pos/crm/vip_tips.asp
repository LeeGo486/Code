<%option explicit
session("formid")=6101026%>
<!--#include file="../f22/report/inc/function.asp" -->
<!--#include file="../f22/report/inc/Class.asp" -->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>VIP信息提示</title>
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
    <td align="center">VIP信息提示</td>
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
    <td>　　　
      <label for="typ">请选择查询类型：</label>
      <select name="typ" id="typ" 
      onChange="if(this.value==1){
            this.form.val.value=1000;document.getElementById('valText').innerText='分'
            }else{
            this.form.val.value=30;document.getElementById('valText').innerText='天'
            }">
      <option value="1" <%if typ=1 then response.write " selected='selected'"%>>超积分顾客</option>
      <option value="2" <%if typ=2 then response.write " selected='selected'"%>>临近生日顾客</option>
      <option value="3" <%if typ=3 then response.write " selected='selected'"%>>即将过期顾客</option>
      <option value="4" <%if typ=4 then response.write " selected='selected'"%>>未消费顾客</option>
      <option value="5" <%if typ=5 then response.write " selected='selected'"%>>VIP升级审核过期</option>
      </select>
  <input type="text" name="val" id="val" style="width:100px; border:solid 1px #d5d5d5;" value="<%=val%>" onChange="this.value=renull(this.value)" />
  <label for="val" id="valText"><%
		if typ=1 or typ="" then
			response.Write("分")
		else
			response.Write("天")
		end if
	
	%></label>
  <input type="submit" value="查询" />
  <input type="button" value="全选/反选" onClick="choall()" />
  <% if session("CF_Pos_SendMas")<>1 and  session("psendmsg1")=true then %>
  <input type="button" value="发送短信" onClick="this.form.action='vip_SMSSender.asp';this.form.submit()" />
  <% end if %>
  </td>
  </tr>
</table>
<%
if typ="" then response.End()  

dim t
'取系统设置
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
	'超积分提示
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
	'生日提示
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
	'过期提示
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
	'未消费提示
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
	'升级审核过期提示
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
		t.SetField 0,"顾客编号","150",0
		't.SetField 1,"店铺编号","60",0
		't.SetField 2,"店铺名称","80",0
	    if session("pos_vipshow")=true then 
		  t.SetField 14,"卡号","120",0
		else
		  t.SetField 3,"卡号","120",0
		end if
		t.SetField 4,"姓名","60",0
		t.SetField 5,"性别","60",0
		t.SetField 6,"生日","60",0
		t.SetField 12,"总积分","60",0
		t.SetField 11,"总储值","60",0
		t.SetField 10,"手机号","60",0
		t.SetField 9,"升级日期","120",0
		t.SetField 13,"升级审核过期天数","120",0
	else
		t.SetField 0,"顾客编号","150",0
		't.SetField 1,"店铺编号","60",0
		't.SetField 2,"店铺名称","80",0
  	    if session("pos_vipshow")=true then
		  t.SetField 37,"卡号","120",0
		else    
		  t.SetField 3,"卡号","120",0
		end if   
		t.SetField 4,"姓名","60",0
		t.SetField 5,"性别","60",0
		t.SetField 6,"总积分","60",0
		t.SetField 7,"总储值","60",0
		t.SetField 8,"出生日期","80",0
		t.SetField 9,"证件类型","60",0
		t.SetField 10,"证件号","120",0
		t.SetField 11,"申办方式","60",0
		t.SetField 12,"籍贯","60",0
		t.SetField 13,"民族","60",0
		t.SetField 14,"身高","60",0
		t.SetField 15,"腰围","60",0
		t.SetField 16,"所属区域","60",0
		t.SetField 17,"电子邮箱","100",0
		t.SetField 18,"联系电话","60",0
		t.SetField 19,"移动电话","80",0
		t.SetField 20,"通讯地址","120",0
		t.SetField 21,"邮政编码","60",0
		t.SetField 22,"着装风格","60",0
		t.SetField 23,"喜欢款式","60",0
		t.SetField 24,"喜欢颜色","60",0
		t.SetField 25,"喜欢尺码","60",0
		t.SetField 26,"可接受价位范围1","60",0
		t.SetField 27,"可接受价位范围2","60",0
		t.SetField 28,"个人喜好","60",0
		t.SetField 29,"职业","60",0
		t.SetField 30,"收入","60",0
		t.SetField 31,"建立日期","120",0
		t.SetField 32,"填表人","60",0
		t.SetField 33,"同意上传","60",0
		t.SetField 34,"同意使用","60",0
		t.SetField 35,"有效贵宾","60",0
		t.SetField 36,"备注","200",0
	end if
	t.height="88%"
	t.Mselect=true	'多选
	t.MselectValue="vipid"	'指定选中checkbox的值
	t.MSDefCheck=false		'默认是打钩还是不打钩
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
		alert('请填写短信内容。')
		return false;
	}else{
		var tab = gtTables.getTable("gt1");
		//提交前先把旧的FORM去掉
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
