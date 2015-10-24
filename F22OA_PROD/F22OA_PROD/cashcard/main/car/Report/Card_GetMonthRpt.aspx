<%@ page language="C#" masterpagefile="~/cashcard/main/car/carmaster.master" autoeventwireup="true" inherits="car_Report_Card_GetMonthRpt, App_Web_card_getmonthrpt.aspx.1bbd70f" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">
    <CR:CrystalReportViewer ID="cryReportView" runat="server" AutoDataBind="true" />
</asp:Content>
