<%@ page language="C#" autoeventwireup="true" inherits="b28web_Append_VIP_ChgVipTzName, App_Web_chgviptzname.aspx.ea5f856c" %>
<%@ Register Assembly="F23Base.Controls" Namespace="F23Base.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>修改拓展人</title>
    <link href="../../Utility/stymain.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
           <div class="x-toolbar">
        <cc1:ToolbarControl runat="server" ID="ToolbarControl1">
            <Buttons>
                 <cc1:ButtonItem ID="btnquery" runat="server" Text="查询" CssClass="icon icon-find" Callback="q_query" />
                 <cc1:ButtonItem ID="btnsure" runat="server" Text="修改" CssClass="icon icon-tick" Callback="e_sure" />
            </Buttons>
        </cc1:ToolbarControl>
        </div>
        &nbsp;
        <select id="seltype" name="seltype" class="field">
            <option value="tz_name">客户经理</option>
            <option value="vipname">顾客姓名</option>
            <option value="vipcode">VIP卡号</option>
            <option value="mobtel">手机号码</option>
        </select>

        <input type="text" id="txt" name="txt" class="field" />

        客户经理：

        <select id="employeeid" name="employeeid" class="field" runat="server">
        </select>

           <cc1:GridControl runat="server" ID="GridControl1"  AllowFilter="false"  AjaxParams="$('.field').serializeObject"      
         AjaxSource="GetList"  RowSelectType="Single"  >
        </cc1:GridControl>
    </form>
</body>
</html>
