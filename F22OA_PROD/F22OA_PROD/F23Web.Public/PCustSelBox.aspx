<%@ Page Title="顾客列表" Language="C#" MasterPageFile="~/MasterPage/Modal.Master" AutoEventWireup="true"
    CodeBehind="PCustSelBox.aspx.cs" Inherits="F23Web.POS.Public.PCustSelBox" %>

<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="toolbar">
        <a id="btnadd" style="color: Blue; cursor: hand"><u>顾客新增</u></a></label>
    </div>
    <cc1:GridControl ID="GridControl1" runat="server" CssClass="display" AllowFilter="True"
        AllowSort="True" HightLight="True" RowSelectType="Single" ServerSide="false"
        Width="100%" Height="100%" BottomHeight="70" AllowPaginate="true" DisplayInfo="false"
        DisplayLength="15" AjaxSource="GetList" StateSave="true" Toolbar="#toolbar" OnRowDoubleClick="e_submit">
    </cc1:GridControl>
</asp:Content>
