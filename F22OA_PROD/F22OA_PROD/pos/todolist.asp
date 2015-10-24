<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="refresh" content="300">
<title>代办事宜</title>
</head>
<style>
a:link {color: #000000;text-decoration: none;}
a:visited {color: #000000;text-decoration: none;}
a:hover {color: #FF0000;text-decoration: none;}
body {margin:0;}
#andyscroll {overflow:hidden;padding:0;text-align:left;width:100%;height:100px;}
#scrollmessage ul{list-style:none;padding:0;margin:0;}
#scrollmessage ul li{clear:both;padding:0 0 0 20px;margin:0;height:20px;line-height:125%;overflow:hidden;background:url(### left no-repeat);}
#scrollmessage ul li a{font-size:12px;line-height:20px;}
</style>
<body>
<%dim dbname
session("dbname")=HTMLEncode(request("dbname"))
if session("dbname")="" then
response.Write "数据库参数不存在！"
response.End()
end if%>
<!-- #include file="cn.asp" -->
<%
function HTMLEncode(fString)
	fString=Trim(fString)
	fString=replace(fString,"<script","&lt;script")
	fString=replace(fString,"script>","script&gt;")
	fString=replace(fString,"<iFrame","&lt;iFrame")
	fString=replace(fString,"iFrame>","iFrame&gt;")
	fString=Replace(fString,CHR(9),"&#9;")
	fString=Replace(fString,CHR(39),"&#39;")	'“'”
	HTMLEncode=fString
end function

Function RequestInt(fString)
	RequestInt=Request(fString)
 	if IsNumeric(RequestInt) then
		RequestInt=int(RequestInt)
	else
		RequestInt=5
	end if
End Function


userid=HTMLEncode(request("userid"))
dbname=HTMLEncode(request("dbname"))
userdtype=request("userdtype")
depotid=HTMLEncode(request("depotid"))

movetype=RequestInt("movetype")

if userid="" or dbname="" then 
   response.End()
end if

set rs=server.CreateObject("adodb.recordset")
rs.open "select sysdefvalue from sys_system where systemid=2064",cn
if rs.eof then
   ctype=0
else
   ctype=cdbl(rs("sysdefvalue"))
end if
rs.close

if userdtype<>4 then
   call gettodolist
else
   if ctype=0 then
      call posinfo
   else
      call posinfo1
   end if
end if
set rs=nothing
cn.close
cn1.close
set cn=nothing
set cn1=nothing

sub gettodolist
if userdtype=0 then
   s="A380_GetToDoList '"&userid&"','"&dbname&"',0"
else
   s="A380_JMSGetToDoList '"&userid&"','"&dbname&"',0"
end if

movetype=1
rs.open s,cn,1,1
if movetype=0 then
  response.write("<marquee direction=left scrollamount=3 scrolldelay=20 onMouseOver='this.stop();' onMouseOut='this.start();'>")
  response.Write("<font size=2>")
  while not rs.eof
    response.write("&nbsp;&nbsp;&nbsp;<font size=4 color=red>&diams;</font><a href='HTTP://WAIT/"&trim(rs("dllname"))&"$$"&trim(rs("formid"))&"$$"&trim(rs("datid"))&"' onFocus='this.onBlur'>"&rs("title")&"</a>")
    rs.movenext
  wend
  response.write("</font></marquee>")

else
  if not rs.eof then%>
                <div id="andyscroll">
                    <div id="scrollmessage">
                    <ul>
                    <%while not rs.eof
                        response.Write("<li><font size=4 color=red>&diams;</font><font size=2><a href='HTTP://WAIT/"&trim(rs("dllname"))&"$$"&trim(rs("formid"))&"$$"&trim(rs("datid"))&"' onFocus='this.onBlur'>"&rs("title")&"</a></font></li>")
                        rs.movenext
                     wend%>
                    </ul>
                    </div>
                </div>
                <script type="text/javascript">
					<!--
					var stopscroll = false;
					var scrollElem = document.getElementById("andyscroll");
					var marqueesHeight = scrollElem.style.height;
					scrollElem.onmouseover = new Function('stopscroll = true');
					scrollElem.onmouseout = new Function('stopscroll = false');
					var preTop = 0;
					var currentTop = 0;
					var stoptime = 0;
					var leftElem = document.getElementById("scrollmessage"); 
					scrollElem.appendChild(leftElem.cloneNode(true));
					init_srolltext();
					
					function init_srolltext(){
					 scrollElem.scrollTop = 0;
					 setInterval('scrollUp()',30);//的面的这个参数25, 是确定滚动速度的, 数值越小, 速度越快
					}
					function scrollUp(){
					 if(stopscroll) return;
					 currentTop += 1; //设为1, 可以实现间歇式的滚动; 设为2, 则是连续滚动
						 if(currentTop == 21) {
						 stoptime += 1;
						 currentTop -= 1;
							 if(stoptime == 50) {
							 currentTop = 0;
							 stoptime = 0;
							 }
						 }else{
						 preTop = scrollElem.scrollTop;
						 scrollElem.scrollTop += 1;
							 if(preTop == scrollElem.scrollTop){
							 scrollElem.scrollTop = 0;
							 scrollElem.scrollTop += 1;
							 }
						 }
					}
					//-->
				</script>
<%end if
end if
rs.close
end sub

sub posinfo
   depotid=HTMLEncode(request("depotid"))
   rs.open "select year(getdate()) as y,month(getdate()) as mon,day(getdate()) as d",cn
   years=cdbl(rs("y"))
   months=cdbl(rs("mon"))
   days=cdbl(rs("d"))
   rs.close
   sql="select isnull(b.m1,0) as m1,isnull(b.m2,0) as m2,isnull(b.m3,0) as m3,isnull(b.m4,0) as m4,isnull(b.m5,0) as m5,"&_
       "isnull(b.m6,0) as m6,isnull(b.m7,0) as m7,isnull(b.m8,0) as m8,isnull(b.m9,0) as m9,isnull(b.m10,0) as m10,"&_
       "isnull(b.m11,0) as m11,isnull(b.m12,0) as m12 "&_
	   "from c_planzy a,c_planzysub b where a.planid=b.planid and isnull(a.sure,0)>0 and planyear="&years&" and b.depotid='"&depotid&"'"
   rs.open sql,cn
   dim m(11),i
   if rs.eof then
      for i=0 to 11
	     m(i)=0
	  next
   else
     '今年销售目标
     for i=0 to 11
       m(i)=cdbl(rs("m"&i+1))*10000
       zm=zm+cdbl(m(i))
     next
   end if
   rs.close
   '今年实销
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and year(a.sure_date)="&years
   rs.open sql,cn
   if rs.eof then
      zretail=0
   else
      zretail=cdbl(rs("sums"))
   end if
   rs.close
   '总达标率
   if zm=0 then
      zbl=0
   else
      zbl=round(zretail/zm,4)*100
   end if
   '本月原目标
   sql="select isnull(b.m"&months&",0)*10000 as m from c_planzy a,c_planzysub b where a.planid=b.planid and a.planyear="&years&_
       " and b.depotid='"&depotid&"' and isnull(a.sure,0)>0"
   rs.open sql,cn
   if rs.eof then
      monthymb=0
   else
      monthymb=cdbl(rs("m"))
   end if
   rs.close
   '本月实际目标，计算全年销售时不包含当天的销售在内
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and year(a.sure_date)="&years&" and convert(char(10),a.sure_date,126)<convert(char(10),getdate(),126)"
   rs.open sql,cn
   if rs.eof then
      tmpretail=0
   else
      tmpretail=cdbl(rs("sums"))
   end if
   rs.close
   if zm=0 then
      monthsmb=0
   else
      monthsmb=round((zm-tmpretail)/(12-months+1),2)
   end if
   '本月总销
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and year(a.sure_date)="&years&" and month(a.sure_date)="&months
   rs.open sql,cn
   if rs.eof then
      monthretail=0
   else
      monthretail=cdbl(rs("sums"))
   end if
   rs.close
   '本月达标
   if monthsmb=0 then
      monthbl=0
   else
      monthbl=round(monthretail/monthsmb,4)*100
   end if
   '当天原目标
   dayymb=round(monthymb/getmonthdays(years,months),2)
   '当天实际目标，计算当月销售时不包含当天的销售在内
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and year(a.sure_date)="&years&" and month(a.sure_date)="&months&" and convert(char(10),a.sure_date,126)<convert(char(10),getdate(),126)"
   rs.open sql,cn
   if rs.eof then
      tmpretail=0
   else
      tmpretail=cdbl(rs("sums"))
   end if
   rs.close
   if monthsmb=0 then
      daysmb=0
   else
      daysmb=round((monthsmb-tmpretail)/(getmonthdays(years,months)-days+1),2)
   end if
   '当天总销
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and convert(char(10),getdate(),126)=convert(char(10),a.sure_date,126)"
   rs.open sql,cn
   if rs.eof then
      dayretail=0
   else
      dayretail=cdbl(rs("sums"))
   end if
   rs.close
   '当天达标
   if daysmb=0 then
      daybl=0
   else
      daybl=round(dayretail/daysmb,4)*100
   end if
   
   response.write("<table width=100% border=0>")
   'response.write("<tr height=20><td colspan=2 align=center><font size=2>本店销售目标状况</font></td></tr>")
   'response.write("<tr><td colspan=2><hr size=1></td></tr>")
   response.write("<tr><td><font size=2>今天原目标</font></td><td><font size=2 color=red>￥ "&dayymb&"</font></td></tr>")
   response.write("<tr><td><font size=2>今天实际目标</font></td><td><font size=2 color=red>￥ "&daysmb&"</font></td></tr>")
   response.write("<tr><td><font size=2>今天总销额</font></td><td><font size=2 color=red>￥ "&dayretail&"</font></td></tr>")
   response.write("<tr><td><font size=2>今天达标率</font></td><td><font size=2 color=red>"&daybl&" %</font></td></tr>")
   response.write("<tr><td colspan=2><hr size=1></td></tr>")
   response.write("<tr><td><font size=2>本月原目标</font></td><td><font size=2 color=red>￥ "&monthymb&"</font></td></tr>")
   response.write("<tr><td><font size=2>本月实际目标</font></td><td><font size=2 color=red>￥ "&monthsmb&"</font></td></tr>")
   response.write("<tr><td><font size=2>本月总销额</font></td><td><font size=2 color=red>￥ "&monthretail&"</font></td></tr>")
   response.write("<tr><td><font size=2>本月达标率</font></td><td><font size=2 color=red>"&monthbl&" %</font></td></tr>") 
   if session("cf_posinfo_year") then
   response.write("<tr><td colspan=2><hr size=1>a</td></tr>")
   response.write("<tr><td><font size=2>今年目标</font></td><td><font size=2 color=red>￥ "&zm&"</font></td></tr>")
   response.write("<tr><td><font size=2>今年总销额</font></td><td><font size=2 color=red>￥ "&zretail&"</font></td></tr>")
   response.write("<tr><td><font size=2>今年总达标率</font></td><td><font size=2 color=red>"&zbl&" %</font></td></tr>")
   end if
   response.write("</table>")
end sub

sub posinfo1
   depotid=HTMLEncode(request("depotid"))
   sql="select isnull(sum(plansums),0) as sums from j_plandptday where depotid='"&depotid&"' and year(plandate)=year(getdate())"
   rs.open sql,cn
   '今年目标
   if rs.eof then
      zm=0
   else
      zm=cdbl(rs("sums"))
   end if
   rs.close
   '今年实销
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and year(a.sure_date)=year(getdate())"
   rs.open sql,cn
   if rs.eof then
      zretail=0
   else
      zretail=cdbl(rs("sums"))
   end if
   rs.close
   '总达标率
   if zm=0 then
      zbl=0
   else
      zbl=round(zretail/zm,4)*100
   end if
   '本月目标
   sql="select isnull(sum(plansums),0) as sums from j_plandptday where depotid='"&depotid&"' and year(plandate)=year(getdate()) and month(plandate)=month(getdate())"
   rs.open sql,cn
   if rs.eof then
      monthymb=0
   else
      monthymb=cdbl(rs("sums"))
   end if
   rs.close
   '本月总销
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and year(a.sure_date)=year(getdate()) and month(a.sure_date)=month(getdate())"
   rs.open sql,cn
   if rs.eof then
      monthretail=0
   else
      monthretail=cdbl(rs("sums"))
   end if
   rs.close
   '本月达标
   if monthsmb=0 then
      monthbl=0
   else
      monthbl=round(monthretail/monthmb,4)*100
   end if
   '当天目标
   sql="select isnull(sum(plansums),0) as sums from j_plandptday where depotid='"&depotid&"' and year(plandate)=year(getdate()) and month(plandate)=month(getdate()) and day(plandate)=day(getdate())"
   rs.open sql,cn
   if rs.eof then
      dayymb=0
   else
      dayymb=cdbl(rs("sums"))
   end if
   rs.close
   '当天总销
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and convert(char(10),getdate(),126)=convert(char(10),a.sure_date,126)"
   rs.open sql,cn
   if rs.eof then
      dayretail=0
   else
      dayretail=cdbl(rs("sums"))
   end if
   rs.close
   '当天达标
   if daysmb=0 then
      daybl=0
   else
      daybl=round(dayretail/daymb,4)*100
   end if
   response.write("<table width=100% border=0>")
   response.write("<tr><td><font size=2>今天目标</font></td><td><font size=2 color=red>￥ "&dayymb&"</font></td></tr>")
   response.write("<tr><td><font size=2>今天总销额</font></td><td><font size=2 color=red>￥ "&dayretail&"</font></td></tr>")
   response.write("<tr><td><font size=2>今天达标率</font></td><td><font size=2 color=red>"&daybl&" %</font></td></tr>")
   response.write("<tr><td colspan=2><hr size=1></td></tr>")
   response.write("<tr><td><font size=2>本月目标</font></td><td><font size=2 color=red>￥ "&monthymb&"</font></td></tr>")
   response.write("<tr><td><font size=2>本月总销额</font></td><td><font size=2 color=red>￥ "&monthretail&"</font></td></tr>")
   response.write("<tr><td><font size=2>本月达标率</font></td><td><font size=2 color=red>"&monthbl&" %</font></td></tr>") 
   if session("cf_posinfo_year") then
   response.write("<tr><td colspan=2><hr size=1></td></tr>")
   response.write("<tr><td><font size=2>今年目标</font></td><td><font size=2 color=red>￥ "&zm&"</font></td></tr>")
   response.write("<tr><td><font size=2>今年总销额</font></td><td><font size=2 color=red>￥ "&zretail&"</font></td></tr>")
   response.write("<tr><td><font size=2>今年总达标率</font></td><td><font size=2 color=red>"&zbl&" %</font></td></tr>")
   end if
   response.write("</table>")
end sub

function getmonthdays(y,m)
dim y1,m1,d1,d2
if m=12 then
   y1=y+1
   m1=0
else
   y1=y
   m1=m
end if
d1=y&"-"&m&"-1"
d2=y1&"-"&m1+1&"-1"
set r1=server.createobject("adodb.recordset")
r1.open "select datediff(d,'"&d1&"','"&d2&"') as d",cn
getmonthdays=r1("d")
r1.close
set r1=nothing
end function%>
</body>
</html>