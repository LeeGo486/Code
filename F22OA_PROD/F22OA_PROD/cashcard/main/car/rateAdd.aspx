<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_rateAdd, App_Web_rateadd.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    <table style="width: 638px">
        <tr>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <%--<asp:UpdatePanel id="UpdatePanel1" runat="server">
                    <contenttemplate>--%>
<TABLE style="WIDTH: 463px; HEIGHT: 113px"><TBODY><TR><TD style="WIDTH: 21px"><asp:Label id="Label1" runat="server" Width="60px" Text="金额起始："></asp:Label></TD><TD style="WIDTH: 120px"><asp:TextBox id="txtRateMin" runat="server"></asp:TextBox> <asp:RangeValidator id="RangeValidator1" runat="server" MaximumValue="1000000" MinimumValue="0" Type="Currency" ControlToValidate="txtRateMin" ErrorMessage="起始金额有误"></asp:RangeValidator></TD></TR><TR><TD style="WIDTH: 21px"><asp:Label id="Label2" runat="server" Width="69px" Text="金额结止："></asp:Label></TD><TD style="WIDTH: 120px"><asp:TextBox id="txtRateMax" runat="server"></asp:TextBox> <asp:RangeValidator id="RangeValidator2" runat="server" MaximumValue="100000000" MinimumValue="0" Type="Currency" ControlToValidate="txtRateMax" ErrorMessage="结止金额有误"></asp:RangeValidator> </TD></TR><TR><TD style="WIDTH: 21px"><asp:Label id="Label3" runat="server" Width="68px" Text="奖励比例："></asp:Label></TD><TD style="WIDTH: 120px"><asp:TextBox id="txtRate" runat="server" Width="99px"></asp:TextBox> <asp:Label id="Label5" runat="server" Text="%"></asp:Label> <asp:RangeValidator id="RangeValidator3" runat="server" MaximumValue="100" MinimumValue="0" Type="Double" ControlToValidate="txtRate" ErrorMessage="奖励比例有误"></asp:RangeValidator></TD></TR><TR><TD style="WIDTH: 21px"><asp:Label id="Label4" runat="server" Width="63px" Text="说明："></asp:Label></TD><TD style="WIDTH: 120px"><asp:TextBox id="txtComment" runat="server" Width="185px"></asp:TextBox></TD></TR><TR><TD style="WIDTH: 21px"></TD><TD style="WIDTH: 120px"><asp:Button id="Button1" onclick="Button1_Click" runat="server" Width="66px" Text="确定"></asp:Button> </TD></TR></TBODY></TABLE><asp:CompareValidator id="CompareValidator1" runat="server" Width="424px" Type="Currency" ControlToValidate="txtRateMax" ErrorMessage="结止金额不能大于起始金额" Operator="GreaterThanEqual" ControlToCompare="txtRateMin"></asp:CompareValidator>&nbsp; 
<%--</contenttemplate>
                </asp:UpdatePanel>--%>
                <asp:Label ID="lbinfo" runat="server" ForeColor="Red" Width="438px"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
        </tr>
    </table>
</asp:Content>

