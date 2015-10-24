<%option explicit
Server.ScriptTimeout=999999
response.AddHeader "Pragma","No-Cache"
response.AddHeader "Cache-Control","No-Cache"
Response.Expires=-1000%>
<!--#include file="inc/function.asp"-->
<html>
<head>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>生成盘点差异</title>
<style type="text/css">
body{background:#eee;font-size:12px;}
</style>
</head>

<body>
请稍等...
<%
dim cd,id,rs,lx,setdate
dim depotid,sql,tmp,tmp1
depotid = session("dm").system_depotid
id=trim(request.QueryString("id"))
set rs = server.CreateObject("ADODB.Recordset")

sql=" select isnull(d_type,0) as d_type,convert(char(10),setdate,126) as setdate,isnull(chk_sure,0) as chk_sure "&_
	" from d_inventory where inventoryid="&qts(id)
rs.open sql,cn,1,1
if rs.eof and rs.bof then
  call close("操作出错,请重新查询后再试一次!")
else
  if rs("chk_sure")>0 then 
     call close("此盘点单已审核，不可以生成差异!")
  end if
  lx=cint(rs("d_type"))
  setdate=rs("setdate")
end if
rs.close

'旧的生成盘点差异方法
'dim dt
''dt=cstr(get_date(date)+" "+get_time(time))
'dt=setdate
'set cd = server.CreateObject("ADODB.Command")
'cd.ActiveConnection = cn
'cd.CommandType = 1
'cd.CommandText = "update d_inventory set diff=1 where inventoryid="&qts(id)
'cd.Execute
'on error resume next
'sql="f22qry_kcpddpt '"&dt&"','"&id&"','"&session("dm").system_depotid&"',"&lx
'cn.execute sql
''cd.CommandType = 4
''cd.CommandText = "f22qry_kcpd"
''cd.Parameters.Append cd.CreateParameter("@rq1", adVarchar, adParamInput, 30, dt)
''cd.Parameters.Append cd.CreateParameter("@id", adVarchar, adParamInput, 32, id)
''cd.Parameters.Append cd.CreateParameter("@dpt", adVarchar, adParamInput, 12, session("dm").system_depotid)
''cd.Parameters.Append cd.CreateParameter("@lx", adVarchar, adParamInput, 4, lx)
''cd.Execute
'set cd = nothing
'set cn=nothing
'call close("盘点单:"&id&" 生成盘点差异成功!")

'改与后台算盘差方法一样 by jackie 2009-01-17
sql="insert into j_stock (depotid,clothingid,styleid,colorid,sizeid) "&_
	" select DISTINCT "&qts(depotid)&",t1.clothingid,"&_
	" t1.styleid,t1.colorid,t1.sizeid "&_
	" from d_inventorysub t1 left join (select clothingid from j_stock where depotid="&qts(depotid)&") A "&_
	" on t1.clothingid=a.clothingid where isnull(t1.clothingid,'')<>''"&_
	" and t1.inventoryid="&qts(id)&" and a.clothingid is null "
cn.execute(sql)
'全局盘点
  tmp=Get_pdkc(depotid,setdate)
if lx=0 then
	sql="insert into d_inventorysub(inventoryid,boxid,clothingid,styleid,colorid,sizeid,nums,d_nums) "&_
		" select DISTINCT "&qts(id)&",'AT9999',a.clothingid,a.styleid,a.colorid,a.sizeid,0,0 "&_
		" from "&tmp&" a left join (select clothingid from d_inventorysub where inventoryid="&qts(id)&") b "&_
		" on a.clothingid=b.clothingid where isnull(a.qckc,0)<>0 and b.clothingid is null "
	cn.execute(sql)
'局部盘点
else
	sql="insert into d_inventorysub(inventoryid,boxid,clothingid,styleid,colorid,sizeid,nums,d_nums) "&_
		" select DISTINCT "&qts(id)&",'AT9999',a.clothingid,a.styleid,a.colorid,a.sizeid,0,0 "&_
		" from "&tmp&" a inner join (select styleid from d_inventorysub where inventoryid="&qts(id)&") c "&_
		" on a.styleid=c.styleid left join (select clothingid from d_inventorysub where inventoryid="&qts(id)&") b "&_
		" on a.clothingid=b.clothingid where isnull(a.qckc,0)<>0 and b.clothingid is null "
	cn.execute(sql)
end if
'拷贝单据
			tmp1= session("dbname")&"_f22_tmp"&".dbo.tmppdd"&qTempFileName()
			sql =" select clothingid,max(styleid) as styleid,max(colorid) as colorid,max(sizeid) as sizeid, "&_
					" avg(j_cost) as j_cost,avg(s_price) as s_price, "&_
					" sum(nums) as nums,sum(d_nums) as d_nums,max(comment) as comment, "&_
					" avg(j_price) as j_price,avg(x_price) as x_price,avg(discount) as discount "&_
					" into "&tmp1&" from d_inventorysub "&_
					" where inventoryid="&qts(id)&" group by clothingid "
			cn.execute(sql)
			sql = "delete from d_inventorysub where inventoryid="&qts(id)
			cn.execute(sql)
      sql = " insert into d_inventorysub(inventoryid,boxid,clothingid,styleid,colorid,sizeid,"&_
            " j_cost,s_price,nums,d_nums,comment,j_price,x_price,discount) "&_
            " select "&qts(id)&",'AT8888',* from "&tmp1
			cn.execute(sql)
			cn.execute("drop table "&tmp1)

     '//*2004-03-28 qdy 当#tmp中没有款式时就更新不了盘赢记录*/
      sql = "update a set a.d_nums=isnull(a.nums,0) from d_inventorysub a where a.inventoryid="&qts(id)
			cn.execute(sql)

     '//更新差异
      sql="update a set a.d_nums=isnull(a.nums,0)-isnull(b.qckc,0)  from d_inventorysub a, "&tmp&" b "&_
				"where a.clothingid=b.clothingid and a.inventoryid="&qts(id)
			cn.execute(sql)

     '//2007-09-19 qdy 为了提高速度，把盘点和库存为零的记录删除。这些记录没有任何用途。
      sql=" delete d_inventorysub where isnull(nums,0)=0 and isnull(d_nums,0)=0 and inventoryid="&qts(id)
			cn.execute(sql)

			'//盘点差异金额按成本价计算
			sql = "select systemid from sys_system where systemid=2111 and isnull(sysdefvalue,0)=1"
			rs.open sql,cn,1,1
			if not(rs.eof and rs.bof) then
       '//更新单价
       sql="update a set a.j_cost=b.j_cost,a.s_price=b.j_cost,a.j_price=b.j_cost,a.x_price=b.j_cost,a.discount=1 "&_
				" from d_inventorysub a ,j_style b "&_
				" where a.styleid=b.styleid "&_
				" and a.inventoryid="&qts(id)
			 cn.execute(sql)
			else
       '//2008-09-24 LEO 去掉刷新单据过程，速度太慢
       '//dm.Run_DjSQL('exec F22_RefreshDj d_inventory,'+QuotedStr(pdid));
       sql="update a set a.j_cost=b.j_cost,a.s_price=b.x_price,a.j_price=b.j_price,a.x_price=b.x_price,a.discount=1 "&_
				" from d_inventorysub a ,j_style b "&_
				" where a.styleid=b.styleid "&_
				" and a.inventoryid="&qts(id)
			 cn.execute(sql)
      end if
		 	rs.close

			cn.execute("drop table "&tmp)

'//
		sql="update d_inventory "&_
				" set zcnums=(select sum(d_inventorysub.d_nums) from d_inventorysub where d_inventorysub.inventoryid=d_inventory.inventoryid),"&_
				" zcsums=(select sum(d_inventorysub.d_nums*d_inventorysub.s_price) "&_
				" from d_inventorysub where d_inventorysub.inventoryid=d_inventory.inventoryid) "&_
				" where inventoryid="&qts(id)
		cn.execute(sql)

'// modify by jackie 20101220 生成差异标记放到最后
sql = "update d_inventory set diff=1 where inventoryid="&qts(id)
cn.execute(sql)


call close("生成盘点差异成功!")


'///////////////过程调用

function Get_begpdkc(depotid, tmptab, StockDate)
dim sql,m,mtab 
dim kcname
kcname = session("dbname")&"_f22_kc"
  sql="select max(ymonth) as ymonth from "&kcname&".dbo.monthclosing where ymonth<="&qts(StockDate)
  rs.open sql,cn,1,1
	m = rs("ymonth")
  rs.close
	  if m<>"" then
		 mtab=kcname&".dbo.m"&mid(m,1,4)&mid(m,6,2)
		 sql=" insert into "&tmptab&"(clothingid,styleid,colorid,sizeid,qckc)"&_
		 	 " select rtrim(a.styleid)+rtrim(a.colorid)+rtrim(a.sizeid),a.styleid,a.colorid,a.sizeid,a.qckc "&_
			 " from "&mtab&" a where a.qckc<>0 and a.depotid="&qts(depotid)
		 cn.execute(sql)
	  end if
  Get_begpdkc = m
end function

'临时表名
function qTempFileName()
	dim ranNum
	randomize
	ranNum=int(90000*rnd)+10000
	qTempFileName = session("dm").system_userid&"#tmp"&year(now())&month(now())&day(now())&hour(now())&minute(now())&second(now())&ranNum
end function

function crtab_pdtabtmp()
dim tabname,sql
  tabname=session("dbname")&"_f22_tmp.dbo.T"&qTempFileName()
  sql="CREATE TABLE "&tabname&_
  	  " ([clothingid] [varchar] (32) COLLATE Chinese_PRC_CI_AS  NULL ,"&_
	  " [styleid] [varchar] (20) COLLATE Chinese_PRC_CI_AS  NULL ,"&_
	  " [colorid] [varchar] (6) COLLATE Chinese_PRC_CI_AS  NULL ,"&_
	  " [sizeid] [varchar] (6) COLLATE Chinese_PRC_CI_AS  NULL ,"&_
	  " [qckc] [int] NULL default 0 "&_
	  " ) ON [PRIMARY] "
  cn.execute(sql)
  crtab_pdtabtmp=tabname
end function

function Get_pdkc(depotid, pdrq)
dim tmptab,sql,kcmonth,tabkc,tabkc1
'得到期初库存,期初1号是早上的库存，所以如果是算1号的库存要加上1号的进销存。
  tmptab=crtab_pdtabtmp()
  kcmonth=Get_begpdkc(depotid,tmptab,(mid(pdrq,1,7)))

  if kcmonth="" or isnull(kcmonth) then kcmonth="1900-01-01" else kcmonth=kcmonth&"-01" end if

  get_pdcylist tmptab,depotid,kcmonth,pdrq

  tabkc1=crtab_pdtabtmp()
  sql=" insert into "&tabkc1&"(clothingid,styleid,colorid,sizeid,qckc) "&_
	" select b.clothingid, max(b.styleid), max(b.colorid), max(b.sizeid), sum(a.qckc) as qckc "&_
	" from "&tmptab&" a, j_clothing b where a.clothingid=b.clothingid and a.styleid=b.styleid "&_
	" group by b.clothingid "
  cn.execute(sql)

   'if kcmonth="1900-01-01"  then 

    if kcmonth="1900-01-01 00:00:00.000" then
    'LEO 加上期初库存 2008-05-09
    sql=" insert into "&tabkc1&"(clothingid,styleid,colorid,sizeid,qckc) "&_
        " select clothingid,styleid,colorid,sizeid,begk_num from j_stock where depotid="&qts(depotid)&" and isnull(begk_num,0)<>0"
	cn.execute(sql)
  end if
  
    response.Write("<br>计算：LEO加上期初库存")
  
  tabkc=crtab_pdtabtmp()
  sql=" insert into "&tabkc&"(clothingid,styleid,colorid,sizeid,qckc) "&_
      " select clothingid,max(styleid),max(colorid),max(sizeid),sum(qckc) from "&tabkc1&" group by clothingid"
  cn.execute(sql)

  '删除临时表
  cn.execute("TRUNCATE table "&tmptab)
  cn.execute("DROP table "&tmptab)
  cn.execute("TRUNCATE table "&tabkc1)
  cn.execute("DROP table "&tabkc1)
  Get_pdkc=tabkc
end function

function getdatetime(d,t)
  if t=2 then
	getdatetime=d&" 23:59:59.000"
  else
	getdatetime=d&" 00:00:00.000"
  end if
end function

sub get_pdcylist(tabname, depotid, begdate, enddate)
dim sql
    '日期加时间
    begdate=getdatetime(begdate,1)
    enddate=getdatetime(enddate,2)
    response.Write("<br>计算：入库数量")
	response.flush()
    sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"&_
		" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),sum(b.nums) "&_
		" FROM  d_indepot a, d_indepotsub b "&_
		" where b.indepotid = a.indepotid "&_
		" and a.sure >0 "&_
		" and a.Sure_Date >= "&qts(begdate)&_
		" and a.Sure_Date <= "&qts(enddate)&_
		" and a.depotid = "&qts(depotid)&_
		" GROUP BY b.clothingid "
	cn.execute(sql)
    response.Write("<br>计算：盘点盈亏数量")
	response.flush()
    sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"&_
		" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),sum(b.d_nums) "&_
		" FROM  d_inventory a,d_inventorysub b "&_
		" where  b.inventoryid = a.inventoryid "&_
		" and a.depotid="&qts(depotid)&_
		" and a.sure>0 and isnull(b.d_nums,0)<>0 "&_
		" and a.Sure_Date >="&qts(begdate)&_
		" and a.Sure_Date <="&qts(enddate)&_
		" GROUP BY b.clothingid "
	cn.execute(sql)
    response.Write("<br>计算：调拨发出数量")
	response.flush()
    sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"&_
		" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),-1*sum(b.set_nums) "&_
		" FROM  dbo.d_movesub b,d_move a "&_
		" where a.moveid = b.moveid "&_
		" and a.set_depotid="&qts(depotid)&_
		" and a.set_sure >0 "&_
		" and a.setSure_Date >="&qts(begdate)&_
        " and a.setSure_Date <="&qts(enddate)&_
        " GROUP BY b.clothingid "
	cn.execute(sql)
    response.Write("<br>计算：退货发货单")
	response.flush()
	sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"
	sql=sql&" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),-1*sum(b.nums) "&_
	   " FROM  dbo.d_outindentsetsub b,dbo.d_outindentset a "&_
	   " where b.outindentid = a.outindentid "&_
	   " and a.set_depotid="&qts(depotid)&_
	   " and a.sure> 0 "&_
	   " and a.Sure_Date >="&qts(begdate)&_
	   " and a.Sure_Date <="&qts(enddate)&_
	   " GROUP BY  b.clothingid "
    cn.execute(sql)
    response.Write("<br>计算：调拨收回数量")
	response.flush()
    sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"
    sql=sql&" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),sum(b.set_nums) "&_
       " FROM  dbo.d_movesub b,d_move a "&_
       " where a.moveid = b.moveid "&_
       " and a.get_depotid="&qts(depotid)&_
       " and a.get_sure >0 "&_
       " and a.getSure_Date >="&qts(begdate)&_
       " and a.getSure_Date <="&qts(enddate)&_
       " GROUP BY b.clothingid "
    cn.execute(sql)
    response.Write("<br>计算：次品退厂数量")
	response.flush()
    sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"
    sql=sql&" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),-1*sum(b.nums) "&_
       " FROM  dbo.d_outdepotsub b,dbo.d_outdepot a "&_
       " where b.outdepotid = a.outdepotid "&_
       " and a.depotid="&qts(depotid)&_
       " and a.sure>0 "&_
       " and a.Sure_Date >="&qts(begdate)&_
       " and a.Sure_Date <="&qts(enddate)&_
       " GROUP BY b.clothingid "
    cn.execute(sql)
    response.Write("<br>计算：退货收货数量")
	response.flush()
    sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"
    sql=sql&" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),sum(b.nums) "&_
       " FROM  dbo.d_outindentsub b,dbo.d_outindent a "&_
       " where b.outindentid = a.outindentid "&_
       " and a.depotid="&qts(depotid)&_
       " and a.sure> 0 "&_
       " and a.Sure_Date >="&qts(begdate)&_
       " and a.Sure_Date <="&qts(enddate)&_
       " GROUP BY  b.clothingid "
    cn.execute(sql)
    response.Write("<br>计算：零售数量")
	response.flush()
    sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"
    sql=sql&" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),-1*sum(b.nums) "&_
       " FROM  dbo.d_retailsub b,dbo.d_retail a "&_
       " where b.retailid = a.retailid "&_
       " and a.depotid="&qts(depotid)&_
       " and a.sure > 0 "&_
       " and a.Sure_Date >="&qts(begdate)&_
       " and a.Sure_Date <="&qts(enddate)&_
       " GROUP BY  b.clothingid "
    cn.execute(sql)
    response.Write("<br>计算：发货数量")
	response.flush()	
    sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"
    sql=sql&" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),-1*sum(b.set_nums) "&_
       " FROM  dbo.d_Sell a,d_sellsub b "&_
       " where a.sellid = b.sellid "&_
       " and a.set_depotid="&qts(depotid)&_
       " and a.set_sure >0 "&_
       " and a.setSure_Date>="&qts(begdate)&_
       " and a.setSure_Date <="&qts(enddate)&_
       " GROUP BY b.clothingid "
     cn.execute(sql)
    response.Write("<br>计算：收货数量")
	response.flush()
    sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"
    sql=sql&" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),sum(b.set_nums) "&_
       " FROM  dbo.d_Sell a,d_sellsub b "&_
       " where a.sellid = b.sellid "&_
       " and a.get_depotid="&qts(depotid)&_
       " and a.get_sure >0 "&_
       " and a.getSure_Date>="&qts(begdate)&_
       " and a.getSure_Date <="&qts(enddate)&_
       " GROUP BY b.clothingid "
     cn.execute(sql)
    response.Write("<br>计算：跨区发货数量")
	response.flush()
    sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"
    sql=sql&" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),-1*sum(b.set_nums) "&_
       " FROM  dbo.d_mSell a,d_msellsub b "&_
       " where a.msellid = b.msellid "&_
       " and a.set_depotid="&qts(depotid)&_
       " and a.set_sure >0 "&_
       " and a.setSure_Date>="&qts(begdate)&_
       " and a.setSure_Date <="&qts(enddate)&_
       " GROUP BY b.clothingid "
     cn.execute(sql)
    response.Write("<br>计算：跨区收货数量")
	response.flush()
    sql=" insert into "&tabname&"(clothingid,styleid,colorid,sizeid,qckc)"
    sql=sql&" SELECT b.clothingid,max(b.styleid),max(b.colorid),max(b.sizeid),sum(b.set_nums) "&_
       " FROM  dbo.d_mSell a,d_msellsub b "&_
       " where a.msellid = b.msellid "&_
       " and a.get_depotid="&qts(depotid)&_
       " and a.get_sure >0 "&_
       " and a.getSure_Date>="&qts(begdate)&_
       " and a.getSure_Date <="&qts(enddate)&_
       " GROUP BY b.clothingid "
     cn.execute(sql)


    
end sub



set rs=nothing
set cn=nothing
%>
</body>
</html>
