<%@ page language="C#" autoeventwireup="true" inherits="AJAX_Print_elegant, App_Web_elegant.aspx.c366eeb9" enableviewstatemac="false" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1"><title>
	打印小票
</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" /> 
    <style type="text/css">
        body,form {margin:0;padding:0;}
        body,td,th {font-size: 9pt;}
    </style>
    <style media="print" type="text/css">
        .Noprint { DISPLAY: none; }
            INPUT {display:none}
        .PageNext { PAGE-BREAK-AFTER: always; }
    </style>
    <script type="text/javascript">
        function KeyDown(){
            with (event){ 
                if(keyCode==13){//打印
                    document.getElementById('Button1').click();
                    event.keyCode = 0; 
                    event.cancelBubble = true; 
                    return false;
                }
                if(keyCode==27){//关闭
                    document.getElementById('Button2').click();
                    event.keyCode = 0; 
                    event.cancelBubble = true; 
                    return false;
                }
                if(keyCode==115){//预览
                    document.getElementById('Button3').click();
                    event.keyCode = 0; 
                    event.cancelBubble = true; 
                    return false;
                }
            }
        }
        document.onkeydown = KeyDown;
    </script>
    <style type="text/css">
        body
        {	
        	width:123mm;
        	margin:0;
        	padding:0;
        	background:#FFF;
        	overflow:hidden;
              }
        .ptable
        {
        	width:123mm;
        	table-layout:fixed;
        	}
        .ptable td
        {
        	line-height:5.1mm;
        	height:5.1mm;
        	font-size:9pt;
        	font-family:arial;
        	width:50%;
        	}
        .ptable td div
        {
        	line-height:5.1mm;
        	height:5.1mm;
        	}
        .prolist{overflow:auto; }
    </style>
    
    <style type="text/css" media="print">
        .prolist
        {
        	overflow:hidden;
        	height:38mm;
                 }
    </style>
</head>
<body>
    <object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext style="display:none;"></object>
    <form id="form1" runat="server">
        <div>
        <div runat="server" id="printdata"></div>
        <div class="Noprint">
            <input id="Button1" type="button" value="打印[Enter]" onclick="pagePrint();"/>
            <input id="Button3" type="button" value="预览[F4]" onclick="eprint.Preview();"/>
            <input id="Button2" type="button" value="关闭[Esc]" onclick="window.close();" />
        </div>
        </div>
    </form>

    <script type="text/javascript">
        function pagePrint()
        {
            try{
                eprint.InitPrint(); 
                eprint.setMarginMeasure(1); 

                eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                eprint.orientation = 1;
                
                eprint.pageHeight = 165.00;
                eprint.pageWidth = 170.00;
                
                eprint.marginLeft = 18.00;
                eprint.marginTop = 28.00;
                eprint.marginRight= 1.00;
                eprint.marginBottom= 1.00;
 
                eprint.header="";
                eprint.footer="";
                
                if (eprint.defaultPrinterName.length==0)
                {
                    alert("没有设置打印机！")
                }else{
                    eprint.Print(true);     //不出打印对话框直接打印
                    //eprint.Preview();     //打印预览
                }
            }catch(e){
               alert("收银成功,小票打印失败,必须下载安装打印控件才能正常打印小票!");
			   window.open("download.aspx",'',"height=200, width=200, top=200, left=400, toolbar=no, menubar=no, scrollbars=no, resizable=no");
			   
				 
            }
            setTimeout(function(){window.close()},0);

        }
        //自动打印
        function window.onload()
        {
            pagePrint();
        }
    </script>
</body>
</html>
