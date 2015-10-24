<%@ page language="C#" autoeventwireup="true" inherits="Modal_vip_Default, App_Web_vipinfo.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>查询VIP顾客资料</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <script src="../Utility/command.js" type="text/javascript"></script>
    <script src="../Utility/jsgrid.js" type="text/javascript"></script>
    <script src="../Utility/jquery-1.2.6.min.js" type="text/javascript"></script>
    <style type="text/css">
    html,body{ overflow:hidden;}
    body{background:#FFF;}
    /*选项卡1*/
    #lib_Tab{width:99%;margin:0px;padding:0px;margin:5px 5px 15px 5px; background:#FFF;}
    /*菜单class*/
    .lib_tabborder{border:1px solid #95C9E1;}
    .lib_Menubox {height:28px;line-height:28px;position:relative;background-color:#E4F2FD}
    .lib_Menubox ul{margin:0px;padding:0px;list-style:none; position:absolute; top:3px; left:0; margin-left:10px; height:25px;text-align:center;}
    .lib_Menubox li{float:left;display:block;cursor:pointer;width:70px;color:#949694;font-weight:bold; margin-right:2px;height:25px;line-height:25px; background-color:#E4F2FD}
    .lib_Menubox li.hover{padding:0px;background:#fff;width:70px;border-left:1px solid #95C9E1;border-top:1px solid #95C9E1;border-right:1px solid #95C9E1;
    color:#036;height:25px;line-height:25px;}
    .lib_Contentbox
    {
        clear:both;margin-top:0px; border-top:none;height:350px;
        text-align:center;overflow:auto;
    }
    #tabContent
    {
    	padding:10px 5px;
    	}
    
    </style>
    <script type="text/javascript">
    function KeyDown(){
        with (event){ 
            if(keyCode==27){//ESC返回输入状态
                window.close();
                event.keyCode = 0; 
                event.cancelBubble = true; 
                return false;
            }
        }
    }
    document.onkeydown = KeyDown;
    </script>
    <script type="text/javascript">
    <!--
    function setTab(name,cursel,n){
     for(i=1;i<=n;i++){
      var menu=document.getElementById(name+i);
      var con=document.getElementById("con_"+name+"_"+i);
      menu.className=i==cursel?"hover":"";
      con.style.display=i==cursel?"block":"none";
     }
    }
    
    //加载添加事件
    $(function(){
        var li = $("#tabHeader").find("LI");
        $.each(li,function(i,obj){
            $(obj).click(function(){load(i)})
        });
    });
    $(document).ready(function(){
        load(0);
    });
    
    //添加ajax加载事件
    function load(n){
        var li = $("#tabHeader").find("LI");
        var urls = new Array();
        urls = [
                "../ajax/vip/vipdetails.aspx",
                "../ajax/vip/vipBuys.aspx",
                "../ajax/vip/vipLookRate.aspx",
                "../ajax/vip/vipIFrame.aspx?url=../../pos/pos/vip/vip_Dollar.asp",
                "../ajax/vip/vipIFrame.aspx?url=../../pos/pos/vip/vip_Award.asp",
                "../ajax/vip/vipIFrame.aspx?url=../../pos/pos/vip/vip_Gift.asp",
                "../ajax/vip/vipIFrame.aspx?url=../../pos/pos/vip/vip_Upgrade.asp",
                "../ajax/vip/vipIFrame.aspx?url=../../pos/pos/vip/vip_ReCard.asp",
                "../ajax/vip/vipIFrame.aspx?url=../../pos/pos/f22/ticket/changeticketsub.asp",
                "../ajax/vip/vipRewardDetail.aspx",
                "../ajax/vip/vipHonor.aspx",
                "../ajax/vip/vipAdjust.aspx",
                "../ajax/vip/vipDeductible.aspx",
                ];
        
        $.each(li,function(i,obj){
            if(n==i)
            $(obj).addClass('hover');
            else
            $(obj).removeClass('hover');
        });
        if(n < urls.length)
        {
            var url = urls[n].split('?');
            var data = "vipcode="+$("#vipcode").val();
            if(url.length > 1) data += "&"+url[1];
            $.ajax({
              beforeSend:function(){
                $("#tabContent").empty();
                $("#tabContent").append('<br><br><br><br><br><img src=\'../images/loading.gif\' align=\'absmiddle\' alt=\'\' /> 加载中...');
              },
              url: url[0],
              data: data,
              dateType:'html',
              cache:false,
              error:function(){
                alert('加载错误')
              },
              success: function(html){
                $("#tabContent").empty();
                $("#tabContent").append(html);
              }
            });
        }

    }
    
    //-->
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="lib_Tab">
    <div class="lib_Menubox lib_tabborder" id="tabHeader">
    <ul>
       <li>基本信息</li>
       <li>消费记录</li>
       <li>查看折扣</li>
       <li>积分换购</li> 
       <li>积分奖励</li> 
       <li>生日礼物</li> 
       <li>VIP卡升级</li> 
       <li>VIP卡补办</li> 
       <li>电子券</li> 
       <li>奖励积分</li> 
       <li>荣誉积分</li> 
       <li>积分调整</li> 
       <li>积分抵扣</li> 
    </ul>
    </div>
     <div class="lib_Contentbox lib_tabborder" id="tabContent">
     </div>
    </div>
    <asp:HiddenField ID="vipcode" runat="server" />
    <asp:HiddenField ID="vipid" runat="server" />
    </form>
</body>
</html>
