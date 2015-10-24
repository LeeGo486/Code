<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_cardconsumedetail, App_Web_cardconsumedetail.aspx.f3086b61" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
<table width=100%>
    <tr><td>&nbsp;</td></tr>
    <tr>
        <td>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" Width=95%
                AutoGenerateColumns="False" DataKeyNames="consumseid" DataSourceID="ObjectDataSource1" GridLines="None" CellPadding="4">
                <Columns>
                    <asp:TemplateField HeaderText="序号">
                        <ItemTemplate>
                            <%# (Container.DataItemIndex + 1).ToString() %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="consumseid" HeaderText="consumseid" InsertVisible="False"
                        ReadOnly="True" SortExpression="consumseid" Visible=false />
                    <asp:BoundField DataField="retailid" HeaderText="retailid" SortExpression="retailid" Visible=false />
                    <asp:BoundField DataField="cardid" HeaderText="卡号" SortExpression="cardid" />
                    <asp:BoundField DataField="cardsums" HeaderText="总金额" SortExpression="cardsums" Visible=false />
                    <asp:BoundField DataField="sums" HeaderText="消费金额" SortExpression="sums" />
                    <asp:BoundField DataField="sure_date" HeaderText="消费日期" SortExpression="sure_date" DataFormatString={0:d} HtmlEncode=false />                    
                    <asp:BoundField DataField="depotid" HeaderText="店铺号" SortExpression="depotid" />
                    <asp:BoundField DataField="d_name" HeaderText="店铺名称" SortExpression="d_name" />
                    <asp:BoundField DataField="crdate" HeaderText="创建日期" SortExpression="crdate" DataFormatString={0:d} HtmlEncode=false />
                    <asp:BoundField DataField="crname" HeaderText="创建人" SortExpression="crname" />
                    <asp:BoundField DataField="dbname" HeaderText="dbname" SortExpression="dbname" Visible=false />
                    <asp:BoundField DataField="comment" HeaderText="备注" SortExpression="comment" />
                </Columns>
                 <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

                <EditRowStyle BackColor="#2461BF"></EditRowStyle>

                <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

                <HeaderStyle BackColor="#507CD1" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" VerticalAlign="Middle"></HeaderStyle>

                <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
            </asp:GridView>
             <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="Getcardconsumedetail"
                        TypeName="jcard">
                        <SelectParameters>
                            <asp:Parameter  Type=String Name="ID" />
                        </SelectParameters>
            </asp:ObjectDataSource>
            
        </td>
    </tr>
    <tr>
        <td align=center>
            <asp:HyperLink ID=hylReturn runat=server NavigateUrl='cardlose.aspx?aspxid=CA1130&aspxname=挂失解挂' Text="返回"></asp:HyperLink>
        </td>
    </tr>
</table>
</asp:Content>

