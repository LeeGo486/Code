<!--#include file="../inc/function.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%color_num=request("color_num")
  size_num=request("size_num")
  indentid=request("indentid")
  styleid=request("styleid")
  for i=0 to color_num
      for j=0 to size_num
	      k=k+1
		  if not pd then
		     if request("cs_num"&k)="" then
			    lr_null="true"
			 elseif request("cs_num"&k)=0 then
		        lr_null="true"
			 else
			    lr_null="false"
                i=color_num
				j=size_num
		     end if
		  end if
	  next
  next
if lr_null then%>
<script language="JavaScript">alert("没有输入数据，不接受处理！");history.go(-1);</script>
<%response.end
end if

set rs=server.CreateObject("adodb.recordset")
rs.open "select top 1 convert(char(10),crdate,126) as crdate from d_indentsub where indentid='"&indentid&"' and styleid='"&styleid&"'",cn
crdate=rs("crdate")
rs.close
set rs=nothing
cn.execute "delete from d_indentsub where indentid='"&indentid&"' and styleid='"&styleid&"'"

set rs=server.CreateObject("adodb.recordset")
rs.open "select dh_2 from j_style where styleid='"&styleid&"'",cn
bz=trim(rs(0))
rs.close
set rs=nothing

set rs1=server.CreateObject("adodb.recordset")
   rs1.open "t18tj_getstyleprice 2,'"&session("dm").system_depotid&"','"&styleid&"','"&get_date(date)&"'",cn
        if isnull(rs1("j_cost")) then j_cost=0 else j_cost=rs1("j_cost") end if
		if isnull(rs1("j_price")) then j_price=0 else j_price=rs1("j_price") end if
		if isnull(rs1("x_price")) then x_price=0 else x_price=rs1("x_price") end if
		if isnull(rs1("s_price")) then s_price=0 else s_price=rs1("s_price") end if
		if isnull(rs1("discount")) then discount=0 else discount=rs1("discount") end if
rs1.close
set rs1=nothing

'f_color=session("indentdh_tq_color1")
'f_size=session("indentdh_tq_size1")
colorid=request("colorid")
sizeid=request("sizeid")
f_color=split(colorid,",")
f_size=split(sizeid,",")

k=0
for i=0 to color_num
    for j=0 to size_num
	    k=k+1
	    'response.Write(f_color(i)&":"&f_size(j)&"=")
		'response.Write(request.form("cs_num"&k)&"<br>")
		if request("cs_num"&k)<>"" then
		   if request("cs_num"&k)<>0 then
		      sql="insert into d_indentsub (indentid,boxid,clothingid,styleid,colorid,sizeid,s_price,nums,crdate,discount,x_price,j_price,j_cost,comment,checked) values "
			  sql=sql&"('"&indentid&"','WB9999','"&styleid&f_color(i)&f_size(j)&"','"&styleid&"','"&f_color(i)&"','"&f_size(j)&"',"&s_price&","&request("cs_num"&k)&",'"&crdate&"',"&discount&","&x_price&","&j_price&","&j_cost&",'"&bz&"',0)"
			  'response.Write(sql)
			  cn.execute sql
		   end if
		end if
    next
next

cn.close
set cn=nothing
response.write("<script language=JavaScript>window.close();</script>")
%>