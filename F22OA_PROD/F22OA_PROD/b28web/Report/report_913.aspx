<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_report_913, App_Web_report_913.aspx.7863a146" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>客单数统计表</title>
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
    	background:#FFF;
    }
    #research thead td
    {
	    text-align:center;
	    width:100px;
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
        $("#toprec").keydown(function(){
            if(event.keyCode==13||event.keyCode==10){
                $(this).change();
                $("#Button1").focus();
                return false;
            }
        });
        $("#toprec").change(function(){
            $(this).val(FormatInt($(this).val()));
            
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
                url: "../ajax/report/report_913.aspx?"+(new Date()),
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
        $("#Button2").click(function(){
             location.href="../ajax/report/report_913.aspx?&act=1&"+QueryString();
        });
        
        //Selection Style
        $("#Button3").click(function(){
        	var s = openModal('../../pos/pos/f22/report/select1.asp',600,500);
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
        var xiaoji  = $("#xiaoji").attr("checked")?"1":"0";
        return "begdate="+begdate+"&enddate="+enddate+"&xiaoji="+xiaoji;
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
     客单数统计表
    </h3>
    <div class="toolbar">
        日期：<asp:TextBox ID="begdate" runat="server" cssclass="calendarSelectDate input" Width="80" ReadOnly="true"></asp:TextBox>
        &nbsp;&nbsp;<asp:TextBox ID="enddate" runat="server" cssclass="calendarSelectDate input" Width="80" ReadOnly="true"></asp:TextBox>
        &nbsp;&nbsp;
        <input type="checkbox" value="1" id="xiaoji" name="xiaoji" checked="checked" /><label for="xiaoji">计算小计</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input id="Button1" type="button" value="查　询" class="btn2" />
        <input id="Button3" type="button" value="选择款式" class="btn2" />
        <input id="Button2" type="button" value="导出EXCEL" class="btn2" style="width:70px" />
        
    </div> 
    <div class="body">
        <div id="research"></div>
    </div>
    </form>
</body>
</html>
