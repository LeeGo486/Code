<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_rate, App_Web_rate.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    &nbsp;<table Width="100%">
        <tr>
            <td >
                <asp:Button ID="Button1" runat="server" Text="添加" Width="72px" PostBackUrl="~/cashcard/main/car/rateAdd.aspx?aspxid=CA1500&aspxname=充值奖励比例" OnClick="Button1_Click" /></td>
        </tr>
        <tr>
            <td >
                <asp:UpdatePanel id="UpdatePanel1" runat="server">
                    <contenttemplate>
<asp:GridView DataKeyNames="rateid" id="GridView1" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" OnRowDeleting="GridView1_RowDeleting" OnRowUpdating="GridView1_RowUpdating" OnRowCreated="GridView1_RowCreated">
<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
<Columns>
<asp:BoundField DataField="rateid" HeaderText="流水号"></asp:BoundField>
<asp:BoundField DataField="ratemin" HeaderText="金额起始"></asp:BoundField>
<asp:BoundField DataField="ratemax" HeaderText="金额结止"></asp:BoundField>
<asp:BoundField DataField="rate" HeaderText="奖励比例(%)"></asp:BoundField>
<asp:BoundField DataField="comment" HeaderText="说明"></asp:BoundField>
<asp:CommandField ShowDeleteButton="True"></asp:CommandField>
</Columns>

<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

<EditRowStyle BackColor="#2461BF"></EditRowStyle>

<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

<HeaderStyle BackColor="#507CD1" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" VerticalAlign="Middle"></HeaderStyle>

<AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
<EmptyDataTemplate>
     <table cellspacing="0" cellpadding="5" border="0" id="ctl00_ctplhder_GridView1" style="color:#333333;width:100%;border-collapse:collapse;">
        <tr style="color:White;background-color:#507CD1;font-weight:bold;font-size=9pt;" >
            <th scope="col">流水号</th>
            <th scope="col">金额起始</th>
            <th scope="col">金额结止</th>
            <th scope="col">奖励比例(%)</th>
            <th scope="col">说明</th>
        </tr>
      </table>
</EmptyDataTemplate>
</asp:GridView> 
</contenttemplate>
                </asp:UpdatePanel>&nbsp;
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="delete"
                    SelectMethod="select" TypeName="drate" UpdateMethod="update" InsertMethod="insert" OnDeleting="ObjectDataSource1_Deleting" OnUpdating="ObjectDataSource1_Updating">
                    <DeleteParameters>
                        <asp:Parameter Name="rateid" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="rateid" Type="Int32" />
                        <asp:Parameter Name="ratemin" Type="Double" />
                        <asp:Parameter Name="ratemax" Type="Double" />
                        <asp:Parameter Name="rate" Type="Double" />
                        <asp:Parameter Name="comment" Type="String" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ratemin" Type="Double" />
                        <asp:Parameter Name="ratemax" Type="Double" />
                        <asp:Parameter Name="rate" Type="Double" />
                        <asp:Parameter Name="comment" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td >
            </td>
        </tr>
    </table>
</asp:Content>

