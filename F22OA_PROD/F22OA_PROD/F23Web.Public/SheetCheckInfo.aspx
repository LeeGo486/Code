<%@ Page Title="查看检查结果" Language="C#" MasterPageFile="~/MasterPage/Modal.master"
    AutoEventWireup="true" CodeBehind="SheetCheckInfo.aspx.cs" Inherits="F23Web.Public.SheetCheckInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .autolayout
        {
        	table-layout:auto !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <Base:GridControl ID="GridControl1" runat="server" AllowSort="true" InnerWidth="100%"
        BottomHeight="80" InitComplete="initcomplete" CssClass="display autolayout">
    </Base:GridControl>
</asp:Content>
