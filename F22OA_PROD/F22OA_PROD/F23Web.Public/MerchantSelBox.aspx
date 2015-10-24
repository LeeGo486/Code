<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true" CodeBehind="MerchantSelBox.aspx.cs" Inherits="F23Web.Public.MerchantSelBox" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <Base:GridControl ID="GridControl1" runat="server" CssClass="display" AllowFilter="True"
        AllowSort="True" HightLight="True" RowSelectType="Single" ServerSide="false"
        Width="100%" AllowPaginate="false" DisplayInfo="false" Height="100%" BottomHeight="70"
        OnRowDoubleClick="e_submit">
    </Base:GridControl>
</asp:Content>
