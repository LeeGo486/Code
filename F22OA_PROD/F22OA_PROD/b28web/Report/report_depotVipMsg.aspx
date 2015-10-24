<%@ page language="C#" autoeventwireup="true" inherits="b28web_Report_report_depotVipMsg, App_Web_report_depotvipmsg.aspx.7863a146" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>

    <script src="js/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script src="js/setday.js" type="text/javascript"></script>

    <style type="text/css">
        body
        {
            font-size: 14px;
        }
        #main
        {
            width: 100%;
            min-height: 450px;
        }
        #main .top
        {
            width: 100%;
            height: 50px;
            border-bottom: solid 1px black;
        }
        #main .content
        {
            height: 400px;
        }
        #main .content #coTab
        {
        }
        #main .content #coTab .oneTr
        {
        }
        #main .content #coTab .oneTr1
        {
        }
        #main .content #coTab .twoTr
        {
        }
        #main .content #coTab .threeTr
        {
        }
        .txtSty
        {
            border: solid 1px #3A69A5;
            width: 80px;
        }
        #main .content #coTab td
        {
            word-break: keep-all;
            text-align: center;
            height: 20px;
            border: solid 1px black;
        }
    </style>

    <script type="text/javascript">
        function getSearchDate(){
            var bt=$("#txt_btime").val();
            var et=$("#txt_etime").val();
            $("##main .content #coTab .oneTr").empty();
            $("##main .content #coTab .oneTr").empty();
            $("#main .content #coTab .twoTr").empty();
            $("#main .content #coTab .threeTr").empty();
            PageMethods.GetSearchDate(bt,et,sf,ef);
        }
        function sf(r){
            var cot2="";
            var cot="<td rowspan='2'>店铺编号</td><td rowspan='2'>店铺名称</td>";
            var j=eval("("+r+")");
            var count=j.count;
            for(var i=0;i<count;i++){
                var str="j.cl"+i;
                var s=eval(str);
                cot=cot+"<td colspan='2'>"+s+"</td>";
                cot2=cot2+"<td>发展数量</td><td>消费数量</td>"
            }
            cot2=cot2+"<td>发展数量</td><td>消费数量</td><td>现存数量</td>"
            cot=cot+"<td colspan='3'>总计</td>";
            $("#main .content #coTab .oneTr").append(cot);
            $("#main .content #coTab .oneTr1").append(cot2);
            
        }
        function ef(e){
            alert(e);
        }
        function getDetailData(){
            var bt=$("#txt_btime").val();
            var et=$("#txt_etime").val();
            PageMethods.GetDepotVipMsg(bt,et,sdf,edf);
        }
        function sdf(r){
            var cot="";
            var j=eval("("+r+")");
            var count=j.count;
            for(var i=0;i<count;i++){
                var str="j.cl"+i;
                var s=eval(str);
                cot=cot+"<td>"+s+"</td>";
            }
            $("#main .content #coTab .twoTr").append(cot);
            $("#main .content #coTab .threeTr").append(cot);
            $("#main .content #coTab .threeTr td").each(function(i){
                if(i==0){
                    $(this).text("合计：");
                }else if(i==1){
                    $(this).text(" ");
                } else{
                    return;
                }
            });
        }
        function edf(e){
            alert(e);
        }
        function m1(){   
            window.clipboardData.setData("Text",document.all('coTab').outerHTML);   
            try  
            {   
                var ExApp = new ActiveXObject("Excel.Application");   
                var ExWBk = ExApp.workbooks.add();
                var ExWSh = ExWBk.worksheets(1);
                ExApp.DisplayAlerts = false ; 
                ExApp.visible = true ;
                ExWBk.worksheets(1).Paste; 
            }     
            catch(e)   
            {   
                alert("您的电脑没有安装Microsoft Excel软件！")   
                return false  
            }    
        }
        
        function m2(){
            function String.prototype.Trim() {return this.replace(/(^\s*)|(\s*$)/g,"");}
          try
          {
            var e = document.getElementById("coTab");
            var s = ""
            for (var j=0; j<e.rows.length; j++)
            {
              if (e.rows[j].style.display != "none")
              {
                for (var i=1; i<e.rows[j].cells.length; i++)
                {
                  if (e.rows[j].cells[i].style.display != "none") 
                    s += e.rows[j].cells[i].innerText.Trim() +"\t";
                }
                s += "\r\n";
              }
            }
            var xlsWindow = window.open("","_blank","width=100,height=100");
            xlsWindow.document.write(s);
            xlsWindow.document.execCommand('SaveAs','test.xls');
            xlsWindow.close();
          }
          catch(e)
          {}
        }  

        
        jQuery(function(){
            $("#btn_search").click(function(){
               getSearchDate(); 
               getDetailData();
            });
        })
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <div id="main">
        <div class="top">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="70%">
                        日期：<input id="txt_btime" type="text" runat="server" class="txtSty" onfocus="setday(this)" />
                        至<input id="txt_etime" type="text" class="txtSty" onfocus="setday(this)" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td width="15%">
                        <input id="btn_search" type="button" value="查询" />
                    </td>
                    <td width="15%">
                        <input id="Button1" type="button" value="导出Excel" onclick="m1()" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="content">
            <table id="coTab" border="0" cellpadding="0" cellspacing="0" runat="server">
                <tr class="oneTr">
                </tr>
                <tr class="oneTr1">
                </tr>
                <tr class="twoTr">
                </tr>
                <tr class="threeTr">
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
