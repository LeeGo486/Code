<%option explicit%>
<%session("formid")=6100001%>

<!--#include file="inc/function.asp"-->
<!--#include file="pos_main.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<script language="javascript">
function clothing(id){

  var sm = showModalDialog('clothing.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
	if(sm)
	{
		try
		{
			parent.document.getElementById('clothingid').value = sm;
			parent.document.forms[0].submit();
		}catch(e){
			
			}
			
		}
}
function dpkc(id){
  showModalDialog('pos_dpkc.asp?id='+id+'&pksname=<%=session("pksname")%>','example04','dialogWidth:600px;dialogHeight:370px;center: yes;help:no;resizable:yes;status:no');
}
function okcode(t){
  t.style.color="red";
}
</script>
<style type="text/css">

body,td,th {
	font-size: 12px;
}
body {
	margin-top: 0px;
	margin-bottom: 0px;
	margin-left: 1px;
	margin-right: 1px;
}
form {
	margin:0px;
}
.nb {
	border:0px;
}

</style>
</head>
<body>
<%
dim rs,posvipcode,shopcard
set cn=server.createobject("ADODB.Connection")
cn.open session("cn")
posvipcode=session("posvipcode")
shopcard=session("shopcard")

dim retailid,ds1,depotid,sql,kc,sums,discount
retailid=session("retailid")
depotid=trim(session("dm").System_depotid)

'重新恢复每个款的原折扣、单价，解决执行促销后进行修改的问题,退货VIP折扣
Sql=" update webtmp_retailsub set discount=prodiscount,s_price=pros_price,vipcentum=0,vipdisc=case when   nums<0  then prodiscount else 0 end  where retailid='"&retailid&"' and isnull(vipdisc,0)=0 and  isnull(cxdisc,1)=1"
Cn.Execute Sql

'调用商场折扣
dim t
set t=new retail
t.CreateAdo

	if shopcard<>"" then
		call t.ShopcardDiscount(shopcard)
	end if
	
'set rs = server.CreateObject("adodb.recordset")
'rs.open "select isnull(vipcode,'') as vipcode,isnull(inputvip,0) as inputvip "&_
'				"from webtmp_retail where retailid='"&retailid&"'",cn,1,1
'if not rs.eof and not rs.bof then
	
	'if rs("vipcode")<>"" then	 '如果已输入VIP卡，就不执行促销
	'	cn.execute "web_vipcalc '"&retailid&"',"&cint(session("novip"))&","&cint(session("vipzsz"))&","&cint(session("selcx"))&",3"
	'else
	'	cn.execute "pos_cxgl '"&retailid&"'"
	'end if
	
'end if
'rs.close
'set rs=nothing
cn.execute "pos_cxgl '"&retailid&"'"	

	
	
'set rs=server.CreateObject("adodb.recordset")
'rs.open "select isnull(vipcode,'') as vipcode,isnull(inputvip,0) as inputvip from webtmp_retail where retailid='"&retailid&"'",cn
'if not rs.eof then
'  if rs("vipcode")="" then
'	
    '判断是否输入过VIP，如果输入过VIP，但现VIP字段为空则恢复原来价格
	  'if rs("inputvip") then
	     'Sql=" update webtmp_retailsub set discount=olddiscount,s_price=olds_price,prodiscount=olddiscount,pros_price=olds_price where retailid='"&retailid&"' "&_
	     '  " update webtmp_retail set inputvip=0 where retailid='"&retailid&"'"
	     'cn.execute Sql	  'end if
    '调用促销*************************************
'  else


'改到存储过程

'   '如果有输入VIP，则对后面输入的款式再执行VIP
'	dim rsvip,rszk,rsjf,sdiscount,vipcode,vipcentum
'	vipcode=rs("vipcode")
'	'执行VIP折扣
'	set rsvip=server.createobject("adodb.recordset")
'	set rszk=server.createobject("adodb.recordset")
'	rsvip.open "select * from webtmp_retailsub where retailid='"&retailid&"' and isnull(vipcode,'')=''",cn,1,1
'	if not rsvip.eof then
'	   set rsjf=server.createobject("adodb.recordset")
'		 
'		 sql=chkvip(vipcode,0)
'	   rsjf.open sql,cn,1,1
'				
'	   if not rsjf.eof then
'	      vipcentum=cdbl(rsjf("centum"))
'	   else
'	      vipcentum=-1
'	   end if
'	   rsjf.close	
'	   set rsjf=nothing
'	
'	   while not rsvip.eof
'	     sdiscount=cdbl(rsvip("discount"))
'	     rszk.open "getvipdiscount '"&vipcode&"',"&vipcentum&","&sdiscount&"",cn
'		 if not rszk.eof then
'		   if cdbl(rszk(0))<>1 then
'			 
'		'判断VIP是否折上折
'			  if session("vipzsz")=0 then
'		         sdiscount=sdiscount*cdbl(rszk(0))
'			  else
'			     if cdbl(sdiscount)>cdbl(rszk(0)) then
'				    sdiscount=cdbl(rszk(0))
'				   end if
'			  end if
'
'			  cn.execute "update webtmp_retailsub set discount="&sdiscount&",s_price="&cdbl(rsvip("x_price"))*sdiscount&","&_
'			             "vipcode='"&vipcode&"',prodiscount="&sdiscount&",pros_price="&cdbl(rsvip("x_price"))*sdiscount&_
'						 " where retailid='"&retailid&"' and isnull(zs,0)=0 and isnull(back,0)=0 and id="&rsvip("id")
'		   end if
'		 end if
'		 rszk.close 
'	     rsvip.movenext
'	   wend
'	end if
'	rsvip.close
'	set rsvip=nothing
'	set rszk=nothing
'	
	
	
'  end if
'else
  '调用促销*************************************
'  cn.execute "pos_cxgl '"&retailid&"'"
'end if

'rs.close
'set rs=nothing
	
t.CloseAdo
set t=nothing

call clsub()


%>
<table width='100%' border=1 cellspacing=0 bordercolorlight='#ACA899' bordercolordark='#FFFFFF' class='f12'>
  <tr bgcolor='#FFEFEF' align='center'>
  <td>货品编号</td>
	<td>货品名称</td>
	<td>颜色</td>
	<td>数量</td>
  <%if pxprice then%><td>现售价</td><%end if%>
	<%if pxprice and psprice then%><td>折扣</td><%end if%>
	<%if psprice then%><td>结算价</td><%end if%>
	<%if pxprice then%><td>现价金额</td><%end if%>
	<%if psprice then%><td>结算金额</td><%end if%>
	<td>库存</td>
	<td>内部编码</td>
	<td>&nbsp;</td>
	<td>库存查询</td>
  </tr>
  <%dim ds,s,i,nums,xs,xsums
  i=0
  s=0
  xs=0
  nums=0
  set ds=Server.CreateObject("ADODB.Recordset")
  'ds.ActiveConnection = cn
  sql = "select id,clothingid,s_name,c_name,isnull(x_price,0) as x_price,isnull(discount,0) as discount,isnull(s_price,0) as s_price,"&_
             "nums,isnull(zs,0) as zs,isnull(back,0) as back,kc,isnull(isnull(s_price,0)*nums,0) as sums,"&_
			 "isnull(isnull(x_price,0)*nums,0) as xsums,code from webtmp_retailsub where retailid='"&retailid&"' order by id desc"
'	de sql
  ds.Open sql,cn,1,1
  while not ds.eof
  i=i+1
  %>
  <tr>
    <td>&nbsp;<a href="javascript:clothing('<%=ds("clothingid")%>');"><%=ds("clothingid")%></a></td>
    <td>&nbsp;<%=ds("s_name")%></td>
    <td>&nbsp;<%=ds("c_name")%></td>
    <td>
    <form name="form1" method="get" action="pos_control.asp">
      <input name="nums" type="text" class="nb" value="<%=ds("nums")%>" size="3" maxlength="3" onKeyDown="okcode(this);"><input type="submit" style="width:0px; " >
	      <input name="act" type="hidden" id="act" value="editnums">
          <input name="id" type="hidden" id="id" value="<%=ds("id")%>">
    </form>
		<%nums=nums+cint(ds("nums"))%>
    <%if ds("zs")=true then response.write "(<font color=#FF0000>赠送</font>)"%>
	</td>
  	<%if pxprice then %>
      <td><%=formatNumber(ds("x_price"),2)%></td>
		<%end if%>
    <%if pxprice and psprice then%>
      <td>
      <% if session("dm_zk") then%>
      <form name="form2" method="get" action="pos_control.asp">
        <input name="discount" type="text" class="nb" value="<%=formatNumber(ds("discount"),,-1)%>" size="5" maxlength="5" onKeyDown="okcode(this);"><input type="submit" style="width:0px; " >
          <input name="act" type="hidden" id="act" value="mdisc">
            <input name="id" type="hidden" id="id" value="<%=ds("id")%>">
      </form>
      <%else%>
      <%=ds("discount")%>
      <%end if%>
      </td>
		<%end if%>
    <%if psprice then %>
      <td>
        <%if session("dm_sp") then%>
          <form name="form3" method="get" action="pos_control.asp">
            <input name="s_price" type="text" class="nb" id="s_price" value="<%=ds("s_price")%>" size="8" maxlength="8" onKeyDown="okcode(this);"><input type="submit" style="width:0px; " >
              <input name="act" type="hidden" id="act" value="editsp">
            <input name="x_price" type="hidden" id="x_price" value="<%=ds("x_price")%>">
                <input name="id" type="hidden" id="id" value="<%=ds("id")%>">
          </form>
        <%else%>
          <%=ds("s_price")%>
        <%end if%>
      </td>
    <%end if%>
    <%if pxprice then %>
      <td>
        <%xsums=cdbl(ds("x_price"))*cint(ds("nums"))
        response.Write xsums
        xs=xs+xsums%></td>
    <%end if%>
    <%if psprice then %>
      <td><%
        sums=cdbl(ds("s_price"))*cint(ds("nums"))
        response.Write sums
        s=s+sums %>
      </td>
    <%end if%>
    <td><%=ds("kc")%>&nbsp;</td>
    <td><form name="form4" method="get" action="pos_control.asp">
      <input name="code" type="text" class="nb" id="code" size="10" maxlength="10" value="<%=ds("code")%>" onKeyDown="okcode(this);">
      <input name="act" type="hidden" id="act" value="code">
      <input name="id" type="hidden" id="id" value="<%=ds("id")%>">
    </form></td>
    <td align="center"><a href="pos_control.asp?act=del&id=<%=ds("id")%>">删除</a></td>
    <td align="center">
	<%if session("onlybdkc") then%>
	&nbsp;
	<%else%>
	<a href="javascript:dpkc('<%=ds("clothingid")%>');">其它店铺</a>
	<%end if%>
	</td>
  </tr>
  <a name="xh<%=i%>"></a>
  <%ds.MoveNext
  wend
  ds.Close
  set ds=nothing%>  
  <tr>
    <td>品种: <%=i%></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><%=nums%></td>
		<%if pxprice then%><td>&nbsp;</td><%end if%>
    <%if pxprice and psprice then%><td>&nbsp;</td><%end if%>
    <%if psprice then%><td>&nbsp;</td><%end if%>
    <%if pxprice then%><td>&nbsp;</td><%end if%>
    <%if psprice then%><td><%=s%></td><%end if%>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>

</table>
<%set ds1=nothing

sub clsub()
select case session("dm_round")
case 0 '四舍五入
       cn.execute "update webtmp_retailsub set s_price=round(isnull(s_price,0),"&session("FRoundDec")&") where retailid='"&retailid&"'"
case 1 '只入不舍
       cn.execute "update webtmp_retailsub set s_price=case when round(isnull(s_price,0),4)>round(isnull(s_price,0),0,1) then round(isnull(s_price,0),0,1)+1 else s_price end where retailid='"&retailid&"'"
case 3 '只舍不入
       cn.execute "update webtmp_retailsub set s_price=round(isnull(s_price,0),0,1) where retailid='"&retailid&"'"
end select
end sub%>
<script language="javascript">
  window.parent.form1.key.value="";
  window.parent.form1.key.focus();
  window.parent.playSound("<%=i%>");
</script>
</body>
</html>