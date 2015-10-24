<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.master" 
AutoEventWireup="true" CodeBehind="ClipboardInput.aspx.cs" Inherits="F23Web.Public.ClipboardInput" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <div id="ClipboardType" runat="server" style="margin:10px 5px">
    </div>
    <Base:GridControl ID="GridControl1" runat="server" Height="200px" OnRowSelected="rowselected"
        InitComplete="initComplete" ShowFooter="false">
    </Base:GridControl>
</asp:Content>
