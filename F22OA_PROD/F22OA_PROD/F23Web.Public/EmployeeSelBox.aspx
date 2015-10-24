<%@ Page Title="选择营业员" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true"
    CodeBehind="EmployeeSelBox.aspx.cs" Inherits="F23Web.Public.EmployeeSelBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <Base:GridControl ID="GridControl1" runat="server" RowSelectType="Multiple" BottomHeight="60"
        AllowSort="true" OnRowDoubleClick="e_submit" OnRowSelected="rowselected">
        <columns>
            <Base:GridControlColumn Caption="编号" ColumnName="employeeid" Width="100" />
            <Base:GridControlColumn Caption="工号" ColumnName="employeeno" Width="80" />
            <Base:GridControlColumn Caption="名称" ColumnName="names" Width="80" />
            <Base:GridControlColumn Caption="班次" ColumnName="groupname" Width="60" />
            <Base:GridControlColumn Caption="主要营业员" ColumnName="isMajor" Width="80" CssClass="center"
                Render="majorRender" Sortable="false" Visibled="false" />
        </columns>
    </Base:GridControl>
</asp:Content>
