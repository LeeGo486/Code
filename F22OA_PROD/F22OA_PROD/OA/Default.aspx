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
    <div class="loading-indicator"><img src="images/ext/loading.gif" alt="" width="32" height="32" style="margin-right:8px;" align="absmiddle"/>���Ե�...</div>
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
    if(hour < 6)welcometips='�賿��'
    else if(hour < 9)welcometips='���Ϻ�'
    else if(hour < 12)welcometips='�����'
    else if(hour < 14)welcometips='�����'
    else if(hour < 17)welcometips='�����'
    else if(hour < 19)welcometips='�����'
    else if(hour < 22)welcometips='���Ϻ�'
    else {welcometips='��ҹ��'}
    if(today.getDay()==0)day='������'
    else if(today.getDay()==1)day='����һ'
    else if(today.getDay()==2)day='���ڶ�'
    else if(today.getDay()==3)day='������'
    else if(today.getDay()==4)day='������'
    else if(today.getDay()==5)day='������'
    else if(today.getDay()==6)day='������'
    date=(today.getYear())+'��'+(today.getMonth() + 1 )+'��'+today.getDate()+'��';
    welcometips += '��<asp:label id="lbname" runat="server" /> ������' + date + ' ' + day;
    </script>
    <script type="text/javascript">
    
//-----------------------------��ʾ��-------------------------start

		var popWidth = 262; //��Ϣ����
		var popHeight = 122; //��Ϣ��߶�
		var popBorder = 22; //����Ļ��Ե�ľ���
		var popShow = 3000; //��Ϣ�����ʾʱ��
		var popTop =0;
		var opopup = window.createPopup();
		
		var loadTime = 5000;//���ض���ʱ�����ʾ
		var checkTime = 600000;//�����ʱ����һ��
		
		//����mainPanel��loadClass,���½���ǩ
		function showLink(url,title){
				pophide();	//���ؾɵ�
				window.focus();		//��ȡ���ڽ���
				
			var mainpanel = Ext.getCmp('doc-body');
			var msgTab=Ext.getCmp('docs-'+title);
			if(msgTab){
				mainpanel.remove('docs-'+title);
			}
			mainpanel.loadClass(url,title);
		}
		
		//�ճ̰�����ʾ
		function taskClick(a,b){
			//���ؾɵ�
			pophide();
		
			//�ճ̰�����ʾʱ����ˡ�֪���ˡ�
			if(a==1){
				autoreader('hiddensubmit.aspx?t=task&id='+b+'');
			//�ճ̰�����ʾʱ����ˡ����ࡱ
			}else if(a==2){
				window.focus();		//��ȡ���ڽ���
				showLink('isprit/schedule/default.htm','�ճ̰���');
			}else if(a==4){
				autoreader('hiddensubmit.aspx?t=msg&id='+b+'');
			}
		}
		//��ȡ���µ��ճ̰��ż�����Ϣ
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
//						    rluser();//ˢ���û��б�[Ϊ���ٷ�������������֪��������ֻ����������������������Զ�ˢ���û��б�]
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
		
		oldTime = setTimeout(autoreader,loadTime);//loadTime���ٿ�ʼ���
		
        function popmsg(msgheader,msgbody,msgfooter)
        {
					
	        opopup.document.body.style.margin='0';
	        opopup.document.body.style.filter='Alpha(Opacity=80)';
	        opopup.document.body.style.background='url(images/tips-background.gif) no-repeat';
					
	        opopup.document.body.innerHTML = '<div style="width:262px;position:relative;cursor:default;height:122px;font-size:12px;font-family:arial;color:#036;"><div style="font-weight:bold; clear:both; line-height:36px; padding:0 15px; position:relative;">'+msgheader+'<span style="position:absolute;left:230px;top:2px; padding:0;margin:0;width:10px; height:10px; overflow:hidden;background:url(images/tips-close-out.gif) no-repeat; " onmouseover="this.style.background=\'url(images/tips-close-over.gif) no-repeat\'" onmouseout="this.style.background=\'url(images/tips-close-out.gif) no-repeat\'" onclick="javascript:parent.pophide();" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div><div style="clear:both; overflow:hidden; height:54px; padding:0 10px; text-indent:12px; line-height:18px;">'+msgbody+'</div><div style="text-align:left; clear:both; height:26px; line-height:26px; padding:0 20px; text-align:right;">'+msgfooter+'</div></div>';
        	
            //��Ϣ�����ʽ
            popshow();
        }

        //��Ϣ����ʾ����
        function popshow()
        {    
            //����������ʾ��Ϣ��ȫ��ʱ����С��Ϣ��߶�
            var tmpHeight = popTop < popHeight ? popTop : popHeight;
            //��Ϣ��λ��screen.width����Ļ��ȡ�screen.height����Ļ�߶�
            opopup.show(screen.width - (popWidth + popBorder), screen.height - popTop, popWidth, tmpHeight);
            if (popTop < (popHeight + popBorder)){
                popTop = popTop + 10; //��Ϣ��λ�õ���
            }else{
                //setTimeout("pophide()", popShow); //׼��������Ϣ��
							if (oldTime){clearTimeout(oldTime);}//����Զ���ȡ
            }
            showtime = setTimeout("popshow()",20);
        }

        //��Ϣ�����س���
        function pophide(){

            if (showtime){clearTimeout(showtime);}
            
            var tmpHeight = popTop < popHeight ? popTop : popHeight;

            opopup.show(screen.width - (popWidth + popBorder), screen.height - popTop, popWidth, tmpHeight);

            if (popTop > 0){
                popTop = popTop - 10;
                hidetime = setTimeout("pophide();",20);
            }else{
                clearTimeout(hidetime);
                opopup.hide();          //��ȫ������Ϣ��
				oldTime = setTimeout(autoreader,checkTime);	//�ٶ�ȡ
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
	//�Զ��������ֵ�
	setInterval(function(){
	Ext.getCmp("viewport").doLayout();
	},500)
</script>
  </body>
</html>