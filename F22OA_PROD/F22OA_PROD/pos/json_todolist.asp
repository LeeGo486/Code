<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
response.CacheControl = "no-cache"
response.Charset = "gb2312"
dim dbname
session("dbname")=HTMLEncode(request("dbname"))
if session("dbname")="" then
response.Write "���ݿ���������ڣ�"
response.End()
end if%>
<!-- #include file="cn.asp" -->
<!-- #include file="pos/f22/config.asp" -->
<%
function HTMLEncode(fString)
	fString=Trim(fString)
	fString=replace(fString,"<script","&lt;script")
	fString=replace(fString,"script>","script&gt;")
	fString=replace(fString,"<iFrame","&lt;iFrame")
	fString=replace(fString,"iFrame>","iFrame&gt;")
	fString=Replace(fString,CHR(9),"&#9;")
	fString=Replace(fString,CHR(39),"&#39;")	'��'��
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
   s="A380_GetToDoList '"&userid&"','"&dbname&"',1"
else
   s="A380_JMSGetToDoList '"&userid&"','"&dbname&"',1"
end if

movetype=1
rs.open s,cn,1,1
if movetype=0 then
  response.write("<marquee direction=left scrollamount=3 scrolldelay=20 onMouseOver='this.stop();' onMouseOut='this.start();'>")
  response.Write("")
  while not rs.eof
    response.write("&nbsp;&nbsp;&nbsp;<font size=4 color=red>&diams;<a href='HTTP://WAIT/"&trim(rs("dllname"))&"$$"&trim(rs("formid"))&"$$"&trim(rs("datid"))&"' onFocus='this.onBlur'>"&rs("title")&"</a>")
    rs.movenext
  wend
  response.write("</marquee>")

else
  if not rs.eof then%>
         <div id="andyscroll">
            <div id="scrollmessage">
            <ul>
            <%while not rs.eof
                response.Write("<li><font size=4 color=red>&diams;<a href='HTTP://WAIT/"&trim(rs("dllname"))&"$$"&trim(rs("formid"))&"$$"&trim(rs("datid"))&"' onFocus='this.onBlur'>"&rs("title")&"</a></li>")
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
             setInterval('scrollUp()',30);//������������25, ��ȷ�������ٶȵ�, ��ֵԽС, �ٶ�Խ��
            }
            function scrollUp(){
             if(stopscroll) return;
             currentTop += 1; //��Ϊ1, ����ʵ�ּ�Ъʽ�Ĺ���; ��Ϊ2, ������������
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
     '��������Ŀ��
     for i=0 to 11
       m(i)=cdbl(rs("m"&i+1))*10000
       zm=zm+cdbl(m(i))
     next
   end if
   rs.close
   '����ʵ��
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and year(a.sure_date)="&years
   rs.open sql,cn
   if rs.eof then
      zretail=0
   else
      zretail=cdbl(rs("sums"))
   end if
   rs.close
   '�ܴ����
   if zm=0 then
      zbl=0
   else
      zbl=round(zretail/zm,4)*100
   end if
   '����ԭĿ��
   sql="select isnull(b.m"&months&",0)*10000 as m from c_planzy a,c_planzysub b where a.planid=b.planid and a.planyear="&years&_
       " and b.depotid='"&depotid&"' and isnull(a.sure,0)>0"
   rs.open sql,cn
   if rs.eof then
      monthymb=0
   else
      monthymb=cdbl(rs("m"))
   end if
   rs.close
   '����ʵ��Ŀ�꣬����ȫ������ʱ�������������������
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
   '��������
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and year(a.sure_date)="&years&" and month(a.sure_date)="&months
   rs.open sql,cn
   if rs.eof then
      monthretail=0
   else
      monthretail=cdbl(rs("sums"))
   end if
   rs.close
   '���´��
   if monthsmb=0 then
      monthbl=0
   else
      monthbl=round(monthretail/monthsmb,4)*100
   end if
   
    '���������
   if monthymb=0 then
      monthwcl=0
   else
      monthwcl=round(monthretail/monthymb,4)*100
   end if
   
   '����ԭĿ��
   dayymb=round(monthymb/getmonthdays(years,months),2)
   '����ʵ��Ŀ�꣬���㵱������ʱ�������������������
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
   '��������
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and convert(char(10),getdate(),126)=convert(char(10),a.sure_date,126)"
   rs.open sql,cn
   if rs.eof then
      dayretail=0
   else
      dayretail=cdbl(rs("sums"))
   end if
   rs.close
   '������
   if daysmb=0 then
      daybl=0
   else
      daybl=round(dayretail/daysmb,4)*100
   end if
   
   response.write("<table width=100% border=0 style=""font-size:12px;margin:5px 0 5px 5px ;width:96%"">")
   'response.write("<tr height=20><td colspan=2 align=center>��������Ŀ��״��</td></tr>")
   'response.write("<tr><td colspan=2></td></tr>")
   if session("cf_posinfo_day") then
   response.write("<tr><td>����ԭĿ��</td><td><font  color=red>�� "&dayymb&"</td></tr>")
   response.write("<tr><td>����ʵ��Ŀ��</td><td><font  color=red>�� "&daysmb&"</td></tr>")
   response.write("<tr><td>����������</td><td><font  color=red>�� "&dayretail&"</td></tr>")
   response.write("<tr><td>��������</td><td><font  color=red>"&daybl&" %</td></tr>")
   end if
   if session("cf_posinfo_month")  then
   response.write("<tr><td colspan=2><hr size=1></td></tr>")
   response.write("<tr><td>����ԭĿ��</td><td><font  color=red>�� "&monthymb&"</td></tr>")
   
   if session("cf_posinfo_monthreal") then
      response.write("<tr><td>����ʵ��Ŀ��</td><td><font  color=red>�� "&monthsmb&"</td></tr>")
   end if   
   
   response.write("<tr><td>����������</td><td><font  color=red>�� "&monthretail&"</td></tr>")
   
   if session("cf_posinfo_monthbl") then
      response.write("<tr><td>���´����</td><td><font  color=red>"&monthbl&" %</td></tr>") 
   end if 
   response.write("<tr><td>���������</td><td><font  color=red>"&monthwcl&" %</td></tr>") 
   end if
   if session("cf_posinfo_year") then
   response.write("<tr><td colspan=2><hr size=1></td></tr>")
   response.write("<tr><td>����Ŀ��</td><td><font  color=red>�� "&zm&"</td></tr>")
   response.write("<tr><td>����������</td><td><font  color=red>�� "&zretail&"</td></tr>")
   response.write("<tr><td>�����ܴ����</td><td><font  color=red>"&zbl&" %</td></tr>")
   end if
   response.write("</table>")
end sub

sub posinfo1
   depotid=HTMLEncode(request("depotid"))
   sql="select isnull(sum(plansums),0) as sums from j_plandptday where depotid='"&depotid&"' and year(plandate)=year(getdate())"
   rs.open sql,cn
   '����Ŀ��
   if rs.eof then
      zm=0
   else
      zm=cdbl(rs("sums"))
   end if
   rs.close
   '����ʵ��
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and year(a.sure_date)=year(getdate())"
   rs.open sql,cn
   if rs.eof then
      zretail=0
   else
      zretail=cdbl(rs("sums"))
   end if
   rs.close
   '�ܴ����
   if zm=0 then
      zbl=0
   else
      zbl=round(zretail/zm,4)*100
   end if
   '����Ŀ��
   sql="select isnull(sum(plansums),0) as sums from j_plandptday where depotid='"&depotid&"' and year(plandate)=year(getdate()) and month(plandate)=month(getdate())"
   rs.open sql,cn
   if rs.eof then
      monthymb=0
   else
      monthymb=cdbl(rs("sums"))
   end if
   rs.close
   '��������
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and year(a.sure_date)=year(getdate()) and month(a.sure_date)=month(getdate())"
   rs.open sql,cn
   if rs.eof then
      monthretail=0
   else
      monthretail=cdbl(rs("sums"))
   end if
   rs.close
   '���´��
   if monthsmb=0 then
      monthbl=0
   else
      monthbl=round(monthretail/monthmb,4)*100
   end if
   '����Ŀ��
   sql="select isnull(sum(plansums),0) as sums from j_plandptday where depotid='"&depotid&"' and year(plandate)=year(getdate()) and month(plandate)=month(getdate()) and day(plandate)=day(getdate())"
   rs.open sql,cn
   if rs.eof then
      dayymb=0
   else
      dayymb=cdbl(rs("sums"))
   end if
   rs.close
   '��������
   sql="select isnull(sum(b.nums*b.s_price),0) as sums from d_retail a,d_retailsub b where a.retailid=b.retailid and isnull(a.sure,0)>0 "&_
       "and a.depotid='"&depotid&"' and convert(char(10),getdate(),126)=convert(char(10),a.sure_date,126)"
   rs.open sql,cn
   if rs.eof then
      dayretail=0
   else
      dayretail=cdbl(rs("sums"))
   end if
   rs.close
   '������
   if daysmb=0 then
      daybl=0
   else
      daybl=round(dayretail/daymb,4)*100
   end if
   response.write("<table width=100% border=0 style=""font-size:12px;margin:5px 0 5px 5px ;width:96%"">")
   if session("cf_posinfo_day") then
   response.write("<tr><td>����Ŀ��</td><td><font  color=red>�� "&dayymb&"</td></tr>")
   response.write("<tr><td>����������</td><td><font  color=red>�� "&dayretail&"</td></tr>")
   response.write("<tr><td>��������</td><td><font  color=red>"&daybl&" %</td></tr>")
   end if
   if session("cf_posinfo_month")  then
   response.write("<tr><td colspan=2><hr size=1></td></tr>")
   response.write("<tr><td>����Ŀ��</td><td><font  color=red>�� "&monthymb&"</td></tr>")
   response.write("<tr><td>����������</td><td><font  color=red>�� "&monthretail&"</td></tr>")
   response.write("<tr><td>���´����</td><td><font  color=red>"&monthbl&" %</td></tr>") 
   end if
   if session("cf_posinfo_year") then
   response.write("<tr><td colspan=2><hr size=1></td></tr>")
   response.write("<tr><td>����Ŀ��</td><td><font  color=red>�� "&zm&"</td></tr>")
   response.write("<tr><td>����������</td><td><font  color=red>�� "&zretail&"</td></tr>")
   response.write("<tr><td>�����ܴ����</td><td><font  color=red>"&zbl&" %</td></tr>")
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
</div>