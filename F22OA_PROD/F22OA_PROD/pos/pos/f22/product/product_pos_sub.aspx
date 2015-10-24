<%@ page language="C#" autoeventwireup="true" inherits="pos_pos_f22_product_product_pos_sub, App_Web_product_pos_sub.aspx.c56c8da6" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>产品维修登记</title>
    <link href="../css/f22.css" rel="stylesheet" type="text/css" />
    <link href="CSS/product_pos_subStyle.css" rel="stylesheet" type="text/css" />

    <script src="JS/js/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script src="../../../inc/js/setday.js" type="text/javascript"></script>

    <script src="JS/js/pos_pruduct_subJS.js" type="text/javascript"></script>

</head>
<body>
    <form id="pos_subForm" runat="server" onsubmit="return checkMsg()">
    <asp:ScriptManager ID="pos_subScriptManger" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <div id="pos_subContent">
        <div id="changeColorSize">
             <img  id="imgWait" src="image/wait.gif" alt="" class="showimg"/>
            <table id="cmTab" class="cMainTab" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="cMainOneTd">
                        款式编号：<span id="styleNum"></span>
                        <input type="hidden" id="hid_colorAndSize" />
                        <input type="hidden" id="hid_colorAndSizeId" />
                    </td>
                </tr>
                <tr>
                    <td class="cMainTwoTd">
                        <table class="intersectionTab" id="conTab">
                            <tr>
                                <td class="leftTopTd">
                                </td>
                                <td class="rightTopTd">
                                    <table id="colorTab">
                                        <tr id="colorTr">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="leftBottomTd">
                                    <table id="sizeTab">
                                    </table>
                                </td>
                                <td valign="top" class="rightBottomTd">
                                    <table id="contentTab">
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="cMainFoot">
                        <h4>
                            按空格键或者回车键选定尺码和颜色！</h4>
                    </td>
                </tr>
            </table>
        </div>
        <table width="100%" cellpadding="2" cellspacing="0" border="1" bordercolor="#ECD4D0"
            bordercolorlight="#FFFFFF" class="f12">
            <tr>
                <td class="titleTd">
                    区&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 域：
                </td>
                <td>
                    <asp:TextBox ID="txt_areaName" runat="server" ReadOnly="true"></asp:TextBox>
                </td>
                <td class="titleTd">
                    受理店铺：
                </td>
                <td>
                    <asp:TextBox ID="txt_accept_dname" runat="server" ReadOnly="true"></asp:TextBox>
                    <asp:HiddenField ID="hid_accept_dId" runat="server" />
                </td>
                <td class="titleTd">
                    受理日期：
                </td>
                <td>
                    <input id="txt_accept_date" type="text" runat="server" onfocus="setday(this);" />
                </td>
            </tr>
            <tr>
                <td class="titleTd">
                    款式编号：
                </td>
                <td>
                    <input id="txt_styleNum" runat="server" type="text" />
                </td>
                <td class="titleTd">
                    尺&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：
                </td>
                <td>
                    <input id="txt_size" type="text" readonly="readonly" />
                    <asp:HiddenField ID="hid_size" runat="server" />
                </td>
                <td class="titleTd">
                    颜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：
                </td>
                <td>
                    <input id="txt_color" type="text" readonly="readonly" runat="server" />
                    <asp:HiddenField ID="hid_color" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="titleTd">
                    货物编号：
                </td>
                <td>
                    <asp:TextBox ID="txt_clothingid" runat="server"></asp:TextBox>
                </td>
                <td class="titleTd">
                    零售价：
                </td>
                <td>
                    <input id="txt_x_price" type="text" runat="server" readonly="readonly" />
                </td>
                <td class="titleTd">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </tr>
            <tr>
                <td class="titleTd">
                    购买价格：
                </td>
                <td>
                    <asp:TextBox ID="txt_s_price" runat="server"></asp:TextBox>
                </td>
                <td class="titleTd">
                    购买日期：
                </td>
                <td>
                    <input id="txt_buy_date" type="text" runat="server" onfocus="setday(this);" />
                </td>
                <td class="titleTd">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td class="titleTd">
                    顾客姓名：
                </td>
                <td>
                    <asp:TextBox ID="txt_retailname" runat="server"></asp:TextBox>
                </td>
                <td class="titleTd">
                    联系方式：
                </td>
                <td>
                    <asp:TextBox ID="txt_tel" runat="server"></asp:TextBox>
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td class="titleTd">
                    新旧程度：
                </td>
                <td>
                    <asp:TextBox ID="txt_newold" runat="server"></asp:TextBox>
                </td>
                <td class="titleTd">
                    维修时限：
                </td>
                <td>
                    <asp:TextBox ID="txt_repairday" runat="server"></asp:TextBox>
                </td>
                <td class="titleTd">
                    紧急程度：
                </td>
                <td>
                    <asp:TextBox ID="txt_exigence" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="titleTd">
                    维修内容：
                </td>
                <td colspan="5">
                    <textarea id="txt_repairtext" cols="50" rows="5" runat="server" class="txtBox"></textarea>
                </td>
            </tr>
            <tr>
                <td class="titleTd">
                    运输方式：
                </td>
                <td>
                    <asp:TextBox ID="txt_retype" runat="server"></asp:TextBox>
                </td>
                <td class="titleTd">
                    运输公司：
                </td>
                <td>
                    <asp:TextBox ID="txt_recompany" runat="server"></asp:TextBox>
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td class="titleTd">
                    提货电话：
                </td>
                <td>
                    <asp:TextBox ID="txt_retel" runat="server"></asp:TextBox>
                </td>
                <td class="titleTd">
                    提货地点：
                </td>
                <td>
                    <asp:TextBox ID="txt_readd" runat="server"></asp:TextBox>
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td class="titleTd">
                    收货人：
                </td>
                <td>
                    <asp:TextBox ID="txt_rename" runat="server"></asp:TextBox>
                </td>
                <td class="titleTd">
                    收货电话：
                </td>
                <td>
                    <asp:TextBox ID="txt_renametel" runat="server"></asp:TextBox>
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td class="titleTd">
                    退回意见：
                </td>
                <td colspan="5">
                    <asp:TextBox ID="txt_renameText" runat="server" Width="586px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="6" style="text-align: center;">
                    <asp:Button ID="btn_save" runat="server" Text="保  存  内  容" OnClick="btn_save_Click" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btn_submit" runat="server" Text="马  上  提  交" OnClick="btn_submit_Click" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input id="btn_close" type="button" value="关  闭  窗  口" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
