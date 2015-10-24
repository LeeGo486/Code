<%@ page language="C#" autoeventwireup="true" inherits="pos_pos_f22_report_depotIOreport_f22_jxctz2009, App_Web_f22_jxctz2009.aspx.7863a146" enableviewstate="false" %>

<html>
<head runat="server">
    <title>店铺日期进销存台帐</title>

    <script src="js/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script src="js/setday.js" type="text/javascript"></script>

    <link href="css/f22jxctz2009Css.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function changSty() {
            showModalDialog('../../pos/pos/f22/report/select1.asp', 'example04', 'dialogWidth:600px;dialogHeight:500px;center: yes;help:no;resizable:yes;status:no;');
        }
        function checkDay() {
            var bt = document.getElementById("txt_bdate").value;
            var ba = bt.split("-");
            var b = new Date(ba[0], ba[1], ba[2]);
            var et = document.getElementById("txt_edate").value;
            var ea = et.split("-");
            var e = new Date(ea[0], ea[1], ea[2]);
            if (b > e) {
                alert("开始日期应该少于或者等于结束日期!");
                document.getElementById("txt_bdate").focus();
                return false;
            }
            return true;
        }
        function btnCheck(str) {
            $(str).click(function() {
                $(this).hide();
                $("#btn_exl").hide();
                $("#btn_chkStyle").hide();
            });
        }

        jQuery(function() {
            // btnCheck("#btn_search");
        })
    </script>

</head>
<body>
    <form id="form1" runat="server" onsubmit="return checkDay()">
    <div id="main" runat="server">
        <div class="top">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="20%" style="text-align: center;">
                        <input id="btn_chkStyle" type="button" value="选择款式" onclick="changSty();" />
                    </td>
                    <td width="50%" style="text-align: center;">
                        选择日期：
                        <input id="txt_bdate" type="text" runat="server" class="txtSty" onfocus="javascript:setday(this);"
                            readonly="readonly" />
                        到
                        <input id="txt_edate" type="text" runat="server" class="txtSty" onfocus="javascript:setday(this);"
                            readonly="readonly" />
                    </td>
                    <td width="15%" style="text-align: center;">
                        <asp:Button ID="btn_search" runat="server" Text="查询" OnClick="btn_search_Click" />
                    </td>
                    <td width="15%" style="text-align: center;">
                        <asp:Button ID="btn_exl" runat="server" Text="导出Excel" OnClick="btn_exl_Click" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="content" runat="server">
            <asp:GridView ID="gv_content" runat="server" Width="100%" CssClass="gridviewSty"
                EmptyDataText="没有数据">
                <HeaderStyle CssClass="FixedTitleRow" />
                <Columns>
                    <asp:BoundField>
                        <HeaderStyle CssClass="FixedTitleColumn" />
                        <ItemStyle CssClass="FixedDataColumn" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
    </form>
</body>
</html>
