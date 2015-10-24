<%@ Page Title="打印装箱单" Language="C#" MasterPageFile="~/MasterPage/Base.Master" AutoEventWireup="true"
    CodeBehind="BoxImportPrint.aspx.cs" Inherits="F23Web.Public.BoxImportPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
     .printHtml
     {
      margin:10px 20px;
    } 
     table
    {
    	font-size:12px;
        width:96%;
    }
    .detail
    {

    }
    .noprint
    {
    	margin-top:20px;
    }
     .noprint input
     {
        margin-left:40px;	
    }
    </style>
    <style media="print" type="text/css">
        .noprint { display: none }
    </style>
    <script type="text/javascript">
        function prtHtml() {
            print();
            window.close();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="printHtml" runat="server" class="printHtml">
    </div>
</asp:Content>
