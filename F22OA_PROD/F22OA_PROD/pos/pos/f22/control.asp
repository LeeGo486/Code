<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%'��������,����������,����ÿ�����ݵ������ý���,���浥�ݵ�ȫ����Ϣ.
dim com,title,comarr(20,1),ca,formid
com=trim(request.querystring("com"))
menusubid=trim(request.QueryString("msid"))
session("com")=com
session("menusubid")=menusubid
select case com
case "1-1-1","2005":'����->����
  session("formid")=2005 '���ڱ��
  session("title")="��������" '�Ƶ������ʼ����
  
  session("PkSName")="indent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"
case "1-1-2","2006":'����->����
  session("formid")=2006
  session("title")="�ǼǼ����̲�����"
  
  session("PkSName")="indent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=2 '�������ͺ�
  session("nums")="nums"
case "1-1-3","2010":'����->�ջ�
  session("formid")=2010
  session("title")="�ǼǼ������ջ������ܱ�"
  
  session("PkSName")="sell" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("nums")="get_nums"
case "2-1-1","2050":'����->����->����
  session("formid")=2050 
  session("title")="�ǼǼ����̶�����"
  
  session("PkSName")="indent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"
case "2-1-2","2051":'����->����
  session("formid")=2051
  session("title")="�ǼǼ����̲�����"
  
  session("PkSName")="indent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=2 '�������ͺ�
  session("nums")="nums"
case "2-1-3","2052":'����->���
  session("formid")=2052
  
  session("PkSName")="quota" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"
case "2-1-4","2053":'����->����
  session("formid")=2053
  session("title")="�����̷�����"
  
  session("PkSName")="sell" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"
case "2-1-5","2054":'����->�ջ�
  session("formid")=2054
  session("title")="��ѯ�������ջ������ܱ�"
  
  session("PkSName")="sell" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="get_nums"
case "2-2-1","2055":'����->�˻�->�˻�����
  session("formid")=2055
  session("title")="�������˻�������"
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"SETsub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("nums")="nums"
case "2-2-2","2056":'�˻�->�˻����
  session("formid")=2056
  session("title")="�������˻��ջ���"
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("nums")="nums"
'case "2-3-1":'����->����->����
'  tt="�����̵��̵��η�����"
'case "2-3-2":'����->�ջ�
'  tt="�����̵��̵����ջ���"
'case "2-3-3":'����->����
'  tt="���˵������۵�"
'case "2-3-4":'����->�̵�
'  tt="���˲ֵ��̵㵥"
'************************************************************************8
'case "3-1-1":'ֱӪ->����->����
'  tt="�Ǽǵ��̶�����"
'case "3-1-2":'����->����
'  tt="�Ǽǵ��̲�����"
'case "3-1-3":'����->���
'  tt="����Ӫ�������"
'case "3-1-4":'����->����
'  tt="���̷�����"
'case "3-1-5":'����->�ջ�
'  tt="�����ջ���"
case "3-2-1","2017":'����->����'*******************************************************
  session("formid")=2017
  session("title")="���̵��η�����"
   
  session("PkSName")="move" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="set_nums"
case "3-2-2","2018":'����->�ջ�
  session("formid")=2018
  session("title")="�����ջ���"
  
  session("PkSName")="move" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="get_nums"
case "3-2-3","2019":'����->����
  session("formid")=2019
  session("title")="��ά¼��������۵�"
  
  session("PkSName")="retail" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"
case "3-2-4","2020":'����->�̵�
  session("formid")=2020
  session("title")="��Ӫ�ֵ��̵㵥"
  
  session("PkSName")="inventory" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"
case "4-1-1","":'����->�տ�
  tt="¼���տ�ƾ֤"
  comarr(0,0)="¼���տ�ƾ֤"
  comarr(0,1)="move3.asp"
  ca=0
  comarr(1,1)="f22_cw.asp?d="
  session("tablename")="d_Inventory"
  session("tablesub")="d_Inventorysub"
  session("PkName")="Inventoryid"
  session("PkSName")="Inventory"
  session("SPName")="f22_lr"& session("PkSName") &"sub"
  session("nums")="nums"
case "5-1-1","2011":'�˻�->�����˻�����***************************************88
  session("formid")=2011
  session("title")="���ܲ��ύ�����˻����뵥"
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"PROsub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 'backrate������ʶ
  session("nums")="nums"
case "5-1-2","2012":'�����˻�����
  session("formid")=2012
  session("title")="���ܲ��ύ�����˻����뵥"
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"PROsub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=0 'backrate�����ʶ
  session("nums")="nums"
case "5-1-3","2013"'�˻����
  session("formid")=2013
  session("title")="�˻�������"
  session("pedit")="create_outindent.asp" '�༭����ҳ��
  session("plist")="f22_d_indent_list.asp" '�������ҳ��
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"CHKsub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=0 '�������ͺ�
  session("nums")="nums"
case "5-1-4","2014" '�˻�������
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
case "5-1-5","2015" '�˻��ջ���
  session("formid")=2015
  session("title")="���ܲ����˻�������"
  session("pedit")="create_outindent.asp" '�༭����ҳ��
  session("plist")="f22_d_indent_list.asp" '�������ҳ��
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=0 '�������ͺ�
  session("nums")="get_nums"
  
case "2060"
  session("formid")=2060 
  session("title")="POS������"
  
  session("PkSName")="indent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"
case "2061"
  session("formid")=2061
  session("title")="�ǼǼ����̲�����"
  
  session("PkSName")="indent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=2 '�������ͺ�
  session("nums")="nums"
case "2062"
  session("formid")=2062
  
  session("PkSName")="move" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="get_nums"
case "2063"
  session("formid")=2063
  session("title")="���ܲ��ύ�����˻����뵥"
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"PROsub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 'backrate������ʶ
  session("nums")="nums"
case "2064"
  session("formid")=2064
  session("title")="���ܲ��ύ�����˻����뵥"
  
  session("PkSName")="outindent" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"PROsub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=0 'backrate������ʶ
  session("nums")="nums"
case "2065"
case "2066"
  session("formid")=2066
  session("title")="��Ӫ�ֵ��̵㵥"
  
  session("PkSName")="inventory" '����
  session("PkName")=session("PkSName")&"id" '������
  session("tablename")="d_"&session("PkSName") '����
  session("tablesub")=session("tablename")&"sub" '�ӱ���
  session("SPName")="f22_lr"& session("PkSName") &"sub" '�õ��Ĵ洢������
  session("d_type")=1 '�������ͺ�
  session("nums")="nums"
end select
%>