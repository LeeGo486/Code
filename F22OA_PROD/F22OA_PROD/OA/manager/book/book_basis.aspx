<%@ page language="C#" autoeventwireup="true" inherits="manager_book_book_basis, App_Web_book_basis.aspx.c640126d" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>录入书籍基础资料</title>
    <link href="../../css/project.css" type="text/css" rel="STYLESHEET">

    <script language="javascript" type="text/javascript" src="../../js/project.js"></script>

    <script src="../../js/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script type="text/javascript">
		    function setValue(id,val){
	            $("#tbvsort").val(id);
	            $("#tbsort").val(val);
	        }
    </script>

</head>
<body topmargin="1" leftmargin="1">
    <form id="form1" runat="server">
    <div id="lrtable">
        <table id="table1" title="带*为必填项目" cellspacing="1" cellpadding="1" width="427" align="center"
            bgcolor="#999999" border="0" style="width: 427px; height: 387px">
            <tr>
                <td class="book_header" colspan="2">
                    <asp:Label ID="lbtitle" runat="server"></asp:Label>
                    <asp:Label ID="lbcode" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="tdright" style="width: 103px" width="103">
                    书籍编号(A):
                </td>
                <td class="tdwhite" width="287">
                    <asp:TextBox ID="tbid" AccessKey="a" runat="server" Width="88px" ToolTip="不能和已有编号重复!"
                        CssClass="tbox" MaxLength="8" strnum="y" cname="书籍编号" nullable="n" EnableViewState="False"></asp:TextBox><font
                            face="宋体" color="#ff0033">*不能重复，且不能为中文</font>
                </td>
            </tr>
            <tr>
                <td class="tdright">
                    书名(B):
                </td>
                <td class="tdwhite">
                    <asp:TextBox ID="TBname" AccessKey="b" runat="server" Width="304px" CssClass="tbox"
                        MaxLength="200" cname="书名" nullable="n" EnableViewState="False"></asp:TextBox><font
                            face="宋体" color="#ff0033">*</font>
                </td>
            </tr>
            <tr>
                <td class="tdHighlight" style="width: 103px; height: 18px">
                    类别:
                </td>
                <td class="tdwhite" style="height: 18px">
                    <input class="tbox1" id="tbsort" style="width: 120px; height: 18px" readonly type="text"
                        cname="类别" nullable="n" size="14" runat="server">
                    <font face="宋体">&nbsp;</font><input class="button" onclick="javascript:window.open('../../manager/book/bookwSort.aspx',200,300,'选择书籍类别','50%')"
                        type="button" value="选择.."><font face="宋体"></font> <a href='book_sort_all.aspx' target="_parent"
                            accesskey="x">编辑类别(X)</a><input id="tbvsort" style="width: 13px; height: 22px" type="hidden"
                                size="1" runat="server">
                </td>
            </tr>
            <tr>
                <td class="tdright" style="width: 103px">
                    ISBN(C):
                </td>
                <td class="tdwhite">
                    <asp:TextBox ID="tbISBN" runat="server" Width="152px" CssClass="tbox" MaxLength="100"
                        AccessKey="c" EnableViewState="False"></asp:TextBox><font face="宋体" color="#ff0033"></font>
                </td>
            </tr>
            <tr>
                <td class="tdright" style="width: 103px">
                    条码(D):
                </td>
                <td class="tdwhite">
                    <asp:TextBox ID="tbcode" runat="server" Width="152px" CssClass="tbox" MaxLength="100"
                        AccessKey="d" EnableViewState="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="tdright" style="width: 103px">
                    出版商|作者(E):
                </td>
                <td class="tdwhite">
                    <asp:TextBox ID="tbpublish" runat="server" Width="152px" CssClass="tbox" MaxLength="100"
                        AccessKey="e" EnableViewState="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="tdright" style="width: 103px">
                    出版日期(F):
                </td>
                <td class="tdwhite">
                    <igsch:WebDateChooser ID="wdcpublish" runat="server">
                        <CalendarLayout PrevMonthImageUrl="ig_cal_blueP0.gif" TitleFormat="Month" NextMonthImageUrl="ig_cal_blueN0.gif"
                            ShowYearDropDown="False" ShowMonthDropDown="False">
                            <TodayDayStyle BackColor="#E0EEFF"></TodayDayStyle>
                            <FooterStyle BackgroundImage="ig_cal_blue1.gif" ForeColor="#505080" Height="16pt"
                                Font-Size="8pt">
                                <BorderDetails ColorTop="LightSteelBlue" WidthTop="1px" StyleTop="Solid"></BorderDetails>
                            </FooterStyle>
                            <SelectedDayStyle BackColor="SteelBlue"></SelectedDayStyle>
                            <NextPrevStyle BackgroundImage="ig_cal_blue2.gif"></NextPrevStyle>
                            <OtherMonthDayStyle ForeColor="SlateGray"></OtherMonthDayStyle>
                            <DayHeaderStyle ForeColor="#8080A0" BackColor="#E0EEFF" Height="1pt" Font-Size="8pt"
                                Font-Bold="true">
                                <BorderDetails StyleBottom="Solid" WidthBottom="1px" ColorBottom="LightSteelBlue">
                                </BorderDetails>
                            </DayHeaderStyle>
                            <TitleStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="#505080" BackColor="#CCDDFF"
                                Height="18pt" Font-Size="10pt" Font-Bold="true"></TitleStyle>
                            <CalendarStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="SteelBlue" BackColor="#CCDDFF"
                                Font-Italic="False" Font-Size="9pt" Font-Names="Verdana" Font-Strikeout="False"
                                Font-Underline="False" Font-Overline="False" Font-Bold="False">
                            </CalendarStyle>
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td class="tdright" style="width: 103px">
                    总页数(G):
                </td>
                <td class="tdwhite">
                    <igtxt:WebNumericEdit ID="tbpp" runat="server" BorderColor="#9FB672" BorderStyle="Solid"
                        BorderWidth="1px" CellSpacing="1" DataMode="Int" MaxValue="9999" MinValue="0"
                        UseBrowserDefaults="False" ValueText="100" Width="68px">
                        <SpinButtons Width="15px" DefaultTriangleImages="ArrowSmall"></SpinButtons>
                        <ButtonsAppearance CustomButtonDefaultTriangleImages="Arrow">
                            <ButtonStyle BorderStyle="Solid" Width="13px" ForeColor="White" BorderWidth="1px"
                                BorderColor="#858C6C" BackColor="#829762">
                            </ButtonStyle>
                            <ButtonDisabledStyle ForeColor="#BEBEBE" BorderColor="#D7D7D7" BackColor="#E1E1DD">
                            </ButtonDisabledStyle>
                            <ButtonHoverStyle BorderColor="#8C9762" BackColor="#BCC794">
                            </ButtonHoverStyle>
                            <ButtonPressedStyle BorderColor="#75805E" BackColor="#99B079">
                            </ButtonPressedStyle>
                        </ButtonsAppearance>
                    </igtxt:WebNumericEdit>
                </td>
            </tr>
            <tr>
                <td class="tdright" style="width: 103px">
                    价格(I):
                </td>
                <td class="tdwhite">
                    <igtxt:WebNumericEdit ID="tbprice" runat="server" BorderColor="#9FB672" BorderStyle="Solid"
                        BorderWidth="1px" CellSpacing="1" DataMode="Int" MaxValue="9999" MinValue="0"
                        UseBrowserDefaults="False" ValueText="0" Width="69px">
                        <SpinButtons Width="15px" DefaultTriangleImages="ArrowSmall"></SpinButtons>
                        <ButtonsAppearance CustomButtonDefaultTriangleImages="Arrow">
                            <ButtonStyle BorderStyle="Solid" Width="13px" ForeColor="White" BorderWidth="1px"
                                BorderColor="#858C6C" BackColor="#829762">
                            </ButtonStyle>
                            <ButtonDisabledStyle ForeColor="#BEBEBE" BorderColor="#D7D7D7" BackColor="#E1E1DD">
                            </ButtonDisabledStyle>
                            <ButtonHoverStyle BorderColor="#8C9762" BackColor="#BCC794">
                            </ButtonHoverStyle>
                            <ButtonPressedStyle BorderColor="#75805E" BackColor="#99B079">
                            </ButtonPressedStyle>
                        </ButtonsAppearance>
                    </igtxt:WebNumericEdit>
                </td>
            </tr>
            <tr>
                <td class="tdright" style="width: 103px">
                    所在架位(H):
                </td>
                <td class="tdwhite">
                    <asp:TextBox ID="tblocation" runat="server" Width="72px" CssClass="tbox" MaxLength="100"
                        AccessKey="h" EnableViewState="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="tdright" style="width: 103px;">
                    备注(J):
                </td>
                <td class="tdwhite" style="height: 26px">
                    <asp:TextBox ID="tbremark" runat="server" Width="263px" CssClass="tbox" MaxLength="100"
                        AccessKey="j" TextMode="MultiLine" Height="56px" EnableViewState="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="footer" align="center" colspan="2">
                    <asp:Button ID="btsave" AccessKey="s" runat="server" CssClass="btn" Text="保存(S)"
                        OnClick="btsave_Click"></asp:Button>
                    &nbsp;<input class="btn" accesskey="z" type="button" value="关闭(Z)" onclick="javascript:closeTab(0);">
                </td>
            </tr>
        </table>
    </div>

    <script type="text/javascript" defer="defer">
    	jsTable('lrtable','lr','600','150','center')
    </script>

    </form>
</body>
</html>
