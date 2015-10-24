<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.Master" AutoEventWireup="true"
    CodeBehind="PPDepotSelBox.aspx.cs" Inherits="F23Web.POS.Public.PDepotSelBox" %>

<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:GridControl ID="GridControl1" runat="server" CssClass="display" AllowFilter="True"
        AllowSort="True" HightLight="True" RowSelectType="Single" ServerSide="false"
        Width="100%" Height="100%" BottomHeight="70" OnRowDoubleClick="e_submit"
        AllowPaginate="true" DisplayInfo="true" DisplayLength="30" AjaxSource="GetList" StateSave="true">
    </cc1:GridControl>
</asp:Content>
