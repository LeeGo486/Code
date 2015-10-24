<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true"
    CodeBehind="ShowClothing.aspx.cs" Inherits="F23Web.Public.ShowClothing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <Base:GridControl ID="GridControl1" runat="server" RowSelectType="Single" BottomHeight="60"
        AllowSort="true" >
        <columns>
            <Base:GridControlColumn Caption="店铺编号" ColumnName="depotid" Width="150" />
            <Base:GridControlColumn Caption="店铺名称" ColumnName="d_name" Width="150" />
            <Base:GridControlColumn Caption="可配库存" ColumnName="p_num" Width="80" />
            <Base:GridControlColumn Caption="目前库存" ColumnName="k_num" Width="80" />
        </columns>
    </Base:GridControl>
</asp:Content>