<%session("formid")=2061%>
<!--#include file="inc/function.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�����ۿ�油��</title>
<link href="report/css/report.css" rel="stylesheet" type="text/css">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../inc/js/setday.js"></script>
<script type="text/javascript" src="inc/abc.js"></script>
<script language="javascript">
<%Call selectSFdh%>
function selectStyle(){
  showModalDialog('report/select1.asp','example04','dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no');
}

function checkform1(theform)
{if(theform.depotid.value==''){alert('��ѡ�񲹻��ֿ⣡');return false;}
 else
 {
 document.frames['is'].document.form3.dptid.value=theform.depotid.value;
 document.frames['is'].document.form3.submit();
  }
}

function checkform2()
{document.all.t1.style.display='block';}

function checkform4(theform)
{if(theform.depotid.value==''){alert('��ѡ�񲹻��ֿ⣡');return false;}
 else
 {
 document.frames['is'].document.form3.f4.value=0;	
 document.frames['is'].document.form3.dptid.value=theform.depotid.value;
 document.frames['is'].document.form3.submit();
  }
}
</script>
</head>

<body>
<%act=request("act")
rq1=request("rq1")
rq2=request("rq2")

if act="" then
   call main()
elseif act="0" or act="1" then
   call seach()
else
   call submit()
end if

Sub main()%>
<table width="100%"  border="0" cellpadding="0" cellspacing="1" class="bar">
<form action="2061_retailstockBH.asp" method="get" name="form2" target="is" onSubmit="return checkform2()">
    <tr>
      <td>������ʽ:
        <input type="radio" name="act" value="0" checked="checked">����油��
        <input type="radio" name="act" value="1">�����۲���</td>
	  <td><input type="button" name="selsty" value="ѡ���ʽ" onClick="selectStyle()"></td>
	  <td>��ʼ���� <input name="rq1" type="text" id="rq1" size="11" maxlength="10" value="<%=get_date(date()-1)%>" onFocus="setday(this);" readonly></td>
      <td>�������� <input name="rq2" type="text" id="rq2" size="11" maxlength="10" value="<%=get_date(date())%>" onFocus="setday(this);" readonly></td>
      <td align=right><input type="submit" name="Submit" value=" ��  ѯ "> </td>
    </tr>
</form>
</table>
<table width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#F2FCFB" id="t1" style="display:none">
<form action="2061_retailstockBH.asp" method="get" name="form1" target="is">
    <tr>
      <td><font size=2>�����ֿ�</font>
	      <input name="depotid" type="text" class="intra13" id="depotid" size="22" maxlength="10" readonly>
          <input type="button" name="Submit" value="..." onClick="selectMD('sd');">
      <input name="sdptname" type="text" class="tcontent" id="sdptname" style="border:none;" tabindex="-1" size="20" readonly></td>
      <td align=right><input type="button" name="Submit" value="ȷ�ϲ���" onClick="return checkform1(this.form)"> </td>
      <td align=right><input type="button" name="Submit" value="���벹��" onClick="return checkform4(this.form)"> </td>
      
    </tr>
</form>	
</table>
<iframe name="is" id="is" width="100%" height="85%" frameborder="0" src=""></iframe>
<%End Sub

Sub seach()%>
<table width="100%" border="1" cellspacing="0" bordercolor="#003333" bordercolordark="#FFFFFF">
<form action="2061_retailstockBH.asp" method="post" name="form3">
 <tr align=center bgcolor="#E9F6F5">
   <td><font size=2>�� ��</font></td>
   <td><font size=2>��ʽ���</font></td>
   <td><font size=2>��ʽ����</font></td>
   <td><font size=2>�� ��</font></td>
   <td><font size=2>�� ɫ</font></td>
   <td><font size=2>�� ��</font></td>
   <td><font size=2>�� ��</font></td>
   <td><font size=2>�� ��</font></td>
   <td><font size=2>�� ��</font></td>
 </tr>
<%
on error resume next
set rs=server.createobject("adodb.recordset")
if act="0" then
   sql1="select a.clothingid,a.styleid,d.s_name,d.x_price,a.colorid,e.c_name,a.sizeid,isnull(b.k_num,0) as kc,0 as xs into #retailstockbh1 "&_
        "from j_clothing a,j_stock b,sys_stylepower18ql c,j_style d,j_color e "&_
        "where a.styleid=c.styleid and c.userid='"&session("dm").system_userid&"' and b.depotid='"&session("dm").system_depotid&"' "&_
        "and a.clothingid*=b.clothingid and a.styleid=d.styleid and c.access=1 and c.selection=1 and a.colorid=e.colorid"
   sql2="insert into #retailstockbh1 "&_
        "select a.clothingid,a.styleid,c.s_name,c.x_price,a.colorid,e.c_name,a.sizeid,0,isnull(b.nums,0) "&_
	    "from j_clothing a,(select b.clothingid,sum(b.nums) as nums from d_retail a,d_retailsub b "&_
        "where a.retailid=b.retailid and a.sure>0 and a.depotid='"&session("dm").system_depotid&"' "&_
	    "and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' group by a.depotid,b.clothingid) b,"&_
		"j_style c,sys_stylepower18ql d,j_color e "&_
        "where a.styleid=c.styleid and d.userid='"&session("dm").system_userid&"' and a.styleid=d.styleid "&_
	    "and a.clothingid*=b.clothingid and d.access=1 and d.selection=1 and a.colorid=e.colorid"
   sql3="select clothingid,max(styleid) as styleid,max(s_name) as s_name,avg(x_price) as x_price,max(colorid) as colorid,"&_
        "max(c_name) as c_name,max(sizeid) as sizeid,sum(kc) as kc,sum(xs) as xs into #retailstockbh2 from #retailstockbh1 group by clothingid"
   cn.execute "drop table #retailstockbh1"
   cn.execute "drop table #retailstockbh2"
   cn.execute sql1
   cn.execute sql2
   cn.execute sql3
else
   sql1="select a.clothingid,a.styleid,c.s_name,c.x_price,a.colorid,f.c_name,a.sizeid,isnull(e.k_num,0) as kc,isnull(b.nums,0) as xs into #retailstockbh2 "&_
	    "from j_clothing a,(select b.clothingid,sum(b.nums) as nums from d_retail a,d_retailsub b "&_
        "where a.retailid=b.retailid and a.sure>0 and a.depotid='"&session("dm").system_depotid&"' "&_
	    "and convert(char(10),a.sure_date,126) between '"&rq1&"' and '"&rq2&"' group by a.depotid,b.clothingid having sum(b.nums)<>0) b,"&_
		"j_style c,sys_stylepower18ql d,j_stock e,j_color f "&_
        "where a.styleid=c.styleid and d.userid='"&session("dm").system_userid&"' and a.styleid=d.styleid and b.clothingid=e.clothingid "&_
	    "and a.clothingid=b.clothingid and d.access=1 and d.selection=1 and e.depotid='"&session("dm").system_depotid&"' "&_
		"and a.colorid=f.colorid"
   'de sql1
   cn.execute "drop table #retailstockbh2"
   cn.execute sql1
end if

rs.open " select clothingid,styleid,s_name,colorid,c_name,sizeid,"&_
				" isnull(x_price,0) x_price,isnull(kc,0) kc,isnull(xs,0) xs "&_
				" from #retailstockbh2 order by clothingid",cn,1,1
i=1
if not rs.eof then
while not rs.eof%>
 <tr align=center <%if rs("kc")=0 and rs("xs")=0 then response.write("bgcolor='#FFA43F'") end if
                    if rs("xs")<>0 then response.write("bgcolor='#ABD5FF'") end if%>>
   <td>
<a href="javascript:;" onClick="showModalDialog('indentpic/fashionzl.asp?styleid=<%=rs("styleid")%>',window,'dialogWidth:750px;dialogHeight:500px;center: yes;help:no;resizable:no;status:no');"><font size=2><%=rs("clothingid")%></font></a>   </td>
   <td><font size=2><%

			if styleid<>rs("styleid") then 
				response.Write rs("styleid") 
				styleid = rs("styleid")
			end if%>&nbsp;</font></td>

  <td><font size=2><%if sname<>rs("s_name") then
                         response.write(rs("s_name"))
						 sname=rs("s_name")
					  end if%>&nbsp;</font></td>
   <td><font size=2><%if x_price<>cdbl(rs("x_price")) then
                         response.write(rs("x_price"))
						 x_price=cdbl(rs("x_price"))
					  end if%>&nbsp;</font></td>
   <td><font size=2><%if colorid<>rs("colorid") then
                         response.write(rs("colorid")&"("&rs("c_name")&")")
						 colorid=rs("colorid")
					  end if%>&nbsp;</font></td>
   <td><font size=2><%=rs("sizeid")%>&nbsp;</font></td>
   <td><font size=2><%if rs("kc")<>0 then 
                         response.write(rs("kc")) 
						 kc=kc+cdbl(rs("kc"))
					  end if%>&nbsp;</font></td>
   <td><font size=2><%if rs("xs")<>0 then 
                         response.write(rs("xs")) 
						 xs=xs+cdbl(rs("xs"))
					  end if%>&nbsp;</font></td>
   <td><input type="hidden" name="clothing<%=i%>" value="<%=rs("clothingid")%>">
   <input type="text" name="n<%=i%>" value="<%if rs("xs")>0 then response.write(rs("xs")) end if%>" size="5" onFocus="this.select()" onKeyDown="if(event.keyCode==13)event.keyCode=9" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;" onBlur="javascript:if(isNaN(this.value)){alert('�������ʹ���');this.focus();}this.value=Math.floor(this.value);"></td>
 </tr>
<%i=i+1
rs.movenext
wend%>
 <tr bgcolor="#FFFF00" align="center"><td>&nbsp;</td><td>&nbsp;</td>
   <td>&nbsp;</td><td>&nbsp;</td>
 <td>&nbsp;</td><td>&nbsp;</td><td><font size=2><%=kc%>&nbsp;</font></td><td><font size=2><%=xs%>&nbsp;</font></td><td>&nbsp;</td></tr>
<%end if
set rs=nothing
cn.execute "drop table #retailstockbh1"
cn.execute "drop table #retailstockbh2"%>
<input type="hidden" name="cnt" value="<%=i-1%>">
<input type="hidden" name="act" value="3">
<input type="hidden" name="dptid"> 
<input type="hidden" name="f4"> 
</form>
</table>
<%End Sub

Sub submit()
Dim i,tmp,clothing,ch,cnt,depotid,s,merchid,parentid,no,rate,rs,gp,f4
Dim j_cost,j_price,x_price,discount,s_price,nums
cnt=request("cnt")
depotid=request("dptid")
f4=request("f4")
if depotid="" then
   call mbox("û��ѡ�񲹻��ֿ⣡")
end if

tmp=""
for i=1 to cnt
  if isNumeric(request("n"&i)) then
    if cdbl(request("n"&i))>0 then
      tmp=tmp+trim(request("clothing"&i))+"^"+request("n"&i)+","
	end if
  end if
next

if tmp="" then
   call mbox("û�в������ݣ�")
end if
tmp=left(tmp,len(tmp)-1)
clothing=split(tmp,",")

set rs=server.createobject("adodb.recordset")
set gp=server.createobject("adodb.recordset")

rs.open "select a.unitid,a.parentid,isnull(b.backrate,0) as zk from j_depot a,j_merchant b "&_
        "where a.depotid='"&session("dm").system_depotid&"' and a.unitid=b.merchantid",cn
merchid=rs("unitid")
parentid=rs("parentid")
rate=rs("zk")
rs.close
'����
no=GetId("d_indent","indentid","BH",session("dm").system_userid)
s="insert into d_indent (indentid,indent,MerchantId,setdate,sure,chk_sure,depotid,getdate,d_type,cr_name,chk_name,chk_date,"&_
  "sure_date,ov_sure,sure_name,cr_date,crdate,backrate,selltype,backdate,get_depotid,parentid) values "&_
  "('"&no&"','"&no&"','"&merchid&"',getdate(),0,0,'"&depotid&"',getdate(),2,'"&session("dm").system_username&"','"&session("dm").system_username&"',"&_
  "getdate(),getdate(),0,'"&session("dm").system_username&"',getdate(),getdate(),"&rate&",'����',getdate()+30,'"&session("dm").system_depotid&"','"&parentid&"')"
cn.execute s

for i=0 to ubound(clothing)
  ch=split(clothing(i),"^")
  'gp.open "t18tj_GetClothingPrice 2,'"&session("dm").system_depotid&"','"&trim(ch(0))&"','',1",cn
  gp.open "t18tj_GetClothingPrice 3,'"&session("dm").system_depotid&"','"&trim(ch(0))&"','',1",cn
  if IsNull(gp("j_cost")) then j_cost=0 else j_cost=gp("j_cost") end if
  if IsNull(gp("j_price")) then j_price=0 else j_price=gp("j_price") end if
  if IsNull(gp("x_price")) then x_price=0 else x_price=gp("x_price") end if
  if IsNull(gp("discount")) then discount=0 else discount=gp("discount") end if
  if IsNull(gp("s_price")) then s_price=0 else s_price=gp("s_price") end if 
  '��������
  if session("roundcnt")>0 then
	 s_price=cdbl(s_price)/session("roundcnt")
	 s_price=round(s_price,2)
	 s_price=s_price*session("roundcnt")
  end if
  nums=nums+cdbl(ch(1))
  s="insert into d_indentsub (indentid,boxid,clothingid,styleid,colorid,sizeid,s_price,nums,crdate,discount,x_price,j_price,j_cost) values "&_
    "('"&no&"','AV"&session("dm").system_userid&"','"&gp("clothingid")&"','"&gp("styleid")&"','"&gp("colorid")&"','"&gp("sizeid")&"',"&_
	s_price&","&ch(1)&",getdate(),"&discount&","&x_price&","&j_price&","&j_cost&")"
  cn.execute s
  gp.close
next
select case f4
case ""
	cn.execute "update d_indent set chk_sure=1 where indentid='"&no&"'"
	cn.execute "update d_indent set sure=1 where indentid='"&no&"'"
case 0 
end select
set rs=nothing
set gp=nothing
response.write("<br><br><center>������ "&no&" ��ȷ�ϣ��ܲ��� "&nums&",���Ե����ݲ�������ѯ�����ѯ��</center>")
End Sub%>
</body>
</html>