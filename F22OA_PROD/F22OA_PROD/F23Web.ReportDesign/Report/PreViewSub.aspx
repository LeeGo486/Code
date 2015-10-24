<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Report.Master" AutoEventWireup="true"
    CodeBehind="PreViewSub.aspx.cs" Inherits="F23Web.ReportDesign.Report.PreViewSub" %>

<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">   
    <style type="text/css">
        body, html
        {
            background: #fff !important;
            overflow:hidden;
        }
       
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="key" class="field" name="key" />
    <div id="toolbar">
    </div>
    <div class="grid" style="height: 100%!important; overflow: hidden;  margin-left:5px; margin-top:-25px">
        <cc1:GridControl ID="GridControl1" AjaxSource="PreViewSub.aspx/GetList" ServerSide="true"
            ServerData="query"  AllowSort="true" AllowPaginate="true" AllowFilter="false"
            RowSelectType="Single" OnRowDoubleClick="ShowDialog"
            AjaxParams="getparams"  AutoLoad="true" runat="server" DisplayLength="50" Toolbar="#toolbar" DisplayInfo="true">
        </cc1:GridControl>
    </div>

  
</asp:Content>
