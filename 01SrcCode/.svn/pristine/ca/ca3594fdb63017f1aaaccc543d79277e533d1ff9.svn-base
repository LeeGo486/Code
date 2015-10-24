<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VipTicketResend.aspx.cs" Inherits="VipTicketResend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>积分兑换券重发</title>
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>

    <style type="text/css">
        body
        {
            font-size: 13px;
            font-family: Arial, "Helvetica Neue", Helvetica, Sans-Serif;
            color: #1a3e66;
            background-color: #fff;
            text-align: center;
            margin: 5px auto;
        }

        div
        {
            text-align: left;
        }

        .Tmain
        {
            border-collapse: collapse;
            border: 1px solid #E3E3E3;
        }

            .Tmain tr
            {
                font-family: Arial;
                border: 1px solid #E3E3E3;
                text-align: center;
                height: 20px;
                font-size: 13px;
            }

                .Tmain tr:hover
                {
                    font-family: Arial;
                    background-color: #F1F1F1;
                }

            .Tmain th
            {
                border: 1px solid #E3E3E3;
                background-color: #F1F1F1;
                text-align: center;
                font-weight: normal;
                vertical-align: middle;
                height: 20px;
            }

            .Tmain td
            {
                vertical-align: middle;
                border: 1px solid #E3E3E3;
                height: 20px;
                overflow: hidden;
                white-space: nowrap;
                color: #666;
                padding: 4px;
            }
    </style>
    <script>

        //Jquery扩展，获取URL的参数值：调用方法：$.getUrlParam('cid');
        (function ($) {
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return "";

            }
        })(jQuery);

        function MSMResend(type,phone,crdate,sums,ticketid,verifycode,vipid) {
            var newPhone = "";
            if(type == "0")
            {
                newPhone = window.prompt("请输入手机号","");
            }

            var struid = $.getUrlParam('uid');

            if( newPhone !="" || type=="1")  //当用户输入内容，点确定后；
            {
                var name = document.getElementById("<%= lblName.ClientID %>").innerText;
                $.ajax({
                    url: "VipTicketResend.aspx?action=resend&oldphone="+phone+"&newphone="+newPhone+"&crdate="+crdate+"&sums="+sums+"&ticketid="+ticketid+"&verifycode="+verifycode+"&rd="+Math.random()+"&Name="+escape(name)+"&vipid="+escape(vipid)+"&uid="+struid,
                    async: false,

                    success: function (data) {
                        alert(eval("[" + data + "]")[0].Message);
                    }
                });
                
                return true;
            }
            else
            {
                alert("手机号不能为空!");
            }

           
        }


    </script>
</head>
<body>
    <form id="form1" runat="server">

        <h3>积分兑换券重发</h3>
            手机号/卡号：<asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
            <asp:Button ID="btnExec" runat="server" click="form1.submit();" Text="查询" />
        <div style="width: 600px; margin-left: auto; margin-right: auto; text-align:left">
           
        <p style="text-align:center;">&nbsp;</p>
        <p style="text-align:center;">&nbsp;<asp:Label ID="lblMessage" runat="server"></asp:Label></p>
        
        <p>姓名：<asp:Label ID="lblName" runat="server"></asp:Label></p>
        <table class="Tmain" style="width: 600px;">
           
            <tr>
                <th>券号
                </th>
                <th>面值
                </th>
                <th>是否使用
                </th>
                <th>创建日期
                </th>
                
                <th>
                </th>
            </tr>
            <asp:Repeater ID="RpList" runat="server">
                <ItemTemplate>
                    <tr runat="server" id="tr1" style="text-align: left">

                        <td>
                            <%# Eval("券号").ToString()%>
                        </td>
                        <td>
                            <%# Eval("面值").ToString()%>
                        </td>
                        <td>
                            <%# Eval("是否使用").ToString()%>
                        </td>
                        <td>
                            <%# Eval("创建日期").ToString()%>
                        </td>
                        <td>
                           
                            <input type="button" onclick="MSMResend('1','<%# Eval("mobtel").ToString()%>','<%# Eval("创建日期").ToString()%>','<%# Eval("面值").ToString()%>','<%# Eval("券号").ToString()%>','<%# Eval("验证码").ToString()%>','<%# Eval("vipid").ToString()%>')" value="发送" />
                            <input type="button" onclick="MSMResend('0','<%# Eval("mobtel").ToString()%>','<%# Eval("创建日期").ToString()%>','<%# Eval("面值").ToString()%>','<%# Eval("券号").ToString()%>','<%# Eval("验证码").ToString()%>','<%# Eval("vipid").ToString()%>')" value="发送到指定手机" />
                        </td>

                        <%--<td style="text-align: right">
                        <%# DataBinder.Eval(Container.DataItem, "单耗", "{0:0.00}").ToString()%>
                    </td>
                    <td style="text-align: right">
                        <%# DataBinder.Eval(Container.DataItem, "在库库存", "{0:0.00}").ToString()%>
                    </td>

                    <td style="text-align: right">
                        <%# DataBinder.Eval(Container.DataItem, "待检库存", "{0:0.00}").ToString()%>
                    </td>
                    <td id="td1" style="text-align: right">
                        <%# Eval("可造件数").ToString()%>
                    </td>
                    <td>
                        <%# Eval("单位").ToString()%>
                    </td>--%>
                    </tr>
                </ItemTemplate>

            </asp:Repeater></div>
    </form>
</body>
</html>
