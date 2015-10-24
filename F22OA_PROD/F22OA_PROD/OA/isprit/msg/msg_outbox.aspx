<%@ page language="C#" autoeventwireup="true" inherits="isprit_msg_msg_outbox, App_Web_msg_outbox.aspx.2dde435b" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>msg_outbox</title>
		<link href="../../css/project.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="../../js/project.js"></script>
		<script language="javascript" type="text/javascript">


        
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
<body  topmargin="5" leftmargin="0" bgcolor="whitesmoke">
    <form id="form1" runat="server">
    <div>
    <table id="table1" cellSpacing="1" cellPadding="1" align="center" border="0" width="100%">
				<tr>
					<td><FONT face="宋体" color="#336699">&nbsp;
							<asp:image id="Image4" runat="server" ImageUrl="../../icon/inbox.gif"></asp:image>短信息发件箱<a href="msg_inbox.aspx">[短信收件箱]</a></FONT></td>
				</tr>
				<tr>
					<td>
						<webdiyer:AspNetpager id="ap" runat="server" ShowInputBox="Always" SubmitButtonText="转到"  PageSize="15" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
					</td>
				</tr>
				<tr>
					<td vAlign="top"><asp:datagrid id="dgbox" runat="server" ForeColor="#333333" GridLines="None"
							ToolTip="点击标题,查看明细" CssClass="tbGrid"  CellSpacing="1"  Width="100%" AutoGenerateColumns="False" ShowFooter="true" CellPadding="3" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated">
							<FooterStyle CssClass="dgHeader" Font-Bold="True"></FooterStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
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
                    <A  href='msgdetail.aspx?msgid=<%# Eval("msgid") %>&box=outbox' onclick="javascript:return showMsg(this);"><%# Eval("message") %></A>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="接收者">
									<HeaderStyle Width="60px"></HeaderStyle>
									<ItemTemplate>
										<a href='../member/showuser.aspx?userid=<%# DataBinder.Eval(Container, "DataItem.id") %>'>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.username") %>' ID="Label1">
											</asp:Label></a>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="接收者已阅">
									<HeaderStyle Width="80px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# r(Convert.ToBoolean( Eval("remind"))) %>' ID="Label4" NAME="Label4">
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="发送时间">
									<HeaderStyle Width="70px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.crdate", "{0:M-d HH:mm}") %>' ID="Label3" NAME="Label1">
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Center" Width="80px"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<HeaderTemplate>
										删除
									</HeaderTemplate>
									<ItemTemplate>
										<asp:ImageButton id="IbDel" runat="server" ToolTip="删除?" ImageUrl="../icon/delete.gif" CommandName="delete"></asp:ImageButton>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Center" ForeColor="White" Position="TopAndBottom" BackColor="#2461BF"></pagerStyle>
                        <EditItemStyle BackColor="#2461BF" />
                        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
						</asp:datagrid></td>
				</tr>
				<tr>
					<td><FONT face="宋体">
							<asp:button id="btOK" accessKey="d" runat="server" Width="160px" CssClass="btr" Text="删除选定的记录(D)" OnClick="btOK_Click"></asp:button></FONT></td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
