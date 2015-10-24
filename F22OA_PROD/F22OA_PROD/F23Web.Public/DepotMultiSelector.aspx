<%@ Page Title="选择仓店" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true"
    CodeBehind="DepotMultiSelector.aspx.cs" Inherits="F23Web.Public.DepotMultiSelector" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <Base:StateSelector ID="StateSelector1" runat="server" DefaultValue="1" Callback="e_change">
        <Status>
            <Base:StateItem Text="按店铺" Value="1" />
            <Base:StateItem Text="按地区" Value="2" />
        </Status>
    </Base:StateSelector>
    <Base:MultiSelector ID="MultiSelector1" runat="server" />
</asp:Content>
