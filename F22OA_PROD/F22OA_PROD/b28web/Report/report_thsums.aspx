<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_report_thsums, App_Web_report_thsums.aspx.7863a146" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>退货金额</title>
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
        querydata();
       
     
    });
    
    function querydata(){
           $.ajax({
                beforeSend:function(){
                    $("#research").empty();
                    $("#research").html('<div id="loading"><img src="../Images/loading.gif" alt="" align="absmiddle"/> 加载中...</div>');
                    $("#loading").show();
                },
                complete:function(){$("#loading").hide();},
                url: "../ajax/report/report_thsums_data.aspx",
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
    }
    
    //格式化成整型
    function FormatInt(val)
    {
        var n = parseInt(val);
        return n.toString().toUpperCase()=="NAN"?0:n;
    }
    
    //收集要传送的数据
    function QueryString()
    {
        var djid = $("#hdfdjid").val();
        var tbname=$("#hdftbname").val();
        return "djid="+djid+"&tbname="+tbname;
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
   <asp:HiddenField ID="hdfdjid" runat="server" />
   <asp:HiddenField ID="hdftbname" runat="server" />
   
   <div  style=" text-align:center;"><b>可退换情况</b></div>
  
    <div class="body">
        <div id="research"></div>
    </div>
    
     <div id="divExcel"></div>
    </form>
</body>
</html>
