<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Print_elegant_new_print2, App_Web_elegant_new_print2.aspx.c366eeb9" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <title>打印小票 </title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <script language="javascript" src="LodopFuncs.js"></script>
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="install_lodop32.exe"></embed>
    </object> 
    <style type="text/css" id="sty">
        body, form
        {
            margin: 0;
            padding: 0;
            font-size:11px;
            font-family: arial;
        }
        #printdata
        {
            width:  13.5cm;  
        }
        table
        {
            font-size:11px;
            width:  13.3cm;  
            padding:0;
            margin:0;
        }
        table tr
        {
            line-height:0.38cm;    
        }
        table td
        {
            margin:0;
            padding:0;    
        }
        
        .thead
        {
            margin-top:2.1cm;    
        }
        .tbody
        {
            margin-top:0.4cm;  
            
          }
        .tfoot
        {
            margin-top:0.6cm;    
            
        }
        .toptable td
        {
            padding-left:2px;    
        }
        .bottomtable td
        {
            padding-left:2px;    
        }
        .tdtop
        {
            border-top:1px solid #999;
        }
       .tdright
        {
           border-right:1px solid #999; 
           width:6.2cm;
        }
       .tdbottom
        {
            border-bottom:1px solid #999;
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
        }
    </style>
<script language="javascript" type="text/javascript">
    function window.onload() {
        CheckIsInstall();
         prn1_print();
          window.close();
        // prn1_preview()
    }

    function CheckIsInstall() {
        try {
            var LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
            if ((LODOP == null) || (typeof (LODOP.VERSION) == "undefined")) {
                alert("Error:本机未安装或需要升级!");
            }
        } catch (err) {
            alert("Error:本机未安装或需要升级!");
        }
    }

    var LODOP; //声明为全局变量 
    function prn1_preview() {
        myPrint();
        LODOP.PREVIEW();
    };
    function prn1_print() {
        myPrint();
        LODOP.PRINT();
    };

    function myPrint() {
        LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
        LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");
        LODOP.PRINT_INIT("POS小票");

        var strBodyStyle = "<style>" + document.getElementById("sty").innerHTML + "</style>";
        var strFormHtml = strBodyStyle + "<body>" + document.getElementById("printdata").innerHTML + "</body>";
        LODOP.ADD_PRINT_HTM(1, 10, "1475", "2090", strFormHtml);   //(intTop,intLeft,intWidth,intHeight,strHtml)增加超文本项 
        LODOP.SET_PRINT_PAGESIZE(1, "1480", "2100", ""); //(intOrient,intPageWidth,intPageHeight,strPageName)设定纸张大小    
        LODOP.SET_PRINTER_INDEXA(-1);
        LODOP.SET_PRINT_COPIES( <%=prt_cnt %>)

    }; 
	   
    </script>
</head>
<body>
 
    <form id="form1" runat="server" enableviewstate="false">
    <div>
        <div runat="server" id="printdata" enableviewstate="false">

         </div>
         <br />
         <br />
        <div class="Noprint">
            <input id="Button1" type="button" value="打印[Enter]" onclick="prn1_print();" />
            <input id="Button3" type="button" value="预览[F4]" onclick="prn1_preview();" />
            <input id="Button2" type="button" value="关闭[Esc]" onclick="window.close();" />
        </div>
    </div>
    </form>
</body>
</html>
