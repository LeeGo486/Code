<%@ page language="C#" autoeventwireup="true" inherits="isprit_msg_msg_send, App_Web_msg_send.aspx.2dde435b" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>msg_send</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="../../css/project.css" type="text/css" rel="stylesheet"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
        <script defer="defer" type="text/javascript">
	        justNew(location.href,"������Ϣ");
        </script>
		<script language="JavaScript">

    //�����Ƿ���δ���
    function CheckForm(){
        if (document.forms[0].TO_ID.value==""&&!document.forms[0].CheckBox1.checked){
            alert("������ռ��ˣ�");
            return false;
         
        }else if (document.form1.tbmsg.value==""){
            alert("����д��Ϣ��");
            return false;
         
        }
      }
    //����û�
    function clear_user()
    {
      document.all.TO_NAME.value="";
      document.all.TO_ID.value="";
     }
    //������ϵ�˴���
    function calluser(){
        var east = parent.Ext.getCmp('east');
		if(east){
			if(east.collapsed){
				east.expand(false);//չ����ϵ�ˣ������false��Ҫ��Ҫ����Ч������˼
			}else{
				east.collapse(false);
			}
		}
    }
		</script>
    <style type="text/css">
        .style1
        {
            width: 51px;
            height: 70px;
        }
        .style2
        {
            width: 371px;
            height: 70px;
        }
        </style>
</head>
<body topmargin="5" leftmargin="0" bgcolor="mintcream">
    <form id="form1" runat="server">
    <div id="lrTable">
    <table border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#cccccc" 
            style="WIDTH: 514px; HEIGHT: 251px">
				<thead>
					<tr>
						<td align="left" bgcolor="#e9fefe" colspan="2"><FONT face="����">
								<asp:Image id="Image1" runat="server" ImageUrl="../../icon/write.gif"></asp:Image></FONT>
                            ���Ͷ���Ϣ
					</tr>
				</thead>
				<tr>
					<TD bgcolor="#e9fefe" class="style1"><FONT face="����">�ռ���:</FONT></TD>
					<TD bgcolor="#f0fede" class="style2">
                        <textarea class="BigStatic" id="TO_NAME" 
                            style="WIDTH: 380px; HEIGHT: 70px; BACKGROUND-COLOR: #eee;" readOnly 
                            wrap="soft" runat="server" NAME="TO_NAME"></textarea>
						<INPUT id="TO_ID" type="hidden" runat="server" NAME="TO_ID"></TD>
				</tr>
				<tr>
					<td bgcolor="#e9fefe" style="WIDTH: 51px">&nbsp;</td>
					<td bgcolor="#f0fede">
						<FONT face="����">
								<INPUT type="button" onclick="calluser()" value="ѡ����ϵ��(A)"
								class="btn"  accessKey="A">
								<input type="button" value="�� ��(C)" class="btn" onClick="clear_user()" title="����ռ���" name="button"
								 accessKey="c">
								 <asp:CheckBox ID="CheckBox1" runat="server" Text="������ϵ��" />
                        </FONT>
					</td>
				</tr>
				<tr>
					<td bgcolor="#e9fefe" style="WIDTH: 51px"><FONT face="����">����Ϣ:</FONT></td>
					<td bgcolor="#f0fede" style="WIDTH: 371px">
						<asp:TextBox id="tbmsg" runat="server" Width="380px" MaxLength="255" 
                            TextMode="MultiLine" ToolTip="ֻ������255���ַ�"
							Height="96px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td bgcolor="#e9fefe" style="WIDTH: 51px">&nbsp;</td>
					<td bgcolor="#f0fede" style="WIDTH: 371px">
					
					<asp:Button id="btsend" runat="server" Text="�� ��(S)" CssClass="btn" accessKey="s" OnClick="btsend_Click"></asp:Button>
					<input class="btn" type="button" value="�� ��(C)" onclick="javascript:closeTab(0);" id="button2"  />
					</td>
				</tr>
			</table>
    </div>
    <script type="text/javascript">
    	jsTable('lrTable','lr','96%','120','center');
    </script>
    </form>
</body>
</html>
