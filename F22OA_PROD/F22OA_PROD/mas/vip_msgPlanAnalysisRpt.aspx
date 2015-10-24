<%@ page language="C#" autoeventwireup="true" inherits="mas_vip_msgPlanAnalysisRpt, App_Web_vip_msgplananalysisrpt.aspx.e229d74e" %>


<html  xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
<head id="Head1" runat="server">
    <title>图报表</title>
       <link  href="../css/project.css" type="text/css"  rel="stylesheet">
        <style media="print" type="text/css">
        .Noprint { DISPLAY: none; }
            INPUT {display:none}
        .PageNext { PAGE-BREAK-AFTER: always; }
    </style>
       <style type="text/css">
           .pnlcss{text-align:center; position:fixed; width:100%;white-space:nowrap;}
           </style>
         <style type="text/css">
  A:link {COLOR: #005a5a; TEXT-DECORATION: none}
 .tra{border:solid 1px #cccccc; }
  .tbRpt {  width:100%; padding:0px; margin:0px;background-color:#F7F7F7;}
  .tbRptD { width:150px; background-color:#D9E5F4;  white-space:nowrap; text-align:left;  height:20px; padding:0px 0px 0px 10px; margin:0px;}

  .tbRptLTD { background-color:#D9E5F4;  white-space:nowrap; text-align:left;  height:20px; padding:0px 0px 0px 0px; margin:0px;}
  .tbRptRTD{  background-color:#ffffff;text-align:left; height:20px; padding:0px 0px 0px 10px; margin:0px;}
  .tbRptTD { background-color:#D9E5F4;  text-align:left; width:40%; height:20px; padding:0px 0px 0px 10px; margin:0px;}

  </style>
    	<STYLE>
		v\:* { BEHAVIOR: url(#default#VML) }
		o\:* { BEHAVIOR: url(#default#VML) }
		</STYLE>
		<script type="text/javascript" defer="defer">
        function pagePrint()
        {
            try{
            document.getElementById('btnBack').className='Noprint';
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
                alert('打印时发生错误，请确认当前电脑上已安装了打印插件！')
            }
            setTimeout(function(){window.close()},0);

        }        
         </script>
        
				
</head>
<body>
    <object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext style="display:none;"></object>
    <form id="form1" runat="server">       
    <div style="margin-top:0px;padding:5px 2px 10px 2px; height:500px;background:#fff;" >  
    <table width="100%" style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F7F7F7,endColorStr=#FFFFFF);">
    <tr>
      <td align="center"> <h2><asp:Label ID="LblTitle" runat="server" Text=""></asp:Label></h2></td>
    </tr>
    <tr><td><br /></td></tr>
     <tr><td align="right">
          <div runat="server" id="printdata"></div>
          <div class="Noprint" >
            <input id="Button1" type="button" value="打印[Enter]" onclick="pagePrint();" class="btn"/>
            <input id="Button3" type="button" value="预览[F4]" onclick="eprint.Preview();" class="btn"/>
             <input id="btnBack" type="button" class="btn" onclick="javascript:window.history.go(-1);" value="返回" />
              <script language="javascript" type="text/javascript">
		      var vh=window.parent.location.href;
	         if(vh.indexOf('loader_frame')>-1)
	            document.getElementById('btnBack').style.display='none';
	            else
	            document.getElementById('btnBack').style.display='';
		    </script>
		 </div>
		
	</td>
    </tr>
     <tr>  
    <td style="text-align:center;"><div>
    <table class="tbRpt">
    <tr  ><td class="tbRptD">调查编号：</td><td class="tbRptRTD"><asp:Label ID="lblNO" runat="server" > </asp:Label>&nbsp;</td></tr>
    <tr  ><td class="tbRptD">调查主题：</td><td class="tbRptRTD"><asp:Label ID="lblTitle1" runat="server"></asp:Label></td></tr>
    <tr  ><td class="tbRptD">调查内容：</td><td class="tbRptRTD"><div id="divContent" runat="server" style="white-space:normal;"></div></td></tr>
    <tr  ><td class="tbRptD">调查说明：</td><td class="tbRptRTD"><asp:Label ID="lblComent" runat="server" Text=""></asp:Label></td></tr>
    <tr  ><td class="tbRptD">创建时间：</td><td class="tbRptRTD"><asp:Label ID="lblCrdate" runat="server"></asp:Label></td></tr>
    </table></div>
     
	</td>
    </tr>
   
    <tr><td><br /><h4>调查统计:</h4></td></tr>
    <tr><td><h5>表统计：</h5>单位(条)</td></tr>
    <tr><td><div><div id="dv9" runat="server" style="width:100px;"></div>
        <table  class="tbRpt" >
        <tr><td colspan="5" class="tbRptLTD">未发：<span id="sp_3" runat="server"></span></td></tr>
        <tr><td colspan="5" class="tbRptLTD">待发：<span id="sp_2" runat="server"></span></td></tr>
        <tr><td rowspan="5" class="tbRptLTD">已发：<span id="sp_1" runat="server"></span></td><td rowspan="3" class="tbRptLTD">发送成功：<span id="sp0" runat="server"></span></td><td colspan="3" class="tbRptLTD">未回复：<span id="sp10" runat="server"></span></td></tr>
        <tr>                                                                                                                                                                               <td rowspan="2" class="tbRptLTD">已回复：<span id="sp20" runat="server"></span></td><td class="tbRptLTD">回复成功：<span id="sp30" runat="server"></span></td><td class="tbRptTD"><span id="sp130" runat="server"></span></td></tr>
        <tr>                                                                                                                                                                                                                                                                       <td class="tbRptLTD">回复出错：<span id="sp200" runat="server"></span></td><td class="tbRptLTD"></td></tr>
        <tr>                                <td rowspan="2" class="tbRptLTD">未发成功：<span id="sp1" runat="server"></span></td><td colspan="3" class="tbRptLTD">未回执：<span id="sp11" runat="server"></span></td></tr>
        <tr>                                                                                   <td colspan="3" class="tbRptLTD">已回执：<span id="sp21" runat="server"></span></td></tr>
        </table>  </div>  
    </td></tr>
    
    <tr> <td><br /><h5>图1：</h5></td></tr>    
    <tr>  <td ><asp:Panel ID="Panel1" runat="server" CssClass="pnlcss"></asp:Panel> </td></tr>
    <tr> <td style="text-align:center;"><br /><a href="#" >(查看明细)</a></td></tr>
    <tr> <td style="text-align:center;"><span id="sp_imgp" runat="server"></span></td></tr>
    <tr><td><br /><h5>图2：</h5></td></tr>
    <tr><td style="height:400px;border solid 1px #111111;"><asp:Panel ID="Panel2" runat="server" CssClass="pnlcss"></asp:Panel></td></tr>
    <tr> <td style="text-align:center;"><a href="#"  id="A1" >(查看明细)</a></td></tr>
     <tr> <td style="text-align:center;"><span id="sp_imgc" runat="server"></span></td></tr>
    </table>
	
		
       </div>
    </form>
</body>
</html>
