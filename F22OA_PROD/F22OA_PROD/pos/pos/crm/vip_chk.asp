<%option explicit%>
<!--#include file="inc/function.asp"-->
<!--#include file="inc/Class.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="css/f22.css" rel="stylesheet" type="text/css">
<link href="css/gt.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="inc/function.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridtable.js"></SCRIPT>
<SCRIPT language="JavaScript" src="inc/gridedittable.js"></SCRIPT>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
</head>
<%
dim ds,sql,depotid,t,str
dim vipcode
depotid=trim(session("dm").System_depotid)
set ds=server.createobject("adodb.recordset")
ds.activeconnection=cn
if trim(request.form("vipcode"))<>"" then
   vipcode=trim(request.form("vipcode"))
   
   if request.cookies("vipflash")("cut")=1 then
	  str=" substring('"&vipcode&"',"&request.cookies("vipflash")("beg")&","&request.cookies("vipflash")("cnt")&")=a.vipcode" 
   else
	  str=" a.vipcode='"&vipcode&"'"
   end if
   
   sql="select 1 from vip_user a,vip_cardvip b where "&str&" and a.vipcode=b.vipcardid "&_
             "and convert(char(10),b.begdate,126)<=convert(char(10),getdate(),126) "&_
             "and convert(char(10),getdate(),126)<=convert(char(10),b.enddate,126) "&_
             "and convert(char(10),isnull(b.viplastdate,getdate())+isnull(b.maxday,0),126)>=convert(char(10),getdate(),126)"
   'de sql
   ds.source=sql
   ds.open
   if ds.eof then
    response.write"<script>alert('��VIP�����ڻ�δ���Ż��ѹ��ڣ����������룡');</script>"
	else
	sql="select a.vipid,vipcodejm='*****',a.vipcode,a.vipname,isnull(a.sums,0)+isnull(b.starsums,0) as sums,isnull(a.centum,0)+isnull(b.starcentum,0) as centum,"&_
	    "a.vipbirth,a.vipsex,substring(convert(char(10),a.vipbirth,126),6,5) as sr,a.city,a.mobtel,a.vipadd,a.viptel "&_
		"from vip_user a,vip_cardvip b where "&str&" and a.vipcode=b.vipcardid"
   end if
end if
%>
<body>
<table width=100% height=150 border=0 bgcolor=#ffffff>
				<tr><form name="chkvip_form" method="post"><td width="41%" vAlign=top>
                  �˿�VIP����:
                    <input name="vipcode" <% if  session("pos_vipshow")=true then response.Write("type=password") else response.Write("type=text")  end if %> id="vipcode" size="20"> 
                    <input type="submit" name="Submit" value="��ѯ">
                   </td></form>
				  <td width="59%" height="20" vAlign=top>��ע��
                    <input type="text" name="textfield">
                    ��
                    <input type="submit" name="Submit" value="  ����  "></td>
				</tr>
				<tr>
				  <td colspan="2" vAlign=top>
<%
if sql<>"" then
  set t=New Table
  t.ActiveConnection =cn
  t.CommandType=1
  'sql= "select vipid,vipname,vipsex,vipbirth,viptel,mobtel,vipemail,vipadd,vipcode from vip_user where isnull(vipcode,'')<>'' and depotid="&qts(depotid)
  t.SetField "vipid","���","80"
  		  if session("pos_vipshow")=true then
		    t.SetField "vipcodejm","VIP��","60"
		  else    
		    t.SetField "vipcode","VIP��","60"
		  end if   
        
          t.SetField "vipname","����","50"
          t.SetField "sums","��ֵ","60"
		  t.SetField "centum","����","60"
		  t.SetField "sr","����","60"
		  t.SetField "vipsex","�Ա�","30"
		  t.SetField "vipbirth","��������","60"
		  t.SetField "city","��������","60"
		  t.SetField "mobtel","�ƶ��绰","60"
		  t.SetField "viptel","�̶��绰","60"
		  t.SetField "vipadd","��ϵ��ַ","120"
		   t.width="98%"
		   t.height="100"
		    t.CommandText=sql
  t.Show
  set t=Nothing
%>
                    <%else%>
                    <div id="gt1" style="width:90%;height:100">
                      <table>
                        <thead>
                          <tr>
                            <th width="140">���</th>
                            <th width="140">VIP��</th>
                            <th width="50">����</th>
                            <th width="100">��ֵ</th>
                            <th width="50">����</th>
                            <th width="100">����</th>
                            <th width="50">�Ա�</th>
                            <th width="60">��������</th>
                            <th width="60">֤����</th>
                            <th width="60">��������</th>
                            <th width="60">�����ʼ�</th>
                            <th width="60">�ƶ��绰</th>
                            <th width="60">�̶��绰</th>
                            <th width="60">��ϵ��ַ</th>
                          </tr>
                        </thead>
                      </table>
                      <%end if%>
                      <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td><input type="hidden" name="te" value=""/></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td>&nbsp;</td>
                        </tr>
                      </table>
                    </div></td>
				  </tr>
				</table>
				<script language="javascript">
    try{
	 gt = new GtTable("gt1");
	 gtTables.addTable(gt);
	 gt.loadTable();
	}catch(ex){}
</script>
</body>
</html>
