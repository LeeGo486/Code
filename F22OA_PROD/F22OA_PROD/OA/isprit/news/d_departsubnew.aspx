<%@ page language="C#" autoeventwireup="true" inherits="OA_isprit_news_d_departsubnew, App_Web_d_departsubnew.aspx.9a188d08" %>

<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
   <title>公告</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body leftmargin="3" topmargin="5">
    <form id="form1" runat="server">
    <div>
    	<div class="content">
					<h2><strong>所有公告、新闻<asp:DropDownList ID="ddlsort" runat="server" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="ddlsort_SelectedIndexChanged"></asp:DropDownList></strong></h2>
				</div>
				<table width="100%" border="0" cellpadding="0" cellspacing="1" >
					<tr>
						<td>
						<div id="tttab">
						    <table>
						    <asp:Repeater ID="dlnews" runat="server">							
								<itemtemplate>
									<tr>
										<td><%#DataBinder.Eval(Container, "DataItem.crdate", "{0:yy-MM-dd HH:MM}")%></td>
										<td>
											<a target="_self" href='d_shownews.aspx?newsid=<%# DataBinder.Eval(Container, "DataItem.newsid") %>'>
												<%# DataBinder.Eval(Container, "DataItem.title") %> </a>
									    </td>
										<td>点击数:<%# DataBinder.Eval(Container, "DataItem.hits") %></td>
									</tr>
								</itemtemplate>
                </asp:Repeater>
                </table>
						</div>	
					    </td>
					</tr>
					<tr>
						<td>
						<div id="tmtab">
							<webdiyer:AspNetpager id="pager" runat="server" PageSize="20" AlwaysShow="True" SubmitButtonText="转到" OnPageChanged="pager_PageChanged"></webdiyer:AspNetpager>
							</div>
							</td>
					</tr>
				</table>
				</div>
		<script type="text/javascript" defer="defer">
    	jsTable('tttab','tt','95%','','center');
    	jsTable('tmtab','tm','95%','','center');
    	</script>
    </div>
    </form>
</body>
</html>

