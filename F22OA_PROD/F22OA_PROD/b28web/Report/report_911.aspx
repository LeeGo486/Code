<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_report_911, App_Web_report_911.aspx.7863a146" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>款式颜色虚拟进销存综合交叉汇总查询</title>
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
    	background:#FFF
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
    	overflow:auto;
    	width:99%;
    	height:450px;
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
                url: "../ajax/report/report_911.aspx",
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
             location.href="../ajax/report/report_911.aspx?&act=1&"+QueryString();
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
        var str="";
        str +="begdate="+$("#begdate").val();
        str +="&enddate="+ $("#enddate").val();
        str +="&Grp="+ $("input:radio:checked[@name=Grp]").val();
        str +="&qc="+ ($("#qc").attr("checked")?"1":"0");
        str +="&shrk="+ ($("#shrk").attr("checked")?"1":"0");
        str +="&jmth="+ ($("#jmth").attr("checked")?"1":"0");
        str +="&cpth="+ ($("#cpth").attr("checked")?"1":"0");
        str +="&pfxh="+ ($("#pfxh").attr("checked")?"1":"0");
        str +="&ls="+ ($("#ls").attr("checked")?"1":"0");
        str +="&dbfh="+ ($("#dbfh").attr("checked")?"1":"0");
        str +="&dbsh="+ ($("#dbsh").attr("checked")?"1":"0");
        str +="&pd="+ ($("#pd").attr("checked")?"1":"0");
        str +="&qm="+ ($("#qm").attr("checked")?"1":"0");
        str +="&zt="+ ($("#zt").attr("checked")?"1":"0");
        str +="&zckc="+ ($("#zckc").attr("checked")?"1":"0");
        
        return str
        
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
     款式颜色虚拟进销存综合交叉汇总查询
    </h3>
    <div class="toolbar">
        日期：<asp:TextBox ID="begdate" runat="server" cssclass="calendarSelectDate input" Width="80" ReadOnly="true"></asp:TextBox>
        &nbsp;&nbsp;<asp:TextBox ID="enddate" runat="server" cssclass="calendarSelectDate input" Width="80" ReadOnly="true"></asp:TextBox>
        &nbsp;&nbsp;汇总方式：<input id="RadioButton1" type="radio" name="Grp" value="1" checked="checked" /><label for="RadioButton1">按款+色</label>
        <input id="RadioButton2" type="radio" name="Grp" value="2" /><label for="RadioButton2">按店+款+色+计划上货期</label>
        <input id="RadioButton3" type="radio" name="Grp" value="3"/><label for="RadioButton3">按款+色+店</label>
        <input id="Button1" type="button" value="查　询" class="btn2" />
        <input id="Button3" type="button" value="按虚拟结构选款" class="btn2" />
        <input id="Button2" type="button" value="导出EXCEL" class="btn2" style="width:70px" />
        <div class="clear" style="height:10px;"></div>
        <input type="checkbox" value="1" id="qc" name="qc" checked="checked" /><label for="qc">期初库存</label>
        <input type="checkbox" value="1" id="shrk" name="shrk" checked="checked" /><label for="shrk">生产入库</label>
        <input type="checkbox" value="1" id="jmth" name="qc" checked="checked" /><label for="jmth">加盟退货</label>
        <input type="checkbox" value="1" id="cpth" name="cpth" checked="checked" /><label for="cpth">次品退货</label>
        <input type="checkbox" value="1" id="pfxh" name="pfxh" checked="checked" /><label for="pfxh">批发销售</label>
        <input type="checkbox" value="1" id="ls" name="ls" checked="checked" /><label for="ls">零售</label>
        <input type="checkbox" value="1" id="dbfh" name="dbfh" checked="checked" /><label for="dbfh">调拨发货</label>
        <input type="checkbox" value="1" id="dbsh" name="dbsh" checked="checked" /><label for="dbsh">调拨收货</label>
        <input type="checkbox" value="1" id="pd" name="pd" checked="checked" /><label for="pd">盘点</label>
        <input type="checkbox" value="1" id="qm" name="qm" checked="checked" /><label for="qm">期末库存</label>
        
        <input type="checkbox" value="1" id="zt" name="zt" /><label for="zt">在途</label>
        <input type="checkbox" value="1" id="zckc" name="zckc" /><label for="zckc">总仓库存</label>
        
    </div> 
    <div class="body">
        <div id="research"></div>
    </div>
    </form>
</body>
</html>
