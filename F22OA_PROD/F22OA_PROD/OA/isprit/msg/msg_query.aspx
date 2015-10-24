<%@ page language="C#" autoeventwireup="true" inherits="isprit_msg_msg_query, App_Web_msg_query.aspx.2dde435b" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>短信查询</title>
    <LINK href="../../css/project.css" type="text/css" rel="stylesheet">
    <script>
        var mainPanel = top.Ext.getCmp("doc-body");
        
        var tt = mainPanel.getActiveTab().title;
        var nt = "短信查询";
        
        if(tt!=nt){
            var href = location.href;
           // mainPanel.remove("docs-"+tt);
            history.go(-1);
            mainPanel.loadClass(href,nt);
        }

    </script>
    <script language="javascript" src="../../js/project.js" type="text/javascript"></script>
    <script language="javascript" src="../../js/check.js" type="text/javascript"></script>
</head>
<body bgColor="mintcream" leftMargin="0" topMargin="5">
    <form id="form1" runat="server">
    <div>
    <div id="lrtable">
    <asp:panel id="pn1" runat="server" Height="216px">
				<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="458" align="center" bgColor="ghostwhite"
					border="0">
					<TR>
						<TD class="header" colSpan="3">短信查询</TD>
					</TR>
					<TR>
						<TD class="tdright" vAlign="top">
							<asp:RadioButtonList id="rd" runat="server" Width="88px">
								<asp:ListItem Value="0" Selected="True">全部短信</asp:ListItem>
								<asp:ListItem Value="1">短信收信箱</asp:ListItem>
								<asp:ListItem Value="2">短信发信箱</asp:ListItem>
							</asp:RadioButtonList></TD>
						<TD><TEXTAREA class="BigStatic" id="TO_NAME" style="BACKGROUND-COLOR: #eeeeee" name="TO_NAME"
								rows="4" readOnly wrap="soft" cols="31" runat="server"></TEXTAREA><BR>
							<INPUT id="TO_ID" type="hidden" name="TO_ID" runat="server"></TD>
						<TD>
                            <input class="btn" 
                        onclick="LoadWindow('../module/selectpeople.aspx',405,480,this.value,true,'50%')" 
                        type="button" value="添加人员"><br>
							<input class="btn" name="button" onclick="clear_user()" title="清空收件人" 
                        type="button" value="清 空"></input></br></input></TD>
					</TR>
					<tr>
					    <TD class="tdright">短信内容:</TD>
						<TD width="261" height="14">
                            <asp:TextBox ID="tbmessage" runat="server" Width="118px"></asp:TextBox></TD>
						<TD height="14"></TD>
					</tr>
					<TR>
						<TD class="tdright">起始日期:</TD>
						<TD width="261" height="14">
                            <igsch:WebDateChooser ID="wdcfrom" runat="server"></igsch:WebDateChooser>
							</TD>
						<TD height="14"></TD>
					</TR>
					<TR>
						<TD class="tdright">截止日期:</TD>
						<TD width="261">
                            <igsch:WebDateChooser ID="wdcto" runat="server"></igsch:WebDateChooser>
							</TD>
						<TD ></TD>
					</TR>
					<TR>
						<TD>&nbsp;</TD>
						<TD class="footer" align="center" colSpan="2">
							<asp:Button id="btsearch" runat="server" Text="查询(S)" CssClass="btn" OnClick="btsearch_Click"></asp:Button>
              &nbsp;<span id="closespan"></span>

              </TD>
					</TR>
				</TABLE>
			</asp:panel>
      </div>
      
      <br><br>
      
    <div id="tmtable">
      <asp:panel id="pn2" runat="server" Height="240px">
				<asp:datagrid id="dgbox" runat="server" Width="100%" PageSize="20" CssClass="tbGrid"  CellSpacing="1"
					BackColor="White" CellPadding="3" ShowFooter="True" AutoGenerateColumns="False" GridLines="Vertical"
					BorderStyle="None" OnItemCreated="dg_ItemCreated">
												<FooterStyle CssClass="dgHeader" Font-Bold="True"></FooterStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center" CssClass="dgHeader"></HeaderStyle>
					  <EditItemStyle BackColor="#2461BF" />
                        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
					<Columns>
						<asp:TemplateColumn Visible="false">
							<HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
							<HeaderTemplate>
								<asp:CheckBox id="chkAll1" runat="server" BorderColor="Silver" BorderWidth="0px" Text="全选" Visible="false"></asp:CheckBox>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:CheckBox id="cb" runat="server" BorderColor="Silver" BorderWidth="0px" Visible="false"></asp:CheckBox>
							</ItemTemplate>
							<FooterTemplate>
								<asp:CheckBox id="chkAll" runat="server" BorderColor="Silver" BorderWidth="0px" Text="全选" Visible="false"></asp:CheckBox>
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
									<%# Eval("message") %>
									<asp:Image ID="imgnew" Runat="server" ImageUrl="../icon/email_new.gif" Visible='<%# Eval("remind") %>'>
									</asp:Image>
								</A>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="发送者">
							<HeaderStyle Width="100px"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<a href='../member/showuser.aspx?userid=<%# DataBinder.Eval(Container, "DataItem.fromuserid") %>'>
									<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.fromusername") %>'>
									</asp:Label></a>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="接收者">
							<HeaderStyle Width="100px"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<a href='../member/showuser.aspx?userid=<%# DataBinder.Eval(Container, "DataItem.touserid") %>'>
									<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.username") %>' ID="Label3">
									</asp:Label></a>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn HeaderText="发送时间">
							<HeaderStyle Width="100px"></HeaderStyle>
							<ItemStyle HorizontalAlign="Center"></ItemStyle>
							<ItemTemplate>
								<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.crdate", "{0:M-d HH:mm}") %>' ID="Label21" NAME="Label21">
								</asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
					<pagerStyle HorizontalAlign="Center" ForeColor="Black" Position="TopAndBottom"
						Mode="NumericPages"></pagerStyle>
				</asp:datagrid>
				<asp:Button id="btdel" accessKey="d" runat="server" Width="168px" Text="删除所选记录(D)" CssClass="button" OnClick="btdel_Click" Visible="False"></asp:Button>
			</asp:panel>
      </div>
    </div>
              <script defer="defer" type="text/javascript">
    	jsTable('lrtable','lr','80%','120','center');
    	jsTable('tmtable','tm','90%','','center');
			goBack("","closespan");
              </script>    
    </form>
</body>
</html>
