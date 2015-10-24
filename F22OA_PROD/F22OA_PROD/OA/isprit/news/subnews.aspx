<%@ page language="C#" autoeventwireup="true" inherits="isprit_news_subnews, App_Web_subnews.aspx.9a188d08" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>subnews</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body leftmargin="3" topmargin="5">
    <form id="form1" runat="server">
    	<div>

					<h2><strong>所有公告、新闻<asp:DropDownList ID="ddlsort" runat="server" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="ddlsort_SelectedIndexChanged">
                        </asp:DropDownList></strong></h2>
							<div id="tmtab">
              <table width="100%" border="0" cellpadding="0" cellspacing="1" >
									<tr>
										<td align="center">标　题</td>
										<td width="80">点击数</td>
                    <td width="80">回贴数</td>
                    <td width="120">发布时间</td>
									</tr>
                </table>
              </div>
            <div id="tttab">
					<asp:DataList ID="dlnews" runat="server" CellPadding="4" ForeColor="#333333" >							
								<itemtemplate>
              <table width="100%" border="0" cellpadding="0" cellspacing="1" >
									<tr>
										<td width="15" valign="top"><img alt="" src="../icon/arr.gif"></td>
										<td>
											<a target=_self href='shownews.aspx?newsid=<%# DataBinder.Eval(Container, "DataItem.newsid") %>'>
												<%# DataBinder.Eval(Container, "DataItem.title") %>
											</a>
										</td>
										<td width="80"><%# DataBinder.Eval(Container, "DataItem.hits") %></td>
                    <td width="80"><%# DataBinder.Eval(Container, "DataItem.reply") %></td>
                    <td width="120"><%#DataBinder.Eval(Container, "DataItem.crdate", "{0:MM-dd HH:MM}")%></td>
									</tr>
                </table>
								</itemtemplate>
                            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <SelectedItemStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                            <AlternatingItemStyle BackColor="White" />
                            <ItemStyle BackColor="#E3EAEB" />
                            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        
							</asp:DataList><br />
              </div>
							<div id="tmtab2">
              <table width="100%" border="0" cellpadding="0" cellspacing="1" >
									<tr>
										<td>
							<webdiyer:AspNetpager id="pager" runat="server" PageSize="20" AlwaysShow="True" SubmitButtonText="转到" OnPageChanged="pager_PageChanged"></webdiyer:AspNetpager>
                  </td>
                </tr>
              </table>
              </div>
		<script type="text/javascript" defer="defer">
    	jsTable('tttab','tt','95%','','center')
    	jsTable('tmtab','tm','95%','','center')
    	jsTable('tmtab2','tm','95%','','center')
			
    </script>
    </div>
    </form>
</body>
</html>
