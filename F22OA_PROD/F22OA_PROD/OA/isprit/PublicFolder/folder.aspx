<%@ page language="C#" autoeventwireup="true" inherits="isprit_PublicFolder_folder, App_Web_folder.aspx.4b83903d" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>公共 文件 柜</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body topmargin="1" leftmargin="1" rightmargin="1">
    <form id="form1" runat="server">
     
    <div>
   <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    	<div id="container">
				
				<table id="table1" bgcolor="#eeeeee" align="center" style="WIDTH: 630px" border="0" cellpadding="0"
					cellspacing="1">
					<tr>
						<td class="tdwhite"><table>
								<tr>
									<td><asp:TextBox id="tbsearch" runat="server" Width="128px" ></asp:TextBox></td>
									<td><asp:Button id="btsearch" runat="server" Text="查询" CssClass="btn" OnClick="btsearch_Click"></asp:Button></td>
									<td></td>
								</tr>
							</table>
							<table>
								<tr>
									<td style="WIDTH: 139px" vAlign="top">
										<table width="100%">
											<tr class="dgHeader" align="center" style="height:26px">
												<td colspan="2">请选择类别</td>
											</tr>
											<asp:Repeater id="rptfolder" Runat="server">
												<ItemTemplate>
													<tr>
														<td><img src="../../icon/Small/Folder.jpg" border="0"></td>
														<td>
															<a href='folder.aspx?folderid=<%# DataBinder.Eval(Container, "DataItem.folderid") %>' title='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
																<%# DataBinder.Eval(Container, "DataItem.foldername") %>
															</a>
														</td>
													</tr>
												</ItemTemplate>
											</asp:Repeater></table>
									</td>
									<td vAlign="top">
										<asp:datagrid id="dg" runat="server" Width="486px" GridLines="None" ToolTip="" CssClass="tbGrid"  CellSpacing="1" 
							 AutoGenerateColumns="False" ShowFooter="True" CellPadding="4" ForeColor="#333333">
											<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
											<Columns>
												<asp:TemplateColumn HeaderText="下载文件名">
													<ItemTemplate>
														<a href='../Module/openfile.aspx?url=../../file/publicfile/<%# Server.UrlEncode((String)DataBinder.Eval(Container, "DataItem.filename")) %>' >
															<asp:label ID=lbfile Runat=server text='<%# DataBinder.Eval(Container, "DataItem.filename") %>'>
															</asp:label>
														</a>
													</ItemTemplate>
												</asp:TemplateColumn>
												<asp:TemplateColumn HeaderText="说明">
													<ItemTemplate>
														<asp:Label runat="server" ID="lbpic" text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
														</asp:Label>
													</ItemTemplate>
												</asp:TemplateColumn>
												<asp:BoundColumn DataField="foldername" HeaderText="类别"></asp:BoundColumn>
												<asp:BoundColumn DataField="crdate" ReadOnly="true" HeaderText="上传日期" DataFormatString="{0:d}"></asp:BoundColumn>
											</Columns>
											<pagerStyle HorizontalAlign="Right" ForeColor="Black" BackColor="White"></pagerStyle>
										</asp:datagrid>
                                        <webdiyer:AspNetpager id="ap" runat="server" InputBoxClass="bt" InputBoxStyle="tb" SubmitButtonText="转到"
											ShowInputBox="Always" AlwaysShow="true" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td><hr color="darkgray" noshade size="1" width="100%">
							<ol>
								<li>
								直接输入文件名，进行查询。支持模糊查询<li>点击分类进行查询
								</li>
							</ol>
						</td>
					</tr>
					<tr>
						<td align="center" style="HEIGHT: 16px">
							<asp:Label id="lbmemo" runat="server"></asp:Label>
						</td>
					</tr>
				</table>
			</div>
    </div>
       
    </form>
</body>
</html>
