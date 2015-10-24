<!--#include file="inc/function.asp"-->
<!-- #include file="upload_5xsoft.asp" -->
<%id=request("id") '单号
act=request("act") '单据类型
dim dtype,dep_parentid,get_depotid
dim dttype
set dttype = Server.CreateObject("ADODB.RECORDSET")
dtype=3
select case act
case "inventory"
     no_id="inventoryid"
	 d_sub="d_inventorysub"
	 nums="nums"
	 cost="j_cost"
case "indepot"
     no_id="indepotid"
	 d_sub="d_indepotsub"
	 nums="nums"
	 cost="j_cost"
case "outdepot"
     no_id="outdepotid"
	 d_sub="d_outdepotsub"
	 nums="nums"
	 cost="cost"
case "move"
     no_id="moveid"
	 d_sub="d_movesub"
	 nums="set_nums"
	 cost="j_cost"
     
case "sell"
     no_id="sellid"
	 d_sub="d_sellsub"
	 nums="set_nums"
	 cost="j_cost"
case "outindentset"
     no_id="outindentid"
	 d_sub="d_outindentsetsub"

     set dttype = Server.CreateObject("ADODB.RECORDSET")
     sql="select b.parentid from d_outindentset a inner join j_depot b on a.depotid=b.depotid where a.outindentid='"&id&"'"
     dttype.open sql,cn,1,1
     If not dttype.eof then
     dep_parentid = dttype("parentid")
     end if
     dttype.close()

    '退货3
    if trim(dep_parentid)=session("dm").System_Parentid then
  	dtype=3
    else
    dtype=2
    end if

	 nums="nums"
	 cost="cost"
case "msell"
     no_id="msellid"
	 d_sub="d_msellsub"
	 nums="set_nums"
	 cost="j_cost"

     sql="select b.parentid,a.get_depotid from d_msell a inner join j_depot b on a.get_depotid=b.depotid where a.msellid='"&id&"'"
    dttype.open sql,cn,1,1
    If not dttype.eof then
    dep_parentid = dttype("parentid")
    get_depotid= dttype("get_depotid")
    end if
    dttype.close
   
    '退货3
    if trim(dep_parentid)=session("dm").System_Parentid then
  	dtype=3
    else
    dtype=2
    end if
case "outindentpro"
     no_id="outindentid"
	 d_sub="d_outindentprosub"
	 nums="nums"
	 cost="cost"

      '2014-03-24 xhp 判断店铺是否2级加盟店铺
    sql="select b.parentid from d_outindentpro a inner join j_depot b on a.depotid=b.depotid where a.outindentid='"&id&"'"
    dttype.open sql,cn,1,1
    If not dttype.eof then
    dep_parentid = dttype("parentid")
    end if
    dttype.close()
    '退货3
    if trim(dep_parentid)=session("dm").System_Parentid then
  	dtype=3
    else
    dtype=2
    end if

case "indent"
     no_id="indentid"
	 d_sub="d_indentsub"
	 nums="nums"
	 cost="j_cost"
end select
set dttype = nothing
'得到取单价的参数
call GetPriceType(id,act)
Server.ScriptTimeout=999999
'on error resume next
cn.execute "delete from web_pdjinput where userid='"&session("dm").System_UserId&"'"
err.clear
set upload=new upload_5xsoft
set txt=upload.file("txt") '文本

'上传文件
txthz=ucase(mid(txt.filename,instr(txt.filename,".")))
if txthz<>".TXT" then 
   response.write("<script>alert('导入文件只能是文本！');history.go(-1)</script>")
   response.end
end if
if txt.fileSize>0 then
   txtname=act&session("dm").System_DepotId&now&txthz
   txtname=replace(txtname," ","")
   txtname=replace(txtname,":","")
   txtname=replace(txtname,"-","")
   txtname=replace(txtname,"/","")
   txt.saveAs Server.mappath ("upload/"&txtname)
   response.write("文件接收成功，请稍等……<br>")
   response.flush
else
   response.write("<script>alert('文件没有内容！');history.go(-1)</script>")
   response.end
end if

'读取文件
response.write("系统正在处理文件内容，请稍等……<br>")
response.flush
set connfile=server.CreateObject("scripting.filesystemobject")
set rs10=server.createobject("adodb.recordset")
filename=server.MapPath("upload/"&txtname)
set fso=connfile.opentextfile(filename)
i=0
while not fso.AtEndOfStream
  '将左右空格和TAB去掉，然后将中间的空格和全角逗号替换成半角逗号
     LineStr=""
	 LineStr=fso.readline
	 i=i+1
	 tmpStr=LineStr
	 LineStr=trim(replace(LineStr,chr(9)," "))
	 LineStr=replace(LineStr," ",",")
	 LineStr=replace(LineStr,"，",",")

  '将逗号前和后的值取出来，然后作相应处理
     tmp=split(LineStr,",")
	 
	 if UBound(tmp)=1 then
		 tmp1=tmp(0)
		 tmp2=tmp(1)

		  if trim(tmp1)="" or not IsNumeric(tmp2) then
			 response.write("第"&i&"行数据有误,款号:"&tmp1&",数量："&tmp2&"<br>")
			 response.Flush()
		  else
			rs10.open "select clothingid from j_clothing where clothingid='"&trim(tmp1)&"' or oldclothingid='"&trim(tmp1)&"'",cn
			if not rs10.eof then
			   tmp1=rs10("clothingid")
			end if
			rs10.close
		
			rs10.open "select 1 from web_pdjinput where userid='"&session("dm").System_UserId&"' and clothingid='"&trim(tmp1)&"'",cn
			if rs10.eof then
			   cn.execute "insert into web_pdjinput (userid,clothingid,nums) values ('"&session("dm").System_UserId&"','"&trim(tmp1)&"',"&cint(tmp2)&")"
			else
			   cn.execute "update web_pdjinput set nums=isnull(nums,0)+"&cint(tmp2)&" where userid='"&session("dm").System_UserId&"' and clothingid='"&trim(tmp1)&"'"
			end if
			rs10.close
		  end if

     else
'		 tmp1=""
'		 tmp2=""
	     response.write("第"&i&"行数据格式有误:"&tmpStr&"<br>")
	 	 response.Flush()
	 end if

wend
set rs10=nothing
fso.close
set fso=nothing

set rs4=server.createobject("adodb.recordset")
str="select clothingid from web_pdjinput where userid='"&session("dm").System_UserId&"' "&_
    "and clothingid not in (select clothingid from j_clothing) "
rs4.open str,cn,1,1
if rs4.recordcount<>0 then
   response.write("以下款号系统中不存在，请核对：<br>")
   response.flush
   while not rs4.eof
     response.write(rs4(0)&"<br>")
     response.flush
   rs4.movenext
   wend
else
   response.write("正在导入……<br><br>")
   response.flush
   drnums=0
   set rs2=server.createobject("adodb.recordset")
   rs2.open "select * from web_pdjinput where userid='"&session("dm").System_UserId&"'",cn
   while not rs2.eof
      set rs1=server.CreateObject("adodb.recordset")
      rs1.open "t18tj_getclothingprice "&dtype&",'"&session("dm").System_DepotId&"','"&rs2("clothingid")&"','',"&request.Cookies("GetPriceType")("T2"),cn
      styleid=rs1("styleid")
      colorid=rs1("colorid")
      sizeid=rs1("sizeid")
      clothingid=rs1("clothingid")
      if isnull(rs1("j_cost")) then j_cost=0 else j_cost=rs1("j_cost") end if
      if isnull(rs1("j_price")) then j_price=0 else j_price=rs1("j_price") end if
      if isnull(rs1("s_price")) then s_price=0 else s_price=rs1("s_price") end if
      if isnull(rs1("x_price")) then x_price=0 else x_price=rs1("x_price") end if
      if isnull(rs1("discount")) then discount=0 else discount=rs1("discount") end if
      rs1.close
 
      set rs=server.CreateObject("adodb.recordset")
      rs.open "select clothingid from "&d_sub&" where "&no_id&"='"&id&"' and clothingid='"&clothingid&"'",cn
      if not rs.eof then
         sql="update "&d_sub&" set "&nums&"="&nums&"+"&rs2("nums")&" where "&no_id&"='"&id&"' and clothingid='"&clothingid&"'"
      else
        '针对跨区调货处理
        if act="msell" then
            rs1.open "t18tj_getclothingprice "&dtype&",'"&get_depotid&"','"&rs2("clothingid")&"','',"&request.Cookies("GetPriceType")("T2"),cn

            sql="insert into "&d_sub&" ("&no_id&",boxid,clothingid,styleid,colorid,sizeid,"&cost&",j_price,s_price,x_price,discount,"&nums&",j_price1,x_price1,s_price1,discount1,crdate) values "
            sql=sql&"('"&id&"','W9999','"&clothingid&"','"&styleid&"','"&colorid&"','"&sizeid&"',"&rs1("j_cost")&","&rs1("j_price")&","&rs1("s_price")&","&rs1("x_price")&","&rs1("discount")&","&rs2("nums")&","&j_price&","&x_price&","&s_price&","&discount&","&get_date(date)&")"
            rs1.close
        else
            sql="insert into "&d_sub&" ("&no_id&",boxid,clothingid,styleid,colorid,sizeid,"&cost&",j_price,s_price,x_price,discount,"&nums&",crdate) values "
            sql=sql&"('"&id&"','W9999','"&clothingid&"','"&styleid&"','"&colorid&"','"&sizeid&"',"&j_cost&","&j_price&","&s_price&","&x_price&","&discount&","&rs2("nums")&","&get_date(date)&")"  
        end if

      set rs1=nothing   
	    
      end if
	  'response.write(sql)
	  cn.execute sql
	  if err then 
         response.write(clothingid&"，数量"&rs2("nums")&"插入失败，原因："&Err.Description & "<BR>")
	     Err.Clear
	     response.Flush
      else
	     drnums=drnums+round(rs2("nums"),0)
'         response.write(clothingid&"，数量"&rs2("nums")&" 导入成功<br>")
	     response.flush
      end if
   rs2.movenext
   wend
   response.write("<br>导入总数："&drnums)
   rs2.close
   set rs2=nothing
   'response.write("<br><br><center><input type=button value='刷新数量' class=box onclick='window.opener.location.reload()'></center>")
end if
rs4.close
set rs4=nothing
cn.execute "delete from web_pdjinput where userid='"&session("dm").System_UserId&"'"
response.write("<br><br><center><input type=button value='  关  闭  ' class=box onclick='window.close()'></center>")
'response.write("<script language=JavaScript>window.opener.document.all.iFrmRef.src='inventory_z_input_mxview.asp?inventoryid="&id&"';window.close();</script>")%>