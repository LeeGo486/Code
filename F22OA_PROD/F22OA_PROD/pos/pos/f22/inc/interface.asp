<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%'���ܽӿ�,�ɰ���,��ֱ���ύ
'������ʵ���Լ��ύ���Լ�
dim com,ispop,ext,action
dim Cfname,Cdname,Cuname,Dfname,Ddname,Duname
dim create,eidt,del,copy
'���ղ���
  com=trim(request("com"))
  action=trim(request("action"))
  ispop=trim(request("ispop"))
  ext=trim(request("ext"))
  if action<>"" then action=lcase(action)
  if lcase(ispop)="true" then
    ispop=true
  else
    ispop=false
  end if
select case com 'ÿ�ֵ���˵���ʱ�õ����ֶ���
case "1-1-1" '����->����d_indent

  Cfname="chk_sure" '��˵����ֶ���
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"

  select case action
  case "create"
  
  case "edit"
  
  case "del"
  
  case "copy"
  
  end select
  create="create_indent.asp?action=create','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  altc="showModalDialog('create_indent.asp?id='+id+'&action=copy','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_indent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_indent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
    
  button="<input type='button' name='Submit' value='�������ж������ɶ�����(C)' style='width:170px;' onClick='altc();' accesskey='c'>"
case "1-1-2" '����->����
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_indent.asp?action=create','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_indent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_indent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "1-1-3":'����->�ջ�d_sell
  Cfname="getchk_sure"
  Cdname="getchk_date"
  Cuname="getchk_name"
  Dfname="get_sure"
  Ddname="getsure_date"
  Duname="getsure_name"
  alta="1"
  alte="1"
  altf="1"
  altd="1"
case "2-1-1":'����->����->����
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_indent.asp?action=create','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_indent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_indent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "2-1-2":'����->����
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_indent.asp?action=create','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_indent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_indent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "2-1-3":'����->���d_quota
  Cfname="setchk_sure"
  Cdname="setchk_date"
  Cuname="setchk_name"
  Dfname="set_sure"
  Ddname="setsure_date"
  Duname="setsure_name"
  alta="showModalDialog('create_quota.asp?action=create','e','dialogWidth:500px;dialogHeight:480px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_quota.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:480px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_quota.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  
  ext="<input type='button' name='Submit' value='���ն�����(Q)' style='width:120px;' onClick='altq();' accesskey='q'>"
case "2-1-4":'����->����
  Cfname="setchk_sure"
  Cdname="setchk_date"
  Cuname="setchk_name"
  Dfname="set_sure"
  Ddname="setsure_date"
  Duname="setsure_name"
  alta="showModalDialog('create_sell.asp?action=create','e','dialogWidth:500px;dialogHeight:480px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_sell.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:480px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_sell.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
  
  ext="<input type='button' name='Submit' value='�������ɷ�����(I)' style='width:120px;' onClick='alti();' accesskey='i'>"
case "2-1-5":'����->�ջ�d_sell
  Cfname="getchk_sure"
  Cdname="getchk_date"
  Cuname="getchk_name"
  Dfname="get_sure"
  Ddname="getsure_date"
  Duname="getsure_name"
  alta="1"
  alte="1"
  altf="1"
  altd="1"
case "2-2-1":'����->�˻�->�˻�����d_outindent
 Cfname="chk_sure"
 Cdname="chk_date"
 Cuname="chk_name"
 Dfname="sure"
 Ddname="sure_date"
 Duname="sure_name"
case "2-2-2":'�˻�->�˻�����ջ��������
 Cfname="getchk_sure"
 Cdname="getchk_suredate"
 Cuname="getchk_name"
 Dfname="get_sure"
 Ddname="getsure_date"
 Duname="getsure_name"
 
case "3-2-1":'����->����->����
  Cfname="setchk_sure"
  Cdname="setchk_date"
  Cuname="setchk_name"
  Dfname="set_sure"
  Ddname="setsure_date"
  Duname="setsure_name"
  alta="showModalDialog('create_move.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_move.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_move.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "3-2-2":'����->�ջ�
  Cfname="getchk_sure"
  Cdname="getchk_date"
  Cuname="getchk_name"
  Dfname="get_sure"
  Ddname="getsure_date"
  Duname="getsure_name"
  alta="showModalDialog('create_move.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_move.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_move.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "3-2-3":'����->����'
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_retail.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_retail.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_retail.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "3-2-4":'����->�̵�
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_inventory.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_inventory.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_inventory.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "5-1-1" '�����˻�
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_outindent.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_outindent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_outindent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "5-1-2" '�����˻�
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_outindent.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_outindent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_outindent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "5-1-3" '�����˻�
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_outindent.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_outindent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_outindent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "5-1-4" '�����˻�
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_outindent.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_outindent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_outindent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "5-1-5" '�����˻�
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_outindent.asp?action=create','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_outindent.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_outindent.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"
case "2066":'����->�̵�
  Cfname="chk_sure"
  Cdname="chk_date"
  Cuname="chk_name"
  Dfname="sure"
  Ddname="sure_date"
  Duname="sure_name"
  alta="showModalDialog('create_inventory.asp?action=create','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  alte="showModalDialog('create_inventory.asp?id='+id+'&action=edit','e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no')"
  altf="showModalDialog('f22_main.asp?id='+id+'&pksname="&session("pksname")&"','e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no')"
  altd="showModalDialog('create_inventory.asp?id='+id+'&action=del','e','dialogWidth:1px;dialogHeight:1px;center: yes;help:no;resizable:yes;status:no')"

end select
%>
<script language="javascript">
/*ͳһͨ�ù��ܽӿ�
 *com:��������
 *act:����,��ʲô��,����������com����
 *ispop:�Ƿ񵯴�
 *ext:��չ����
 *����ԭ��
 *function com(com,action,ispop,ext)
 */
function com(){

  var com = arguments[0] || "<%=session("com")%>";
  var action = arguments[1] || "";
  var ispop = arguments[2] || 0;
  var ext = arguments[3] || "";

  switch(action){
  case 0://����µ�
    if(ispop==0){
	
	}else{
      var alta=<%=alta%>;
	}
    break;
  case 1://ͨ�ò�ѯ����
    if(ispop==0){
	  window.location.href="index.asp?com="+com+"&action="+action+"&ext="+ext;
	}else{
      var alta=<%=alta%>;
	}
    
    break;
  case 2://���������ѯ����
    ext="task";
    if(ispop==0){
	  window.location.href="index.asp?com="+com+"&action="+action+"&ext="+ext+"&stype=2";
	}else{
     showModalDialog("index.asp?com="+com+"&action="+action+"&ext="+ext+"&stype=2",'e','dialogWidth:500px;dialogHeight:425px;center: yes;help:no;resizable:yes;status:no');
	}
    break;
  case 3://�޸ĵ���
    
    break;
  case 4://����
  
    break;
  default:
    
  }
}
</script>