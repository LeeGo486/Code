<%@ page language="C#" autoeventwireup="true" inherits="OA_scripts_docs, App_Web_docs.aspx.34d608db" enableviewstatemac="false" enableEventValidation="false" %>

//<script>
Ext.BLANK_IMAGE_URL = 'images/ext/s.gif';

Docs = {};

var fm=Ext.form;

function RemoveHTML(strText){
	var regEx = /<[^>]*>/g;
	strText=strText.replace(regEx, "");
	//strText=strText.replace("&","");
	return strText;
}


function oaconfig(){
	var otabs	= Ext.getCmp("configWindow");
	if(!otabs){
		
	var disktop = [{boxLabel:'���Ź���',name:'news'},{boxLabel:'�������찲��',name:'works'},{boxLabel:'��������¼',name:'flow1'},
	                {boxLabel:'δ���Ĳ��ļ�¼',name:'flow2'},{boxLabel:'δ�����ѽ�����¼',name:'flow3'},{boxLabel:'�ճ���¼',name:'logs'},
	                {disabled:true,checked:false,boxLabel:'��ʾ��Ϣ',name:'tips'},{boxLabel:'����Ϣ',name:'msg'},{boxLabel:'���ʼ�',name:'mail'},
	                {disabled:true,checked:false,boxLabel:'��������',name:'daiban'},{disabled:true,checked:false,boxLabel:'��ʽ����',name:'diaocha'}];
								
	var tips = [{boxLabel:'��ʽȱ��',name:'ksqh'},{boxLabel:'�¿����',name:'xkrh'},{disabled:true,checked:false,boxLabel:'��������',name:'sales'}];
					
	var others = [{boxLabel:'Ĭ��չ���˵��б�',name:'news'},{boxLabel:'Ĭ��չ����ϵ���б�',name:'tips'},{boxLabel:'���ò˵�������¼',name:'works'},
	            {disabled:true,checked:false,boxLabel:'�رն���Ϣ��ʾ�����Ƽ���',name:'msg'},{disabled:true,checked:false,boxLabel:'�ر��¼���ʾ�����Ƽ���',name:'closeEvent'}];
			
    var tabs = new Ext.FormPanel({
				baseCls: 'x-plain',
        labelWidth :0,
        labelAlign : 'right',
        bodyStyle:'padding:5px 5px 0',
        border:false,
        width: 250,
				items:[{
						xtype:'tabpanel',
						baseCls: 'x-plain',
            plain:true,
            activeTab:0,
            height:300,
            defaults:{bodyStyle:'padding:10px'},
            items:[{
                title:'����ģ��',
								layout:'form',
                defaultType: 'checkbox',
								defaults:{checked:true,hideLabel:true},
								items: disktop
								
							},{
                title:'��ʾ��Ϣ����',
								layout:'form',
                defaultType: 'checkbox',
								defaults:{checked:true,hideLabel:true},
                items: tips
							},{
                title:'����',
								layout:'form',
                defaultType: 'checkbox',
								defaults:{checked:true,hideLabel:true},
                items: others
						}]
				}]

});

	var configWindow = new Ext.Window({
			id:'configWindow',
			title: '��ҳ�Զ�������',
			width: 300,
			autoHeight:true,
			minWidth: 300,
			layout: 'fit',
			plain:true,
			bodyStyle:'padding:5px;',
			buttonAlign:'center',
			items: tabs,
			buttons: [{
					text: '�� ��'
			},{
					text: 'ȡ ��',
					handler:function(){
						configWindow.close();
					}
			}]
	});
	
	configWindow.show();
	}
}


ApiPanel = function() {
    ApiPanel.superclass.constructor.call(this, {
        id:'api-tree',
        region:'west',
        split:true,
        width: 190,
        minSize: 120,
        maxSize: 300,
        collapsible: true,
        margins:'0 0 0 5',
        cmargins:'0 0 0 0',
        rootVisible:false,
        lines:true,
        autoScroll:true,
        animCollapse:false,//����ʱ������
				animate:false,//�˵�����ʱ����
        collapseMode:'mini',
        loader: new Ext.tree.TreeLoader({
					preloadChildren: true,
					clearOnLoad: false,
					dataUrl:'<%= menuUrl() %>'
				}),
        root: new Ext.tree.AsyncTreeNode({
            id:'root'
				}),
        collapseFirst:false/*,
				bbar:[
					'&nbsp;&nbsp;&nbsp;&nbsp;','��ǰ��<b id="onlinenum">1<\/b>������'
					]*/
    });
    // no longer needed!
    //new Ext.tree.TreeSorter(this, {folderSort:true,leafAttr:'isClass'});

    this.getSelectionModel().on('beforeselect', function(sm, node){
        return node.isLeaf();
    });
};


Ext.extend(ApiPanel, Ext.tree.TreePanel, {
    selectClass : function(cls){
        if(cls){
            var parts = cls.split(']');
            var last = parts.length-1;
            for(var i = 0; i < last; i++){ // things get nasty - static classes can have .
                var p = parts[i];
                var fc = p.charAt(0);
                var staticCls = fc.toUpperCase() == fc;
                if(p == 'Ext' || !staticCls){
                    parts[i] = 'pkg-'+p;
                }else if(staticCls){
                    --last;
                    parts.splice(i, 1);
                }
            }
            parts[last] = cls;

            this.selectPath('/root/cmpmenu/'+parts.join('/'));
        }
    }
});



// tools
	var tools = [
	    {id:'refresh',
			handler: function(e, target, panel){
			    panel.load(panel.autoLoad);
			}
	}/*,{
	//�رհ�ť
			id:'close',
			handler: function(e, target, panel){
					panel.ownerCt.remove(panel, true);
			}
	}*/];


DocPanel = Ext.extend(Ext.Panel, {
    closable: true,
    autoScroll:true,
    initComponent : function(){
        var ps = this.cclass.split('.');
        this.title = ps[ps.length-1];

        DocPanel.superclass.initComponent.call(this);
    },

    scrollToMember : function(member){
        var el = Ext.fly(this.cclass + '-' + member);
        if(el){
            var top = (el.getOffsetsTo(this.body)[1]) + this.body.dom.scrollTop;
            this.body.scrollTo('top', top-25, {duration:.75, callback: this.hlMember.createDelegate(this, [member])});
        }
    },

	scrollToSection : function(id){
		var el = Ext.getDom(id);
		if(el){
			var top = (Ext.fly(el).getOffsetsTo(this.body)[1]) + this.body.dom.scrollTop;
			this.body.scrollTo('top', top-25, {duration:.5, callback: function(){
                Ext.fly(el).next('h2').pause(.2).highlight('#8DB2E3', {attr:'color'});
            }});
        }
	},

    hlMember : function(member){
        var el = Ext.fly(this.cclass + '-' + member);
        if(el){
            el.up('tr').highlight('#cadaf9');
        }
    }
});


MainPanel = function(){
	    MainPanel.superclass.constructor.call(this, {
        id:'doc-body',
        region:'center',
        margins:'0 0 0 0',
        resizeTabs: true,
        minTabWidth: 70,//��Tab��ǩ�ܶ��ʱ�򣬿������ֳ���
        tabWidth: 130,  //Ĭ������¸ñ�ǩ�Ŀ��
        plugins: new Ext.ux.TabCloseMenu(),
				deferredRender:false, 
				monitorResize: true, 
				enableTabScroll:true, 
        activeTab: 0,
        items: {
            id:'welcome-panel',
            title: '��Ϣ������ҳ',
						iconCls:'icon-home',
            autoScroll: true,
						
//------------------------------------------portal��start
						xtype:'portal',//����
						layout:'column',
						items:<%= getitem("desktop").ToString().Replace("]}]",",{id:'reportplugin',title:'������δ������',layout:'fit',html:'<iframe src=/DRP_Plugin/Rank.aspx?shopid="+user+" frameborder=0 scrolling=no width=100% height=100% />',height:330}]}]").Replace(".69",".64").Replace(".30",".35") %>
//------------------------------------------portal��end
        }
    });
};


Ext.extend(MainPanel, Ext.TabPanel, {
    initEvents : function(){
        MainPanel.superclass.initEvents.call(this);
        this.body.on('click', this.onClick, this);	//��ȡmainpanel�ڵ���¼�
    },

    onClick: function(e, target){																//��ҳ��Ĵ���
        if(target = e.getTarget('a:not(.exi)', 3)){
            var cls = Ext.fly(target).getAttributeNS('ext', 'cls');
						var tt = target.title;														//��������ȡ���ӵı��⣬����Lab�ı���
						if(tt == ''){tt = RemoveHTML(target.innerHTML);}									//���ϣ��������û�б��⣬�Ǿ�������
						e.stopEvent();
						if(cls){
                var member = Ext.fly(target).getAttributeNS('ext', 'member');
                this.loadClass(target.href, cls, member);
						}else if(target.href.search('#')==(target.href.length-1)){
								return false;
						}else if(target.target == '_self'){//��ǰҳ�򿪵�
								var aaaa = this.getActiveTab();
								this.remove(aaaa.id);									//��ʵ�������Ƶ����ڵ�,Ȼ����loadһ������
                this.loadClass(target.href, aaaa.id);
						}else if(target.target == '_blank'){
                window.open(target.href);
						}else{
                this.loadClass(target.href, tt, member);
            }
        }else if(target = e.getTarget('.micon', 2)){
            e.stopEvent();
            var tr = Ext.fly(target.parentNode);
            if(tr.hasClass('expandable')){
                tr.toggleClass('expanded');
            }
        }
    },
    loadClass : function(href, cls, member, parames){//����tbar,bbar
				//ȫ��ƥ�䣬�滻������������
				cls = cls.replace(/\_/g,"").replace(/\./g,"").replace(/\&/g,"").replace(/amp;/g,"").replace(/"/g,"").replace(/;/g,"")
				if(cls.length<=0){cls="�ޱ���"}
				var id = 'docs-' + cls;
				var fid = 'iframe-' + cls;
				shref=href.split("/");
				if(shref[1]&&href.indexOf("oa")<0&&href.indexOf("msg")<0&&href.indexOf("mail")<0){
					id = 'docs-'+shref[1];
					fid = 'iframe-'+shref[1];
				}
                var f=false;
                if(shref[1]=="b28web"&&shref[2]=="report")
                {
                    id = 'docs-post';
                    fid = 'iframe-post';
                }
		        var tab = this.getComponent(id);//�����Ƿ��з��ϵ�ID
				if(tab && this.getActiveTab().id ==id){		//����з��ϵ�ID
						//this.remove(id);
						//this.loadClass(href, cls)
						this.getActiveTab().setTitle(cls);
						document.getElementById(fid).src=href;

        }else if(tab){													//���򣬽����ظ�����
					this.setActiveTab(tab);			//���㽫������Tab
            //if(member){									//�������ê������������ê
            //    tab.scrollToMember(member);
            //}
        }else{
					//var autoLoad = {url: href, scripts:true, text:'������...'};		//����,����ִ��ҳ����� 
					var iframe  ='<iframe frameborder="0" id="'+fid+'" name="'+fid+'" '
						+' width="100%" height="100%" src="'+href+'" scrolling="auto"></iframe>'
								//����һ��iframe�߶������ݸ߶ȸı䣬Ӧ��Ext�Ĺ���������
						//+' height="100%" width="100%" src="'+href+'" scrolling="auto"></iframe>'
								//���������߶�100%���õ�iframe����Ĺ�����������IE6����ֺ��������
            //if(member){
//                autoLoad.callback = function(){
//                    Ext.getCmp(id).scrollToMember(member);
//                }
//            }
            var p = this.add(new DocPanel({
                id: id,
                cclass : cls,
								layout:'fit',
                html: iframe
					}));
            this.setActiveTab(p);
			}
    }
});


Ext.onReady(function(){

			Ext.QuickTips.init();

    var api = new ApiPanel();
    var mainPanel = new MainPanel();

    api.on('click', function(node, e){
         if(node.isLeaf()){
            e.stopEvent();
						var apihref=node.attributes.href.toLowerCase();
						if(apihref.search("http://f22/")==0){
							location.href=apihref;
						}else{
							mainPanel.loadClass(apihref, node.text);//node.text:��ʾTab��̧ͷ����
						}
         }
    });

    mainPanel.on('tabchange', function(tp, tab){
        api.selectClass(tab.cclass); 
    });

		var tipsform = new Ext.form.FormPanel({
		        id:'tipsform',
				//url:'hiddensubmit.aspx',
				items: [{
				    xtype:'hidden',
				    id:'gtype',
				    name:'gtype',
				    value:'getonline'
				    //���ر������ڻ�ȡ��ʱ����
				    /**/
				}]
		});
		
		tipsform.render('gtform');

    var hd = new Ext.Panel({
        border: false,
        layout:'anchor',
        region:'north',
        cls: 'docs-header',
        height:60,
        items: [{
            xtype:'box',
            el:'header',
            border:false,
            anchor: 'none -25'
        },
        new Ext.Toolbar({
            cls:'top-toolbar',
            items:[
									 ' ',
						{
                iconCls: 'icon-expand-all',		//չ��ȫ��
								tooltip: 'ȫ��չ��',
                handler: function(){ api.root.expand(true); }
            }, '-', {
                iconCls: 'icon-collapse-all',	//����ȫ��
                tooltip: 'ȫ������',
                handler: function(){ 
								api.root.collapse(true);
								api.expandPath('/root/cmpmenu');
								}
            },'-',
	            welcometips,//�û���ʾ,������default.aspx
	            '->',{
			            text:'��ҳ',
										iconCls: 'icon-home font-blue',
			            handler:function(){
			                        mainPanel.setActiveTab(0);
					            }
            },<%= getitem("menu")%> /*'-', {
                tooltip:'��ҳ�Զ�������',
								text:'�Զ���',
								iconCls: 'icon-config',
								handler:function(){
													oaconfig();
									}
            }, '-',{
                tooltip:'��ʾ��������ϵ�˻��ò˵��б�',
								text:'��ϵ��',
                iconCls: 'usergroup font-blue',
								handler:function(){
									var east = Ext.getCmp('east');
									if(east)
										if(east.collapsed){
											east.expand(false);//չ����ϵ�ˣ������false��Ҫ��Ҫ����Ч������˼
										}else{
											east.collapse(false);
										}
								}
							//oa/bbsxp/Default.asp
								
            },*/'-',{
                tooltip:{title:'EP_CRM',text:'��˾CRMϵͳ'},
                text:'EP_CRM',
                iconCls: 'icon-question font-blue',
                handler:function(){
                    window.open("http://192.168.0.49/login/loginpost.php?loginsystem=1&loginname="+'<%=user%>'+"&password="+'<%=pd%>'+"");
								}
                
            },'-',{
                tooltip:{title:'ϵͳ����',text:'ϵͳ����ϵͳ'},
                text:'ϵͳ����',
                icon: '/DRP_Plugin/AppList/block.png',iconCls: 'font-blue',
                handler:function(){
                    var win=new Ext.Window({
                        width:550,
                        height:460,
                        title:"ϵͳ����",
                        iconCls: 'icon-fav font-blue',
                        modal:true,
                        html:'<iframe src="/DRP_Plugin/AppList/index.aspx?uid=<%=user%>&pwd=<%=pd%>&zt=<%=f18pass%>&depotid=<%=app_user.depotid%>" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>'
					});
				    win.show();
				}

           }/*, '-', {
                tooltip:'ע����ǰ�û�',
				text:'ע��',
                iconCls: 'icon-exit font-blue',
				handler:function(){
					Ext.Msg.confirm('ע��','ע����ǰ�û����˳���ǰϵͳ!<br />ȷ��Ҫע����?',function(btn, text){
						//top.window.close();
						if(btn == 'yes'){
							self.location.href='../relogin.aspx';
						}
					});
				}
            }*/]
        })]
    })

//-----------���������Ҽ��˵�----------	

    var personalmenu = new Ext.menu.Menu({
        id: 'mainMenu',
        items: [{
                text: '�޸�����',
                handler:function(){
										mainPanel.loadClass('isprit/member/UpdateDetail.aspx','�����޸�')
									}
            },{
                text: '�޸�����',
								iconCls:'icon-lock',
                handler:function(){
										mainPanel.loadClass('isprit/member/updatepwd.aspx','�޸�����')
									}
            }]
    });
//���ͽṹ..................start
//var alluser = new Ext.tree.TreePanel({
//				id:'im-tree',
//				iconCls:'usergroup',
//				autoScroll:true,
//				loader: new Ext.tree.TreeLoader({
//					preloadChildren: true,
//					clearOnLoad: false,
//					dataUrl:'isprit/member/json_userlist.aspx'
//				}),
//				root: new Ext.tree.AsyncTreeNode({
//						id:'tree-user'
//				}),
//				rootVisible:false,
//				lines:true,
//				title:'��ϵ��',
//				border: false,//���б߿�,����Ϊfalse
//			    bbar:[
//				'&nbsp;&nbsp;&nbsp;&nbsp;','��ǰ��<b id="onlinenum">1<\/b>������'
//				],
//				tbar:[{
//						tooltip:'��ʾ���������������û�',
//						iconCls:'connect',
//						pressed: true,
//						enableToggle:true,
//						toggleHandler:function(){
//							var usertree = Ext.getCmp('im-tree');			//��ȡ��
//							var uld = usertree.loader.dataUrl;
//							if(uld.search('alluser')>0){
//								//����ʾ�����û�
//								usertree.loader.dataUrl='isprit/member/json_userlist.aspx';
//							}else{
//								//��ʾ�����û�
//								usertree.loader.dataUrl='isprit/member/json_userlist.aspx?ut=alluser';
//							}
//							usertree.body.mask('Loading', 'x-mask-loading');
//							usertree.root.reload();									//���¼�����
//							usertree.root.collapse(true, false);
//							setTimeout(function(){ // mimic a server call
//									usertree.body.unmask();
//									//usertree.root.expand(true, true);
//							}, 1000);
//						}
//				},'-',{
//				tooltip:{title:'������',text:'�鿴�����շ����ż�¼'},
//				iconCls:'icon-msg',
//				handler:function(){
//					mainPanel.loadClass('isprit/msg/msg_default.htm','����Ϣ');
//					}
//				},'-',{
//				tooltip:{title:'�ʼ�',text:'�鿴�������ʼ���¼'},
//				iconCls:'icon-mail',
//				handler:function(){
//					mainPanel.loadClass('isprit/mail/mail_default.htm','�ʼ�');
//					}
//				},'-',{
//				iconCls:'icon-refresh',
//				tooltip:'ˢ���û��б�',
//				handler: function(){
//				    rluser();
//				    parent.autoreader('hiddensubmit.aspx');
//				   
//				}
//				},'->',{
//						tooltip:'���������޸�',
//						iconCls:'info-edit',
//						menu:personalmenu
//				}]
//			})
//---------��ϵ�˵��Ҽ��˵�------------------------
//	alluser.on('dblclick', dblclick, alluser);
//	alluser.on('contextmenu', contextmenu, alluser);
	function dblclick(node, e) {
		if(node.leaf==true&&node.id.search('user')>=0){
		
		//��ȡ��ǰ���Tab��ID
			var mi = Ext.getCmp("doc-body").getActiveTab().id
			if(mi=="docs-д�ʼ�"){
				//�����ǰ���Tab��ID��д�ʼ��ģ���ֱ����ӵ��ʼ�������
				usersendurl(node.id,node.text,"mail");
			}else{
				//���򰴷����Ŵ���
				usersendurl(node.id,node.text,"msg");
			}
		}
	};
	
	function contextmenu(node, e) {
		if(node.leaf==true&&node.id.search('user')>=0){
			treeMenu = new Ext.menu.Menu({
					id : 'treeMenu',
					items: [{
									text : '�鿴����',
									handler:function(){
									var userid = node.id.replace('user','')
										mainPanel.loadClass('isprit/member/showuser.aspx?userid='+userid, node.text+'�ĸ�������');
									}
									
									}
							,'-',{
									text : '��'+node.text+'����Ϣ',
									iconCls : 'icon-msg',
									handler:function(){
										usersendurl(node.id,node.text,"msg");
									}
							},{
									text : '��'+node.text+'���ʼ�',
									iconCls : 'icon-sendmail',
									handler:function(){
										usersendurl(node.id,node.text,"mail");
									}
							}
					]
			});
		}else{
			treeMenu = new Ext.menu.Menu({
					id : 'treeMenu',
					items: [{
									text : '��'+node.text+'����Ϣ',
									iconCls : 'icon-msg',
									handler:function(){
										node.expand();
										setTimeout(function(){
											var userid="",username="";
											
											for(i=0;i<node.childNodes.length;i++)
											{
												if(i==0){
													userid+=node.childNodes[i].id;
													username+=node.childNodes[i].text;
												}else{
													userid+="||"+node.childNodes[i].id;
													username+="||"+node.childNodes[i].text;
												}
											}
											usersendurl(userid,username,"msg");
										},0)
									}
							},{
									text : '��'+node.text+'���ʼ�',
									iconCls : 'icon-sendmail',
									handler:function(){
										node.expand();
										setTimeout(function(){
											var userid="",username="";
											for(i=0;i<node.childNodes.length;i++)
											{
												if(i==0){
													userid+=node.childNodes[i].id;
													username+=node.childNodes[i].text;
												}else{
													userid+="||"+node.childNodes[i].id;
													username+="||"+node.childNodes[i].text;
												}
											}
											usersendurl(userid,username,"mail");
										},0)
									}
							}/*,'-',{
									text : '�������˷���Ϣ',
									handler:function(){
										usersendurl('','','msg');
									}
							},{
									text : '�������˷��ʼ�',
									handler:function(){
										usersendurl('','','mail');
									}
							}*/
					]
			});
		}
			coords = e.getXY();
			treeMenu.showAt([coords[0], coords[1]]);
	};
	

//���ͽṹ..................end


//-----------------------------------------------------East �Ĳ���
//var east = new Ext.Panel({//�¶���һ������
//		id:'east',
//		region:'east',
//		//title: '�û�����',
//		collapseMode:'mini',
//		hideCollapseTool :false,
//		collapsible: true,
//		collapsed:true,	//�ر�sidebar;
//		split:true,
//		width: 152,
//		minSize: 152,
//		maxSize: 250,
//		layout:'fit',
//		margins:'0 5 0 0',
//		items:
//	    new Ext.TabPanel({
//		    border:false,
//		    activeTab:0,
//		    tabPosition:'top',
//		    items:[alluser,{
//				    title: '���ò˵�',
//				    autoScroll:true,
//				    layout:'fit',
//				    bbar:['','','','','���� <b id="menu_history">0</b> ����ʷ��¼'],
//				    autoLoad:{url:'menu_history.aspx',scripts:true}     //��ݷ�ʽ
//			        }//�û��б�
//				    ]
//		    })

//})
//---------------------------
// Add Tree Menu
    function onContextShow(node, e) {   
        createContextMenu();   
           
        if(ctxNode){   
           ctxNode.ui.removeClass('x-node-ctx');   
        }   
        if (node) {   
           ctxNode = node;   
           ctxNode.ui.addClass('x-node-ctx');   
        }   
           
        ctx.showAt(e.getXY());   
    } 
//---------------------	
    /*var south = new Ext.Panel({//�¶���һ������
					region:'south',//������������south(��)
					split:true,
					height: 50,
					minSize: 50,
					maxSize: 100,
					collapsible: true,
					margins:'0 0 0 0',
					autoLoad:'bottom.html'

		})*/
//---------------------	
    var viewport = new Ext.Viewport({
				id:'viewport',
        layout:'border',
        items:[ hd, api, mainPanel]//, east, south
    });
	//����ʱչ��ĳһ���ݲ˵� start
    api.expandPath('/root/cmpmenu');
    //end 
		
    // �ⲿ�������ӵ�
			//��URL��ȡ
    var page = window.location.href.split('?')[1];
    if(page){
        var ps = Ext.urlDecode(page);
        var url = ps['u'];
        var cls = ps['c'];
				if(url&&cls){					//�������������ֵ�ſ���loadclass
						url = url.replace('%3F','?');
				    url = url.replace('%26','&');
				    url = url.replace('%3D','=');
				    mainPanel.loadClass(url, cls);
				}
    }
		
	// �ⲿ�������� end
	
		
	//setTimeout(function(){
  //      Ext.get('loading').remove();
  //      Ext.get('loading-mask').fadeOut({remove:true});
  //  }, 250);
	
	var filter = new Ext.tree.TreeFilter(api, {
		clearBlank: true,
		autoClear: true
	});
	var hiddenPkgs = [];
	function filterTree(e){
		var text = e.target.value;
		Ext.each(hiddenPkgs, function(n){
			n.ui.show();
		});
		if(!text){
			filter.clear();
			return;
		}
		api.expandAll();
		
		var re = new RegExp('^' + Ext.escapeRe(text), 'i');
		filter.filterBy(function(n){
			return !n.attributes.isClass || re.test(n.text);
		});
		
		// hide empty packages that weren't filtered
		hiddenPkgs = [];
		api.root.cascade(function(n){
			if(!n.attributes.isClass && n.ui.ctNode.offsetHeight < 3){
				n.ui.hide();
				hiddenPkgs.push(n);
			}
		});
	}
		
		
});


//-------------------------

//----------------------	

    function rluser(){
        var tree = Ext.getCmp('im-tree');			//ˢ���û��б�
		tree.body.mask('Loading', 'x-mask-loading');
		tree.root.reload();									//���¼�����
		tree.root.collapse(true, false);
		setTimeout(function(){ // mimic a server call
				tree.body.unmask();
				//tree.root.expand(true, true);
		}, 800);
    }

//-----------------
	function chgTreeDataUrl(v){
		var tree = Ext.getCmp('api-tree');			//��ȡ��
		tree.loader.dataUrl='json_menu.aspx?type='+v;
		tree.body.mask('Loading', 'x-mask-loading');
		tree.root.reload();									//���¼�����
		//tree.root.collapse(true, false);
		setTimeout(function(){ // mimic a server call
				tree.body.unmask();
				//tree.root.expand(true, true);
		}, 800);
	}
	
//---------------------------
	function usersendurl(to_id,to_user,to_type){
			var mainPanel=Ext.getCmp('doc-body');
			
			var sendmsg = Ext.getCmp('docs-������Ϣ');
			var sendmail = Ext.getCmp('docs-д�ʼ�');			
			
			var userid=to_id.replace('user','')+",";
			var username=to_user+"/"+userid;

			var actId="";
			var ifrm="";

				//���Ͷ���Ϣ
				if(sendmsg && to_type=="msg"){
					actId="docs-������Ϣ";
					ifrm="iframe-������Ϣ";
					
				//�����ʼ�
				}else if(sendmail && to_type=="mail"){
					actId="docs-д�ʼ�";
					ifrm="iframe-д�ʼ�";

				//��һ�δ�
				}else{
					var data = '';
					var ids = to_id.split('||');
					var names = to_user.split('||');
					if(to_id != '')
					{
						if(to_id.indexOf('||')>0){
	
							for(i=0;i<ids.length;i++)
							{
								if(i==0){ data+="?" }else{ data+="&" }
								data+="touserid="+ids[i].replace('user','')+"&tousername="+names[i]+"/"+ids[i].replace('user','');
							}
						}else{
							data = '?touserid='+userid+'&tousername='+username;
						}
					}
				
					if(to_type=="msg"){
						var msglink='isprit/msg/msg_send.aspx' + data;
						msglink=encodeURI(msglink,'utf-8');	//�������ȥ��ֵ��������
						mainPanel.loadClass(msglink,'������Ϣ','','');
					}else{
						var msglink='isprit/mail/mail_write.aspx' + data;
						msglink=encodeURI(msglink,'utf-8');	//�������ȥ��ֵ��������
						mainPanel.loadClass(msglink,'д�ʼ�','','');
					}
				}
				//׷������
				if(ifrm!=""&&actId!=""){
					mainPanel.setActiveTab(actId);
					if(to_id == '') return ;
					var frmdoc = document.frames ? document.frames[ifrm].document : document.getElementById(ifrm).contentDocument;
						var TO_ID=frmdoc.getElementById("TO_ID");
						var TO_NAME=frmdoc.getElementById("TO_NAME");
						
					var data = '';
					var ids = to_id.split('||');
					var names = to_user.split('||');
					if(to_id.indexOf('||')>0){

						for(i=0;i<ids.length;i++)
						{
							//�޴������������
								if(TO_ID.value.indexOf(","+ids[i].replace('user',''))<0 && TO_ID.value.indexOf(ids[i].replace('user',''))!=0){
									TO_ID.value   += ids[i].replace('user','')+",";
									TO_NAME.value += names[i]+"/"+ids[i].replace('user','')+",";
									
							//�д����������Ƴ�
								}else{
									TO_ID.value   = TO_ID.value.replace(ids[i].replace('user',''),'')+",";
									TO_NAME.value = TO_NAME.value.replace(names[i]+"/"+ids[i].replace('user','')+",",'');
								}
						}
					}else{

					//�޴������������
						if(TO_ID.value.indexOf(","+userid)<0 && TO_ID.value.indexOf(userid)!=0){
							TO_ID.value   += userid;
							TO_NAME.value += username;
							
					//�д����������Ƴ�
						}else{
							//TO_NAME.setValue(names.replace(username,''));
							//TO_ID.setValue(toid.replace(userid,''));
							TO_ID.value   = TO_ID.value.replace(userid,'');
							TO_NAME.value = TO_NAME.value.replace(username,'');
						}
					}


				}
	};
	
	