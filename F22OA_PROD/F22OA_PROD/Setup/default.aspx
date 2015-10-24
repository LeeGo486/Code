<%@ page language="C#" autoeventwireup="true" inherits="setup, App_Web_default.aspx.4cd3357d" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>F22安装方法</title>
    <script src="../b28web/Utility/trans.js" type="text/javascript"></script>
    <style type="text/css">
        body
        {
        	font-size:11pt;
        	line-height:20px;
        	}
        p b
        {
        	font-size:14pt;
        	
        	}
    span
    {
    	color:Red;}
    .printarea { DISPLAY: none; }
    .Noprint { DISPLAY: block; }

    </style>
    
    <style media="print" type="text/css">
        .printarea { DISPLAY: block; }
        .Noprint { DISPLAY: none; }
    </style>

    
    <script type="text/javascript" defer="defer">
        function pagePrint(){
            try{
                eprint.InitPrint(); 
                eprint.setMarginMeasure(1); 

                eprint.paperSize = "美国标准 Fanfold"; //用户自定义 
                eprint.orientation = 1;
                
                eprint.pageHeight = 167.00;
                eprint.pageWidth = 170.00;
                
                eprint.marginLeft = 20.00;
                eprint.marginTop = 28.00;
                eprint.marginRight= 1.00;
                eprint.marginBottom= 0.00;
 
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
                alert("打印时发生错误，请确定是否已正确安装以上插件！")
            }
        }
    </script>

    
</head>
<body>  
<object id="Trans1" classid="CLSID:E2EEEA3B-34C4-43B7-B7AC-CB12DCA6FBBE" style="display:none;">
    <param name="_version" value="1.0" />
    <param name="_extentx" value="13229" />
    <param name="_extenty" value="13229" />
    <param name="_stockprops" value="0" />
</object>
<object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" style="display:none;"></object>
    <form id="form1" runat="server">
    <div class="printarea">
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p><b>打印插件安装成功</b></p>
        <p>&nbsp;</p>
        <p><b>可以正常打印小票</b></p>
        <p>&nbsp;</p>
        <p><b>打印插件安装成功</b></p>
        <p>&nbsp;</p>
        <p><b>可以正常打印小票</b></p>
        
        
    </div>
    <div class="Noprint">

				<p><b>一、自营店铺专用安装：</b></p>
        <ol>
            	自营店铺请点击下载<a href="Project1.exe" target="_blank">Project1.exe</a>文件到本地，然后双击安装。<br  />
				<span>（注意：如果不是自营店铺请直接跳过这一步，否则将无法正常使用电脑）<br />
				若加盟店铺已不小心安装，请直接与信息管理部联系	</span>	
				</ol>
			
			
         <p><b>二、所有店铺必须安装：</b></p>
            <ol>
				<li>安装插件。	点击下载<a href="setup.exe" target="_blank">setup.exe</a>文件到本地，然后双击安装。	<br /> <br /> </li>
				<li>安装收银证书。点击下载<a href="Install.exe" target="_blank">Install.exe</a>文件到本地，然后双击安装。<br /><br /></li>
				安装完成插件后请先退出IE浏览器，然后重新打开此页面点击<a href="javascript:pagePrint();">打印测试</a>。<br />
				打印机如打印出以下内容说明插件安装成功<br />
				“打印插件安装成功”<br />
			  “可以正常打印小票”<br /><br />
				
				<span>（若有不明之处请直接与信息管理部联系）   </span> <br /><br /><br />
			
				第一点的安装插件，其实就是完成以下操作<br />
			
        a、将 http://<%= Request.ServerVariables["Http_Host"].ToString()%> 添加到“可信站点”中。、<br />
								
        b、自定义可信站点，将跟 ActiveX 有关的全部启用。<br  />
				如：“ ActiveX 控件自动提示”、“对未标记为可安全执行脚本的 ActiveX 控件初始化并执行脚本”、<br \>
				“下载未签名的 ActiveX 控件”、“允许 Scriptlet ”、“在没有使用外部媒体播入机的网页上显示显示视频和动画” 全部都设置为“启用”。<br  />

        c、关闭弹出窗口阻止程序功能。<br />

			 	d、安装打印插件。<br />
		    </ol>
		
       
        <p><b>三、安装工行刷卡控件<span>（限个别自营专卖店）</span>：</b></p>
         <ol>
         如果需要用到工商银行刷卡的请点击下载：<a href="ICBC.exe" target="_blank">ICBC.exe</a>文件到本地，然后双击安装。<br /><br />
				
        安装完插件后请先退出IE浏览器,然后再重新打开此点击<a href="javascript:openTrans();">签到</a>，若提示交易成功即可以正常使用；<br /><br />
				也可以使用<a href="ocxtest.aspx" target="_blank">消费测试</a>。
				</ol>



 				<p><b>四、总部人员安装软件<span>（所有使用F22系统人员）</span>：</b></p>
        <ol>
         所有需要使用F22系统的人员请点击下载：<a href="F22.exe" target="_blank">F22.exe</a>文件到本地，然后双击安装。<br /><br />
				</ol>

    </div>

    </form>
</body>
</html>

