<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Print_elegant_td, App_Web_elegant-td.aspx.c366eeb9" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title>小票打印</title>
    <style type="text/css">
        body
        {
            margin:0px;
            font-size:12px;	
            
        }
        table
        {
            width: 100%;
        }
        .maintable
        {
        	width:12.6cm;
        }
        .head1
        {
        	font-size:18px;
        	font-weight:bold;
        	letter-spacing:11px;
        }
        .head2
        {
        	font-size:14px;
        	background-color:#cccccc;
        	 letter-spacing:2px
        }
        .bodytable
        {
        	text-align:center
        }
        span
        {
        	 
        }
        #tbdetail
        {
            text-align: center;
            line-height:10px;
            font-size:10px;
        }
        .bottonTxt
        {
        	font-size:10px;
        }
    </style>
        <style media="print" type="text/css">
        .Noprint
        {
            display: none;
        }
        .PageNext
        {
            page-break-after: always;
            vertical-align:top;
            height:28mm;
        }
        .prolist
        {
            overflow: hidden;
            border: 0px;
            border-left: 0px solid #000000;
            border-right: 0px solid #000000;
        }
        .showborder
        {
        	border:#cccccc solid 1px;
        }
        .paddingleft
        {
        	text-align:right;       	 
        }
        .showDottedBorder
        {
        	border:#cccccc solid 1px dotted;
            width:7.5cm;
        }
        .tbskfs
        {
            line-height:25px;
        }
    </style>
    <script type="text/javascript" defer="defer">
        function pagePrint() {
            try {
                eprint.InitPrint();
                eprint.setMarginMeasure(1);

                eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                eprint.orientation = 1;

                eprint.pageHeight = 200.40;
                eprint.pageWidth = 140.60;

                eprint.marginLeft = 10.00;
                eprint.marginTop = 5.00;
                eprint.marginRight = 8.00;
                eprint.marginBottom = 5.00;

                eprint.header = "";
                eprint.footer = "";

                if (eprint.defaultPrinterName.length == 0) {
                    alert("没有设置打印机！")
                } else {
                   eprint.Print(true);     //不出打印对话框直接打印
                // eprint.Preview();     //打印预览
                }
            } catch (e) {
                alert('打印时发生错误，请确认当前电脑上已安装了打印插件！')
            }
            setTimeout(function(){window.close()},0);
         

        }
        //自动打印
        function window.onload() {
            pagePrint();
            setTimeout(pagePrint, 300);
            window.close();
        }
    </script>
</head>
<body>
    <object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext
        style="display: none;">
    </object>
        <form id="form1" runat="server">
    <div >
        <div runat="server" id="printdata" >
        </div>
        <div class="Noprint" align="center">
            <input id="Button1" type="button" value="打印[Enter]" onclick="pagePrint();" />
            <input id="Button2" type="button" value="关闭[Esc]" onclick="window.close();" />
        </div>
    </div>
    </form>
</body>
</html>
