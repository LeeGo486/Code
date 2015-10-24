<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_report_vipxf, App_Web_report_vipxf.aspx.7863a146" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>VIP状态消费统计报表</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />

    <script src="../Utility/command.js" type="text/javascript"></script>

    <link href="../Utility/dateChooser.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Utility/jquery-1.2.6.min.js"></script>

    <script type="text/javascript" src="../Utility/dateChooser.js"></script>

    <style type="text/css">
        body
        {
            padding: 10px;
        }
        #header
        {
            text-align: center;
            padding: 10px;
            line-height: 30px;
        }
        #header
        {
            text-align: center;
            padding: 10px;
            line-height: 30px;
        }
        #research table
        {
            table-layout: fixed;
        }
        #research thead td
        {
            text-align: center;
            width: 40px;
            overflow: hidden;
        }
        #DataBody tr
        {
            background: #F7F6F3;
        }
        #DataBody tr.selected
        {
            background: #E2DED6;
        }
        .calendarSelectDate
        {
        }
        .body
        {
            padding: 10px;
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
                url: "../ajax/report/report_vipxf_data.aspx",
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
             location.href="../ajax/report/report_vipxf_data.aspx?&act=1&"+QueryString();
        });
        
     
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
        return "begdate="+begdate+"&enddate="+enddate;
    }
    
    //绑定反回Grid的事件
    function setevents()
    {
        $("#DataBody").find("tr").click(function(){
           $(this).toggleClass("selected");
        });
    }
    
   function showdetail(condtion,cardtype){
      $.ajax({
                beforeSend:function(){
                    $("#divinfosub").empty();
                    $("#divinfosub").html('<div id="loading"><img src="../Images/loading.gif" alt="" align="absmiddle"/> 加载中...</div>');
                    $("#loading").show();
                },
                complete:function(){$("#loading").hide();},
                url: "../ajax/Report/report_vipxf_data_detail.aspx?begdate="+$("#begdate").val()+"&enddate="+$("#enddate").val()+"&cardtype="+encodeURI(cardtype)+"&condtion="+condtion,
                type: "POST",
                data: "",
                async: true,
                success:function(html){
                    $("#divinfosub").html(html);
                    showtipsinfo();
                },
                error:function(html){
                    alert('数据加载出错！');
                }
            });
            
            showtipsinfo();
            return;
        }
        
        function showtipsinfo(){
            $("#divinfo").css("top",(screen.height-450)/2);
            $("#divinfo").css("left",(screen.width-880)/2);
            $("#divinfo").show();
        }
        
        function closeinfo(){
          $("#divinfo").hide();
        }
    </script>

</head>
<body>
    <form id="form2" runat="server">
    <h3 id="header">
        VIP状态消费统计报表
    </h3>
    <div class="toolbar">
        日期：<asp:TextBox ID="begdate" runat="server" CssClass="calendarSelectDate input" Width="80"
            ReadOnly="false" Enabled="true"></asp:TextBox>
        &nbsp;&nbsp;<asp:TextBox ID="enddate" runat="server" CssClass="calendarSelectDate input"
            Width="80" ReadOnly="false" Enabled="true"></asp:TextBox>
        <input id="Button1" type="button" value="查　询" class="btn2" />
        <input id="Button2" type="button" value="导出EXCEL" class="btn2" style="width: 70px" />
    </div>
    <div class="body">
        <div id="research">
        </div>
    </div>
    <div id="divinfo" style="display: none; width: 650px; position: absolute; height: 270px;
        background-color: #fff; border: 1px solid #cad9ea;">
        <div style="background: url(images/cat_bg.gif); height: 15px; text-align: left; paddint-bottom: 1px;
            border: 0px solid red">
            <a href="#" id="closevipimg" onclick="closeinfo()">
                <div style="border: 0px solid blue" class="CloseDropOut" onmouseover="this.className='CloseDropOn'"
                    onmouseout="this.className='CloseDropOut'">
                </div>
            </a><a href="#" id="showvipimg"></a>
        </div>
        <div id="divinfosub" style="width: 98%; text-align: center; height: 240px; overflow-y: auto;">
        </div>
    </div>
    <div id="divExcel">
    </div>
    </form>
</body>
</html>
