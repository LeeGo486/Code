<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Report.Master" AutoEventWireup="true"
    CodeBehind="PreView.aspx.cs" Inherits="F23Web.ReportDesign.Report.PreView" %>

<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        body, html
        {
            overflow: hidden;
        }
        .progressbar
        {
            position: absolute;
            top: 35%;
            left: 50%;
            width: 250px;
            height: 30px;
            margin-left: -125px;
            margin-top: -15px;
            padding: 14px 0 2px 0;
            border: 0px solid #ddd;
            text-align: center;
            background-position: 75px center;
        }
        .divinfo
        {
            position: absolute;
            top: 100px;
            left: 50%;
            margin-left: -300px;
            width: 600px;
            height: 250px;
            font-size: 14px;
            padding: 20px 10px;
            border: 0px solid #ddd;
            text-align: left;
            display: none;
            z-index: 10;
            background-position: 75px center;
            background-color: #ffd;
            border: solid 1px #ccc;
            overflow: auto;
        }
        .divinfo h3
        {
            line-height: 30px;
        }
        .divinfo p
        {
            line-height: 20px;
            font-size: 14px;
            color: #333;
        }
        .divinfo-content
        {
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <span class="progressbar" id="progressbar">0% </span>
    <div class="divinfo">  
        <h3>
            报表说明
        </h3>
        <div id="rptreadme" runat="server">
        </div>
        <h3>
            报表设计说明
        </h3>
        <div id="desreadme" runat="server">
        </div>
    </div>
    <cc1:ToolbarControl ID="ToolbarControl1" runat="server">

    </cc1:ToolbarControl>
    </div>
    <div id="toolbar" runat="server">
    
    </div>
    <div style="width: 100%; ">
        <iframe id="grid" src="blank.aspx" style="width: 100%; overflow: hidden;" frameborder="0">
        </iframe>
    </div>
    <div id="divdate" style="display: none">
        <cc1:DatePicker ID="date" class="field textInput" runat="server" />
    </div>
    
</asp:Content>
