<%@ Page Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="EPReper.Web.EPSafe.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style id="Style1" type="text/css" runat="server">
        .TMsg
        {
            border-collapse: collapse;
            border: 1px solid #E3E3E3;
            margin: 5px 0px 0px 0px;
        }
        .TMsg tr
        {
            border: 1px solid #E3E3E3;
            font-size: 12px;
        }
        .TMsg th
        {
            border: 1px solid #E3E3E3;
            background-color: #F1F1F1;
            text-align: left;
            font-weight: normal;
            padding: 0px;
            color: #666;
            vertical-align: middle;
        }
        .TMsg td
        {
            vertical-align: top;
            border: 1px solid #E3E3E3;
            text-align: left;
            padding: 5px;
            color: #222;
        }
        
        .score
        {
            border: 1px dotted #CCC;
            padding: 10px;
            font-size: 12px;
            margin: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SafeContentPlace" runat="server">
    <div>
        <p style="font-size: 18px; font-weight: bold; text-align: center; padding: 10px;">
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
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="font-size: 12px;">
                <asp:Repeater ID="aqyh" runat="server">
                    <ItemTemplate>
                        <table width="960px" class="TMsg">
                            <tr>
                                <th style="text-align: left; height: 10px; padding: 0px 0px 0px 10px;">
                                    <%# Eval("createperson").ToString()%>&nbsp;&nbsp;
                                    <%# Eval("createtime").ToString() %>
                                </th>
                            </tr>
                            <tr>
                                <td style="min-height: 40px;">
                                    <%# Eval("pitcontents").ToString()%>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
       
        </ContentTemplate>
    </asp:UpdatePanel>
    <hr />
</asp:Content>

