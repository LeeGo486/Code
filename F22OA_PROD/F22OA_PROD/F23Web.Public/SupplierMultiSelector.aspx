<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true" CodeBehind="SupplierMultiSelector.aspx.cs" Inherits="F23Web.Public.SupplierMultiSelector" %>
<%@ Register assembly="F23Base.Controls" namespace="F23Base.Controls" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <cc1:MultiSelector ID="MultiSelector1" runat="server" />

</asp:Content>
