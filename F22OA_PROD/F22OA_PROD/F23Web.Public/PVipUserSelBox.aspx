<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.Master" AutoEventWireup="true"
    CodeBehind="PVipUserSelBox.aspx.cs" Inherits="F23Web.Public.PVipUserSelBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="type" name="type" value="1" class="field" />
    <Public:SheetQueryControl ID="SheetQueryControl1" runat="server" />
    <div id="toolbar">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <Base:StateSelector ID="dtype" runat="server" CssClass="field" DefaultValue="0">
                        <Status>
                            <Base:StateItem Enabled="true" Text="发卡日期" Value="0" />
                            <Base:StateItem Enabled="true" Text="最后消费日期" Value="1" />
                            <Base:StateItem Enabled="true" Text="按积分" Value="2" />
                            <Base:StateItem Enabled="true" Text="按储值" Value="3" />
                            <Base:StateItem Enabled="true" Text="按卡类型" Value="4" />
                            <Base:StateItem Enabled="true" Text="按卡号" Value="5" />
                            <Base:StateItem Enabled="true" Text="按店铺" Value="6" />
                        </Status>
                    </Base:StateSelector>
                    &nbsp;&nbsp;
                </td>
                <td>
                    <div id="keyword" style="display: none">
                        <input type="text" name="key" id="key" class="field textInput mini" />
                    </div>
                    <div id="centumrangee" style="display: none">
                        从
                        <input type="text" name="beg" id="beg" class="field textInput mini" />
                        到<input type="text" name="end" id="end" class="field textInput mini" />
                    </div>
                    <div id="daterangee">
                        <Public:DateRangeControl ID="DateRangeControl1" runat="server" />
                    </div>
                    <div id="viptype" style="display: none">
                        <Public:VipTypeSelector ID="viptypename"  runat="server" />
                    </div>
                    <div id="depot" style="display: none">
                        <input type="button" id="btndepot" value="选择店铺" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
