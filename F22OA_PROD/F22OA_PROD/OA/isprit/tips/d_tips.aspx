<%@ page language="C#" autoeventwireup="true" inherits="OA_isprit_tips_d_tips, App_Web_d_tips.aspx.27805cd5" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>


<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
   <title>公告</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body leftmargin="0" topmargin="0">
    <form id="form1" runat="server">
    <div> <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    	<div class="content">
					<h2><strong>
                       
                        提示信息<asp:DropDownList ID="ddlsort" runat="server" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="ddlsort_SelectedIndexChanged"></asp:DropDownList></strong></h2>
				</div>
				<table width="100%" border="0" cellpadding="0" cellspacing="1" >
					<tr>
						<td><asp:DataList ID="dlnews" runat="server" CellPadding="4" ForeColor="#333333" >							
								<itemtemplate>
									<tr>
										<td width="15" valign="top"><img alt="" src="../icon/arr.gif"></td>
										<td>
											<a target=_self href='<%# Eval("weburl").ToString()==""?"#":Eval("weburl").ToString() %>'>
												<%# DataBinder.Eval(Container, "DataItem.title") %>
												<%#DataBinder.Eval(Container, "DataItem.lastdate", "({0:MM-dd HH:MM})")%>
											</a>
											
										</td>
										<td></td>
									</tr>
								</itemtemplate>
                            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <SelectedItemStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                            <AlternatingItemStyle BackColor="White" />
                            <ItemStyle BackColor="#E3EAEB" />
                            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        
							</asp:DataList></td>
					</tr>
					<tr>
						<td>
							<webdiyer:AspNetpager id="pager" runat="server" PageSize="20" AlwaysShow="True" SubmitButtonText="转到" OnPageChanged="pager_PageChanged"></webdiyer:AspNetpager></td>
					</tr>
				</table>
		
    </div>
    </form>
</body>
</html>

