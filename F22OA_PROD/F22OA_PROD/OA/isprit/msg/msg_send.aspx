<%@ page language="C#" autoeventwireup="true" inherits="isprit_msg_msg_send, App_Web_msg_send.aspx.2dde435b" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>msg_send</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="../../css/project.css" type="text/css" rel="stylesheet"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
        <script defer="defer" type="text/javascript">
	        justNew(location.href,"发送信息");
        </script>
		<script language="JavaScript">

    //检查表单是否有未填项　
    function CheckForm(){
        if (document.forms[0].TO_ID.value==""&&!document.forms[0].CheckBox1.checked){
            alert("请添加收件人！");
            return false;
         
        }else if (document.form1.tbmsg.value==""){
            alert("请填写消息！");
            return false;
         
        }
      }
    //清除用户
    function clear_user()
    {
      document.all.TO_NAME.value="";
      document.all.TO_ID.value="";
     }
    //调用联系人窗口
    function calluser(){
        var east = parent.Ext.getCmp('east');
		if(east){
			if(east.collapsed){
				east.expand(false);//展开联系人：里面的false是要不要动画效果的意思
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
						<td align="left" bgcolor="#e9fefe" colspan="2"><FONT face="宋体">
								<asp:Image id="Image1" runat="server" ImageUrl="../../icon/write.gif"></asp:Image></FONT>
                            发送短信息
					</tr>
				</thead>
				<tr>
					<TD bgcolor="#e9fefe" class="style1"><FONT face="宋体">收件人:</FONT></TD>
					<TD bgcolor="#f0fede" class="style2">
                        <textarea class="BigStatic" id="TO_NAME" 
                            style="WIDTH: 380px; HEIGHT: 70px; BACKGROUND-COLOR: #eee;" readOnly 
                            wrap="soft" runat="server" NAME="TO_NAME"></textarea>
						<INPUT id="TO_ID" type="hidden" runat="server" NAME="TO_ID"></TD>
				</tr>
				<tr>
					<td bgcolor="#e9fefe" style="WIDTH: 51px">&nbsp;</td>
					<td bgcolor="#f0fede">
						<FONT face="宋体">
								<INPUT type="button" onclick="calluser()" value="选择联系人(A)"
								class="btn"  accessKey="A">
								<input type="button" value="清 空(C)" class="btn" onClick="clear_user()" title="清空收件人" name="button"
								 accessKey="c">
								 <asp:CheckBox ID="CheckBox1" runat="server" Text="所有联系人" />
                        </FONT>
					</td>
				</tr>
				<tr>
					<td bgcolor="#e9fefe" style="WIDTH: 51px"><FONT face="宋体">短消息:</FONT></td>
					<td bgcolor="#f0fede" style="WIDTH: 371px">
						<asp:TextBox id="tbmsg" runat="server" Width="380px" MaxLength="255" 
                            TextMode="MultiLine" ToolTip="只能输入255个字符"
							Height="96px"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td bgcolor="#e9fefe" style="WIDTH: 51px">&nbsp;</td>
					<td bgcolor="#f0fede" style="WIDTH: 371px">
					
					<asp:Button id="btsend" runat="server" Text="发 送(S)" CssClass="btn" accessKey="s" OnClick="btsend_Click"></asp:Button>
					<input class="btn" type="button" value="关 闭(C)" onclick="javascript:closeTab(0);" id="button2"  />
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
