<%option explicit
on error resume next
Response.Expires=-1000
%>
<!--#include file="inc/function.asp"-->
<%dim str,opt,dfname,cfname
response.Charset = "gb2312"
opt=trim(request.QueryString("opt"))
str=trim(request.QueryString("str"))%>
<html>
<head>
<script language="javascript" src="../inc/js/setday1.js"></script>
<script type="text/javascript" src="../../../scripts/jquery-1.2.6.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ȷ�� <%=str%></title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-right: 0px;
}
.f12 {
	font-size: 12px;
}
.bk {
	border: 1px solid;
}
-->
</style>
<script language="javascript">
//ͬ������
function Syncnums(id)
{
    //if (!confirm("ȷ���������������������?�����󷢻�����ͬ���ɼ����.")){return false;}
	var url='ajax/2067_moveset_Sync.asp?date()';
	data = 'id='+id;
 	var html = $.ajax({
    url: url,
    type: "POST",
    dataType: "html",
    data: data,
    async: false
    }).responseText;	
	if (html=='true'){
		alert("ͬ���ɹ�!���ڱ�ע������֪ͨ���ͷ�������һ�µ���ϸԭ��!");
		showModalDialog('2067_move_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
	}else{
	    alert("ͬ��ʧ��!");
	}
}

//����Ƿ���д��֪ͨ���ͷ�������һ�µ���ϸԭ��
function CheckRemark(id)
{    
	var url='ajax/2067_moveset_check.asp?date()';
	data = 'id='+id;
 	var html = $.ajax({
    url: url,
    type: "POST",
    dataType: "html",
    data: data,
    async: false
    }).responseText;	
	if (html=='false'){
		alert("���ڱ�ע������֪ͨ���ͷ�������һ�µ���ϸԭ��!");	
		showModalDialog('2067_move_create.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no');
		return false;	
	}else{
		return true;
	}
}

function exit(){
  window.close();
}
</script>
<base target="abcdefg">
<link href="css/f22.css" rel="stylesheet" type="text/css">
</head>

<body>
<iframe style="display:none; " name="abcdefg" id="abcdefg"></iframe>
<%dim o,id,rs,rs1,rs2,ifchange,s1,newid,dptid,ifcheck,checktype,je,djje,fhje,str1,zmdate,sql,sameunit,sameorg,setdate,chkkc,tbname,tbid,tbnums,tbgetdepot,grxyje,kyje,mqje,xyje,phlsje,fhlsje,je2,isdiff
'response.Write("cfname="&request.QueryString("cfname"))
'response.Write(" cdname="&request.QueryString("cdname"))
'response.Write(" cuname="&request.QueryString("cuname"))
'response.Write(" dfname="&request.QueryString("dfname"))
'response.Write(" ddname="&request.QueryString("ddname"))
'response.Write(" duname="&request.QueryString("duname"))
'response.Write("opt="&request.QueryString("opt"))
'response.Write("str=")
'response.End()
opt=trim(request.QueryString("opt"))
cfname=trim(request.QueryString("cfname"))
dfname=trim(request.QueryString("dfname"))
id=trim(request.QueryString("id"))
'session("id")=id
'de session("tablename")
'�ж��̵㵥û�����ɲ��첻�������
if str="���" and session("tablename")="d_inventory" then
   set rs=server.createobject("adodb.recordset")
   rs.open "select 1  from d_inventory where inventoryid='"&id&"' and substring('"&id&"',1,2)='PD' and diff=0",cn
   if not rs.eof then
      rs.close
	  set rs=nothing
      response.write("<script language='javascript'>alert('�̵㵥��û�����ɲ��죬������ˣ�');window.close();</script>")
	  response.end
   end if
   rs.close
   set rs=nothing
end if

if (str="���" or str="����") and session("tablename")="d_inventory" then
   set rs=server.createobject("adodb.recordset")
   rs.open "select setdate=convert(varchar(10),setdate,126)  from d_inventory where inventoryid='"&id&"'",cn
   if not rs.eof then
      setdate=rs(0)
   end if
   rs.close
end if 

'ͬ���������������֪ͨ��:��鷢�����Ƿ���ڼ����;��鷢�����Ƿ�С��֪ͨ��
if str="���" and session("tablename")="d_move" then
   
   set rs=server.createobject("adodb.recordset")
   rs.open " select top 1 1 from d_move a "&_
		   " inner join d_movenotice b on a.indentid=b.noticeid "&_
		   " inner join d_movesub c on a.moveid=c.moveid "&_
		   " left join webtmp_barcodeget d on a.moveid=d.id  and c.clothingid=d.clothingid "&_
		   " where a.moveid='"&id&"'" &_
		   " and c.set_nums<>isnull(d.nums,0)",cn
   		   
   if not rs.eof then
     rs.close 
	 set rs=nothing
     response.Write("<script> if (!confirm('�������ͼ��������,��Ҫ����������ͬ���ɼ����!')) { window.close(); } else { Syncnums('"+id+"')}</script>")       
	 'response.end()	 
   else
     rs.close
     set rs=nothing
   end if
end if 

'�����ж�����
if str="����" and request.form("dt")<>"" then
   
   select case session("tablename")
   case "d_indent"
        s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq from d_indent a,j_depot b where a.get_depotid=b.depotid and a.indentid='"&id&"'"
   case "d_sell"
        s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq from d_sell a,j_depot b where a.get_depotid=b.depotid and a.sellid='"&id&"'"
   case "d_outindentpro"
        s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq from d_outindentpro a,j_depot b where a.set_depotid=b.depotid and a.outindentid='"&id&"'"
   case "d_outindentset"
        s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq from d_outindentset a,j_depot b where a.set_depotid=b.depotid and a.outindentid='"&id&"'"
   case "d_move"
        if dfname="set_sure" then
           s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq from d_move a,j_depot b where a.set_depotid=b.depotid and a.moveid='"&id&"'"
        else
           s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq from d_move a,j_depot b where a.get_depotid=b.depotid and a.moveid='"&id&"'"
		end if
   case "d_msell"
        if dfname="set_sure" then
           s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq from d_msell a,j_depot b where a.set_depotid=b.depotid and a.msellid='"&id&"'"
        else
           s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq from d_msell a,j_depot b where a.get_depotid=b.depotid and a.msellid='"&id&"'"
		end if
   case "d_inventory"
        s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq from d_inventory a,j_depot b where a.depotid=b.depotid and a.inventoryid='"&id&"'"
   end select
     
   if s1<>"" then
      
      if str="����" and session("tablename")="d_outindentpro" then
         response.write("<script language='javascript'>alert('����ϵ��˾�ܲ��������뵥������ͨ���󷽿ɷ��������������и���');window.close();</script>")
      end if   
        
      set rs1=server.createobject("adodb.recordset")
	  rs1.open s1,cn,1,1

	  if request.form("dt")<=rs1("zmrq") then
	     rs1.close
	     set rs1=nothing
         response.write("<script language='javascript'>alert('��Ŀ�Ѿ����������ܵ��ʣ�');window.close();</script>")
	     response.end
	  end if
	  rs1.close
	  set rs1=nothing
   end if
   
     
end if

'�������ж�����
if str="������" and request.form("dt")="" then
   select case session("tablename")
   case "d_indent"
        s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq,convert(char(10),a.sure_date,126) as suredate "&_
		   "from d_indent a,j_depot b where a.get_depotid=b.depotid and a.indentid='"&id&"'"
   case "d_sell"
        s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq,convert(char(10),a.getsure_date,126) as suredate "&_
		   "from d_sell a,j_depot b where a.get_depotid=b.depotid and a.sellid='"&id&"'"
   case "d_outindentpro"
        s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq,convert(char(10),a.sure_date,126) as suredate "&_
		   "from d_outindentpro a,j_depot b where a.set_depotid=b.depotid and a.outindentid='"&id&"'"
   case "d_outindentset"
        s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq,convert(char(10),a.sure_date,126) as suredate "&_
		   "from d_outindentset a,j_depot b where a.set_depotid=b.depotid and a.outindentid='"&id&"'"
   case "d_move"
        if dfname="set_sure" then
           s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq,convert(char(10),a.setsure_date,126) as suredate "&_
		      "from d_move a,j_depot b where a.set_depotid=b.depotid and a.moveid='"&id&"'"
        else
           s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq,convert(char(10),a.getsure_date,126) as suredate "&_
		      "from d_move a,j_depot b where a.get_depotid=b.depotid and a.moveid='"&id&"'"
		end if
   case "d_msell"
        if dfname="set_sure" then
           s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq,convert(char(10),a.setsure_date,126) as suredate "&_
		      "from d_msell a,j_depot b where a.set_depotid=b.depotid and a.msellid='"&id&"'"
        else
           s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq,convert(char(10),a.getsure_date,126) as suredate "&_
		      "from d_msell a,j_depot b where a.get_depotid=b.depotid and a.msellid='"&id&"'"
		end if
   case "d_inventory"
        s1="select isnull(convert(char(10),b.zmrqdate,126),'1900-01-01') as zmrq,convert(char(10),a.sure_date,126) as suredate "&_
		   "from d_inventory a,j_depot b where a.depotid=b.depotid and a.inventoryid='"&id&"'"
   end select
   if s1<>"" then
      set rs1=server.createobject("adodb.recordset")
	  rs1.open s1,cn,1,1
	  if rs1("suredate")<=rs1("zmrq") then
	     rs1.close
	     set rs1=nothing
         response.write("<script language='javascript'>alert('��Ŀ�Ѿ����������ܷ����ʣ�');window.close();</script>")
	     response.end
	  end if
	  rs1.close
	  set rs1=nothing
   end if
end if


'�˻���ͬ�ж�
if (str="���" or str= "����") and (session("tablename")="d_outindentpro" or session("tablename")="d_outindentset") and cfname="chk_sure" then
  
  set rs=server.CreateObject("adodb.recordset")
  rs.open " select merchantid from j_merchant where merchantid='"&session("dm").system_unitid&"' and endpact>=convert(varchar(10),getdate(),126)",cn,1,1
  if rs.eof and rs.bof then
     response.write("<script language='javascript'>alert('��ͬ�Ѿ����ڣ������˻�!');window.close();</script>")
	 response.end
  end if
  rs.close
  
  ' �˻���������
  rs.open "select comment from j18_lookupsub where lookupid=7003 and not exists (select 1 from j18_lookupsub where lookupid=7003 and ISNULL(lvalue,1)=0)  order by lookcode ",cn,1,1
  if(str= "����" and rs.recordcount>0) then
    dim strcom
    strcom=""
      while not rs.eof
        strcom=strcom&rs("comment")&" \n "
       rs.movenext
      wend
    response.write("<script language='javascript'>alert("""&strcom&""");</script>")
  end if

  
end if

'�����Ǹ���֪ͨ�����������
if str="���" and (session("tablename")="d_msell" or session("tablename")="d_outindentset") and (cfname="chk_sure" or cfname="setchk_sure") then
   if session("tablename")="d_outindentset" then
     sql=" select top 1 a.clothingid"&_
        " from  d_outindentsetsub a  "&_
        " inner join d_outindentset b on a.outindentid=b.outindentid" &_
        " left join  d_outindentCHKsub c on b.quotaid=c.outindentid and a.clothingid=c.clothingid "&_
        " where b.outindentid='"&id&"' and isnull(b.quotaid,'')<>'' and a.nums>isnull(c.nums,0)  "
   else
     sql=" select top 1 a.clothingid"&_
        " from  d_msellsub a  "&_
        " inner join d_msell b on a.msellid=b.msellid" &_
        " left join  d_movenoticesub c on b.noticeid=c.noticeid and a.clothingid=c.clothingid "&_
        " where b.msellid='"&id&"' and isnull(b.noticeid,'')<>'' and set_nums>isnull(nums,0) "
   end if		
  'de sql		
  set rs=server.CreateObject("adodb.recordset")
  rs.open sql,cn,1,1
  if not rs.eof  then
     response.write("<script language='javascript'>alert('������������֪ͨ���ڵķ�������!');window.close();</script>")
	 response.end
  end if
end if


'������������ж�
if (str="���" or str= "����") and session("tablename")="d_msell" and cfname="setchk_sure" and request.form("dt")="" then
    
   cn.execute "F22_GetMsellsub '"&id&"'"
   
   set rs1=server.createobject("adodb.recordset")
   
   '�¸ĵ��жϹ���begin
    '����������
	rs1.open "select chksums=isnull(chksums,0) from j_user  where userid='"&session("dm").system_userid&"'",cn,1,1
	if not rs1.eof then
      grxyje=round(rs1("chksums"),2)
	else
	  grxyje=0
    end if 
	rs1.close
	
    '�ջ����
	rs1.open "select sum(s_price*set_nums) as sums from d_msellsub where msellid='"&id&"'",cn,1,1
	if not rs1.eof then
      fhje=round(rs1("sums"),2)
	else
	  fhje=0
    end if 
	rs1.close
	
   '�ջ��ͻ���ؽ��	
    rs1.open "select isnull(a.s_sums,0) as s_sums,isnull(a.sums,0) as sums,isnull(a.bachcredit,0) as bachcredit,"&_
	          " isnull(nofreesums,0) as nofreesums,phcredit=case when datediff(d,getdate(),phcreditdate)>=0  then "&_
			  " isnull(phcredit,0) else 0 end,"&_
			  " fhcredit=case when datediff(d,getdate(),fhcreditdate)>=0 then isnull(fhcredit,0) else 0 end"&_
			  " from j_merchant a,d_msell b where b.msellid='"&id&"' and a.merchantid=b.get_mchid",cn,1,1
	if not rs1.eof then
	   '���ý��
	   kyje=round(rs1("s_sums"),2)
	   'Ŀǰ���
	   mqje=round(rs1("sums"),2)
	   '�ͻ�������
	   xyje=round(rs1("bachcredit"),2)
	   '������
	   djje=round(rs1("nofreesums"),2)
	   '�����ʱ������
	   phlsje=round(rs1("phcredit"),2)
	   '������ʱ������
	   fhlsje=round(rs1("fhcredit"),2)
	else
	  kyje=0
	  mqje=0
	  xyje=0
	  djje=0
	  phlsje=0
	  fhlsje=0
	end if   
	rs1.close	
	
	'��ʾ��ʽ
	rs1.open "select sysdefvalue from sys_system where systemid=2046",cn,1,1
    ifcheck=cdbl(rs1("sysdefvalue"))
    rs1.close
	
	'�ջ��ص��ϼ�������������ܹ�˾��ֹ�˾��ͬһ�������ж�
	'or  (set_parentid=get_parentid)
    sql=" select count(*) as counts from d_msell a inner join J_merchant c on c.MerchantId=a.get_mchid "&_
	     " where (msellid='"&id&"' and ((c.lb='�ܹ�˾' or c.lb='�ֹ�˾')  or (set_mchid=get_mchid)  ))"
	rs1.open sql,cn,1,1
	sameunit=round(rs1("counts"),2)
	rs1.close
	
	if sameunit=0 then
	  '�ջ�������(sum(s_price*set_nums))<=�������(s_sums)+�ͻ�������(bachcredit)-������(nofreesums)+����������(chksums)+�����ʱ������(phcredit,phcreditdate)
  	  '�ϼƿ�֧����Ϊ
	  je=kyje+xyje-djje+grxyje+phlsje
	
	  '�ջ�������(sum(s_price*set_nums))<=    ��ǰ���(Sums)+�ͻ�������(bachcredit)-������(nofreesums)+����������(chksums)+������ʱ������(fhcredit,fhcreditdate)
	  'Ŀǰ��� ������Ǯ
	  '�ϼƿ�֧����Ϊ
	   mqje=mqje*-1
	 	 
	  je2=mqje+xyje-djje+grxyje+fhlsje
	   
	 
	  
   	  if je<fhje or abs(je2)<fhje then
	    if je<fhje then
		  str1="�������㣡\n\nĿǰ��֧�����:"&kyje&"\n\n������Ϊ:"&djje&"\n\n������Ϊ:"&xyje&"\n\n������ʱ�����"&grxyje&"\n\n�����ʱ������Ϊ:"&phlsje&"\n\n�ϼƿ�֧����Ϊ:"&je&"\n\nĿǰ������Ϊ:"&fhje&"\n\n������Ϊ:"&fhje-je
		else
          str1="Ŀǰ���㣡\n\nĿǰ��֧�����:"&mqje&"\n\n������Ϊ:"&djje&"\n\n������Ϊ:"&xyje&"\n\n������ʱ������:"&grxyje&"\n\n������ʱ������Ϊ:"&fhlsje&"\n\n�ϼƿ�֧����Ϊ:"&je2&"\n\nĿǰ������Ϊ:"&fhje&"\n\n������Ϊ:"&fhje-je2
		end if

		
        if ifcheck = 2 then
	  	  response.write("<script language='javascript'>alert('"&str1&"');window.close();</script>")
	  	  response.end
	    else
	      str1=str1+"\n\n\n\n�Ƿ�������?"
		  response.write("<script language='javascript'> if (confirm('"&str1&"')){} else {window.close();}</script>") 
	   end if
	  end if
	end if    
	set rs1=nothing
   '�¸ĵ��жϹ���end
end if

'�ж��Ƿ����̵㵥
if str="����" and request.form("dt")<>"" then
	
   set rs1=server.createobject("adodb.recordset")
   select case session("tablename")
   case "d_indent"
        rs1.open "select get_depotid from d_indent where indentid='"&id&"'",cn,1,1
		dptid=rs1(0)
   case "d_outindentpro"
        rs1.open "select set_depotid from d_outindentpro where outindentid='"&id&"'",cn,1,1
		dptid=rs1(0)
   case "d_outindentset"
        rs1.open "select set_depotid from d_outindentset where outindentid='"&id&"'",cn,1,1
		dptid=rs1(0)
   case "d_move"
        if dfname="set_sure" then
           rs1.open "select set_depotid from d_move where moveid='"&id&"'",cn,1,1
		else
		   rs1.open "select get_depotid from d_move where moveid='"&id&"'",cn,1,1
		end if
		dptid=rs1(0)
   case "d_msell"
        if dfname="set_sure" then
           rs1.open "select set_depotid from d_msell where msellid='"&id&"'",cn,1,1
		else
		   rs1.open "select get_depotid from d_msell where msellid='"&id&"'",cn,1,1
		end if
		dptid=rs1(0)
   case "d_sell"
        rs1.open "select get_depotid from d_sell where sellid='"&id&"'",cn,1,1
		dptid=rs1(0)
   end select
   rs1.close
      
   if dptid<>"" then
     s1="select 1 from d_inventory where depotid='"&dptid&"' and isnull(sure,0)>0 and substring(inventoryid,1,2)='PD' "&_
        "and convert(char(10),sure_date,126)>='"&request.form("dt")&"'"
	 'de s1
     rs1.open s1,cn,1,1
     if not rs1.eof then
        rs1.close
	    set rs1=nothing
        response.write("<script language='javascript'>alert('�˵�������֮�������̵㵥�����ܵ��ʣ�');window.close();</script>")
	    response.end
     end if
     rs1.close
	 
	 '�ж�����
	 'rs1.open "select isnull(sysdefvalue,'1900-01-01') as dates from sys_system where systemid=4001",cn,1,1
	 'if not rs1.eof then
	 '   if request.form("dt")<=rs1(0) then
	 '	   rs1.close
	 '       set rs1=nothing
     '       response.write("<script language='javascript'>alert('�˵���������������Ŀ�����ܵ��ʣ�');window.close();</script")
	 '       response.end
	 '	end if
	 'end if
	 'rs1.close
   end if
   set rs1=nothing
end if

'�ж��Ƿ��в���
if str="������" then
   set rs2=server.createobject("adodb.recordset")
   select case session("tablename")
   case "d_indent" 
        rs2.open "select 1 from d_quota where indentid='"&id&"'",cn,1,1
        if not rs2.eof then
		   rs2.close
		   set rs2=nothing
           response.write("<script language='javascript'>alert('�˵��Ѿ������գ����ܷ����ʣ�');window.close();</script>")
		   response.end
        end if
		rs2.close
   case "d_outindentpro"
        rs2.open "select 1 from d_outindentchk where quotaid='"&id&"'",cn,1,1
        if not rs2.eof then
		   rs2.close
		   set rs2=nothing
           response.write("<script language='javascript'>alert('�˵��Ѿ������գ����ܷ����ʣ�');window.close();</script>")
		   response.end
        end if
		rs2.close
   case "d_outindentset"
        rs2.open "select 1 from d_outindent where quotaid='"&id&"'",cn,1,1
        if not rs2.eof then
		   rs2.close
		   set rs2=nothing
           response.write("<script language='javascript'>alert('�˵��Ѿ������գ����ܷ����ʣ�');window.close();</script>")
		   response.end
        end if
		rs2.close
   case "d_move"
        if dfname="set_sure" then
		   rs2.open "select 1 from d_move where moveid='"&id&"' and getchk_sure>0",cn,1,1
           if not rs2.eof then
		     rs2.close
		     set rs2=nothing
             response.write("<script language='javascript'>alert('�˵��Ѿ��ջ������ܷ����ʣ�');window.close();</script>")
		     response.end
           end if
		   rs2.close
		end if
   case "d_msell"
        if dfname="set_sure" then
		   rs2.open "select 1 from d_msell where msellid='"&id&"' and getchk_sure>0",cn,1,1
           if not rs2.eof then
		     rs2.close
		     set rs2=nothing
             response.write("<script language='javascript'>alert('�˵��Ѿ��ջ������ܷ����ʣ�');window.close();</script>")
		     response.end
           end if
		   rs2.close
		end if
   end select
   set rs2=nothing
end if

if trim(request.Form("dt"))<>"" then
 
  set o=server.CreateObject("f22_DjOperation.c")
  o.TableNameVb=session("tablename")
  o.PkNameVb=session("PkName")
  o.sopen
  set o=nothing
end if%>

<script>
function pdckdate()
{
   var tbname='<%=session("tablename")%>';
   var op='<%=str%>';
   if (tbname=="d_inventory"){
      if  (op=="���"||op=="����") {
      	 if (form1.setdate.value!=form1.dt.value){
           alert("<%=str%>"+"���ڱ�����̵�����һ�£�");
  	       event.returnValue=false;
	       return ;
         }
	  }
   }
   if (tbname=="d_move"&&op=="���"){     
         
         var id='<%=id%>';
		 var check=CheckRemark(id);
		 if (!check){
		 	event.returnValue=false;
		 	return ;
		 }         
   }
   var now= new Date();
   var dt=form1.dt.value;
   dt=dt+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
   form1.dt.value=dt;
}
</script>
<form name="form1" method="post" action="" target="abcdefg" onSubmit="this.S1.disabled=true;pdckdate();">
  <input name="isdiff" type="hidden" id="isdiff" value="<%=isdiff%>">
  <table width="200" border="0" align="center">
    <tr>
      <td></td>
    </tr>
  </table>
  <table width="300"  border="0" align="center" cellpadding="0" cellspacing="0" class="f14">
    <tr>
      <td width="9"><img src="img/smbg_l.gif" width="9" height="41"></td>
      <td width="282" align="center" background="img/smbg_b.gif">ȷ�� <%=str%> ����:
      <input name="action" type="hidden" id="action" value="<%=opt%>">
      <input name="id" type="hidden" id="id" value="<%=id%>"></td>
      <td width="10"><img src="img/smbg_r.gif" width="9" height="41"></td>
    </tr>
  </table>
  <table width="200" border="0" align="center">
    <tr>
      <td></td>
    </tr>
  </table>
  <table width="300"  border="0" align="center" bordercolor="#94867B" class="tcontent">
    <tr>
      <td height="27" class="f12">&nbsp;&nbsp;&nbsp;&nbsp;<%=str%>��ĵ��ݲ����޸ĺ�ɾ��!</td>
    </tr>
    <tr>
      <td height="25" class="f12">&nbsp;&nbsp;&nbsp;&nbsp;������Ч��<%=str%>����Ϊ׼!</td>
    </tr>
    <tr>
      <td height="27" class="f12">&nbsp;&nbsp;&nbsp;&nbsp;<%=str%>����:
	  <input type="hidden" name="setdate" id="setdate" value="<%=setdate%>">
      <input name="dt" type="text" id="dt" value="<%=get_date(date())%>" onFocus="setday(this);" size="8" tabindex="-1" readonly>	</td>
    </tr>
    <tr>
      <td height="25" class="f12">���Ҫ<%=str%>��?</td>
    </tr>
  </table>
  <table width="200" border="0" align="center">
    <tr>
      <td></td>
    </tr>
  </table>
  <table width="300" border="0" align="center" cellspacing="0" class="tcontent">
    <tr>
      <td height="29" align="center"><input type="submit" name="S1"  value="ȷ��(S)" accesskey="s" >
      <input type="button" name="e" value="ȡ��(X)" onClick="exit();" accesskey="x"></td>
    </tr>
  </table>
</form>
<%if err.number <>0 then
    dim errd
	errd=err.description
	if instr(errd,"�ɹ�")>=0 then 
	
	 '�ж��Ƿ��Զ�ת�ջ�
	 if session("tablename")="d_outindentset" and opt="sure" then
        set rs=server.createobject("adodb.recordset")
        rs.open "select sysdefvalue from sys_system where systemid=2072",cn,1,1
        if not rs.eof then
          ifchange=int(rs("sysdefvalue"))
        else
          ifchange=0
        end if
        rs.close
		
		
        set rs=nothing
        if ifchange=1 then
		   '�����շ�����һ��
           'newid=getid("d_outindent","outindentid","TF",session("dm").system_userid)
	       s1="insert into d_outindent (outindentid,outindent,outindentsq,quotaid,merchantid,depotid,set_depotid,parentid,"&_
              "getsure_date,sure,chk_sure,ov_sure,setdate,cr_name,cr_date,backrate,selltype,ds_type,Taxonomy) "&_
              "select '"&id&"','"&id&"',quotaid,outindentid,merchantid,depotid,set_depotid,parentid,"&_
              "sure_date,0,0,0,setdate,cr_name,getdate(),backrate,selltype,ds_type,Taxonomy from d_outindentset where outindentid='"&id&"'"
	       cn.execute s1
		   
		    '����dtype
		   s1="update d_outindent set dtype=1 where depotid not in (select depotid from j_depot where m_type=0 or m_type=1) and outindentid='"&id&"'"
		   cn.execute s1
			
	       s1="insert into d_outindentsub (outindentid,boxid,clothingid,styleid,colorid,sizeid,cost,j_price,x_price,discount,s_price,nums) "&_
              "select '"&id&"',boxid,clothingid,styleid,colorid,sizeid,cost,j_price,x_price,discount,s_price,nums "&_
              "from d_outindentsetsub where outindentid='"&id&"'"
	       cn.execute s1
	    end if
	 end if
  
  
     '�ջ���¼�¿�
     if session("InsertNewStyle")>0 then
        if session("tablename")="d_sell" and dfname="get_sure" then
	       cn.execute "A380_InsertNewStyle 0,'"&id&"'"
	    end if
	    if session("tablename")="d_move" and dfname="get_sure" then
	       cn.execute "A380_InsertNewStyle 1,'"&id&"'"
	    end if
	    if session("tablename")="d_msell" and dfname="get_sure" then
	       cn.execute "A380_InsertNewStyle 2,'"&id&"'"
	    end if
      end if
	   if  errd<>"" then
		 response.write "<script language='javascript'>alert("""&errd&""");window.close();</script>"
	   else
	     response.write "<script language='javascript'>window.close();</script>"	 
	   end if 
	end if
	
	if  err.description<>"" then
      response.write "<script language='javascript'>alert("""&err.description&""");window.history.back();</script>"
	else
	   response.write "<script language='javascript'>window.history.back();</script>"  
	end if 
end if%>
<script language="javascript">
//document.form1.dt.focus();
</script>
</body>
</html>
