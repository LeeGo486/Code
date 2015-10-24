<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true" CodeBehind="BookDetails.aspx.cs" Inherits="EPReper.Web.EPSafe.BookDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SafeContentPlace" runat="server">
    <link rel="stylesheet" type="text/css" href="style/Css/base.min.css">
    <link id="templateFrame" rel="stylesheet" type="text/css" href="style/Css/332.min.css">
    <script type="text/javascript" src="style/Script/jquery-1.6.4.min.js"></script>
    <script type="text/javascript" src="style/Script/fai.min.js"></script>
    <script type="text/javascript" src="style/Script/jquery.imageSwitch.js"></script>
 <div>
        <p style="font-size: 18px; font-weight: bold; text-align: center;  padding:10px;">
            <asp:Label ID="lbtitle" runat="server" Text=""></asp:Label>
        </p>
        <p align="center" style="font-size: 12px;">
            <asp:Label ID="lbAinfo" runat="server" Text=""></asp:Label>
        </p>
    </div>
    <hr />
    <br />
    <div style="line-height: 30px; overflow: hidden; font-size: 14px; width: 880px; white-space: normal;">
        <asp:Label ID="lbcontent" runat="server" Text=""></asp:Label></div>
    <br />
    <br />
    <hr />
</asp:Content>
