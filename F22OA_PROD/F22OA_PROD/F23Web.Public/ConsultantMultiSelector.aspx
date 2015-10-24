<%@ Page Title="选择形象顾问" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true"
    CodeBehind="ConsultantMultiSelector.aspx.cs" Inherits="F23Web.Public.ConsultantMultiSelector" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <Base:MultiSelector ID="MultiSelector1" runat="server" />
</asp:Content>
