<%@ page language="C#" autoeventwireup="true" inherits="Retail_Default, App_Web_default.aspx.832efc68" enableviewstatemac="false" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>B28WEB收银</title>
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <link href="../Utility/dateChooser.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Utility/jquery-1.2.6.min.js"></script>
    <script src="../Utility/jquery.blockUI.js" type="text/javascript"></script>
    <script src="../Utility/command.js" type="text/javascript"></script>
   <%-- <script src="../Utility/trans.js" type="text/javascript"></script>--%>
    <script src="../Utility/TransMulti.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Utility/dateChooser.js"></script>
    <script type="text/javascript" src="../../js/sound.js"></script>
    <script type="text/javascript" src="scripts/retail.js?ver=20150318"></script>
    <script src="../Utility/jquery-autocomplete/jquery.autocomplete.js" type="text/javascript"></script>
    <link href="../Utility/jquery-autocomplete/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/VipIdentify.js" type="text/javascript"></script>
    <style type="text/css">
        #sub_template
        {
            display: none;
        }
        body, html
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        #SheetArea
        {
            overflow: auto;
            width: 100%;
        }
    </style>
</head>
<body>
    <embed id="soundControl" src="../../sound/scan.wav" mastersound hidden="true" loop="false"
        autostart="false"></embed>
 <object ID="ocx" WIDTH=0 HEIGHT=0 CLASSID="CLSID:E2EEEA3B-34C4-43B7-B7AC-CB12DCA6FBBE">
</object>
    <form id="form1" runat="server">
    <div class="bar" id="header">
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    </div>
    <div style="padding: 10px 5px;">
        <div>
            <table>
                <tr>
                    <td>
                        <a href="javascript:;" title="点击签到" id="opentrans">销售店柜</a>：
                        <asp:TextBox ID="DepotName" runat="server" ReadOnly="True" Width="110px" CssClass="input"></asp:TextBox>
                        &nbsp;&nbsp;班&emsp;&emsp;次：
                        <asp:DropDownList ID="x_name" runat="server" Width="100px" CssClass="input">
                        </asp:DropDownList>
                        &nbsp;&nbsp;销售日期：<asp:TextBox ID="setdate" runat="server" Width="94px" Enabled="false"
                            CssClass="input" ReadOnly="true"></asp:TextBox>
                        <!--
                        Enabled="false"
                        ReadOnly="true" 
                        onFocus="setday(this);" 
                        onpropertychange="updateDate(this);" 
                        document.getElementById('dateflag').value='1';
                        <input type="hidden" id="dateflag" value="0" />
                        <input id="chb_date" type="checkbox"/>选择销售日期
                        -->
                          &nbsp; &nbsp;天&emsp;气：
                        <asp:TextBox ID="daystat" runat="server" Width="80px" CssClass="input" ></asp:TextBox>
                         
                        &nbsp;
                        <asp:label runat="server" ID="lblchangetype" Text="打折/退货："> </asp:label>
                        <asp:DropDownList ID="changetype" runat="server" Width="100px" CssClass="input" >
                        </asp:DropDownList>
                        <asp:TextBox ID="reason" runat="server" Width="160px" CssClass="input"
                            AutoCompleteType="Disabled" MaxLength="60"></asp:TextBox>
               <%--         <asp:DropDownList ID="dropreason" runat="server" Width="140px" CssClass="input" >
                        </asp:DropDownList>--%>

                          <input type="text" id="txtdropreason" class="input"  style="width: 120px;" /> 
 
                    </td>
                </tr>
                <tr>
                    <td>
                        款&emsp;&emsp;号：
                        <asp:TextBox ID="key" runat="server" Width="110px" CssClass="input ucase" AutoCompleteType="Disabled"
                            ToolTip="输入款号/款式编号/款式助记码"></asp:TextBox>
                        &nbsp;&nbsp;截&emsp;&emsp;取：
                        <asp:TextBox ID="clothing_len" ToolTip="条码截取位数" MaxLength="2" runat="server" Width="20px"
                            CssClass="input" AutoCompleteType="Disabled"></asp:TextBox>
                        &nbsp;&nbsp;&emsp;整单备注：<asp:TextBox ID="comment" runat="server" Width="158px" CssClass="input"
                            AutoCompleteType="Disabled"></asp:TextBox>
                        &nbsp;&nbsp;&nbsp;优惠卡：
                        <asp:DropDownList ID="shopcard" runat="server" CssClass="input" Width="85px" >
                            <asp:ListItem Text="不使用" Value=""></asp:ListItem>
                        </asp:DropDownList>
                        <a href="javascript:;" title="查询银行卡余额" id="querycard" style="display: ">查询银行卡余额</a>
                      
                    </td>
                </tr>
                <tr>
                    <td>
                     成交渠道：
                           <asp:DropDownList ID="channel" runat="server" CssClass="input" Width="115px">
                        </asp:DropDownList>
                        &nbsp;&nbsp;商场活动：
                        <asp:DropDownList ID="ActPlanID" runat="server" CssClass="input">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div id="gridTab">
            <table id="retailsub" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr>
                        <td class="gw10">
                            款式编号
                        </td>
                        <td class="gw7">
                            颜色
                        </td>
                        <td class="gw7">
                            名称
                        </td>
                        <td class="gw4">
                            尺码
                        </td>
                        <td class="gw4">
                            数量
                        </td>
                        <td class="gw6">
                            原价
                        </td>
                        <td class="gw7">
                            现价
                        </td>
                        <td class="gw7">
                            折扣
                        </td>
                        <td class="gw7">
                            结算单价
                        </td>
                        <td class="gw7">
                            现价总额
                        </td>
                        <td class="gw7">
                            结算总额
                        </td>
                        <td class="gw12">
                            单款备注
                        </td>
                        <td class="gw6">
                            库存
                        </td>
                        <td class="gw10">
                            同区库存
                        </td>
                        <td class="gw10">
                            购买楼层
                        </td>
                        <td class="gw3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr id="sub_template">
                        <td id="sstyleid" class="gw10">
                        </td>
                        <td id="scolorid" class="gw4">
                        </td>
                        <td id="sname" class="gw4">
                        </td>
                        <td id="ssizeid" class="gw4">
                        </td>
                        <td id="snums" class="gw4">
                            <input name="sub_nums" type="text" autocomplete="off" maxlength="7" id="sub_nums"
                                style="width: 89%;" />
                        </td>
                        <td id="sj_price" class="gw6">
                            <span id="sub_j_price">-</span>
                        </td>
                        <td id="sx_price" class="gw7">
                            <span id="sub_x_price"></span>
                        </td>
                        <td id="sdiscount" class="gw7">
                            <input name="sub_discount" type="text" autocomplete="off" id="sub_discount" style="width: 90%;" />
                        </td>
                        <td id="ss_price" class="gw7">
                            <input name="sub_s_price" type="text" autocomplete="off" id="sub_s_price" style="width: 90%;" />
                            <input name="sub_old_s_price" type="hidden" autocomplete="off" id="sub_old_s_price" />
                        </td>
                        <td id="sx_sums" class="gw7">
                            <span id="sub_xsums"></span>
                        </td>
                        <td id="ssums" class="gw7">
                            <span id="sub_sums"></span>
                        </td>
                        <td id="scomment" class="gw12">
                            <input name="sub_comment" type="text" autocomplete="off" id="sub_comment" style="width: 96%;" />
                        </td>
                        <td id="zskc" class="gw6">
                            <span id="sub_zskc"></span>
                        </td>
                        <td id="skc" class="gw4">
                        </td>
                        <td id="floor" class="gw4">
                            <select runat="server" id="sub_floor" name="sub_floor" ></select> 
                        </td>
                        <td id="sdel" class="gw3">
                            <input type="hidden" name="sub_ID" id="sub_ID" />
                            <input type="hidden" name="sub_ClothingID" id="sub_ClothingID" />
                            <input type="hidden" name="sub_olddiscount" id="sub_olddiscount" />
                              <input type="hidden" name="sub_olddiscount2"id="sub_olddiscount2" />
                            <img src="../Images/del.gif" alt="删除" id="sub_del" />
                        </td>
                    </tr>
                </thead>
                <tbody id="sub_body">
                </tbody>
                <tfoot>
                    <tr>
                        <td class="gw10">
                            品种：<span id="ct_style">0</span>
                        </td>
                        <td class="gw4">
                        </td>
                        <td class="gw4">
                        </td>
                        <td class="gw4">
                        </td>
                        <td class="gw4" id="ct_nums">
                            0
                        </td>
                        <td class="gw6">
                        </td>
                        <td class="gw7">
                        </td>
                        <td class="gw7">
                        </td>
                        <td class="gw7">
                        </td>
                        <td class="gw7" id="ct_xsums">
                            0
                        </td>
                        <td class="gw7" id="ct_sums">
                            0
                        </td>
                        <td class="gw12">
                        </td>
                        <td class="gw6">
                        </td>
                        <td class="gw4">
                        </td>
                        <td class="gw4">
                        </td>
                        <td class="gw3">
                            &nbsp;
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
        <div style="width: 100%; text-align: center;">
            <table style="text-align: left; margin: auto;">
               
                <tr>
                    <td align="left">
                        &nbsp;&nbsp;VIP卡：
                        <asp:TextBox ID="vipcard" runat="server" Width="120px" AutoCompleteType="Disabled"
                            CssClass="input ucase"></asp:TextBox>
                        <input id="f1" class="btn2" value="F1 刷VIP卡" type="button" style="width: 80px;" />
                         <input type="checkbox" id="oldnewyn" value="0" style=" display: none" /><input
                            id="f10" class="btn2" value="F10 老带新" type="button" style="width: 75px; display: none" />
                        <input id="f8" class="btn2" value="F8 其他方式" type="button" style="width: 80px;" />
                        <input id="f12" class="btn2" value="F12 消费记录" type="button" style="width: 90px;" />
                        &nbsp;&nbsp;顾客姓名：<asp:Label ID="vipname" runat="server" Text="-"></asp:Label>
                        &nbsp;&nbsp;总积分：<asp:Label ID="centum" runat="server" Text="0"></asp:Label>
                        &nbsp;&nbsp;&nbsp;&nbsp;上单金额：<asp:Label ID="Label2" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <label id="lblvipbjf" runat="server" ><input type="checkbox" checked="checked" id="nocentum" />VIP积分</label>
                        <label id="lblvipbdz" runat="server" ><input type="checkbox" checked="checked" id="chkvipbdz" />VIP打折</label> 
                        <input id="f2" class="btn2" value="F2 正常收银" type="button" style="width: 80px;" />
                        <input id="f3" class="btn2" value="F3 使用券收银" title="折扣券抵值券收银" type="button" style="width: 110px;" />
                        <input id="f3_disabled" class="btn2" value="F3 挂单" type="button" style="width: 60px;
                            display: none;" />
                        <input id="f4_disabled" class="btn2" value="F4 取单" type="button" style="width: 60px;
                            display: none;" />
                        <input id="f5" class="btn2" value="F5 赠送" type="button" style="width: 60px;" />
                        <input id="f6" class="btn2" value="F6 整单打折" type="button" style="width: 80px;" />
                        <input id="f7" class="btn2" value="F7 整单作废" type="button" style="width: 80px;" />
                        <input id="f9" class="btn2" value="F9 退货" type="button" style="width: 60px;" />
                        <input id="f10_disabled" class="btn2" value="F10 手工输入" type="button" style="width: 90px;
                            display: none;" />
                        <input id="f11" class="btn2" value="F11 退换货" type="button" style="width: 70px;" />
                        <input id="f4" class="btn2" value="F4 挂单取单" type="button" style="width: 90px;" />
                        <%--<asp:Label ID="RetailTips" runat="server" Text=""></asp:Label>--%>
                        <asp:HiddenField ID="LocalDateTime" runat="server" />
                        <asp:HiddenField ID="hd_zs" runat="server" Value="0" />
                        <%--赠送--%>
                        <asp:HiddenField ID="hd_back" runat="server" Value="0" />
                        <%--退货--%>
                        <asp:HiddenField ID="retail_zs" runat="server" Value="1" />
                        <%--是否允许赠送--%>
                        <asp:HiddenField ID="retail_back" runat="server" Value="1" />
                        <%--是否允许退货--%>
                        <asp:HiddenField ID="retail_thh" runat="server" Value="1" />
                        <%--允许退换货--%>
                        <asp:HiddenField ID="retail_thType" runat="server" Value="0" />
                        <%--退换货状态--%>
                        <asp:HiddenField ID="retail_yj" runat="server" Value="0" />
                        <%--不显示原价--%>
                        <asp:HiddenField ID="retail_jsj" runat="server" Value="0" />
                        <%--不能改结算价--%>
                        <asp:HiddenField ID="retail_zk" runat="server" Value="0" />
                        <%--不能改折扣--%>
                        <asp:HiddenField ID="retail_dz" runat="server" Value="0" />
                        <%--允许整单打折权限--%>
                        <asp:HiddenField ID="round_type" runat="server" Value="0" />
                        <asp:HiddenField ID="round_bit" runat="server" Value="2" />
                        <asp:HiddenField ID="vipcut" runat="server" Value="0" />
                        <asp:HiddenField ID="vipbeg" runat="server" Value="0" />
                        <asp:HiddenField ID="vipcnt" runat="server" Value="0" />
                        <asp:HiddenField ID="oldvnewv" runat="server" Value="0" />
                        <asp:HiddenField ID="PayCode" runat="server" />
                        <asp:HiddenField ID="isvip" runat="server" Value="0" />
                        <asp:HiddenField ID="showvip" runat="server" Value="0" />
                         <%--强制打折/退货原因--%>
                        <asp:HiddenField ID="checkdisc" runat="server" Value="false" />
                        <asp:HiddenField ID="checkclick" runat="server" Value="0" />
                        <input type="hidden" id="hid_vipcut" value="" />
                        <asp:HiddenField ID="busicode" runat="server" Value="" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="divvippic" style="top: 260px; display: none; left: 470px; width: 100px;
        position: absolute; height: 120px; background-color: #fff; border: 1px solid #cad9ea;">
        <div style="background: url(../images/cat_bg.gif); height: 8px; text-align: left;
            paddint-bottom: 1px">
            <a href="#" id="closevipimg">
                <div class="CloseDropOut" onmouseover="this.className='CloseDropOn'" onmouseout="this.className='CloseDropOut'">
                </div>
            </a><a href="#" id="showvipimg"></a>
        </div>
        <img id="vippic" src="../AJAX/Vip/vipImg.aspx?vipcode=-999" width="100px" height="133px"
            alt="" />
    </div>
    <input type="hidden" id="cx_run" value="0" />
    <input type="hidden" id="cx_runid" value="-1" />
    </form>
</body>
</html>
