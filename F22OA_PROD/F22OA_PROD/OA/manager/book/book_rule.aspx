<%@ page language="C#" autoeventwireup="true" inherits="manager_book_book_rule, App_Web_book_rule.aspx.c640126d" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>book_rule</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
		<META HTTP-EQUIV="pragma" CONTENT="no-cache">
		<script language="JavaScript">
			window.attachEvent("onload", fixPNG);
		</script>
		<base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <TABLE id="Table1" cellSpacing="1" cellPadding="1" width="300" border="0" align="center">
				<TR>
					<TD class="title" colspan="3">图书借阅规则设置</TD>
				</TR>
				<TR>
					<TD style="WIDTH: 18px"><IMG alt="" src="../../icon/book/calendar.png"></TD>
					<TD style="WIDTH: 27px">
                        <igtxt:WebNumericEdit ID="wd1" runat="server" MaxValue="1000" MinValue="0" BorderColor="#7F9DB9" BorderStyle="Solid" BorderWidth="1px" CellSpacing="1" UseBrowserDefaults="False" Width="120px">
                            <SpinButtons DefaultTriangleImages="ArrowSmall" LowerButtonDisabledImageUrl="[ig_edit_21b.gif]"
                                LowerButtonImageUrl="[ig_edit_2b.gif]" UpperButtonDisabledImageUrl="[ig_edit_11b.gif]"
                                UpperButtonImageUrl="[ig_edit_1b.gif]" Width="15px" />
                            <ButtonsAppearance CustomButtonDefaultTriangleImages="Arrow" CustomButtonDisabledImageUrl="[ig_edit_01b.gif]"
                                CustomButtonImageUrl="[ig_edit_0b.gif]">
                                <ButtonStyle BackColor="#C5D5FC" BorderColor="#ABC1F4" BorderStyle="Solid" BorderWidth="1px"
                                    Width="13px">
                                </ButtonStyle>
                                <ButtonDisabledStyle BackColor="#F1F1ED" BorderColor="#E4E4E4">
                                </ButtonDisabledStyle>
                                <ButtonHoverStyle BackColor="#DCEDFD">
                                </ButtonHoverStyle>
                                <ButtonPressedStyle BackColor="#83A6F4">
                                </ButtonPressedStyle>
                            </ButtonsAppearance>
                        </igtxt:WebNumericEdit>
                    </TD>
					<TD>图书借阅天数</TD>
				</TR>
				<TR>
					<TD style="WIDTH: 18px"><IMG alt="" src="../../icon/book/redo.png"></TD>
					<TD style="WIDTH: 27px">
                        <igtxt:WebNumericEdit ID="wd2" runat="server" MaxValue="100" MinValue="0" BorderColor="#7F9DB9" BorderStyle="Solid" BorderWidth="1px" CellSpacing="1" UseBrowserDefaults="False" Width="120px">
                            <SpinButtons DefaultTriangleImages="ArrowSmall" LowerButtonDisabledImageUrl="[ig_edit_21b.gif]"
                                LowerButtonImageUrl="[ig_edit_2b.gif]" UpperButtonDisabledImageUrl="[ig_edit_11b.gif]"
                                UpperButtonImageUrl="[ig_edit_1b.gif]" Width="15px" />
                            <ButtonsAppearance CustomButtonDefaultTriangleImages="Arrow" CustomButtonDisabledImageUrl="[ig_edit_01b.gif]"
                                CustomButtonImageUrl="[ig_edit_0b.gif]">
                                <ButtonStyle BackColor="#C5D5FC" BorderColor="#ABC1F4" BorderStyle="Solid" BorderWidth="1px"
                                    Width="13px">
                                </ButtonStyle>
                                <ButtonDisabledStyle BackColor="#F1F1ED" BorderColor="#E4E4E4">
                                </ButtonDisabledStyle>
                                <ButtonHoverStyle BackColor="#DCEDFD">
                                </ButtonHoverStyle>
                                <ButtonPressedStyle BackColor="#83A6F4">
                                </ButtonPressedStyle>
                            </ButtonsAppearance>
                        </igtxt:WebNumericEdit>
                    </TD>
					<TD><FONT face="宋体">续借次数<BR>
							0表示不允许续借</FONT></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 18px"><IMG alt="" src="../../icon/book/file_temp.png"></TD>
					<TD style="WIDTH: 27px">
                        <igtxt:WebNumericEdit ID="wd3" runat="server" MaxValue="100" MinValue="0" BorderColor="#7F9DB9" BorderStyle="Solid" BorderWidth="1px" CellSpacing="1" UseBrowserDefaults="False" Width="120px">
                            <SpinButtons DefaultTriangleImages="ArrowSmall" LowerButtonDisabledImageUrl="[ig_edit_21b.gif]"
                                LowerButtonImageUrl="[ig_edit_2b.gif]" UpperButtonDisabledImageUrl="[ig_edit_11b.gif]"
                                UpperButtonImageUrl="[ig_edit_1b.gif]" Width="15px" />
                            <ButtonsAppearance CustomButtonDefaultTriangleImages="Arrow" CustomButtonDisabledImageUrl="[ig_edit_01b.gif]"
                                CustomButtonImageUrl="[ig_edit_0b.gif]">
                                <ButtonStyle BackColor="#C5D5FC" BorderColor="#ABC1F4" BorderStyle="Solid" BorderWidth="1px"
                                    Width="13px">
                                </ButtonStyle>
                                <ButtonDisabledStyle BackColor="#F1F1ED" BorderColor="#E4E4E4">
                                </ButtonDisabledStyle>
                                <ButtonHoverStyle BackColor="#DCEDFD">
                                </ButtonHoverStyle>
                                <ButtonPressedStyle BackColor="#83A6F4">
                                </ButtonPressedStyle>
                            </ButtonsAppearance>
                        </igtxt:WebNumericEdit>
                    </TD>
					<TD>图书续借天数</TD>
				</TR>
				<TR>
					<TD align="center" colspan="3">
                        <igtxt:WebImageButton ID="wib" runat="server" Text="OK" Width="79px" OnClick="wib_Click">
                        </igtxt:WebImageButton>
                    </TD>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
