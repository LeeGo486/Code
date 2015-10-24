<!--#include file="../inc/function.asp"-->
<%color_num=request("color_num")
  size_num=request("size_num")
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

styleid=request("styleid")
color1=request("color1")
size1=request("size1")
f_color=split(color1,",")
f_size=split(size1,",")
dh_no=request.Cookies("pic_indentid")
   
   '取得款式类型
   set rs=server.CreateObject("adodb.recordset")
   rs.open "select dh_2 from j_style where styleid='"&styleid&"'",cn
   bz=trim(rs(0))
   rs.close
   set rs=nothing
   k=0
   '加入明细单
   for i=0 to color_num
      for j=0 to size_num
	      k=k+1
		  if request("cs_num"&k)<>"" then
		     if request("cs_num"&k)<>0 then
		        set rs=server.createobject("adodb.recordset")
				clothingid=trim(styleid)+trim(f_color(i))+trim(f_size(j))
		        rs.open "select clothingid from d_indentsub where indentid='"&dh_no&"' and clothingid='"&clothingid&"'",cn
		        if not rs.eof then
				   cn.execute "update d_indentsub set nums=nums+"&request("cs_num"&k)&" where indentid='"&dh_no&"' and clothingid='"&clothingid&"'"
				else
				   set rs1=server.CreateObject("adodb.recordset")
				   set rs2=server.createobject("adodb.recordset")
		           sql="t18tj_GetClothingPrice 3,'"&session("dm").system_depotid&"','"&clothingid&"','',1"
		           rs1.open sql,cn
				   rs2.open "select isnull(rate,0) as rate from j_merchant where merchantid='"&session("dm").system_unitid&"'",cn
				   if round(rs2("rate"),2)=0 then discount=1 else discount=round(rs2("rate"),2) end if
		           if isnull(rs1("x_price")) then x_price=0 else x_price=round(rs1("x_price"),2) end if
		           if isnull(rs1("j_price")) then j_price=0 else j_price=round(rs1("j_price"),2) end if
		           if isnull(rs1("j_cost")) then j_cost=0 else j_cost=round(rs1("j_cost"),2) end if
                   if discount<>0 then s_price=round(j_price*discount,4) else s_price=j_price end if
				   sql="insert into d_indentsub (indentid,boxid,clothingid,styleid,colorid,sizeid,s_price,nums,crdate,"&_
				       "discount,x_price,j_price,j_cost,comment) values "&_
					   "('"&dh_no&"','WB9999','"&clothingid&"','"&styleid&"','"&f_color(i)&"','"&f_size(j)&"'"&_
					   ","&s_price&","&request("cs_num"&k)&",getdate(),"&discount&","&x_price&","&j_price&","&j_cost&",'"&bz&"')"
		           cn.execute sql
		           rs1.close
				   rs2.close
		           set rs1=nothing
				   set rs2=nothing
				end if
		        rs.close
				set rs=nothing
			 end if
		  end if
	  next
   next

response.write("<script language=JavaScript>window.close();</script>")
cn.close
set cn=nothing%>
