<%@ page language="C#" autoeventwireup="true" inherits="Report_bankcardreport, App_Web_bankcardreport.aspx.7863a146" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>银行卡消费记录</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <script src="../Utility/command.js" type="text/javascript"></script>
    <link href="../Utility/dateChooser.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript"  src="../Utility/jquery-1.2.6.min.js"></script>
    <script type="text/javascript" src="../Utility/dateChooser.js"></script>
    <style type="text/css">
    #research
    {
    	padding:10px 0;
    }
    .calendarSelectDate{ }
    .body
    {
    	padding:10px;
    	}
    </style>
    <script type="text/javascript">
    $(function(){
        $("#loading").hide();
        $("#keyword").keydown(function(){
            if(event.keyCode==13||event.keyCode==10){
                $("#Button1").click();
                return false;
            }
        });
        $("#Button1").click(function(){
           $("#Button5").attr('disabled','disabled');
           $("#HiddenField1").val('');
            $.ajax({
                beforeSend:function(){
                    $("#research").empty();
                    $("#research").html('<div id="loading"><img src="../Images/loading.gif" alt="" align="absmiddle"/> 加载中...</div>');
                    $("#loading").show();
                },
                complete:function(){$("#loading").hide();},
                url: "../ajax/report/bankcardreport.aspx",
                type: "POST",
                data: "begdate="+$("#begdate").val()+"&enddate="+$("#enddate").val(),
                async: true,
                success:function(html){
                    $("#research").html(html);
                },
                error:function(html){
                    alert('数据加载出错！');
                }
            });
        });
        $("#Button2").click(function(){
            location.href="../ajax/report/bankcardreport.aspx?begdate="+$("#begdate").val()+"&enddate="+$("#enddate").val()+"&act=1";
        });
    });
    
    function setevents()
    {
            var row = $("#DataBody").find("tr");
            $.each(row,function(i,obj){
                if(i % 2 == 0)$(obj).css("background-color", "#F7F6F3");
                $(obj).click(function(){
                   $(obj).find(":radio").attr('checked','checked');
                   $(obj).css("background-color", "#E2DED6");
                   $("#Button5").removeAttr('disabled');
                   $("#HiddenField1").val( $(obj).find("input").val());
                });
                
                $(obj).dblclick(function(){
                   $("#HiddenField1").val( $(obj).find("input").val());
                   $("#Button5").removeAttr('disabled');
                   $("#Button5").click();

                });
            
                $(obj).find("a").click(function()
                {
                    openModal('../Modal/Vipinfo.aspx?vipcode=' + ($(obj).find(":radio").val().split('$'))[0],800,450);
                    return false;
                })
            });
    }
    
    </script>

    
</head>
<body>
    <form id="form1" runat="server">
    <div class="bar" id="header">
     工行控件刷卡消费记录查询
    </div>
    <div class="body" style="padding:10px 5px;">
        开始日期：<asp:TextBox ID="begdate" runat="server" cssclass="calendarSelectDate input" Width="80" ReadOnly="true"></asp:TextBox>
        &nbsp;&nbsp;结束日期：<asp:TextBox ID="enddate" runat="server" cssclass="calendarSelectDate input" Width="80" ReadOnly="true"></asp:TextBox>
<%--        &nbsp;&nbsp;汇总：
        <asp:DropDownList 
            ID="DropDownList1" runat="server">
            <asp:ListItem Value=""></asp:ListItem>
            <asp:ListItem Value="setdate">按日期汇总</asp:ListItem>
            <asp:ListItem Value="depotid">按店铺汇总</asp:ListItem>
            <asp:ListItem Value="bankcard">按卡号汇总</asp:ListItem>
        </asp:DropDownList>
       &nbsp;&nbsp;排序：
        <asp:DropDownList ID="DropDownList2" runat="server">
            <asp:ListItem Value="setdate">刷卡日期</asp:ListItem>
            <asp:ListItem Value="depotid">店铺编号</asp:ListItem>
            <asp:ListItem Value="bank_sums">消费金额</asp:ListItem>
            <asp:ListItem Value="bankcard">银行卡号</asp:ListItem>
        </asp:DropDownList>
        <asp:DropDownList ID="DropDownList3" runat="server">
            <asp:ListItem Value="desc">降序</asp:ListItem>
            <asp:ListItem Value="asc">升序</asp:ListItem>
        </asp:DropDownList>
--%>         <input id="Button1" type="button" value="查询" class="btn2" />
        <input id="Button2" type="button" value="导出EXCEL" class="btn2" />
        <%--<input id="Button3" type="button" value="打印" class="btn2" />--%>
        <div id="research">
        
        </div>
    </div>
    </form>
</body>
</html>
