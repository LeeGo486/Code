<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!-- #include file="inc/const.asp" -->
<%
Response.cachecontrol = "no-cache"
response.Charset = "gb2312"

Dim cn
set cn=server.CreateObject("adodb.connection")
cn.open session("cn")

dim title,rs,i,mobtellist,s1,dname,Nowdate,Nowtime,Setdate,nums,sums,fcalcsums,VIPnums,VIPsums,VIPfcalcsums,msg,t



if session("psendmsg1")<>true then
   response.write "{success:true,data:{msg:'��ǰ����Աû�з����ֻ����ŵ�Ȩ�ޣ����ܷ��ͣ�'}}"
   response.End()
end if 

set rs=server.createobject("adodb.recordset")
rs.open "select isnull(mobtel,'') as mobtel from j_depot where depotid='"&session("dm").system_depotid&"'",cn
mobtellist=rs("mobtel")
rs.close
'ȡ��ģ��
rs.open "select tmpcontent from vip_msgtemplate where tmpid=6102038",cn
if not rs.eof then
   msg=trim(rs("tmpcontent"))
end if
rs.close
if mobtellist="" then
   response.write "{success:true,data:{msg:'�ֻ��б�Ϊ�գ����ܷ��ͣ�����ϵ�ܹ�˾'}}"
elseif msg="" then
   response.write "{success:true,data:{msg:'����ģ��Ϊ�գ�����ϵ�ܹ�˾��'}}"
else
'�޸�˵��:������������ȫ��������Ӧ�ֶ�ȡ������ʵ����VIP����������VIP�����VIPʵ�����;ģ������ֱ�Ϊ$FcalcSums, $VIPnums, $VIPsums, $VIPfcalcsums
'������ʱ������ĳ�ȫ�ƣ��޸ķ���ʱ���Ϊ��ǰʱ��+5���� ���ֶ�����Ϊ convert(char(19),dateadd( n, 5 ,getdate()),120) as Setdate
   s1="select e.depotid,e.d_name,"&_
            "convert(char(10),getdate(),126) as Nowdate,convert(char(8),getdate(),114) as Nowtime,convert(char(19),dateadd( n, 5 ,getdate()),120) as Setdate, "&_
            "e.nums,e.sums,e.fcalcsums,  "&_
       "isnull(f.VIPnums,0) as VIPnums,isnull(f.VIPsums,0) as VIPsums,isnull(f.VIPfcalcsums,0) as VIPfcalcsums "&_
       "from  "&_
            "(select a.depotid,max(c.d_name) as d_name,sum(a.znums) as nums,sum(a.zssums) as sums,sum(a.fcalcsums) as fcalcsums "&_
         "from d_retail a,j_depot c "&_
        "where isnull(a.sure,0)>0 and isnull(dtype,0) = 0 and convert(char(10),getdate(),126)=convert(char(10),a.sure_date,126) "&_
	     "and a.depotid=c.depotid and a.depotid='"&session("dm").system_depotid&"' group by a.depotid ) e left join "&_
          "(select depotid,sum(znums) as vipnums,sum(zssums) as vipsums,sum(fcalcsums) as vipfcalcsums "&_
         "from d_retail "&_
         "where isnull(sure,0)> 0 and isnull(dtype,0) = 0 and convert(char(10),getdate(),126)=convert(char(10),sure_date,126) "&_
	      "and isnull(vipcode,'') <> '' and depotid='"&session("dm").system_depotid&"' group by depotid ) f  on e.depotid = f.depotid "
   rs.open s1,cn
   if not rs.eof then
        dname=rs("d_name")
        Nowdate=rs("Nowdate")
        Nowtime=rs("Nowtime")
        Setdate=rs("Setdate")
        nums=rs("nums")
        sums=rs("sums")
        fcalcsums=rs("fcalcsums")
        VIPnums=rs("VIPnums")
        VIPsums=rs("VIPsums")
        VIPfcalcsums=rs("VIPfcalcsums")
   else
      rs.close
      s1="select d_name,convert(char(10),getdate(),126) as Nowdate,convert(char(8),getdate(),114) as Nowtime,"&_
         "convert(char(19),dateadd( n, 5 ,getdate()),120) as Setdate from j_depot where depotid='"&session("dm").system_depotid&"'"
	  rs.open s1,cn
        dname=rs("d_name")
        Nowdate=rs("Nowdate")
        Nowtime=rs("Nowtime")
        Setdate=rs("Setdate")
        nums=0
        sums=0
        fcalcsums=0
        VIPnums=0
        VIPsums=0
        VIPfcalcsums=0
   end if
   rs.close
   msg=replace(msg,"$Dptname",trim(dname))
   msg=replace(msg,"$Nowdate",Nowdate)
   msg=replace(msg,"$Nowtime",Nowtime)
   msg=replace(msg,"$Nums",nums)
   msg=replace(msg,"$Sums",sums)
   msg=replace(msg,"$FcalcSums",fcalcsums)
   msg=replace(msg,"$VIPnums",VIPnums)
   msg=replace(msg,"$VIPsums",VIPsums)
   msg=replace(msg,"$VIPfcalcsums",VIPfcalcsums)

   'msg=trim(dname)&Nowdate&"��,�ܹ����� "&nums&" ��,���۶� �� "&sums&" ,�������ݽ�ֹʱ��Ϊ"&Nowtime
   t=split(mobtellist,",")
   for i=0 to ubound(t)
      s1="insert into vip_message (msg,setdate,sure,tel,crdate,crname) values "&_
         "('"&msg&"','"&setdate&"',0,'"&t(i)&"',getdate(),'"&session("dm").System_UserName&"')"
      cn.execute s1
   next
   'http://localhost/f22/pos/index_login.asp?name=0001&pass=1&dbname=f22d&url=pos/json_send.asp
   response.write "{success:true,data:{msg:'���ͳɹ�'}}"
end if
set rs=nothing
cn.close
set cn=nothing
%>
