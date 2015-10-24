<%@ page language="C#" autoeventwireup="true" inherits="isprit_mail_mail_outbox, App_Web_mail_outbox.aspx.2cabe2e1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>inbox</title>
    	
		<link href="../../css/project.css" type="text/css" rel="stylesheet"/>
		<base target="_self" />
		<script language="javascript"  type="text/javascript">

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
<body topmargin="0" leftmargin="0" bgcolor="#eeffee">
    <form id="form1" runat="server">
    <div>
    <TABLE align="center" id="Table1" cellSpacing="1" cellPadding="1" border="0" WIDTH="100%">
				<tr>
					<td><FONT face="宋体" color="#669900"><IMG alt="" src="../../icon/inbox.gif">&nbsp;邮件发件箱</FONT><a href="mail_inbox.aspx">[转到收件箱]</a></td>
				</tr>
				<tr>
				   <td><table><tr><td>选择时间段:</td><td>
                <igsch:WebDateChooser ID="wdc1" ToolTip="开始日期" runat="server">
                </igsch:WebDateChooser>
                  </td>
			      <td>
			        <igsch:WebDateChooser ID="wdc2" runat="server" ToolTip="结束日期">
                    </igsch:WebDateChooser>
                  </td>
                  <td>
                 <asp:DropDownList ID="dlsearchname" runat="server" Width="65px">
                     <asp:ListItem Value="username">收件人</asp:ListItem>
                     <asp:ListItem Value="title">标题</asp:ListItem>
                     <asp:ListItem Value="a_mail.remark">内容</asp:ListItem>
                     
                    </asp:DropDownList>
                    <asp:TextBox ID="tbsearch" Width="120px" runat="server"></asp:TextBox></td><td>
                    <asp:ImageButton ID="imbsearch" runat="server" AlternateText="查询" ImageUrl="../../icon/search.gif" ToolTip="有查询字符时，是没有时间限制的" OnClick="imbsearch_Click" /></td>
			    </tr></table></td>
				</tr>
				<tr>
					<td>
						<webdiyer:AspNetpager id="ap" runat="server" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager></td>
				</tr>
				<tr>
					<td vAlign="top">
						<asp:datagrid id="dgbox" runat="server" CellPadding="4" CellSpacing="1"  ShowFooter="true" AutoGenerateColumns="False" WIDTH="100%"
							CssClass="news" ToolTip="点击标题,查看明细" GridLines="None" ForeColor="#333333" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated">
							<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#E2DED6"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White" ForeColor="#284775"></AlternatingItemStyle>
							<ItemStyle ForeColor="#333333" BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center" CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  CssClass="dgHeader"  Font-Bold="True"></FooterStyle>
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
									<ItemStyle  Width="25px"></ItemStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.mailid") %>' ID="Label2" NAME="Label2">
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="标题">
									<ItemStyle HorizontalAlign="Left"></ItemStyle>
									<ItemTemplate>
										<A  href='maildetail.aspx?mailid=<%# Eval("mailid") %>&action=outbox'>
											<%# Eval("title") %>
										</A>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="收件人">
									<HeaderStyle Width="100px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.username") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="收件人已阅">
									<ItemTemplate>
										<asp:Label ID="Label3" runat="server" Text='<%# r( Convert.ToBoolean(Eval("readit"))) %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="发送时间">
									<HeaderStyle Width="100px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.crdate", "{0:d}") %>' ID="Label21" NAME="Label21">
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
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
						</asp:datagrid></td>
				</tr>
				<tr>
					<td><FONT face="宋体">
							<asp:button id="btOK" accessKey="d" runat="server" Width="160px" 
                            CssClass="btr" Text="删除选定的邮件(D)" OnClick="btOK_Click"></asp:button></FONT></td>
				</tr>
			</TABLE>
    </div>
    </form>
</body>
</html>
