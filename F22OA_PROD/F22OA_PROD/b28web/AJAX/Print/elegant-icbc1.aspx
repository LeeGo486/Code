<%@ page language="C#" autoeventwireup="true" inherits="AJAX_Print_elegant_icbc1, App_Web_elegant-icbc1.aspx.c366eeb9" enableviewstatemac="false" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <title>打印小票（2009） </title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <style type="text/css">
        body, form
        {
            margin: 0;
            padding: 0;
        }
        body, td, th
        {
            font-size: 9pt;
        }
        body
        {
            width: 123mm; /*显示宽度*/
            margin: 0;
            padding: 0;
            background: #FFF;
            overflow: hidden;
        }
        .ptable
        {
            width: 123mm; /*显示宽度*/
            table-layout: fixed;
        }
        .ptable td
        {
            line-height: 5.1mm; /*行高*/
            height: 5.1mm; /*行高*/
            font-size: 9pt;
            font-family: arial;
            width: 50%;
        }
        .ptable td div
        {
            line-height: 5.1mm; /*行高*/
            height: 5.1mm; /*行高*/
        }
        .prolist
        {
            overflow: auto;
        }
    </style>
    <style media="print" type="text/css">
        .Noprint
        {
            display: none;
        }
        INPUT
        {
            display: none;
        }
        .PageNext
        {
            page-break-after: always;
        }
        .prolist
        {
            overflow: hidden;
            height: 33mm; /*货品列表行高*/
        }
    </style>
    <script type="text/javascript">
        function KeyDown() {
            with (event) {
                if (keyCode == 13) {//打印
                    document.getElementById('Button1').click();
                    event.keyCode = 0;
                    event.cancelBubble = true;
                    return false;
                }
                if (keyCode == 27) {//关闭
                    document.getElementById('Button2').click();
                    event.keyCode = 0;
                    event.cancelBubble = true;
                    return false;
                }
                if (keyCode == 115) {//预览
                    document.getElementById('Button3').click();
                    event.keyCode = 0;
                    event.cancelBubble = true;
                    return false;
                }
            }
        }
        document.onkeydown = KeyDown;
    </script>
</head>
<body>
    <object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext
        style="display: none;">
    </object>
    <form id="form1" runat="server" enableviewstate="false">
    <div>
        <div runat="server" id="printdata" enableviewstate="false">
        </div>
        <div class="Noprint">
            <input id="Button1" type="button" value="打印[Enter]" onclick="pagePrint();" />
            <input id="Button3" type="button" value="预览[F4]" onclick="eprint.Preview();" />
            <input id="Button2" type="button" value="关闭[Esc]" onclick="window.close();" />
        </div>
    </div>
    </form>
    <script type="text/javascript" defer="defer">
        function pagePrint() {
            try {
                eprint.InitPrint();
                eprint.setMarginMeasure(1);

                eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                eprint.orientation = 1;

                eprint.pageHeight = 165.00;             //纸张宽度
                eprint.pageWidth = 170.00;              //纸张高度

                eprint.marginLeft = 18.00;              //左边距
                eprint.marginTop = 30.00;               //上边距
                eprint.marginRight = 1.00;               //右边距
                eprint.marginBottom = 1.00;              //下边距

                eprint.header = "";
                eprint.footer = "";

                if (eprint.defaultPrinterName.length == 0) {
                    alert("没有设置打印机！")
                } else {
                    document.getElementById('Button1').value = '正在打印...';
                    document.getElementById('Button1').disabled = 'disabled';
                    eprint.Print(true);     //不出打印对话框直接打印
                    //eprint.Preview();     //打印预览
                }
            } catch (e) {
                alert("收银成功,小票打印失败,必须下载安装打印控件才能正常打印小票!");
                window.open("download.aspx", '', "height=200, width=200, top=200, left=400, toolbar=no, menubar=no, scrollbars=no, resizable=no");
            }
            setTimeout(function () { window.close() }, 500);

        }
        //自动打印
        function window.onload() {
            pagePrint();
        }
    </script>
</body>
</html>
