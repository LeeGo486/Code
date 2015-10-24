<%@ page language="C#" autoeventwireup="true" inherits="Modal_retail_checkout, App_Web_retail_checkout.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>收银</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
<%--    <script src="../Utility/jquery-1.2.6.min.js" type="text/javascript"></script>--%>
    <script src="../../jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../Utility/jquery.blockUI.js" type="text/javascript"></script>
    <script src="../Utility/command.js" type="text/javascript"></script>
<%--    <script src="../Utility/trans.js" type="text/javascript"></script>--%>
    <script src="../Utility/TransMulti.js?v=20141127" type="text/javascript"></script>
    <script type="text/javascript" src="scripts/checkout.js?v=20141127"></script>
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        td
        {
            height: 25px;
            line-height: 25px;
            font-size: 14px;
        }
        td input, td select
        {
            border: solid 1px #CCC;
        }
        .binput
        {
            height: 22px;
            line-height: 22px;
            font-size: 14px;
            font-family: Arial;
            font-weight: bold;
            padding: 0 5px;
            margin: 0;
        }
        td span
        {
            height: 25px;
            line-height: 25px;
            font-family: Arial;
        }
        #payment thead td
        {
            text-align: center;
        }
        #ptemplate
        {
            display: none;
        }
        #btnIsCash
        {
            font-size:12px;
            color:Blue;
            cursor:pointer;
            text-decoration:underline;	
        }
        .TryAgain
        {
            color:red;
            font-size:14px; 
            cursor:pointer;
            text-decoration:underline;    
            font-weight:normal;
        }

    </style>
</head>
<body>
 <object ID="ocx" WIDTH=0 HEIGHT=0 CLASSID="CLSID:E2EEEA3B-34C4-43B7-B7AC-CB12DCA6FBBE">
</object>
    <form id="form1" runat="server">
    <input type="hidden" id="employeeid" />
    <div style="padding: 10px 15px;">
        <table style="width: 98%;">
            <tr>
                <td align="right" width="25%">
                    现价总额：
                </td>
                <td width="25%">
                    ￥&nbsp;&nbsp;<asp:Label ID="Label1" runat="server" Text="0"></asp:Label>
                </td>
                <td align="right" width="25%">
                    销售总量：
                </td>
                <td width="25%">
                    <asp:Label ID="Label2" runat="server" Text="0"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    应收总额：
                </td>
                <td>
                    ￥&nbsp;&nbsp;<asp:Label ID="Label6" runat="server" Text="0"></asp:Label>
                </td>
                <td align="right">
                    <span style="color: Red">促销优惠：</span>
                </td>
                <td>
                    <span style="color: Red">￥&nbsp;&nbsp;</span><asp:Label ID="Label3" runat="server"
                        Text="0" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    实 收：
                </td>
                <td colspan="3">
                    ￥&nbsp;&nbsp;<asp:TextBox ID="TextBox2" runat="server" CssClass="binput"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    找 零：
                </td>
                <td colspan="3">
                    ￥&nbsp;&nbsp;<asp:Label ID="Label4" runat="server" Text="0"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    营业员编号：
                </td>
                <td colspan="3">
                    &nbsp;&nbsp;<asp:TextBox ID="TextBox3" runat="server" CssClass="binput"></asp:TextBox>
                    <input id="F8" type="button" value="选择..." class="btn2" style="width: 50px; height: 23px;" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    营业员姓名：
                </td>
                <td colspan="3">
                    &nbsp;&nbsp;<asp:Label ID="Label5" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <div style="text-align: center;">
            <input id="F2" type="button" value="收　银[F2]" class="btn2" style="width: 70px; height: 22px;"
                disabled="disabled" />
            <%if (useICBC)
              {%>
            <input id="F4" type="button" value="刷　卡[F4]" class="btn2" style="width: 70px; height: 22px;"
                disabled="disabled" />            
            <%} if (useCashCard)
              {%>
            <input id="F3" type="button" value="充值卡[F3]" class="btn2" style="width: 70px; height: 22px;"
                disabled="disabled" />
            <%} if (useScore)
              {%>
            <input id="F5" type="button" value="积分抵扣[F5]" class="btn2" style="width: 75px; height: 22px;"
                disabled="disabled" />
            <%} if (useTicket)
              {%>
            <input id="F6" type="button" value="使用现金券[F6]" class="btn2" style="width: 90px; height: 22px;"
                disabled="disabled" />
            <%} %>
            <%--<input id="F9" type="button" value="" class="btn2" style="width:0px;height:0px;" />--%>
            <input id="Button2" type="button" value="取　消[Esc]" class="btn2" style="width: 70px;
                height: 22px;" />
        </div>
        <br />
        <div>
            <table style="width: 98%;" id="payment" cellpadding="3" cellspacing="0">
                <thead>
                    <tr>
                        <td>
                            收款方式
                        </td>
                        <td>
                            收款金额
                        </td>
                        <td>
                            币种
                        </td>
                        <td>
                            卡号
                        </td>
                        <td style="width:100px;">
                            备注
                        </td>
                    </tr>
                </thead>
                <tbody id="pbody">
                    <tr>
                        <td colspan="5" align="center">
                            <br />
                            <br />
                            <br />
                            <img src="../Images/loading.gif" alt="" align="absmiddle" />
                            加载中...
                            <br />
                            <br />
                            <br />
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td align="right">
                            合计：
                        </td>
                        <td colspan="4">
                            <span id="hjsums">0</span> <span style="color: red">未分配：</span><span id="wfsums"
                                style="color: red">0</span>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
        <asp:HiddenField ID="thType" runat="server" />
        <asp:HiddenField ID="PayCode" runat="server" />
        <asp:HiddenField ID="userid" runat="server" />
        <asp:HiddenField ID="jsums" runat="server" />
        <asp:HiddenField ID="vipcode" runat="server" />
        <asp:HiddenField ID="zssums" runat="server" />
        <asp:HiddenField ID="UseBankCard" runat="server" />
        <asp:HiddenField ID="busicode" runat="server" Value="" />
        <input type="hidden" id="severDay" value="<%=System.DateTime.Now.Day.ToString() %>" />
        <div style="display: none;">
            <asp:DropDownList ID="crtype" runat="server" CssClass="text">
            </asp:DropDownList>
        </div>
        <div id="printArea">
        </div>
    </div>
    </form>
</body>
</html>
