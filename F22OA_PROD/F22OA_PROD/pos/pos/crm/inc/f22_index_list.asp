<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%'��f22_index.asp����
if session("cn")="" or isnull(session("cn")) then
  session.Abandon()
  response.Write "<script language='javascript'>"
  response.Write "alert('�Բ���,�Ự�ѳ�ʱ,�������µ�¼!');"
  response.Write "window.top.location.href='/index.asp';"
  response.Write "</script>"
  response.End()
end if

DIM list(9,2)
dim Cfname,Cdname,Cuname,Dfname,Ddname,Duname
dim alta,altc,alte,altf,altd,ext,action
dim page,create,edit,del,copy,task,search,sure,unsure,chksure,unchksure,check,cPop,ePop,cont,report
  if trim(request("com"))<>"" then
    session("com")=request("com")
  else
    com=session("com")
  end if
select case session("com")
case "2005"  pagename=">> ҵ������ >> �������� >> ���ܲ�����"
  session("formid")=2005 '���ڱ��
  session("title")="��������" '�Ƶ������ʼ����
  
  session("PkSName")="indent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"

  'create="create_indent.asp"
  create="f22_dh.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont=""
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2006"  pagename=">> ҵ������ >> �������� >> ���ܲ�����"
  session("formid")=2006
  session("title")="�ǼǼ����̲�����"
  
  session("PkSName")="indent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=2 '�������ͺ�
  session("nums")="nums"

  create="create_indent.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont=""
  task="index.asp"
  search="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  report="report/"
  check="index.asp"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
			  
case "2010"  pagename=">> ҵ������ >> �������� >> �ջ�"
  session("formid")=2010
  session("title")="�ǼǼ������ջ������ܱ�"
  
  session("PkSName")="sell" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("nums")="get_nums"

  create=""
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont=""
  task="index.asp"
  search="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  report="report/"
  check="index.asp"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2050"  pagename=">> ҵ������ >> ���˹��� >> ��������"
  session("formid")=2050 
  session("title")="�ǼǼ����̶�����"
  
  session("PkSName")="indent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"

  create="create_indent_jm.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont=""
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  report="report/"
  unchksure="index.asp"
  check="index.asp"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2051"  pagename=">> ҵ������ >> ���˹��� >> ��������"
  session("formid")=2051
  session("title")="�ǼǼ����̲�����"
  
  session("PkSName")="indent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=2 '�������ͺ�
  session("nums")="nums"

  create="create_indent_jm.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont=""
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2052"  pagename=">> ҵ������ >> ���˹��� >> �������"
  session("formid")=2052
  
  session("PkSName")="quota" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"

  create="create_quota.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont="f22cz_indent.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:450px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2053"  pagename=">> ҵ������ >> ���˹��� >> ��������"
  session("formid")=2053
  session("title")="�����̷�����"
  
  session("PkSName")="sell" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"

  create="create_sell.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  cont="f22cz_quota.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:450px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2054"  pagename=">> ҵ������ >> ���˹��� >> �ջ�����"
  session("formid")=2054
  session("title")="��ѯ�������ջ������ܱ�"
  
  session("PkSName")="sell" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="get_nums"

  create="create_sell.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:480px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2055"  pagename=">> ҵ������ >> ���˹��� >> �����˻�"
  session("formid")=2055
  session("title")="�������˻�������"
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"SETsub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("nums")="nums"

  create="create_outindent.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:300px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2056"  pagename=">> ҵ������ >> ���˹��� >> �˻��ջ�"
  session("formid")=2056
  session("title")="�������˻��ջ���"
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("nums")="nums"

  create="create_outindent.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:300px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
case "2017"  pagename=">> ҵ������ >> ���̹��� >> ��������"
  session("formid")=2017
  session("title")="���̵��η�����"
   
  session("PkSName")="move" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="set_nums"
  
  create="create_move.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2018"  pagename=">> ҵ������ >> ���̹��� >> �����ջ�"
  session("formid")=2018
  session("title")="�����ջ���"
  
  session("PkSName")="move" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="get_nums"

  create="create_move.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:400px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2019"  pagename=">> ҵ������ >> ���̹��� >> ��������"
  session("formid")=2019
  session("title")="��ά¼��������۵�"
  
  session("PkSName")="retail" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"

  create="create_retail.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:330px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:330px;center: yes;help:no;resizable:yes;status:no'"
  
case "2020"  pagename=">> ҵ������ >> ���̹��� >> �����̵�"
  session("formid")=2020
  session("title")="��Ӫ�ֵ��̵㵥"
  
  session("PkSName")="inventory" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"

  create="create_inventory.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:280px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
  
case "2011"  pagename=">> ҵ������ >> �˻������� >> ������������"
  session("formid")=2011
  session("title")="���ܲ��ύ�����˻����뵥"
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"PROsub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 'backrate������ʶ
  session("nums")="nums"

  create="create_outindent_zb.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:290px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
case "2012"  pagename=">> ҵ������ >> �˻������� >> ���⻻������"
  session("formid")=2012
  session("title")="���ܲ��ύ�����˻����뵥"
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"PROsub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=0 'backrate�����ʶ
  session("nums")="nums"

  create="create_outindent_zb.asp"
  edit="index.asp"
  del="index.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:290px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
case "2014"  pagename=">> ҵ������ >> �˻������� >> ������"
  session("formid")=2014
  session("title")="���ܲ����˻�������"
  session("pedit")="create_outindent.asp" '�༭����ҳ��
  session("plist")="f22_d_indent_list.asp" '�������ҳ��
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"SETsub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=0 '�������ͺ�
  session("nums")="set_nums"

  create="create_outindent_zb.asp"
  edit="index.asp"
  del="index.asp"
  cont="f22cz_outindentset.asp"
  copy="index.asp"
  search="index.asp"
  task="index.asp"
  sure="index.asp"
  unsure="index.asp"
  chksure="index.asp"
  unchksure="index.asp"
  check="index.asp"
  report="report/"
  cPop="'e','dialogWidth:500px;dialogHeight:320px;center: yes;help:no;resizable:yes;status:no'"
  ePop="'e','dialogWidth:700px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no'"
end select%>
<%
dim ds,i,menusubid,cn
cn=session("cn")
menusubid=session("menusubid")
set ds=server.CreateObject("ADODB.Recordset")
ds.Activeconnection =cn
ds.source = "select * from web_menusubsub where menusubid="&menusubid&" and enable=1 order by sort asc"
ds.open
i=0
while not ds.eof
  list(i,0)=ds("msname")
  list(i,1)=replace(ds("intra"),vbcrlf,"<br>")
  list(i,2)=ds("com")
  i=i+1
  ds.movenext
wend
ds.close
set ds=nothing
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
function com(action,ispop,ext){
  if(ispop==true)
    switch(action){
	case "create":
	  showModalDialog("<%=create%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "edit":
	  showModalDialog("<%=edit%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "task":
	  showModalDialog("<%=task%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "copy":
	  showModalDialog("<%=copy%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
    case "cont":
	  showModalDialog("<%=cont%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "del":
	  showModalDialog("<%=del%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "search":
	  showModalDialog("<%=search%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "chksure":
	  showModalDialog("<%=chksure%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "unchksure":
	  showModalDialog("<%=unchksure%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "sure":
	  showModalDialog("<%=sure%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "unsure":
	  showModalDialog("<%=unsure%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "check": //ȷ��
	  showModalDialog("<%=check%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	case "report":
	  showModalDialog("<%=report%>?action="+action+"&ext="+ext,<%=cPop%>);
	  break;
	default:
	  alert("û��Ϊ���ؽӿڵ�Action��������!");
    }
  else
    switch(action){
	case "create":
	  window.location.href="<%=create%>?action="+action+"&ext="+ext;
	  break;
	case "edit":
	  window.location.href="<%=edit%>?action="+action+"&ext="+ext;
	  break;
	case "task":
	  window.location.href="<%=task%>?action="+action+"&ext="+ext;
	  break;
	case "copy":
	  window.location.href="<%=copy%>?action="+action+"&ext="+ext;
	  break;
    case "cont":
	  window.location.href="<%=cont%>?action="+action+"&ext="+ext;
	  break;
	case "del":
	  window.location.href="<%=del%>?action="+action+"&ext="+ext;
	  break;
	case "search":
	  window.location.href="<%=search%>?action="+action+"&ext="+ext;
	  break;
	case "chksure":
	  window.location.href="<%=chksure%>?action="+action+"&ext="+ext;
	  break;
	case "sure":
	  window.location.href="<%=sure%>?action="+action+"&ext="+ext;
	  break;
	case "check": //ȷ��
	  window.location.href="<%=check%>?action="+action+"&ext="+ext;
	  break;
	case "report":
	  //window.parent.midFrame.oa_tool();
	  window.location.href="<%=report%>?action="+action+"&ext="+ext;
	  break;
	default:
	  alert("û��Ϊ���ؽӿڵ�Action��������!");
    }
}
</script>