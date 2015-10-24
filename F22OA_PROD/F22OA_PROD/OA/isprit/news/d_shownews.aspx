<%@ page language="C#" autoeventwireup="true" validaterequest="false" inherits="OA_isprit_news_d_shownews, App_Web_d_shownews.aspx.9a188d08" %>

<%@ Register Assembly="DotNetTextBox" Namespace="DotNetTextBox" TagPrefix="DNTB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>shownews</title>
		<link href="../../css/project.css" type="text/css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<meta HTTP-EQUIV="imagetoolbar" CONTENT="no"> 
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
			
			//检测内容是否为空
			function CheckForm()
        {

     if (document.all.WebEditor1.value==""){
     alert("请填写内容！");
    // document.all.WebEditor1.focus();
   
     return (false);
   }
   return (true);
  }
 
		</script>
</head>
<body leftMargin="2" topMargin="1" rightmargin="2"  oncontextmenu=self.event.returnValue=false onselectstart="return false">
    <form id="form1" runat="server">
    <div>
    <table cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
				<tr>
					<td vAlign="top" height="221">
						<table id="tt" cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
							<tr>
								<td>
                <div id="tmtable">
									<TABLE class="news" id="Table2" cellSpacing="1" cellPadding="1" width="100%" align="center"
										bgColor="whitesmoke" border="0">
										<TR>
										  <TD height="300" colspan="8" valign="top">
                      <div style="margin:20px 40px;line-height:30px;font-weight:bold; font-size:14px;text-align:center;">
                      <asp:label id="lbtitle" runat="server"></asp:label>
                      </div>
                      <div style="line-height:40px; border-bottom:dotted 1px #DDD;text-align:center;">
                        日期：<asp:label id="lbdate" runat="server" ></asp:label>
                        类别：<asp:label id="lbclass" runat="server" ></asp:label>
                        点击数：<asp:label id="lbhits" runat="server"></asp:label>
                        作者：<asp:label id="lbauthor" runat="server"></asp:label>
                      </div>
                      <div style="line-height:20px;padding:20px;">
                      <asp:label id="lbcontent" runat="server"></asp:label>
                      </div>
                      </TD>
									  </TR>
										<TR>
										  <TD colspan="8">
                      <div style="padding:20px 40px;">
                    <asp:datalist id="dlfile" runat="server" Width="100%" ForeColor="DodgerBlue" ToolTip="附件列表" Caption="附件列表" CaptionAlign="Left">
							<ItemTemplate>
								<li type="I">
									<a href="..\module\openfile.aspx?Url=..\..\file\uploadFiles\<%# Server.UrlEncode((String)DataBinder.Eval(Container,"DataItem.fileurl")) %>"
									 target="_blank"><%# DataBinder.Eval(Container, "DataItem.filename") %>
									</a>
								</li>
							</ItemTemplate>
						</asp:datalist></div>
                      </TD>
                    </TR>
                    <TR>
                      <TD align="center" colSpan="8">
                      <span id="backSpan"><input class="btn" type="button" value="返 回" onclick="javascript:history.go(-1);" /></span>
                      <span id="lrdiv" runat="server">&nbsp;<input class="btn" type="button" value="回 复" onclick="javascript:self.location.href='#reply'" /></span>
                      </TD>
                    </TR>
                    </TABLE>
                  </div>
								</td>
							</tr>
							<tr>
								<td align="center">
                                </td>
							</tr>
							<tr>
								<td>
                        <div id="lrtable" runat="server">
                                <asp:datalist id="dldiscuss" runat="server" Width="95%" CellPadding="0" CellSpacing="0" BorderWidth="0" OnItemDataBound="dldiscuss_ItemBound">
									<ItemTemplate>
										<div style="text-align:center; display:block; width:100%;">
                                          <div style="text-align:left;padding:5px"> <asp:Label id="lbnum" Runat="server" Font-Bold="True"></asp:Label>
                                                <a href='../member/showuser.aspx?userid=<%# DataBinder.Eval(Container, "DataItem.userid") %>'>
                                                <b><%# DataBinder.Eval(Container, "DataItem.username") %></b></A></div>
                                          <img  width="<%=imgwidth%>" alt="" height="<%=imgheight%>" src='..\..\icon\portrait\<%# DataBinder.Eval(Container, "DataItem.icon") %>' 
                                                	style="border:solid 1px #FFF;" /><br />
                                               <div style="padding:5px"><%# DataBinder.Eval(Container, "DataItem.crdate") %></div>
                                            </div>
                                            </td><td>
                                            <br />
                                            <div style="padding:20px">
                                                    <%# DataBinder.Eval(Container, "DataItem.content") %>
                                                    </div>
                                                <div style="text-align:right;width:50%;float:right;clear:both;padding:20px;border-top:solid 1px #ddd;color:Gray">
                                                <%#DataBinder.Eval(Container, "DataItem.remark")%></div>
									</ItemTemplate>
								</asp:datalist>
                        <a name="reply"></a>
										<TABLE id="Table1" style="WIDTH: 458px; HEIGHT: 188px" borderColor="#ebe9ed" height="188"
                     cellSpacing="1" cellPadding="0" width="458" bgColor="#99ccff" border="0">
											<TR>
												<TD colspan="2" align="left">回复新闻</TD>
											</TR>
											<TR>
												<TD width="75" height="13" class="tdright">呢称:</TD>
												<TD width="185" bgColor="#ffffff"><asp:textbox id="tbnickname" runat="server" CssClass="tbox1" ReadOnly="True"></asp:textbox></TD>
											</TR>
											<TR>
												<TD height="13" class="tdright">内容:</TD>
												<TD bgColor="#ffffff"><DNTB:WebEditor ID="WebEditor1" Width="409px" runat="server" />
                                                </TD>
											</TR>
											<TR>
												<TD align="center" bgColor="#ffffff" colSpan="2"><FONT face="宋体"><asp:button id="btreply" accessKey="r" runat="server" CssClass="btn" Text="发 表(R)" OnClick="btreply_Click"></asp:button></FONT>&nbsp;
                        <span id="Span1"><input class="btn" type="button" value="返 回" onclick="javascript:history.go(-1);" /></span>
                      <input class="btn" type="button" value="查看主题" onclick="javascript:self.location.href='#'" />
                        </TD>
											</TR>
										</TABLE>
                    </div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
        
		<script type="text/javascript" defer="defer">
		goBack("公告栏");
    	jsTable('lrtable','lr','95%','140','center');
    	jsTable('tmtable','tt','95%','','center');
			
			
		</script>
    
    
    </div>
    </form>
</body>
</html>
