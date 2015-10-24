<%@ page title="选择店铺" language="C#" masterpagefile="~/branch/MasterPages/Base.master" autoeventwireup="true" inherits="branch_Public_DepotMultiSelector, App_Web_depotmultiselector.aspx.730a0094" %>

<%@ Register Src="../Controls/MultiSelector.ascx" TagName="MultiSelector" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        body,html
        {
            overflow: hidden;
        }
    </style>

    <script src="Scripts/DepotMultiSelector.js?v=?1.0.0.8" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">   
    <uc1:MultiSelector ID="MultiSelector1" runat="server" />
    <table border="0" cellspacing="5" width="100%">
        <tr>
            <td align="center">
                <button type="button" name="ok">
                    确 定 [F5]</button>
                <button type="button" name="cancel">
                    取 消 [ESC]</button>
            </td>
        </tr>
    </table>
</asp:Content>
