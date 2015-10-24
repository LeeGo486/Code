<%@ Page Title="查找款式" Language="C#" MasterPageFile="~/MasterPage/Modal.master" AutoEventWireup="true" 
CodeBehind="FindStyle.aspx.cs" Inherits="F23Web.Public.FindStyle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <Base:GridControl ID="GridControl1" runat="server" AllowFilter="true" RowSelectType = "Single" AllowSort="true"
      OnRowSelected = "dgRowSelect"  OnRowDoubleClick="dgRowDbClick" BottomHeight="50">
        <columns>
            <Base:GridControlColumn  ColumnName="styleid" Caption="款式编号" Width="100" />
            <Base:GridControlColumn  ColumnName="s_name" Caption="款式名称" Width="120" />
            <Base:GridControlColumn  ColumnName="drname" Caption="品牌" Width="80" />
            <Base:GridControlColumn  ColumnName="st_year" Caption="年份" Width="60" />
            <Base:GridControlColumn  ColumnName="st_month" Caption="季节" Width="60" />
            <Base:GridControlColumn  ColumnName="st_type" Caption="类型" Width="80" />
            <Base:GridControlColumn  ColumnName="st_cloth" Caption="布种" Width="80" />
        </columns>
    </Base:GridControl>
</asp:Content>
