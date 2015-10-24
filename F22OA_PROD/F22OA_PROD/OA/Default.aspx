<%@ page language="C#" autoeventwireup="true" inherits="oa_default, App_Web_default.aspx.766205c1" %>
<html lang="en" xmlns:ext="http://extjs.com/docs">
<head>
  <meta http-equiv="pragma" content="no-cache" />
  <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
  <title id="titlelabel" runat="server"></title>
  <script type="text/javascript">
  //window.onerror = function(){return true}
  </script>
  <link rel="stylesheet" type="text/css" href="scripts/ext-all.css" />
  <link rel="stylesheet" type="text/css" href="scripts/docs.css" />
  <link rel="stylesheet" type="text/css" href="scripts/portal.css" />
  </head>
<body scroll="no" id="docs">
    <script type="text/javascript" src="scripts/ext-base.js"></script>
    <script type="text/javascript" src="scripts/ext-all.js"></script>
    <script type="text/javascript" src="scripts/TabCloseMenu.js"></script>
    <script type="text/javascript" src="scripts/docs.aspx"></script>
    <script type="text/javascript" src="scripts/Portal.js"></script>
<!--
  <div id="loading-mask" style=""></div>
  <div id="loading">
    <div class="loading-indicator"><img src="images/ext/loading.gif" alt="" width="32" height="32" style="margin-right:8px;" align="absmiddle"/>请稍等...</div>
  </div>
-->
<!-- include everything after the loading indicator -->
    <script type="text/javascript">
			//Portlet.js
			Ext.ux.Portlet = Ext.extend(Ext.Panel, {
					anchor: '100%',
					frame:true,
					collapsible:true,
					draggable:true,
					cls:'x-portlet'
			});
			Ext.reg('portlet', Ext.ux.Portlet);
			
			//protalcolumn.js
			Ext.ux.PortalColumn = Ext.extend(Ext.Container, {
					layout: 'anchor',
					autoEl: 'div',
					defaultType: 'portlet',
					cls:'x-portal-column'
			});
			Ext.reg('portalcolumn', Ext.ux.PortalColumn);
		
		
    today=new Date();
    var day; var date; var welcometips; var wel;
    hour=new Date().getHours()
    if(hour < 6)welcometips='凌晨好'
    else if(hour < 9)welcometips='早上好'
    else if(hour < 12)welcometips='上午好'
    else if(hour < 14)welcometips='中午好'
    else if(hour < 17)welcometips='下午好'
    else if(hour < 19)welcometips='傍晚好'
    else if(hour < 22)welcometips='晚上好'
    else {welcometips='深夜了'}
    if(today.getDay()==0)day='星期日'
    else if(today.getDay()==1)day='星期一'
    else if(today.getDay()==2)day='星期二'
    else if(today.getDay()==3)day='星期三'
    else if(today.getDay()==4)day='星期四'
    else if(today.getDay()==5)day='星期五'
    else if(today.getDay()==6)day='星期六'
    date=(today.getYear())+'年'+(today.getMonth() + 1 )+'月'+today.getDate()+'日';
    welcometips += '，<asp:label id="lbname" runat="server" /> 现在是' + date + ' ' + day;
    </script>
    <script type="text/javascript">
    
//-----------------------------提示框-------------------------start

		var popWidth = 262; //信息框宽度
		var popHeight = 122; //信息框高度
		var popBorder = 22; //距屏幕边缘的距离
		var popShow = 3000; //信息框的显示时间
		var popTop =0;
		var opopup = window.createPopup();
		
		var loadTime = 5000;//加载多少时间后显示
		var checkTime = 600000;//隔多久时间检测一次
		
		//调用mainPanel的loadClass,可新建标签
		function showLink(url,title){
				pophide();	//隐藏旧的
				window.focus();		//获取窗口焦点
				
			var mainpanel = Ext.getCmp('doc-body');
			var msgTab=Ext.getCmp('docs-'+title);
			if(msgTab){
				mainpanel.remove('docs-'+title);
			}
			mainpanel.loadClass(url,title);
		}
		
		//日程安排提示
		function taskClick(a,b){
			//隐藏旧的
			pophide();
		
			//日程安排提示时点击了“知道了”
			if(a==1){
				autoreader('hiddensubmit.aspx?t=task&id='+b+'');
			//日程安排提示时点击了“更多”
			}else if(a==2){
				window.focus();		//获取窗口焦点
				showLink('isprit/schedule/default.htm','日程安排');
			}else if(a==4){
				autoreader('hiddensubmit.aspx?t=msg&id='+b+'');
			}
		}
		//读取最新的日程安排及短消息
		function autoreader(url) {		    
			var tipsform = Ext.getCmp("tipsform");
			if(!url){
				url = 'hiddensubmit.aspx';
			}
			tipsform.getForm().submit({
					url:url,
					success:function(form,action){
						var online = action.result.data.online;
						var msg = action.result.data.msg;
						var msgheader = action.result.data.msgheader;
						var msgbody = action.result.data.msgbody;
						var msgfooter = action.result.data.msgfooter;
						//var onum = document.getElementById("onlinenum");
						
//						if(onum.innerHTML!=online){
//						    onum.innerHTML=online;
//						    rluser();//刷新用户列表[为减少服务器负担，获知最新人数只更新下面的在线人数，不自动刷新用户列表]
//						}
						if(msgheader){
							if(msgheader.length>0){
							   popmsg(msgheader,msgbody,msgfooter)
							}
						}else if(msg){
							if(msg.length>0) alert(msg);
						}
					}
				});
				oldTime = setTimeout(autoreader,checkTime);
		}
		
		oldTime = setTimeout(autoreader,loadTime);//loadTime后再开始检查
		
        function popmsg(msgheader,msgbody,msgfooter)
        {
					
	        opopup.document.body.style.margin='0';
	        opopup.document.body.style.filter='Alpha(Opacity=80)';
	        opopup.document.body.style.background='url(images/tips-background.gif) no-repeat';
					
	        opopup.document.body.innerHTML = '<div style="width:262px;position:relative;cursor:default;height:122px;font-size:12px;font-family:arial;color:#036;"><div style="font-weight:bold; clear:both; line-height:36px; padding:0 15px; position:relative;">'+msgheader+'<span style="position:absolute;left:230px;top:2px; padding:0;margin:0;width:10px; height:10px; overflow:hidden;background:url(images/tips-close-out.gif) no-repeat; " onmouseover="this.style.background=\'url(images/tips-close-over.gif) no-repeat\'" onmouseout="this.style.background=\'url(images/tips-close-out.gif) no-repeat\'" onclick="javascript:parent.pophide();" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div><div style="clear:both; overflow:hidden; height:54px; padding:0 10px; text-indent:12px; line-height:18px;">'+msgbody+'</div><div style="text-align:left; clear:both; height:26px; line-height:26px; padding:0 20px; text-align:right;">'+msgfooter+'</div></div>';
        	
            //信息框的样式
            popshow();
        }

        //信息框显示程序
        function popshow()
        {    
            //当不足以显示信息框全部时，缩小信息框高度
            var tmpHeight = popTop < popHeight ? popTop : popHeight;
            //信息框定位，screen.width：屏幕宽度、screen.height：屏幕高度
            opopup.show(screen.width - (popWidth + popBorder), screen.height - popTop, popWidth, tmpHeight);
            if (popTop < (popHeight + popBorder)){
                popTop = popTop + 10; //信息框位置递增
            }else{
                //setTimeout("pophide()", popShow); //准备隐藏信息框
							if (oldTime){clearTimeout(oldTime);}//清除自动读取
            }
            showtime = setTimeout("popshow()",20);
        }

        //信息框隐藏程序
        function pophide(){

            if (showtime){clearTimeout(showtime);}
            
            var tmpHeight = popTop < popHeight ? popTop : popHeight;

            opopup.show(screen.width - (popWidth + popBorder), screen.height - popTop, popWidth, tmpHeight);

            if (popTop > 0){
                popTop = popTop - 10;
                hidetime = setTimeout("pophide();",20);
            }else{
                clearTimeout(hidetime);
                opopup.hide();          //完全隐藏信息框
				oldTime = setTimeout(autoreader,checkTime);	//再读取
            }

        }
    </script>
  <div id="header">
	<a href="#" style="float:right;margin-right:10px;"><asp:image id="imglogo" Height="25" runat="server" /></a>
    <div class="api-title" id="lbcompany" runat="server" ></div>
  </div>
  <div id="classes"></div>
  <div id="main"></div>
  <div id="gtform" style="display:none;"></div>
<script type="text/javascript" defer="defer">
	//自动调整布局的
	setInterval(function(){
	Ext.getCmp("viewport").doLayout();
	},500)
</script>
  </body>
</html>