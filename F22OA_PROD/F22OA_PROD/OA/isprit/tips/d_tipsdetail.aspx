<%@ page language="C#" autoeventwireup="true" inherits="OA_isprit_tips_d_tipsdetail, App_Web_d_tipsdetail.aspx.27805cd5" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>提示信息明细</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		
</head>
<body leftMargin="2" topMargin="1" rightmargin="2">
    <form id="form1" runat="server">
    <div>
    <table cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
				<tr>
					<td vAlign="top" height="221">
						<table id="tt" cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
							<tr>
								<td bgColor="#eeeadf">
									<table cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="27"></td>
											<td nowrap ></td>
											<td width="27"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="HEIGHT: 18px">
									<TABLE class="news" id="Table2" cellSpacing="1" cellPadding="1" width="100%" align="center"
										bgColor="whitesmoke" border="0">
										<TR align="center">
											<TD style="WIDTH: 43px" height="22">日期:</TD>
											<TD>
												<asp:label id="lbdate" runat="server" ForeColor="MediumAquamarine"></asp:label></TD>
											<TD>类别:</TD>
											<TD>
												<asp:label id="lbclass" runat="server" ForeColor="DarkGoldenrod"></asp:label></TD>
											
										</TR>
									</TABLE>
								</td>
							</tr>
							<tr>
								<td style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 2px; PADDING-TOP: 10px; height: 26px;"><asp:label id="lbcontent" runat="server" CssClass="news"></asp:label>
								</td>
							</tr>
							<tr>
								<td>	<div>
                                    &nbsp;</div></td>
							</tr>
							<tr>
								<td align="center"></td>
							</tr>
							
							<tr align="center">
								<td>〖 <A href="javascript:history.go(-1);"><font color="#0000ff">返回</font></A>
									〗</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
