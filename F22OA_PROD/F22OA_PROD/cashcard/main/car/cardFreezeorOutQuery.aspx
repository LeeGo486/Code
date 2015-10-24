<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_cardFreezeorOutQuery, App_Web_cardfreezeoroutquery.aspx.f3086b61" title="Untitled Page" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    <table width=100%>    
        <tr>
            <td width=100%>
                <fieldset>
                <legend>查询条件</legend>
                <table width=100%>
                    <tr>
                        <td style="width: 62px" align=right>
                            卡号：
                        </td>
                        <td style="width: 142px"><asp:TextBox ID="txtCardid" runat="server"></asp:TextBox> </td>
                        <td style="width: 58px"  align=right>卡状态：</td>
                        <td><asp:DropDownList ID="ddlCardstate" runat="server">
                                <asp:ListItem Value="-" Text="不限"></asp:ListItem>
                                <asp:ListItem Value="1" Text="已冻结"></asp:ListItem>
                                <asp:ListItem Value="0" Text="已解冻"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td rowspan=2>
                            <asp:Button ID="btnSearch" runat="server" Text="查询" Width=70px OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 62px"  align=right>
                            <asp:Label ID="Label1" runat="server" Text="日期起始："></asp:Label>                           
                        </td>
                        <td style="width: 142px">
                            <igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False" Height="10px"
                                Width="101px">
                            </igsch:WebDateChooser>
                        
                        </td>
                        <td style="width: 58px"  align=right><asp:Label id="Label2" runat="server" Text="日期结止：" Width="61px"></asp:Label></td>
                        <td>
                            <igsch:WebDateChooser id="WebDateChooser2" runat="server" Width="101px" AllowNull="False" Height="9px"></igsch:WebDateChooser>
                            <asp:CompareValidator id="CompareValidator1" runat="server" ControlToValidate="WebDateChooser2" ErrorMessage="日期范围填写有误" ControlToCompare="WebDateChooser1" Type="Date" Operator="GreaterThanEqual" Display="Dynamic"></asp:CompareValidator>
                        </td>
                    </tr>
                </table>
                </fieldset>
             </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" GridLines="None" ForeColor="#333333" CellPadding="4"
                    DataSourceID="ObjectDataSource1" AllowPaging="True" AllowSorting="True" DataKeyNames="cardid" Width=100%
                     OnRowDataBound="GridView1_RowDataBound" >
                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></RowStyle>

                    <EditRowStyle BackColor="#2461BF"></EditRowStyle>

                    <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>

                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>

                    <HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>

                    <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="序号">
                            <ItemTemplate>
                                <%# (Container.DataItemIndex + 1).ToString() %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="cardid" HeaderText="卡号" ReadOnly="True" SortExpression="cardid" />
                        <asp:BoundField DataField="cardname" HeaderText="卡名称" SortExpression="cardname" />
                        <asp:BoundField DataField="sums" HeaderText="金额" SortExpression="sums" />
                        <asp:BoundField DataField="names" HeaderText="顾客姓名" SortExpression="names" />
                        <asp:BoundField DataField="crdate" HeaderText="创建时间" SortExpression="crdate"  DataFormatString={0:d} HtmlEncode=false />
                        <asp:BoundField DataField="lastdate" HeaderText="lastdate" SortExpression="lastdate" Visible=false />
                        <asp:BoundField DataField="crname" HeaderText="创建人" SortExpression="crname" Visible=false  />
                        <asp:BoundField DataField="username" HeaderText="创建人" SortExpression="username" /> 
                        <asp:BoundField DataField="depotid" HeaderText="店铺号" SortExpression="depotid" /> 
                        <asp:BoundField DataField="d_name" HeaderText="发卡店铺" SortExpression="depotid" /> 
                        <asp:BoundField DataField="statename" HeaderText="卡状态" SortExpression="statename" />                       
                        <asp:CheckBoxField DataField="start" HeaderText="start" SortExpression="start" Visible=false />
                        <asp:BoundField DataField="proposerid" HeaderText="proposerid" SortExpression="proposerid" Visible=false />
                        <asp:BoundField DataField="password" HeaderText="password" SortExpression="password" Visible=false />                        
                        <asp:BoundField DataField="congeal" HeaderText="congeal" SortExpression="congeal" ControlStyle-Width=1px Visible=false >                            
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="卡操作">
                            <ItemTemplate>
                                <asp:Label ID="lblcongeal" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"congeal").ToString()=="1"?"已冻结":"已解冻" %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="comment" HeaderText="备注" SortExpression="comment" />
                        <asp:TemplateField AccessibleHeaderText="解冻" HeaderText="操作"><ItemTemplate>
                            <asp:LinkButton id="LinkBtnChange" CommandArgument='<%# Eval("cardid") %>'   runat="server" Text="解冻" CausesValidation="false" CommandName='<%# Eval("proposerid") %>'
                                 OnClick="LinkBtnChange_Click" ></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerSettings Mode=nextPreviousFirstLast FirstPageText="首页" LastPageText="末页" NextPageText="下一页" PreviousPageText="上一页"  />
                    <EmptyDataTemplate>
                         <table cellspacing="0" cellpadding="5" border="0" id="ctl00_ctplhder_GridView1" style="color:#333333;width:100%;border-collapse:collapse;">
                            <tr style="color:White;background-color:#507CD1;font-weight:bold;font-size=9pt;" >
                                <th scope="col">序号</th>
                                <th scope="col">卡号</th>
                                <th scope="col">卡名称</th>
                                <th scope="col">金额</th>
                                <th scope="col">顾客姓名</th>
                                <th scope="col">创建时间</th>
                                <th scope="col">创建人</th>
                                <th scope="col">发卡店铺</th>
                                <th scope="col">卡状态</th>
                                <th scope="col">卡操作</th>
                                <th scope="col">备注</th>
                            </tr>
                          </table>
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:ObjectDataSource ID=ObjectDataSource1 runat=server SelectMethod="GetCardFreezeorOutQueryList" TypeName="jcard">
                    <SelectParameters>
                        <asp:Parameter Name=cardid Type=string DefaultValue="-" />
                        <asp:Parameter Name=congealstate Type=string DefaultValue="-" />
                        <asp:Parameter Name=startdate Type=string DefaultValue="1900-01-01" />
                        <asp:Parameter Name=enddate Type=string DefaultValue="1900-01-01" />
                    </SelectParameters>
                </asp:ObjectDataSource>
    
            </td>
        </tr>
    </table>
</asp:Content>

