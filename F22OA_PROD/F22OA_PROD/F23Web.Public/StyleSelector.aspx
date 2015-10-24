<%@ Page Title="选择款式" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true"
    CodeBehind="StyleSelector.aspx.cs" Inherits="F23Web.Public.StyleSelector" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="lib/tabs/jquery.ui.tabs.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="tabs">
        <ul>
            <li><a href="#MultiSelector"><span>按款式</span></a></li>
            <li><a href="#TypeSelector"><span>其它方式</span></a></li>
        </ul>
        <div id="MultiSelector">
            <Base:MultiSelector ID="MultiSelector1" runat="server" />
        </div>
        <div id="TypeSelector">
            <table height="350">
                <tr height="20" align="center">
                    <td>
                        <font size="2">年份</font>
                    </td>
                    <td>
                        <font size="2">季节</font>
                    </td>
                    <td>
                        <font size="2">波段</font>
                    </td>
                    <td>
                        <font size="2">种类</font>
                    </td>
                    <td>
                        <font size="2">大类</font>
                    </td>
                    <td>
                        <font size="2">小类</font>
                    </td>
                    <td>
                        <font size="2">品牌</font>
                    </td>
                    <td>
                        <font size="2">性别</font>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Base:SelectBox ID="years" runat="server" Height="300" Width="70" CssClass="field">
                        </Base:SelectBox>
                    </td>
                    <td>
                        <Base:SelectBox ID="months" runat="server" Height="300" Width="70" CssClass="field">
                        </Base:SelectBox>
                    </td>
                    <td>
                        <Base:SelectBox ID="bd" runat="server" Height="300" Width="70" CssClass="field">
                        </Base:SelectBox>
                    </td>
                    <td>
                        <Base:SelectBox ID="zl" runat="server" Height="300" Width="70" CssClass="field">
                        </Base:SelectBox>
                    </td>
                    <td>
                        <Base:SelectBox ID="dl" runat="server" Height="300" Width="70" CssClass="field">
                        </Base:SelectBox>
                    </td>
                    <td>
                        <Base:SelectBox ID="xl" runat="server" Height="300" Width="70" CssClass="field">
                        </Base:SelectBox>
                    </td>
                    <td>
                        <Base:SelectBox ID="brandid" runat="server" Height="300" Width="70" CssClass="field">
                        </Base:SelectBox>
                    </td>
                    <td>
                        <Base:SelectBox ID="sex" runat="server" Height="300" Width="70" CssClass="field">
                        </Base:SelectBox>
                    </td>
                </tr>
                <tr height="20" align="center">
                    <td>
                        <font size="2"><a id="btnyears" name="btnyears" style="cursor: hand">全选</a> <a id="btnunyears"
                            name="btnunyears" style="cursor: hand">取消</a></font>
                    </td>
                    <td>
                        <font size="2"><a id="btnmonths" name="btnmonths" style="cursor: hand">全选</a> <a
                            id="btnunmonths" name="btnunmonths" style="cursor: hand">取消</a></font>
                    </td>
                    <td>
                        <font size="2"><a id="btnbd" name="btnbd" style="cursor: hand">全选</a> <a
                            id="btnunbd" name="btnunbd" style="cursor: hand">取消</a></font>
                    </td>
                    <td>
                        <font size="2"><a id="btnzl" name="btnzl" style="cursor: hand">全选</a> <a id="btnunzl"
                            name="btnunzl" style="cursor: hand">取消</a></font>
                    </td>
                    <td>
                        <font size="2"><a id="btndl" name="btndl" style="cursor: hand">全选</a> <a id="btnundl"
                            name="btnundl" style="cursor: hand">取消</a></font>
                    </td>
                    <td>
                        <font size="2"><a id="btnxl" name="btnxl" style="cursor: hand">全选</a> <a id="btnunxl"
                            name="btnunxl" style="cursor: hand">取消</a></font>
                    </td>
                    <td>
                        <font size="2"><a id="btnbrand" name="btnbrand" style="cursor: hand">全选</a> <a id="btnunbrand"
                            name="btnunbrand" style="cursor: hand">取消</a></font>
                    </td>
                    <td>
                        <font size="2"><a id="btnsex" name="btnsex" style="cursor: hand">全选</a> <a id="btnunsex"
                            name="btnunsex" style="cursor: hand">取消</a></font>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
