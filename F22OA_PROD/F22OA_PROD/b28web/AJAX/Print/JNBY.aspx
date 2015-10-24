<%@ page language="C#" autoeventwireup="true" inherits="b28web_AJAX_Print_JNBY, App_Web_jnby.aspx.c366eeb9" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1"><title>
	打印小票
</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <style type="text/css">
        body
        {
            margin:0px;
            padding:0px;
            font-size:9pt;
        }
        #printdata
        {
            margin:0px;
            padding:0px;
            width:120mm;
            overflow:hidden;    
        }
    </style>
    <style media="print" type="text/css">
         body
        {
            margin:0px;
            padding:0px;
            font-size:9pt;
        }
        #printdata
        {
            padding:0px;
            margin:0px;
            width:120mm;
            overflow:hidden;    
        }
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
    <script type="text/javascript" defer="defer">
        function pagePrint()
        {
            try{
                eprint.InitPrint(); 
                eprint.setMarginMeasure(1); 

                eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                eprint.orientation = 1;
                
                //eprint.pageHeight = 107.00;
                //eprint.pageWidth = 147.00;
                
                eprint.marginLeft = 9.00;
                eprint.marginTop = 13.00;
                eprint.marginRight= 6.00;
               eprint.marginBottom= 1.00;
 
                eprint.header="";
                eprint.footer="";

                if (eprint.defaultPrinterName.length==0)
                {
                    alert("没有设置打印机！")
                }
                else
                {
                   eprint.Print(true);     //不出打印对话框直接打印
                    //eprint.Preview();     //打印预览
                }
            }catch(e){
                alert('打印时发生错误，请确认当前电脑上已安装了打印插件！')
            }
            setTimeout(function(){window.close()},0);

        }
        //自动打印
        function window.onload()
        {
            pagePrint();
        }
    </script>
</head>
<body>
    <object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext style="display:none;"></object>
    <form id="form1" runat="server">
        <div>
        <div id="printdata">
            <div style="height:7mm;">
            <table style=" table-layout:fixed;" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td style="width:60mm"><asp:Label ID="sd_depotid" runat="server"></asp:Label></td>
                    <td style="width:10mm"><asp:Label ID="sd_year" runat="server"></asp:Label></td>
                    <td style="width:7mm"><asp:Label ID="sd_month" runat="server"></asp:Label></td>
                    <td style="width:7mm"><asp:Label ID="sd_day" runat="server"></asp:Label></td>
                </tr>
            </table>
            </div>
            <div style="height:80mm; overflow:hidden;">
            <asp:Repeater ID="Repeater1" runat="server" EnableViewState="False">
            <HeaderTemplate>
                <table style="table-layout:fixed;" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td style="width:12mm;text-align:center">&nbsp;</td>
                    <td style="height:10mm;width:13.5mm">&nbsp;</td>
                    <td style="width:8mm">&nbsp;</td>
                    <td style="width:9.3mm">&nbsp;</td>
                    <td style="width:9mm">&nbsp;</td>
                    <td style="width:10mm">&nbsp;</td>
                    <td style="width:20mm;">&nbsp;</td>
                    <td style="width:11mm;">&nbsp;</td>
                    <td style="width:15mm;">&nbsp;</td>
                </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td style="width:12mm;height:5mm;text-align:center; "><%#Eval("s_name") %></td>
                    <td style="width:13.5mm;text-align:center;"><%#Eval("styleid") %></td>
                    <td style="width:8mm; text-align:center;"><%#Eval("colorid") %></td>
                    <td style="width:9.3mm; text-align:center;"><%#Eval("sizeid") %></td>
                    <td style="width:9mm; text-align:center;"><%#Eval("nums") %></td>
                    <td style="width:10mm; text-align:center;"><%#Eval("s_price") %></td>
                    <td style="width:20mm;text-align:center;"><%#Eval("vipcardid").ToString().ToUpper()%></td>
                    <td style="width:11mm; text-align:center;"><%#Convert.ToDouble(Eval("discount").ToString()).ToString("0.00") %></td>
                    <td style="width:15mm; text-align:center;"><%#Eval("FSSums")%></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
            </asp:Repeater>
            </div>
            <table style="table-layout:fixed;" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td style="width:10mm">&nbsp;</td>
                    <td style="width:47mm"><asp:Label ID="sd_employee" runat="server"></asp:Label></td>
                    <td style="width:39mm"><asp:Label ID="sd_saler" runat="server"></asp:Label></td>
                    <td style="width:39mm"><asp:Label ID="sd_tel" runat="server"></asp:Label></td>
                </tr>
            </table>
        </div>
        <div class="Noprint">
            <input id="Button1" type="button" value="打印[Enter]" onclick="pagePrint();"/>
            <input id="Button3" type="button" value="预览[F4]" onclick="eprint.Preview();"/>
            <input id="Button2" type="button" value="关闭[Esc]" onclick="window.close();" />

        </div>
        </div>
    </form>
</body>
</html>
