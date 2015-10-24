<%@ page language="C#" autoeventwireup="true" inherits="isprit_member_users, App_Web_users.aspx.be6dd291" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>users</title>
		
		
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
    <!--部门-->
						
				<asp:datalist id="dgmain" runat="server" DataKeyField="departid" OnItemDataBound="dgmain_databound" Width=100%>
					
					<ItemTemplate>
						<TR style="CURSOR: hand">
							<TD onclick="clickMenu('<%# DataBinder.Eval(Container, "DataItem.departid") %>')" align=center width="100%" colspan="2" height="24" background=../../icon/title1.jpg><b><FONT color="#4E4C47">
										<%# DataBinder.Eval(Container, "DataItem.department") %>
									</FONT></b>
							</TD>
							
						</TR>
						<TR>
							<TD colSpan="2">
								<!--人员列表--><div id='<%# DataBinder.Eval(Container, "DataItem.departid") %>'>
								<asp:DataList id="dgsub" runat="server" Width=100%>
															
									<AlternatingItemStyle BackColor="#eeeff5"></AlternatingItemStyle>
									<ItemTemplate>
											<table width=100%>
											<TR>
												<TD width=70 bordercolor=AliceBlue><a target="main" href='showuser.aspx?userid=<%# DataBinder.Eval(Container, "DataItem.id") %>'><%# DataBinder.Eval(Container, "DataItem.username") %></a></TD>
												<TD align=center>
													<a target="main" href='../msg/msg_send.aspx?touserid=<%# DataBinder.Eval(Container, "DataItem.id") %>,&tousername=<%# Server.UrlEncode(DataBinder.Eval(Container, "DataItem.username").ToString()) %>,'>短信</a>
													<a target="main" href='../mail/mail_write.aspx?touserid=<%# DataBinder.Eval(Container, "DataItem.id") %>,&tousername=<%# Server.UrlEncode(DataBinder.Eval(Container, "DataItem.username").ToString()) %>,'>邮件</a>
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
