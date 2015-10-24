<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_setNotConsumeTime, App_Web_setnotconsumetime.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    <table width=100%>
        <tr>
        <td style="height: 63px">
            <fieldset>
            <legend>设置条件</legend>&nbsp;<asp:Label ID="Label1" runat="server" Text="未充值月数："></asp:Label>
            <asp:TextBox ID="txtMonthnum" runat="server" Width="77px" Text=3></asp:TextBox>
            <asp:Label ID="Label2" runat="server" Text="个月"></asp:Label>,冻结卡
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtMonthnum"
                ErrorMessage="只能是数字！" ValidationExpression="^\d*"></asp:RegularExpressionValidator>
            
            <asp:Button ID="btnSet" runat="server" Text="设置" Width=70px OnClick="btnSet_Click" /> &nbsp;
            <asp:Label ID="lblMessage" runat="server" Text="Label" Visible=false Font-Size=Medium></asp:Label>
            </fieldset>
            提示：此时间为卡的金额为０后，在一定时间段内未充值，则冻结卡</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id"
                    DataSourceID="ObjectDataSource1" GridLines="None" ForeColor="#333333" CellPadding="4" Width=100%>
                    <Columns>
                        <asp:TemplateField HeaderText="序号">
                            <ItemTemplate>
                                <%# (Container.DataItemIndex + 1).ToString() %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="id" HeaderText="序号" InsertVisible="False" ReadOnly="True"
                            SortExpression="id" Visible=false />
                        <asp:BoundField DataField="monthnum" HeaderText="未消费月数" SortExpression="monthnum" />
                    </Columns>
                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

                    <EditRowStyle BackColor="#2461BF"></EditRowStyle>

                    <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

                    <HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>

                    <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:carcn %>"
                    SelectCommand="SELECT * FROM [j_setnotconsumetime]"></asp:SqlDataSource>
                 <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" TypeName="jcard" SelectMethod="GetnotCousumeMonthnum"></asp:ObjectDataSource>
                
            </td>
        </tr>
    </table>
</asp:Content>

