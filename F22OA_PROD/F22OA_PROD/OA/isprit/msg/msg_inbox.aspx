<%@ page language="C#" autoeventwireup="true" inherits="isprit_msg_msg_inbox, App_Web_msg_inbox.aspx.2dde435b" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>msg_inbox</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" src="../../js/project.js"></script>
		<script type="text/javascript">

    function SelectAll (chkVal, idVal) { 

       var thisfrm = document.forms[0];

           // 查找Forms里面所有的元素

           for (i=0; i<thisfrm.length; i++) {

              // 查找模板头中的CheckBox

              if (idVal.indexOf ('chkAll') != -1) {

                  if(chkVal == true) {

                     thisfrm.elements[i].checked = true;

                  } 

                  else {

                      thisfrm.elements[i].checked = false;

                  }

               } // if

               // 如果除题头以外的项没有全选上则取消题头的选择

              else if (idVal.indexOf ('chkDelete') != -1) {

                  if(thisfrm.elements[i].checked == false) {

                     thisfrm.elements[1].checked = false; 

                  }

               }

           } // for

        }
//==============================================================================
 function SelectAll1 (chkVal, idVal) { 

       var thisfrm = document.forms[0];

           // 查找Forms里面所有的元素

           for (i=0; i<thisfrm.length; i++) {

              // 查找模板头中的CheckBox

              if (idVal.indexOf ('chkAll1') != -1) {

                  if(chkVal == true) {

                     thisfrm.elements[i].checked = true;

                  } 

                  else {

                      thisfrm.elements[i].checked = false;

                  }

               } // if

               // 如果除题头以外的项没有全选上则取消题头的选择

              else if (idVal.indexOf ('chkDelete') != -1) {

                  if(thisfrm.elements[i].checked == false) {

                     thisfrm.elements[1].checked = false; 

                  }

               }

           } // for

        }
        
        //inbox
        function inbox(){
        
        
			window.open("box.aspx?box=1","","target=_self")
        }
        //outbox
        function outbox(){
        
        
			window.open("box.aspx?box=2","","target=_self")
        }
		</script>
</head>
<body topmargin="5" leftmargin="0" bgcolor="ghostwhite">
    <form id="form1" runat="server">
    <div>
    <TABLE id="Table1" cellSpacing="1" cellPadding="1" align="center" border="0" width="100%">
				<TR>
					<TD><FONT color="#996633">
							<asp:image id="Image3" runat="server" ImageUrl="../../icon/email.gif"></asp:image>&nbsp;短信息收件箱<A href="msg_outbox.aspx">[短信发件箱]</A></FONT></TD>
				</TR>
				<TR>
					<TD>
						<webdiyer:AspNetpager id="ap" runat="server" ShowInputBox="Always" SubmitButtonText="转到" PageSize="15" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
					</TD>
				</TR>
				<TR>
					<TD vAlign="top"><asp:datagrid id="dgbox" runat="server" ForeColor="#333333" GridLines="None"  CssClass="tbGrid"  CellSpacing="1" 
							Width="100%" AutoGenerateColumns="False" ShowFooter="True" CellPadding="3" OnItemCommand="dgbox_ItemCommand" OnItemCreated="dgbox_ItemCreated">
							<FooterStyle BackColor="#5D7B9D" Font-Bold="True" CssClass="dgHeader"></FooterStyle>
							<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#E2DED6"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White" ForeColor="#284775"></AlternatingItemStyle>
							<ItemStyle BackColor="#F7F6F3" ForeColor="#333333"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center" CssClass="dgHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
									<HeaderTemplate>
										<asp:CheckBox id="chkAll1" runat="server" BorderColor="Silver" BorderWidth="0px" Text="全选"></asp:CheckBox>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="cb" runat="server" BorderColor="Silver" BorderWidth="0px"></asp:CheckBox>
									</ItemTemplate>
									<FooterTemplate>
										<asp:CheckBox id="chkAll" runat="server" BorderColor="Silver" BorderWidth="0px" Text="全选"></asp:CheckBox>
									</FooterTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="ID">
									<HeaderStyle Width="50px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Left"></ItemStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.msgid") %>' ID="Label2" NAME="Label2">
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="短信内容">
									<ItemStyle HorizontalAlign="Left"></ItemStyle>
									<ItemTemplate>
                                    <A  href='msgdetail.aspx?msgid=<%# Eval("msgid") %>&remind=false&box=inbox' onclick="javascript:return showMsg(this);">
									<%# Eval("message") %><asp:Image ID="imgnew" Runat="server" ImageUrl="../icon/email_new.gif" Visible='<%# Eval("remind") %>' />
                                    </A>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="发送者">
									<HeaderStyle Width="60px"></HeaderStyle>
									<ItemTemplate>
										<a href='../member/showuser.aspx?userid=<%# DataBinder.Eval(Container, "DataItem.id") %>'>
											<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.username") %>'>
											</asp:Label></a>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="发送时间">
									<HeaderStyle Width="80px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.crdate", "{0:M-d HH:mm}") %>' ID="Label21" NAME="Label21">
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Center" Width="30px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<HeaderTemplate>
										删除
									</HeaderTemplate>
									<ItemTemplate>
										<asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../icon/delete.gif" CommandName="delete"></asp:ImageButton>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Center" ForeColor="White" Position="TopAndBottom" BackColor="#284775"></pagerStyle>
                        <EditItemStyle BackColor="#999999" />
						</asp:datagrid></TD>
				</TR>
				<TR>
					<TD><FONT face="宋体">
							<asp:button id="btOK" accessKey="d" runat="server" Width="160px" CssClass="btr" Text="删除选定的记录(D)" OnClick="btOK_Click"></asp:button></FONT></TD>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
