<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_setInisums, App_Web_setinisums.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<table width=100%>
        <tr>
        <td>
            <fieldset>
            <legend>设置条件</legend>&nbsp;<asp:Label ID="Label1" runat="server" Text="初始金额："></asp:Label>
            <asp:TextBox ID="txtMonthnum" runat="server" Width="77px" Text=0></asp:TextBox>
            <asp:Label ID="Label2" runat="server" Text="元"></asp:Label>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtMonthnum"
                ErrorMessage="只能是数字！" ValidationExpression="^\d*"></asp:RegularExpressionValidator>
            
            <asp:Button ID="btnSet" runat="server" Text="设置" Width=70px OnClick="btnSet_Click" /> &nbsp;
            <asp:Label ID="lblMessage" runat="server" Text="Label" Visible=False Font-Size=10pt ForeColor="Red"></asp:Label>
            </fieldset>
        </td>
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
                        <asp:BoundField DataField="lesssums" HeaderText="初始金额" SortExpression="lesssums" />
                    </Columns>
                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

                    <EditRowStyle BackColor="#2461BF"></EditRowStyle>

                    <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

                    <HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>

                    <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                </asp:GridView>
              
                 <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" TypeName="jcard" SelectMethod="GetsetInisums"></asp:ObjectDataSource>
                
            </td>
        </tr>
    </table>
</asp:Content>

