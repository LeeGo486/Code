<%@ page language="C#" autoeventwireup="true" inherits="isprit_WORDPAD_everyitem, App_Web_everyitem.aspx.2b69af9" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>everyitem</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
					<SCRIPT language="javascript" src="js/calendar2.js"  type="text/javascript"></SCRIPT>
								<SCRIPT language="javascript" src="js/dateValidate.js"  type="text/javascript"></SCRIPT>
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
		</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table id="table1" align="center" cellSpacing="1" cellPadding="1" width="100%" border="0">
					<tr>
						<td>
							<table style="100%">
							
								<tr>
								<td>搜索根据日期:</td>
								<td>
								<igsch:WebDateChooser ID="wdc1" ToolTip="开始日期" runat="server">
                </igsch:WebDateChooser>
											</td>
								<td>
											至
				
												 </td>
									<td >
										<igsch:WebDateChooser ID="wdc2" runat="server" ToolTip="结束日期">
                    </igsch:WebDateChooser>
									</td>
									<td>
											<asp:button id="btsearch" accessKey="s" runat="server" Text="搜 索...(S)" CssClass="btn" Width="100px" OnClick="btsearch_Click"></asp:button>
											</td>
								</tr>
							</table>
							<webdiyer:AspNetpager id="ap" runat="server" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
						</td>
					</tr>
					<tr>
						<td  style="HEIGHT: 192px" vAlign="top">
							<asp:datagrid id="dg" runat="server"  Width="100%" AutoGenerateColumns="False" GridLines="None" CssClass="tbGrid"  CellSpacing="1"
								ShowFooter="true" CellPadding="4"   OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated">
							<FooterStyle CssClass="dgHeader" Font-Bold="True"></FooterStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center" CssClass="dgHeader"></HeaderStyle>
							<EditItemStyle BackColor="#2461BF" />
                        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
								<Columns>
									<asp:TemplateColumn>
										<HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
										<ItemStyle Width="50px"></ItemStyle>
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
										<ItemStyle HorizontalAlign="Center" Width="60px"></ItemStyle>
										<ItemTemplate>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.noteid") %>' ID="Label2" >
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="记录时间">
										<HeaderStyle Width="100px"></HeaderStyle>
										<ItemTemplate>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.crdate", "{0:yyyy-M-d}") %>' ID="Label1" >
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="标题">
										<ItemTemplate>
											<A  href='shownote.aspx?noteid=<%# Eval("noteid") %>'>
												<%# Eval("title") %>
											</A>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="类别">
										<HeaderStyle Width="100px"></HeaderStyle>
										<ItemTemplate>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.classname") %>' ID="Label3" >
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="编辑">
										<HeaderStyle Width="80px"></HeaderStyle>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<ItemTemplate>
											<A href='note/htmlEdit.aspx?action=edit&amp;noteid=<%# DataBinder.Eval(Container, "DataItem.noteid") %>'>
												编辑</A>
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
								<pagerStyle HorizontalAlign="Left" ForeColor="#003399" Position="TopAndBottom" BackColor="#99CCCC"
									Mode="NumericPages"></pagerStyle>
							</asp:datagrid></td>
					</tr>
					<tr>
						<td vAlign="top">
							<asp:button id="btOK" accessKey="d" runat="server" Width="160px" CssClass="btr" Text="删除选定的记录(D)" OnClick="btOK_Click"></asp:button></td>
					</tr>
					<tr>
						<td><FONT face="宋体"></FONT></td>
					</tr>
				</table>
		
    </div>
    </form>
</body>
</html>
