<!--#include file="inc/function.asp"-->
<html><head>
<meta http-equiv='Content-Type' content='text/html; charset=gb2312'>
<link href='../skin/<%=session("skindir")%>/default.css' rel='stylesheet' type='text/css'>
<link rel="StyleSheet" href="dtree/dtree.css" type="text/css" />
<script type="text/javascript" src="dtree/dtree.js"></script>
<style type="text/css">
.tbhide{display:none;}
.tbshow{display:block;}
</style>
</head>

<body topmargin=1 leftmargin="0">
<%
'userid=session("dm").System_Userid
'if userid="" then response.write "<script>top.location.href='../../../relogin.aspx';< /script>"
'sql="f18master.dbo.F22D_GetMenuList '"&userid&"'"
'set rs=server.CreateObject("ADODB.Recordset")
'rs.open sql,cn,1,1

%>
<div class="dtree">
<script type="text/javascript">
		<!--
		d = new dTree('d');
		d.add(0,-1,' �˵��б� <a href="javascript: d.closeAll();" title="ȫ���ر�"><img src="img/nolines_plus.gif" border=0></a><a href="javascript: d.openAll();" title="ȫ��չ��"><img src="img/nolines_minus.gif" border="0"></a>');
		
		   d.add(1,0,'POSҵ�����','');
		   d.add(2,1,'����','../../../pos/pos/f22/pos_create_retail.asp?opt=2&msid=111','','main');
		   //d.add(3,1,'ά�޼�¼','../../../pos/pos/f22/product_posseach.asp','','main');
		   d.add(4,1,'����','../../../pos/pos/f22/2060_index.asp','','main');
		   d.add(5,1,'����','../../../pos/pos/f22/2061_index.asp','','main');
		   d.add(6,1,'�ջ�','../../../pos/pos/f22/2062_index.asp','','main');
		   d.add(7,1,'�˻�����','../../../pos/pos/f22/2063_index.asp','','main');
		   d.add(8,1,'�˻�����','../../../pos/pos/f22/2065_index.asp','','main');
		   d.add(9,1,'��������','../../../pos/pos/f22/2067_index.asp','','main');
		   d.add(10,1,'�����ջ�','../../../pos/pos/f22/2068_index.asp','','main');
		   d.add(11,1,'��������','../../../pos/pos/f22/2070_index.asp','','main');
		   d.add(12,1,'�̵�','../../../pos/pos/f22/2066_index.asp','','main');
		   //d.add(13,1,'�˻�����(��������)','../../../pos/pos/f22/2163_index.asp','','main');
		   //d.add(14,1,'�˻�����(��������)','../../../pos/pos/f22/2165_index.asp','','main');
		   d.add(15,0,'POSVIP����','');
		   d.add(16,15,'�����VIP�˿�����','../../../pos/pos/crm/vip_add.asp','','main');
		   d.add(17,15,'��VIP��','../../../pos/pos/crm/vip_sendcard.asp','','main');
		   d.add(18,15,'VIP�˿����ϲ�ѯ','../../../pos/pos/crm/vip_search.asp','','main');
		   d.add(19,15,'VIP�ͻ�����','../../../pos/pos/crm/vip_card.asp','','main');
		   d.add(20,0,'POS�������','');
		   d.add(21,20,'���۲�ѯ-��ϸ','../../../pos/pos/f22/report/f22qry_xs.asp?id=90&msid=119','','main');
		   d.add(22,20,'���۲�ѯ-����','../../../pos/pos/f22/report/f22qry_retail_style_seach.asp','','main');
		   d.add(23,20,'���۲�ѯ-������','../../../pos/pos/f22/report/f22qry_retail_date_seach.asp','','main');
		   d.add(24,20,'���۲�ѯ-���տʽ','../../../pos/pos/f22/report/f22qry_retail_skfs_seach.asp','','main');
		   d.add(25,20,'���۲�ѯ-������ۺ�','../../../pos/pos/f22/report/f22qry_retail_lb_seach.asp','','main');
		   d.add(26,20,'���۲�ѯ-��ӪҵԱ','../../../pos/pos/f22/report/tbFrame.asp?cid=3003&msid=121','','main');
		   d.add(27,20,'���۲�ѯ-�����','../../../pos/pos/f22/report/tbFrame.asp?cid=3018&msid=122','','main');
		   d.add(28,20,'���۵���ѯ','../../../pos/pos/f22/2019_index.asp','','main');
		   d.add(29,20,'������ѯ-����','../../../pos/pos/f22/report/f22qry_move_style_seach.asp','','main');
		   d.add(30,20,'�������ѯ','../../../pos/pos/f22/report/f22qry_stylekcsub.asp?act=2','','main');
		   d.add(31,20,'����ѯ-��ά','../../../pos/pos/f22/report/f22qry_kc2_seach.asp','','main');
		   d.add(32,20,'����ѯ-�����','../../../pos/pos/f22/report/f22qry_kclb_seach.asp','','main');
		   d.add(33,20,'�������̿���ѯ','../../../pos/pos/f22/report/f22qry_otherkcsub.asp?id=90&msid=134','','main');
		   d.add(34,20,'�����������۲�ѯ','../../../pos/pos/f22/report/f22qry_otherretail.asp','','main');
		   d.add(35,20,'�������ѯ','../../../pos/pos/f22/report/f22qry_kcjxc.asp?id=90&msid=134','','main');
		   d.add(36,20,'���ʵ���ѯ','../../../pos/pos/f22/report/f22qry_dzd.asp','','main');
		   d.add(37,20,'�ۺϵ�/��/�˻����ܱ���','../../../pos/pos/f22/report/f22qry_8901.asp','','main');
		   d.add(38,20,'�ۺ���/�������ܱ���','../../../pos/pos/f22/report/f22qry_8902.asp','','main');
		   d.add(39,20,'���۵��ۺϻ��ܱ���','../../../pos/pos/f22/report/f22qry_8900.asp','','main');
		   d.add(40,20,'��ʽ���ۼ۲�ѯ','../../../pos/pos/f22/report/f22qry_style_price.asp','','main');
		   //d.add(41,0,'POS�������','');
		   //d.add(42,41,'��Ʒ���е���','../../../pos/pos/f22/extend/dc_newlist.asp','','main');
		   //d.add(43,41,'����Ʒ�����۵���','../../../pos/pos/f22/extend/jz_xs.asp','','main');
		   //d.add(44,41,'����Ʒ�����е���','../../../pos/pos/f22/extend/jz_ss.asp','','main');
		   //d.add(45,41,'�Զ������','../../../pos/pos/f22/extend/dc_theme.asp','','main');
		   d.add(46,0,'POS���ù���','');
		   d.add(47,46,'���ð�μ�ӪҵԱ','../../../pos/pos/f22/pos_option.asp','','main');
		   d.add(48,46,'�޸�����','../../../pos/pos/f22/Pass_modify.asp','','main');
		   
		document.write(d);
		d.openAll();
		//-->
	</script>

	<!--<script type="text/javascript">
		d = new dTree('d');
		d.add(0,-1,' �˵��б� <a href="javascript: d.closeAll();" title="ȫ���ر�"><img src="img/nolines_plus.gif" border=0></a><a href="javascript: d.openAll();" title="ȫ��չ��"><img src="img/nolines_minus.gif" border="0"></a>');
		< %
		i=1
		if Not Rs.Eof then
		   powername=Rs("powername")
		end if
		While Not Rs.Eof
		   Url="../../../"&Rs("readme")
		if i=1 then%>
		   d.add(< %=i%>,0,'< %=Rs("powername")%>','');
		   d.add(< %=i+1%>,< %=i%>,'< %=Rs("menuname")%>','< %=Url%>','','main');
		< %j=i
		  i=i+2
		else
		if i>1 and powername<>Rs("powername") then%>
		   d.add(< %=i%>,0,'< %=Rs("powername")%>','');
		   d.add(< %=i+1%>,< %=i%>,'< %=Rs("menuname")%>','< %=Url%>','','main');
		< %j=i
		  i=i+2
		elseif i>1 then%>
		   d.add(< %=i%>,< %=j%>,'< %=Rs("menuname")%>','< %=Url%>','','main');
		   < %i=i+1
		end if
		end if
		powername=Rs("powername")
		Rs.MoveNext
		Wend%>
		document.write(d);
		d.openAll();
	< /s c ript >-->
</div>
</body>
</html>
<%'rs.close
'set rs=nothing%>