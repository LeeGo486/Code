<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Print_sh_rose, App_Web_sh-rose.aspx.c366eeb9" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1"><title>
	打印小票
</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
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
        #t
        {
        	border-right:solid 0px black;
        	border-left:solid 0px black;
        }
        body,form {margin:0;padding:0;background:#FFF;}
        body,td,th {font-size: 8.5pt; font-family:Verdana, Geneva, sans-serif;}
	    table{ width:150mm; clear:both; table-layout:fixed;}
        table td{ height:5mm; line-height:5mm;padding:0px; }
        .prolist{overflow:auto;padding:0px; }
        #ftab
        {
            width:150mm;	
        }
        .ptable
        {
        	width:150mm;
        }
        .td_left{border:0px;border-left:1px solid #000000;}
        .td_bottom{border:0px;border-bottom:1px solid #000000;}
        .td_left_bottom{border:0px;border-left:1px solid #000000;border-bottom:1px solid #000000;}
        .td_left_right{border:0px;border-left:1px solid #000000;border-right:1px solid #000000;}
        .td_full{border:1px solid #000000;}
        .td_title_middle{border:0px;border-top:1px solid #000000;border-bottom:1px solid #000000;}
        .td_title_left{border-right:0px;border-left:1px solid #000000;border-bottom:1px solid #000000;border-top:1px solid #000000;}
        .td_title_right{border-left:0px;border-right:1px solid #000000;border-top:1px solid #000000;border-bottom:1px solid #000000;}
        
        .td_detail_left{border-right:1px solid #000000;border-left:1px solid #000000;border-bottom:0px;border-top:0px;}
        .td_detail_right{border-left:0px;border-right:1px solid #000000;}
        .td_detail_left2{border-left:1px solid #000;}
    </style>
    <style media="print" type="text/css">
        .Noprint { DISPLAY: none; }
            INPUT {display:none}
        .PageNext { PAGE-BREAK-AFTER: always; }
        .prolist
        {
        	overflow:hidden;
        	height:41mm;
        	border:0px;
        	border-left:1px solid #000000;
        	border-right:1px solid #000000;
        }
    </style>	
    <script type="text/javascript" defer="defer">
       function pagePrint()
        {
            try{
                eprint.InitPrint(); 
                eprint.setMarginMeasure(1); 

                eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                eprint.orientation = 1;
                
                //更改以下参数可以调整打印格式BEGIN
                //纸张高度(mm)
                eprint.pageHeight = 101.70;
                 //纸张宽度(mm)
                eprint.pageWidth = 177.00;
               
               
                
                //页边距左边
                eprint.marginLeft = 1.00;
                
                  //页边距右边
                eprint.marginRight= 1.00;
                
                 //页边距上边
                eprint.marginTop = 10.00;
                  
                
                 //页边距下边
                eprint.marginBottom= 1.00;
                //更改以下参数可以调整打印格式END
                
 
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
                alert('打印时发生错误，请确认当前电脑上已安装了打印插件！')
            }
            //setTimeout(function(){window.close()},0);

        }
        //自动打印
        function window.onload() {

            //eprint.Preview();
            //pagePrint();
        }
        
   //    function show(){
   //         WebBrowser.ExecWB(7,1);
   //    }
   //    function print(){
   //         WebBrowser.ExecWB(6,1);
   //         window.opener=null;
   //         window.close();
   //    }
   //    function closeWin(){
   //         window.close();
   //    }
      // WebBrowser.ExecWB(6,6);
    </script>
</head>
<body>
   <!--<object   ID='WebBrowser'   WIDTH=0   HEIGHT=0   CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2'></object>-->
    <object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext style="display:none;"></object>
    <form id="form1" runat="server">
        <div>
        <div runat="server" id="printdata"></div>
        <div class="Noprint" align="center">
            <input id="Button1" type="button" value="打印[Enter]" onclick="pagePrint();"/>
            <input id="Button3" type="button" value="预览[F4]" onclick="eprint.Preview();"/>
            <input id="Button2" type="button" value="关闭[Esc]" onclick="window.close();" />
        </div>
        </div>
    </form>
</body>
</html>
