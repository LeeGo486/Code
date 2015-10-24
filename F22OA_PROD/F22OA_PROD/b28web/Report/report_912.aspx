<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_report_912, App_Web_report_912.aspx.7863a146" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>款色销售预测表</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <script src="../Utility/command.js" type="text/javascript"></script>
    <link href="../Utility/dateChooser.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript"  src="../Utility/jquery-1.2.6.min.js"></script>
    <script type="text/javascript" src="../Utility/dateChooser.js"></script>
    <style type="text/css">
    body{
    	padding:10px;
    }
    #header{
    	text-align:center;
    	padding:10px;
    	line-height:30px;
    	}
    #header{
    	text-align:center;
    	padding:10px;
    	line-height:30px;
    	}
    #research table
    {
    	table-layout:fixed;
    }
    #research thead td
    {
    	text-align:center;
    	width:40px;
    	overflow:hidden;
    }
    #DataBody tr
    {
    	background:#F7F6F3
    }
    #DataBody tr.selected
    {
    	background:#E2DED6
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
        //查询
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
                url: "../ajax/report/report_912.aspx",
                type: "POST",
                data: QueryString(),
                async: true,
                success:function(html){
                    $("#research").html(html);
                    setevents();
                },
                error:function(html){
                    alert('数据加载出错！');
                }
            });
        });
       
        //导出
        $("#Button2").click(function(){
             location.href="../ajax/report/report_912.aspx?&act=1&"+QueryString();
        });
        
        //Selection Style
        $("#Button3").click(function(){
        	var s = openModal('../../pos/pos/f22/report/select3.asp',600,500);
        	return false;
        })
    });
    
    //格式化成整型
    function FormatInt(val)
    {
        var n = parseInt(val);
        return n.toString().toUpperCase()=="NAN"?0:n;
    }
    
    //收集要传送的数据
    function QueryString()
    {
        var begdate = $("#begdate").val();
        var enddate = $("#enddate").val();
        var OrderItem = $("input:radio:checked[@name=OrderItem]").val();
        var OrderField = $("#OrderField").val();
        var OrderType = $("input:radio:checked[@name=OrderType]").val();
        
        var isTotalZT = $("#isTotalZT").attr("checked")?"1":"0";
        var isXTab = $("#isXTab").attr("checked")?"1":"0";
        var ifzero = $("#ifzero").attr("checked")?"1":"0";
        
        return "begdate="+begdate+"&enddate="+enddate+"&OrderItem="+OrderItem+"&OrderField="+OrderField+"&OrderType="+OrderType+
               "&isTotalZT="+isTotalZT+"&isXTab="+isXTab+"&ifzero="+ifzero;
    }
    
    //绑定反回Grid的事件
    function setevents()
    {
        $("#DataBody").find("tr").click(function(){
           $(this).toggleClass("selected");
        });
    }
    
   </script>
    
</head>
<body>

    <form id="form2" runat="server">
     <h3 id="header">
     款色销售预测表
    </h3>
    <div class="toolbar">
        排序：
        <select name="OrderField" id="OrderField">
        <option value="xs">按累计销售数 </option>
        <option value="ps">按累计配送数 </option>
        <option value="db">按累计调拨发货数 </option>
        <option value="szxs">按上周销售数 </option>
        <option value="kc">按库存数</option>
        <option value="zxsl">按总销售率</option>

        </select>
        <input id="RadioButton1" type="radio" name="OrderType" value="1" checked="checked" /><label for="RadioButton1">升序</label>
        <input id="RadioButton2" type="radio" name="OrderType" value="0" /><label for="RadioButton2">降序</label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序方式：<input id="Radio1" type="radio" name="OrderItem" value="0" checked="checked" /><label for="Radio1">系列+SKC</label>
        <input id="Radio2" type="radio" name="OrderItem" value="1" /><label for="Radio2">款式大类+SKC</label>
        <div class="clear" style="height:10px;"></div>
        日期：<asp:TextBox ID="begdate" runat="server" cssclass="calendarSelectDate input" Width="80" ReadOnly="true" Enabled="false"></asp:TextBox>
        &nbsp;&nbsp;<asp:TextBox ID="enddate" runat="server" cssclass="calendarSelectDate input" Width="80" ReadOnly="true" Enabled="false"></asp:TextBox>

        &nbsp;&nbsp;<input type="checkbox" value="1" name="isTotalZT" id="isTotalZT" /><label for="isTotalZT">统计在途</label>
        &nbsp;&nbsp;<input type="checkbox" value="1" name="isXTab" id="isXTab" /><label for="isXTab">交叉</label>
        &nbsp;&nbsp;<input type="checkbox" value="1" name="ifzero" id="ifzero" /><label for="ifzero">显示为零数据</label>
        
        <input id="Button3" type="button" value="按虚拟结构选款" class="btn2" />
        <input id="Button1" type="button" value="查　询" class="btn2" />
        <input id="Button2" type="button" value="导出EXCEL"   disabled="disabled"   class="btn2" style="width:70px" />
        <input id="Button4" type="button" value="导出Zip"   disabled="disabled"   class="btn2" style="width:70px" />
        
    </div> 
    <div class="body">
        <div id="research"></div>
    </div>
    
     <div id="divExcel"></div>
    </form>
</body>
</html>
