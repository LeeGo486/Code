<%@ page language="C#" autoeventwireup="true" inherits="isprit_msg_msgdetail, App_Web_msgdetail.aspx.2dde435b" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>消息内容</title>
		
		<LINK href="../../css/project.css"  type="text/css" rel="stylesheet" />
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
        <script type="text/javascript">
        	function checkForm(){
			var tbreply = document.getElementById("tbreply");
				if(tbreply.value.length<=0){
					alert("请填写回复内容");
					tbreply.focus();
					return false;
				}
				return true;
			}
        </script>
</head>
<body leftMargin="0" topMargin="5">
    <form id="form1" runat="server">
    <div id="lrTable">
   <table id="table1" style="width: 382px; height: 215px" cellspacing="1" cellpadding="1"
				align="center" bgColor="#336600" border="0">
				<TR>
					<TD class="tdright" width="100"><asp:label id="lb" runat="server"></asp:label></TD>
					<TD class="tdwhite" style="HEIGHT: 19px"><asp:label id="lbto" runat="server" ForeColor="Blue"></asp:label><asp:label id="lbuserid" runat="server" ForeColor="White"></asp:label></TD>
				</TR>
				<TR>
					<TD class="tdright">发送时间：</TD>
					<TD class="tdwhite" style="HEIGHT: 21px"><asp:label id="lbdate" runat="server" ForeColor="Green"></asp:label></TD>
				</TR>
				<TR>
					<TD class="tdright" style="HEIGHT: 100px">信息内容：</TD>
					<TD class="tdwhite"><p><asp:label id="lbmsg" runat="server"></asp:label></p></TD>
				</TR>
				<tr>
					<td class="tdright">
						<asp:Label id="lbt" runat="server">回复内容：</asp:Label></td>
					<td class="tdwhite"><asp:textbox cname="回复内容" nullable="n" id="tbreply" runat="server" TextMode="MultiLine" Height="104px" Width="80%"></asp:textbox></td>
				</tr>
				<TR>
					<TD class="footer" height="30" align="center" colSpan="2">
						<asp:button id="btreply" runat="server" CssClass="btn" Text="回复(S)" accessKey="s" OnClick="btreply_Click"></asp:button>&nbsp;
                        <input type="button" value="关闭(C)" accesskey="c" class="btn" onclick="javascript:closeTab(0);" /></TD>
				</TR>
			</TABLE>
    </div>
    <script type="text/javascript">
    	jsTable('lrTable','lr','90%','120','center')
    </script>
    </form>
</body>
</html>
