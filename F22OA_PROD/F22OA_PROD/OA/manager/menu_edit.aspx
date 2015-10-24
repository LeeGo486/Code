<%@ page language="C#" autoeventwireup="true" inherits="manager_menu_edit, App_Web_menu_edit.aspx.3665c05a" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>menu_edit</title>
		<LINK href="../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../js/project.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class="content">
				<div class="header" align="center"><asp:label id="lbtitle" runat="server"></asp:label></div>
				<table title="带*为必填项目" style="WIDTH: 386px; HEIGHT: 148px" cellSpacing="2" cellPadding="1"
					width="386" align="center" bgColor="#eefaff" border="0">
					<tr>
						<td class="tdright">选择父菜单:</td>
						<td class="tdwhite"><FONT face="宋体" color="#ff0033"><asp:dropdownlist id="ddparent" runat="server" Width="136px"></asp:dropdownlist>*</FONT></td>
					</tr>
					<tr>
						<td class="tdright">菜单名(<U>C</U>):</td>
						<td class="tdwhite"><asp:textbox id="tbmenu" onblur="javascript:highlight(0)" onfocus="javascript:highlight(1)" accessKey="c"
								runat="server" Width="292px" nullable="n" cname="菜单名" MaxLength="100" CssClass="on"></asp:textbox><FONT face="宋体" color="#ff0033">*</FONT>
						</td>
					</tr>
					<tr>
						<td class="tdright">URL(<U>D</U>):</td>
						<td class="tdwhite"><asp:textbox id="tburl" onblur="javascript:highlight(0)" onfocus="javascript:highlight(1)" accessKey="d"
								runat="server" Width="292px" nullable="n" cname="URL" MaxLength="100" CssClass="on"></asp:textbox><FONT face="宋体" color="#ff0033">*</FONT>
						</td>
					</tr>
					<tr>
						<td class="tdright">图标(<U>E</U>):</td>
						<td class="tdwhite"><asp:textbox id="tbicon" onblur="javascript:highlight(0)" onfocus="javascript:highlight(1)" accessKey="e"
								runat="server" Width="112px" nullable="n" cname="图标" MaxLength="100" CssClass="on"></asp:textbox><FONT face="宋体" color="#ff0033">*</FONT>
						</td>
					</tr>
					<tr>
						<td class="tdright">排序:</td>
						<td class="tdwhite">
                            <igtxt:webnumericedit id="tbseq" runat="server" bordercolor="#9FB672" borderstyle="Solid"
                                borderwidth="1px" cellspacing="1" datamode="Int" usebrowserdefaults="False" valuetext="100"
                                width="108px">
<SpinButtons Width="15px" DefaultTriangleImages="ArrowSmall"></SpinButtons>

<ButtonsAppearance CustomButtonDefaultTriangleImages="Arrow">
<ButtonStyle BorderStyle="Solid" Width="13px" ForeColor="White" BorderWidth="1px" BorderColor="#858C6C" BackColor="#829762"></ButtonStyle>

<ButtonDisabledStyle ForeColor="#BEBEBE" BorderColor="#D7D7D7" BackColor="#E1E1DD"></ButtonDisabledStyle>

<ButtonHoverStyle BorderColor="#8C9762" BackColor="#BCC794"></ButtonHoverStyle>

<ButtonPressedStyle BorderColor="#75805E" BackColor="#99B079"></ButtonPressedStyle>
</ButtonsAppearance>
</igtxt:webnumericedit>
                        </td>
					</tr>
					<tr>
						<td class="tip" align="center" colSpan="2"><asp:button id="btsave" runat="server" Text="保存" Width="95px" OnClick="btsave_Click"></asp:button></td>
					</tr>
				</table>
			</div>
    </div>
    </form>
</body>
</html>
