<%option explicit
'on error resume next
response.Expires=-1000%>
<!--#include file="../inc/const.asp" -->
<!--#include file="inc/function.asp" -->
<%Dim djid,oldformid,newformid,prdname,selectsql,ntype,fdate,ldate,zdlist,rs,tname,cd,userid,depotid,sellist
djid=request("djid")
oldformid=request("oldformid")
userid=session("dm").System_userid
depotid=session("dm").System_depotid
if request("newformid")="" then newformid=1005 else newformid=request("newformid") end if
 fdate=session("fdate")
 if request("fdate")="" then
 fdate=get_date(date)
  else
  fdate=request("fdate")
   end if
  
   ldate=session("ldate")
if request("ldate")="" then ldate=get_date(date) else ldate=request("ldate") end if


if djid="" or oldformid="" then
   response.write("<script>alert('无效参数！');window.close();</script>")
   response.end
end if
ntype=0

select case newformid
case 1005 tname="订货单"
          sellist="indentid,Setdepotid,setdptname,Getdepotid,GetdptName,nums,sums"
          selectsql="a.indentid,a.depotid as Setdepotid,b.d_name as setdptname,a.get_depotid as Getdepotid,c.d_name as GetdptName,"&_
		            "(select sum(d.nums) from d_indentsub d where d.indentid=a.indentid) as nums,"&_
					"(select sum(e.nums*e.s_price) from d_indentsub e where e.indentid=a.indentid) as sums"
		  prdname="select "&selectsql&" from d_indent a,j_depot b,j_depot c where a.d_type=1 and a.Get_depotid="&qts(depotid)&_
		          " and a.depotid=b.depotid and a.get_depotid=c.depotid and convert(char(10),a.cr_date,126) between "&qts(fdate)&" and "&qts(ldate)
case 1006 tname="补货单"
          sellist="indentid,Setdepotid,setdptname,Getdepotid,GetdptName,nums,sums"
          selectsql="a.indentid,a.depotid as Setdepotid,b.d_name as setdptname,a.get_depotid as Getdepotid,c.d_name as GetdptName,"&_
		            "(select sum(d.nums) from d_indentsub d where d.indentid=a.indentid) as nums,"&_
					"(select sum(e.nums*e.s_price) from d_indentsub e where e.indentid=a.indentid) as sums"
		  prdname="select "&selectsql&" from d_indent a,j_depot b,j_depot c where a.d_type=2 and a.Get_depotid="&qts(depotid)&_
		          " and a.depotid=b.depotid and a.get_depotid=c.depotid and convert(char(10),a.cr_date,126) between "&qts(fdate)&" and "&qts(ldate)
case 1007 tname="铺场计划单"
          sellist="indentid,Setdepotid,setdptname,Getdepotid,GetdptName,nums,sums"
          selectsql="a.indentid,a.depotid as Setdepotid,b.d_name as setdptname,a.get_depotid as Getdepotid,c.d_name as GetdptName,"&_
		            "(select sum(d.nums) from d_indentsub d where d.indentid=a.indentid) as nums,"&_
					"(select sum(e.nums*e.s_price) from d_indentsub e where e.indentid=a.indentid) as sums"
		  prdname="select "&selectsql&" from d_indent a,j_depot b,j_depot c where a.d_type=3 and a.Get_depotid="&qts(depotid)&_
		          " and a.depotid=b.depotid and a.get_depotid=c.depotid and convert(char(10),a.cr_date,126) between "&qts(fdate)&" and "&qts(ldate)
case 1008 tname="配货单"
          sellist="quotaid,setdepotid,setdptname,get_depotid,getdptname,nums,xpsums"
          selectsql="a.quotaid,a.set_depotid as setdepotid,b.d_name as setdptname,a.get_depotid,c.d_name as getdptname,"&_
		            "(select sum(d.nums) from d_quotasub d where d.quotaid=a.quotaid) as nums,"&_
					"(select sum(e.nums*e.s_price) from d_quotasub e where e.quotaid=a.quotaid) as xpsums"
		  prdname="select "&selectsql&" from d_quota a,j_depot b,j_depot c where a.d_type=1 and a.Get_depotid="&qts(depotid)&_
		          " and a.set_depotid=b.depotid and a.get_depotid=c.depotid and convert(char(10),a.cr_date,126) between "&qts(fdate)&" and "&qts(ldate)
case 1009 tname="发货单"
          sellist="sellid,setdepotid,setdptname,getdepotid,getdptname,set_nums,set_sums"
          selectsql="a.sellid,a.set_depotid as setdepotid,b.d_name as setdptname,a.get_depotid as getdepotid,c.d_name as getdptname,"&_
		            "(select sum(d.set_nums) from d_sellsub d where d.sellid=a.sellid) as set_nums,"&_
					"(select sum(e.set_nums*e.s_price) from d_sellsub e where e.sellid=a.sellid) as set_sums"
		  prdname="select "&selectsql&" from d_sell a,j_depot b,j_depot c where a.set_depotid="&qts(depotid)&_
		          " and a.set_depotid=b.depotid and a.get_depotid=c.depotid and convert(char(10),a.setcr_date,126) between "&qts(fdate)&" and "&qts(ldate)
case 1010 tname="收货单"
          sellist="sellid,setdepotid,setdptname,getdepotid,getdptname,set_nums,set_sums"
          selectsql="a.sellid,a.set_depotid as setdepotid,b.d_name as setdptname,a.get_depotid as getdepotid,c.d_name as getdptname,"&_
		            "(select sum(d.set_nums) from d_sellsub d where d.sellid=a.sellid) as set_nums,"&_
					"(select sum(e.set_nums*e.s_price) from d_sellsub e where e.sellid=a.sellid) as set_sums"
		  prdname="select "&selectsql&" from d_sell a,j_depot b,j_depot c where a.Get_depotid="&qts(depotid)&_
		          " and a.set_depotid=b.depotid and a.get_depotid=c.depotid and convert(char(10),a.crdate,126) between "&qts(fdate)&" and "&qts(ldate)
							'a.getcr_date 取不到数据,改成 a.crdate by jackie 20090512
case 1011 tname="退货申请单"
          sellist="outindentid,set_depotid,setdptname,depotid,getdptname,nums,sums"
          selectsql="a.outindentid,a.set_depotid,b.d_name as setdptname,a.depotid,c.d_name as getdptname,"&_
		            "(select sum(d.nums) from d_outindentprosub d where d.outindentid=a.outindentid) as nums,"&_
					"(select sum(e.nums*e.s_price) from d_outindentprosub e where e.outindentid=e.outindentid) as sums"
		  prdname="select "&selectsql&" from d_outindentpro a,j_depot b,j_depot c where a.set_depotid="&qts(depotid)&_
		          " and a.set_depotid=b.depotid and a.depotid=c.depotid and convert(char(10),a.cr_date,126) between "&qts(fdate)&" and "&qts(ldate)
case 1012 tname="特殊退货申请单"
          sellist="outindentid,set_depotid,setdptname,depotid,getdptname,sqnums,sqjpsums"
          selectsql="outindentid,set_depotid,setdptname,depotid,getdptname,sqnums,sqjpsums"
		  response.End()
case 1013 tname="退货审批单"
          sellist="outindentid,set_depotid,setdptname,depotid,getdptname,chknums,chkjpsums"
          selectsql="outindentid,set_depotid,setdptname,depotid,getdptname,chknums,chkjpsums"
		  response.End()
case 1014 tname="退货发货单"
          sellist="outindentid,set_depotid,setdptname,depotid,getdptname,nums,sums"
          selectsql="a.outindentid,a.set_depotid,b.d_name as setdptname,a.depotid,c.d_name as getdptname,"&_
		            "(select sum(d.nums) from d_outindentsetsub d where d.outindentid=a.outindentid) as nums,"&_
					"(select sum(e.nums*e.s_price) from d_outindentsetsub e where e.outindentid=e.outindentid) as sums"
		  prdname="select "&selectsql&" from d_outindentset a,j_depot b,j_depot c where a.set_depotid="&qts(depotid)&_
		          " and a.set_depotid=b.depotid and a.depotid=c.depotid and convert(char(10),a.cr_date,126) between "&qts(fdate)&" and "&qts(ldate)
case 1015 tname="退货收货单"
          'prdname="f22qry_outindentget"
          'selectsql="outindentid,set_depotid,setdptname,depotid,getdptname,getnums,getjpsums"
		  response.End()
case 1017 tname="调拨发货单"
          sellist="moveid,setdepotid,dptname,getdepotid,getdptname,nums,jpsums"
          selectsql="a.moveid,a.set_depotid as setdepotid,b.d_name as dptname,a.get_depotid as getdepotid,c.d_name as getdptname,"&_
		            "(select sum(d.set_nums) from d_movesub d where d.moveid=a.moveid) as nums,"&_
					"(select sum(e.set_nums*e.s_price) from d_movesub e where e.moveid=a.moveid) as jpsums"
		  prdname="select "&selectsql&" from d_move a,j_depot b,j_depot c where a.set_depotid="&qts(depotid)&_
		          " and a.set_depotid=b.depotid and a.get_depotid=c.depotid and convert(char(10),a.setcr_date,126) between "&qts(fdate)&" and "&qts(ldate)
case 1018 tname="调拨收货单"
          sellist="moveid,setdepotid,dptname,getdepotid,getdptname,nums,jpsums"
          selectsql="a.moveid,a.set_depotid as setdepotid,b.d_name as dptname,a.get_depotid as getdepotid,c.d_name as getdptname,"&_
		            "(select sum(d.set_nums) from d_movesub d where d.moveid=a.moveid) as nums,"&_
					"(select sum(e.set_nums*e.s_price) from d_movesub e where e.moveid=a.moveid) as jpsums"
		  prdname="select "&selectsql&" from d_move a,j_depot b,j_depot c where a.get_depotid="&qts(depotid)&_
		          " and a.set_depotid=b.depotid and a.get_depotid=c.depotid and convert(char(10),a.getsure_date,126) between "&qts(fdate)&" and "&qts(ldate)
case 1019 tname="盘点单"
          sellist="inventoryid,depotid,d_name,a1,a2,nums,sums"
		  selectsql="a.inventoryid,a.depotid,b.d_name,'' as a1,'' as a2,"&_
		            "(select sum(c.nums) from d_inventorysub c where c.inventoryid=a.inventoryid) as nums,"&_
					"(select sum(d.nums*d.j_price) from d_inventorysub d where d.inventoryid=a.inventoryid) as sums "
		  prdname="select "&selectsql&" from d_inventory a,j_depot b where a.depotid="&qts(depotid)&_
		          " and a.depotid=b.depotid and convert(char(10),a.setdate,126) between "&qts(fdate)&" and "&qts(ldate)
case 1020 tname="盘点差异单"
          sellist="inventoryid,depotid,d_name,a1,a2,nums,sums"
          selectsql="a.inventoryid,a.depotid,b.d_name,'' as a1,'' as a2,"&_
		            "(select sum(c.d_nums) from d_inventorysub c where c.inventoryid=a.inventoryid) as nums,"&_
					"(select sum(d.d_nums*d.j_price) from d_inventorysub d where d.inventoryid=a.inventoryid) as sums"
		  prdname="select "&selectsql&" from d_inventory a,j_depot b where a.depotid="&qts(depotid)&_
		          " and a.depotid=b.depotid and convert(char(10),a.setdate,126) between "&qts(fdate)&" and "&qts(ldate)
case 1021 tname="零售单"
          sellist="retailid,depotid,d_name,a1,a2,nums,sums"
          selectsql="a.retailid,a.depotid,b.d_name,'' as a1,'' as a2,"&_
		            "(select sum(c.nums) from d_retailsub c where c.retailid=a.retailid) as nums,"&_
					"(select sum(d.nums*d.s_price) from d_retailsub d where d.retailid=a.retailid) as sums"
		  prdname="select "&selectsql&" from d_retail a,j_depot b where a.depotid="&qts(depotid)&_
		          " and a.depotid=b.depotid and convert(char(10),a.cr_date,126) between "&qts(fdate)&" and "&qts(ldate)
case 1022 tname="跨区调货单"
          sellist="msellid,set_depotid,setdptname,get_depotid,getdptname,setnums,jpsums"
          selectsql="a.msellid,a.set_depotid,b.d_name as setdptname,a.get_depotid,c.d_name as getdptname,"&_
		            "(select sum(d.set_nums) from d_msellsub d where d.msellid=a.msellid) as setnums,"&_
					"(select sum(e.set_nums*e.s_price) from d_msellsub e where e.msellid=a.msellid) as jpsums"
		  prdname="select "&selectsql&" from d_msell a,j_depot b,j_depot c where a.set_depotid="&qts(depotid)&_
		          " and a.set_depotid=b.depotid and a.get_depotid=c.depotid and convert(char(10),a.setcr_date,126) between "&qts(fdate)&" and "&qts(ldate)
end select
'de prdname
if newformid<>"" then
'set cd =server.CreateObject("ADODB.Command")
'cd.Activeconnection=cn
'cd.Commandtype=4
'cd.CommandText=Prdname
'cd.Parameters.Append cd.CreateParameter("@rq1",adVarchar,adParamInput,10,fdate)
'cd.Parameters.Append cd.CreateParameter("@rq2",adVarchar,adParamInput,10,ldate)
'cd.Parameters.Append cd.CreateParameter("@userid",adVarchar,adParamInput,10,session("dm").System_userid)
'cd.Parameters.Append cd.CreateParameter("@type",adInteger,adParamInput,10,0)
'cd.Parameters.Append cd.CreateParameter("@worktype",adVarchar,adParamInput,20,"")
set rs=server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = cn
'de prdname
rs.Source = prdname
rs.open
end if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<title>单据拷贝</title>
<style type="text/css">
.chkbox{margin:0px;
padding:0px;
}
</style>
<script language="javascript" src="../inc/js/setday.js"></script>
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<script>
function subm(){

  if(check(document.form1)){
    document.form1.submit();
  }
}

function check(theform)
{

var i=0;
var j=0;
var select = false
var obj = theform.sel
if (obj==undefined)
{
 alert('没有选择要拷贝的单据！');
 return false;
}

for(i=0 ;i<obj.length;i++)
	{
		if(obj[i].checked)
		{
			j++;
			select = true;
		}
	}
	if (!select){alert('没有选择要拷贝的单据！');return false;}

if(window.parent.copytype[0].checked){document.form1.copytype.value=0;}
if(window.parent.copytype[1].checked)
  {//if(j>1){alert('取反数只能选择一条单据！');return false;}
   document.form1.copytype.value=1;}
//alert(document.form1.copytype.value);
return true;
}

</script>
</head>
<body bgcolor="#F7F7F7">
<table width="100%" border="0" cellspacing="0">
  <tr> 
    <form name="form2" method="post" action="djcopysub.asp?oldformid=<%=oldformid%>&newformid=<%=newformid%>&djid=<%=djid%>">
	  <td><font class="f12">当前所查询单据：<%=tname%></font></td>
      <td valign=midden align=right>开始日期：
        <input type="text" name="fdate" onFocus="setday(this)" size=10 value="<%=fdate%>" style="height:20px;">
        结束日期：
        <input type="text" name="ldate" onFocus="setday(this)" size=10 value="<%=ldate%>" style="height:20px;"> 
      <input type=submit value="查询(S)" accesskey="s"></td>
    </form>
  </tr>
</table>
  <form name="form1" method="post" action="djcopyinsert.asp?oldformid=<%=oldformid%>&newformid=<%=newformid%>&djid=<%=djid%>"> 
    <input type="hidden" name="copytype">
<div id="list" style="width:100%;height:90%;"> 
        <table border="0">
          <thead>
            <tr> 
              <td width=30>选择</td>
              <td width=140>单号</td>
              <td>发货地编号</td>
              <td width=100>发货地名称</td>
              <td>收货地编号</td>
              <td>收货地名称</td>
              <td width=50>数量</td>
              <td>金额</td>
            </tr>
          </thead>
          <%
	  if newformid<>"" then
	  dim uz,i
	 
	  zdlist=split(sellist,",")
	   uz=ubound(zdlist)
	  while not rs.eof
	     response.Write("<tr><td><input type='checkbox' name='sel' value='"&rs(zdlist(0))&"' class='chkbox'></td>")
		 for i=0 to uz-1 
		 if zdlist(i)="" then response.write("<td></td>") else response.Write("<td>"&rs(zdlist(i))&"</td>") end if
		 'if zdlist(1)="" then response.write("<td></td>") else response.Write("<td>"&rs(zdlist(1))&"</td>") end if
		 'if zdlist(2)="" then response.write("<td></td>") else response.Write("<td>"&rs(zdlist(2))&"</td>") end if
		 'if zdlist(3)="" then response.write("<td></td>") else response.Write("<td>"&rs(zdlist(3))&"</td>") end if
		 'if zdlist(4)="" then response.write("<td></td>") else response.Write("<td>"&rs(zdlist(4))&"</td>") end if
		 'if zdlist(5)="" then response.write("<td></td>") else response.Write("<td>"&rs(zdlist(5))&"</td>") end if
		 next
		 'de zdlist(i)
		 if zdlist(i)="" then response.write("<td></td></tr>") else response.Write("<td>"&rs(zdlist(i))&"</td></tr>") end if
	     rs.movenext
	  wend
	  rs.close
	  set rs=nothing
	  set cd=nothing
	  end if%>
    </table>
    </div></form>
<script language="javascript">
    try{
	 gt = new GtTable("list");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
</html>
<%
	  set rs=nothing
	  set cd=nothing
	  set cn=nothing
%>