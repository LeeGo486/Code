<%@ page language="C#" autoeventwireup="true" inherits="isprit_mail_maildetail, App_Web_maildetail.aspx.2cabe2e1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>mailretail</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
		<link href="../../css/project.css" type="text/css" rel="stylesheet"/>
</head>
<body leftMargin="10" rightmargin="0" topMargin="0">
    <form id="form1" runat="server">
    <div id="lrTable">
    <asp:Label id="lberror" runat="server" ForeColor="Red"></asp:Label>
			<TABLE border="0" align="center" id="Table1" width="765" style="height: 28px">
			
				<TR>
					<TD align="right">标　　题：</TD>
					<TD>
          <b><asp:label id="lbtitle" runat="server" Font-Size="14"></asp:label></b>
          </TD>
				</TR>	
				<TR>
					<TD align="right">发 件 人：</TD>
					<TD>
          <asp:label id="lbfrom" runat="server" ForeColor="#0000C0"></asp:label>
          </TD>
				</TR>	
				<TR>
					<TD align="right">收 件 人：</TD>
					<TD>
          <asp:label id="lbto" runat="server" ForeColor="#0000C0"></asp:label>
          </TD>
				</TR>	
				<TR>
					<TD align="right">发送时间：</TD>
					<TD>
          <asp:label id="lbcrdate" runat="server" ForeColor="Navy"></asp:label>
          </TD>
				</TR>	
				<TR>
					<TD height="300" align="right">邮件内容：</TD>
					<TD valign="top">
                      <div style="line-height:20px;padding:20px;">
          <asp:Label id="lbcontent" runat="server"></asp:Label>
          </div>
          </TD>
				</TR>	
				<TR>
					<TD align="right">邮件附件：</TD>
					<TD>
          <asp:datalist id="dlfile" runat="server" Width="100%" ForeColor="DodgerBlue">
          <HeaderTemplate>
          <ul>
          </HeaderTemplate>
			<ItemTemplate>
            <li><a href='..\module\openfile.aspx?Url=..\..\file\<%# Server.UrlEncode((String)DataBinder.Eval(Container, "DataItem.filename")) %>'
                 target="_blank" style="color:Blue; text-decoration:underline"><%# DataBinder.Eval(Container, "DataItem.filename") %></a></li>
			</ItemTemplate>
	        <FooterTemplate>
	        </ul>
	        </FooterTemplate>
		</asp:datalist>
		</TD>
				</TR>
				<tr>
				<td>&nbsp;</td>
				<td>注：如果附件无法下载，请确认发件人是否已经把上传的文件删除！</td>
				</tr>
				
				<TR >
					<TD align="center" colspan="2">
                    <asp:Button ID="btreply" runat="server" Text="回复(R)" CssClass="btn" UseSubmitBehavior="false"  />
                    <asp:Button id="bttransfer" accessKey="f" runat="server" Text="转发(F)" CssClass="btn" UseSubmitBehavior="false"/>
                    <asp:Button id="btdel" accessKey="d" runat="server" Text="删除(D)" CssClass="btn" OnClick="btdel_Click" />
              <label id="backSpan"></label>
          </TD>
				</TR>	
			</TABLE>
    </div>
		<script type="text/javascript" defer="defer">
		goBack("邮件");
    	jsTable('lrTable','lr','98%','120','center')
    </script>
    </form>
</body>
</html>
