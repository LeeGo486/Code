<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.Master" AutoEventWireup="true"
    CodeBehind="BDepotSelBox.aspx.cs" Inherits="F23Web.Public.BDepotSelBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <Base:GridControl ID="GridControl1" runat="server" CssClass="display" AllowFilter="True"
        AllowSort="True" HightLight="True" RowSelectType="Single" ServerSide="false"
        Width="100%" Height="100%" BottomHeight="70" OnRowDoubleClick="e_submit" AllowPaginate="true"
        DisplayInfo="true" DisplayLength="30" AjaxSource="GetList" StateSave="true">
    </Base:GridControl>
</asp:Content>
