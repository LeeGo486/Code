<%@ page language="C#" autoeventwireup="true" inherits="isprit_member_onlineusers, App_Web_onlineusers.aspx.be6dd291" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>onlineUsers</title>
		<META http-equiv="Content-Type" content="text/html; charset=gb2312">
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="JavaScript" type="text/javascript">
function killErrors()
{
  return true;
}
window.onerror = killErrors;
function clickMenu(ID)
{   
    targetelement=document.all(ID);
    if (targetelement.style.display=="none")
        targetelement.style.display='';
    else
        targetelement.style.display="none";
}
		</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <!--����-->
			<asp:datalist id="dgmain" runat="server" DataKeyField="departid" OnItemDataBound="dgmain_databound"
				Width="100%">
				<ItemTemplate>
					<TR style="CURSOR: hand">
							<TD onclick="clickMenu('<%# DataBinder.Eval(Container, "DataItem.departid") %>')" align=center width="100%" colspan="2" height="24"  background=../../icon/title1.jpg><b><FONT color="#4E4C47">
										<%# DataBinder.Eval(Container, "DataItem.department") %>
									</FONT></b>
							</TD>
							
						</TR>
						<TR>
							<TD colSpan="2">
								<!--��Ա�б�--><div id='<%# DataBinder.Eval(Container, "DataItem.departid") %>'>
								<asp:DataList id="dgsub" runat="server" Width=100%>
															
									<AlternatingItemStyle BackColor="#eeeff5"></AlternatingItemStyle>
									<ItemTemplate>
											<table width=100%>
											<TR>
												<TD width=70 bordercolor=AliceBlue><a target="main" href='showuser.aspx?userid=<%# DataBinder.Eval(Container, "DataItem.id") %>'><%# DataBinder.Eval(Container, "DataItem.username") %></a></TD>
												<TD align=center>
													<a target="main" href='../msg/msg_send.aspx?touserid=<%# DataBinder.Eval(Container, "DataItem.id") %>,&tousername=<%# DataBinder.Eval(Container, "DataItem.username") %>,'><img src="../../icon/sms.gif" style="border:0" title="���Ͷ���" /></a>
													<a target="main" href='../mail/mail_write.aspx?touserid=<%# DataBinder.Eval(Container, "DataItem.id") %>,&tousername=<%# DataBinder.Eval(Container, "DataItem.username") %>,'><img src="../../icon/email_new.gif" style="border:0" title="�����ʼ�" /></a>
												</TD>
											</TR>
										</table>
									</ItemTemplate>
								</asp:DataList>
								<!--end--></div>
							</TD>
						</TR>
				</ItemTemplate>
			</asp:datalist>
			<!--end-->
    </div>
    </form>
</body>
</html>
