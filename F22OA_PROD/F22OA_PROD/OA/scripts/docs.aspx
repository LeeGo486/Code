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
		
	var disktop = [{boxLabel:'新闻公告',name:'news'},{boxLabel:'最新七天安排',name:'works'},{boxLabel:'待审批记录',name:'flow1'},
	                {boxLabel:'未看的查阅记录',name:'flow2'},{boxLabel:'未看的已结束记录',name:'flow3'},{boxLabel:'日常记录',name:'logs'},
	                {disabled:true,checked:false,boxLabel:'提示信息',name:'tips'},{boxLabel:'短消息',name:'msg'},{boxLabel:'新邮件',name:'mail'},
	                {disabled:true,checked:false,boxLabel:'待办事宜',name:'daiban'},{disabled:true,checked:false,boxLabel:'款式调查',name:'diaocha'}];
								
	var tips = [{boxLabel:'款式缺货',name:'ksqh'},{boxLabel:'新款入货',name:'xkrh'},{disabled:true,checked:false,boxLabel:'销售排行',name:'sales'}];
					
	var others = [{boxLabel:'默认展开菜单列表',name:'news'},{boxLabel:'默认展开联系人列表',name:'tips'},{boxLabel:'启用菜单操作记录',name:'works'},
	            {disabled:true,checked:false,boxLabel:'关闭短消息提示（不推荐）',name:'msg'},{disabled:true,checked:false,boxLabel:'关闭事件提示（不推荐）',name:'closeEvent'}];
			
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
                title:'桌面模块',
								layout:'form',
                defaultType: 'checkbox',
								defaults:{checked:true,hideLabel:true},
								items: disktop
								
							},{
                title:'提示信息设置',
								layout:'form',
                defaultType: 'checkbox',
								defaults:{checked:true,hideLabel:true},
                items: tips
							},{
                title:'其它',
								layout:'form',
                defaultType: 'checkbox',
								defaults:{checked:true,hideLabel:true},
                items: others
						}]
				}]

});

	var configWindow = new Ext.Window({
			id:'configWindow',
			title: '首页自定义设置',
			width: 300,
			autoHeight:true,
			minWidth: 300,
			layout: 'fit',
			plain:true,
			bodyStyle:'padding:5px;',
			buttonAlign:'center',
			items: tabs,
			buttons: [{
					text: '保 存'
			},{
					text: '取 消',
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
        animCollapse:false,//收隐时带动画
				animate:false,//菜单缩隐时动画
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
					'&nbsp;&nbsp;&nbsp;&nbsp;','当前有<b id="onlinenum">1<\/b>人在线'
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
	//关闭按钮
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
        minTabWidth: 70,//当Tab标签很多的时候，可以体现出来
        tabWidth: 130,  //默认情况下该标签的宽度
        plugins: new Ext.ux.TabCloseMenu(),
				deferredRender:false, 
				monitorResize: true, 
				enableTabScroll:true, 
        activeTab: 0,
        items: {
            id:'welcome-panel',
            title: '信息管理首页',
						iconCls:'icon-home',
            autoScroll: true,
						
//------------------------------------------portal　start
						xtype:'portal',//类型
						layout:'column',
						items:<%= getitem("desktop").ToString().Replace("]}]",",{id:'reportplugin',title:'畅销款未销提醒',layout:'fit',html:'<iframe src=/DRP_Plugin/Rank.aspx?shopid="+user+" frameborder=0 scrolling=no width=100% height=100% />',height:330}]}]").Replace(".69",".64").Replace(".30",".35") %>
//------------------------------------------portal　end
        }
    });
};


Ext.extend(MainPanel, Ext.TabPanel, {
    initEvents : function(){
        MainPanel.superclass.initEvents.call(this);
        this.body.on('click', this.onClick, this);	//获取mainpanel内点击事件
    },

    onClick: function(e, target){																//打开页面的代码
        if(target = e.getTarget('a:not(.exi)', 3)){
            var cls = Ext.fly(target).getAttributeNS('ext', 'cls');
						var tt = target.title;														//新增，获取连接的标题，用于Lab的标题
						if(tt == ''){tt = RemoveHTML(target.innerHTML);}									//继上，如果连接没有标题，那就用内容
						e.stopEvent();
						if(cls){
                var member = Ext.fly(target).getAttributeNS('ext', 'member');
                this.loadClass(target.href, cls, member);
						}else if(target.href.search('#')==(target.href.length-1)){
								return false;
						}else if(target.target == '_self'){//当前页打开的
								var aaaa = this.getActiveTab();
								this.remove(aaaa.id);									//其实就是先移掉现在的,然后再load一个进来
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
    loadClass : function(href, cls, member, parames){//新增tbar,bbar
				//全文匹配，替换掉这两个符号
				cls = cls.replace(/\_/g,"").replace(/\./g,"").replace(/\&/g,"").replace(/amp;/g,"").replace(/"/g,"").replace(/;/g,"")
				if(cls.length<=0){cls="无标题"}
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
		        var tab = this.getComponent(id);//查找是否有符合的ID
				if(tab && this.getActiveTab().id ==id){		//如果有符合的ID
						//this.remove(id);
						//this.loadClass(href, cls)
						this.getActiveTab().setTitle(cls);
						document.getElementById(fid).src=href;

        }else if(tab){													//否则，将加载该连接
					this.setActiveTab(tab);			//焦点将跳至该Tab
            //if(member){									//如果有抛锚，将滚动至该锚
            //    tab.scrollToMember(member);
            //}
        }else{
					//var autoLoad = {url: href, scripts:true, text:'加载中...'};		//新增,用于执行页面代码 
					var iframe  ='<iframe frameborder="0" id="'+fid+'" name="'+fid+'" '
						+' width="100%" height="100%" src="'+href+'" scrolling="auto"></iframe>'
								//方法一：iframe高度随内容高度改变，应用Ext的滚动条滚动
						//+' height="100%" width="100%" src="'+href+'" scrolling="auto"></iframe>'
								//方法二：高度100%，用到iframe自身的滚动条，但是IE6会出现横向滚动条
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
							mainPanel.loadClass(apihref, node.text);//node.text:显示Tab的抬头文字
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
				    //隐藏表单，用于获取即时数据
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
                iconCls: 'icon-expand-all',		//展开全部
								tooltip: '全部展开',
                handler: function(){ api.root.expand(true); }
            }, '-', {
                iconCls: 'icon-collapse-all',	//收缩全部
                tooltip: '全部收缩',
                handler: function(){ 
								api.root.collapse(true);
								api.expandPath('/root/cmpmenu');
								}
            },'-',
	            welcometips,//用户提示,内容在default.aspx
	            '->',{
			            text:'首页',
										iconCls: 'icon-home font-blue',
			            handler:function(){
			                        mainPanel.setActiveTab(0);
					            }
            },<%= getitem("menu")%> /*'-', {
                tooltip:'首页自定义设置',
								text:'自定义',
								iconCls: 'icon-config',
								handler:function(){
													oaconfig();
									}
            }, '-',{
                tooltip:'显示或隐藏联系人或常用菜单列表',
								text:'联系人',
                iconCls: 'usergroup font-blue',
								handler:function(){
									var east = Ext.getCmp('east');
									if(east)
										if(east.collapsed){
											east.expand(false);//展开联系人：里面的false是要不要动画效果的意思
										}else{
											east.collapse(false);
										}
								}
							//oa/bbsxp/Default.asp
								
            },*/'-',{
                tooltip:{title:'EP_CRM',text:'公司CRM系统'},
                text:'EP_CRM',
                iconCls: 'icon-question font-blue',
                handler:function(){
                    window.open("http://192.168.0.49/login/loginpost.php?loginsystem=1&loginname="+'<%=user%>'+"&password="+'<%=pd%>'+"");
								}
                
            },'-',{
                tooltip:{title:'系统集合',text:'系统集合系统'},
                text:'系统集合',
                icon: '/DRP_Plugin/AppList/block.png',iconCls: 'font-blue',
                handler:function(){
                    var win=new Ext.Window({
                        width:550,
                        height:460,
                        title:"系统集合",
                        iconCls: 'icon-fav font-blue',
                        modal:true,
                        html:'<iframe src="/DRP_Plugin/AppList/index.aspx?uid=<%=user%>&pwd=<%=pd%>&zt=<%=f18pass%>&depotid=<%=app_user.depotid%>" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>'
					});
				    win.show();
				}

           }/*, '-', {
                tooltip:'注销当前用户',
				text:'注销',
                iconCls: 'icon-exit font-blue',
				handler:function(){
					Ext.Msg.confirm('注销','注销当前用户将退出当前系统!<br />确定要注销吗?',function(btn, text){
						//top.window.close();
						if(btn == 'yes'){
							self.location.href='../relogin.aspx';
						}
					});
				}
            }*/]
        })]
    })

//-----------个人资料右键菜单----------	

    var personalmenu = new Ext.menu.Menu({
        id: 'mainMenu',
        items: [{
                text: '修改资料',
                handler:function(){
										mainPanel.loadClass('isprit/member/UpdateDetail.aspx','资料修改')
									}
            },{
                text: '修改密码',
								iconCls:'icon-lock',
                handler:function(){
										mainPanel.loadClass('isprit/member/updatepwd.aspx','修改密码')
									}
            }]
    });
//树型结构..................start
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
//				title:'联系人',
//				border: false,//树有边框,可设为false
//			    bbar:[
//				'&nbsp;&nbsp;&nbsp;&nbsp;','当前有<b id="onlinenum">1<\/b>人在线'
//				],
//				tbar:[{
//						tooltip:'显示或隐藏所有离线用户',
//						iconCls:'connect',
//						pressed: true,
//						enableToggle:true,
//						toggleHandler:function(){
//							var usertree = Ext.getCmp('im-tree');			//获取树
//							var uld = usertree.loader.dataUrl;
//							if(uld.search('alluser')>0){
//								//仅显示在线用户
//								usertree.loader.dataUrl='isprit/member/json_userlist.aspx';
//							}else{
//								//显示所有用户
//								usertree.loader.dataUrl='isprit/member/json_userlist.aspx?ut=alluser';
//							}
//							usertree.body.mask('Loading', 'x-mask-loading');
//							usertree.root.reload();									//重新加载树
//							usertree.root.collapse(true, false);
//							setTimeout(function(){ // mimic a server call
//									usertree.body.unmask();
//									//usertree.root.expand(true, true);
//							}, 1000);
//						}
//				},'-',{
//				tooltip:{title:'收信箱',text:'查看所有收发短信记录'},
//				iconCls:'icon-msg',
//				handler:function(){
//					mainPanel.loadClass('isprit/msg/msg_default.htm','短信息');
//					}
//				},'-',{
//				tooltip:{title:'邮件',text:'查看所有收邮件记录'},
//				iconCls:'icon-mail',
//				handler:function(){
//					mainPanel.loadClass('isprit/mail/mail_default.htm','邮件');
//					}
//				},'-',{
//				iconCls:'icon-refresh',
//				tooltip:'刷新用户列表',
//				handler: function(){
//				    rluser();
//				    parent.autoreader('hiddensubmit.aspx');
//				   
//				}
//				},'->',{
//						tooltip:'个人资料修改',
//						iconCls:'info-edit',
//						menu:personalmenu
//				}]
//			})
//---------联系人的右键菜单------------------------
//	alluser.on('dblclick', dblclick, alluser);
//	alluser.on('contextmenu', contextmenu, alluser);
	function dblclick(node, e) {
		if(node.leaf==true&&node.id.search('user')>=0){
		
		//获取当前活动的Tab的ID
			var mi = Ext.getCmp("doc-body").getActiveTab().id
			if(mi=="docs-写邮件"){
				//如果当前活动的Tab的ID是写邮件的，则直接添加到邮件接收人
				usersendurl(node.id,node.text,"mail");
			}else{
				//否则按发短信处理
				usersendurl(node.id,node.text,"msg");
			}
		}
	};
	
	function contextmenu(node, e) {
		if(node.leaf==true&&node.id.search('user')>=0){
			treeMenu = new Ext.menu.Menu({
					id : 'treeMenu',
					items: [{
									text : '查看资料',
									handler:function(){
									var userid = node.id.replace('user','')
										mainPanel.loadClass('isprit/member/showuser.aspx?userid='+userid, node.text+'的个人资料');
									}
									
									}
							,'-',{
									text : '给'+node.text+'发信息',
									iconCls : 'icon-msg',
									handler:function(){
										usersendurl(node.id,node.text,"msg");
									}
							},{
									text : '给'+node.text+'发邮件',
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
									text : '给'+node.text+'发信息',
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
									text : '给'+node.text+'发邮件',
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
									text : '给所有人发信息',
									handler:function(){
										usersendurl('','','msg');
									}
							},{
									text : '给所有人发邮件',
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
	

//树型结构..................end


//-----------------------------------------------------East 的布局
//var east = new Ext.Panel({//新定义一个区域
//		id:'east',
//		region:'east',
//		//title: '用户操作',
//		collapseMode:'mini',
//		hideCollapseTool :false,
//		collapsible: true,
//		collapsed:true,	//关闭sidebar;
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
//				    title: '常用菜单',
//				    autoScroll:true,
//				    layout:'fit',
//				    bbar:['','','','','共有 <b id="menu_history">0</b> 条历史记录'],
//				    autoLoad:{url:'menu_history.aspx',scripts:true}     //快捷方式
//			        }//用户列表
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
    /*var south = new Ext.Panel({//新定义一个区域
					region:'south',//声明该区域在south(南)
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
	//加载时展开某一部份菜单 start
    api.expandPath('/root/cmpmenu');
    //end 
		
    // 外部加入连接的
			//由URL读取
    var page = window.location.href.split('?')[1];
    if(page){
        var ps = Ext.urlDecode(page);
        var url = ps['u'];
        var cls = ps['c'];
				if(url&&cls){					//必须具有这两个值才可以loadclass
						url = url.replace('%3F','?');
				    url = url.replace('%26','&');
				    url = url.replace('%3D','=');
				    mainPanel.loadClass(url, cls);
				}
    }
		
	// 外部加入连接 end
	
		
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
        var tree = Ext.getCmp('im-tree');			//刷新用户列表
		tree.body.mask('Loading', 'x-mask-loading');
		tree.root.reload();									//重新加载树
		tree.root.collapse(true, false);
		setTimeout(function(){ // mimic a server call
				tree.body.unmask();
				//tree.root.expand(true, true);
		}, 800);
    }

//-----------------
	function chgTreeDataUrl(v){
		var tree = Ext.getCmp('api-tree');			//获取树
		tree.loader.dataUrl='json_menu.aspx?type='+v;
		tree.body.mask('Loading', 'x-mask-loading');
		tree.root.reload();									//重新加载树
		//tree.root.collapse(true, false);
		setTimeout(function(){ // mimic a server call
				tree.body.unmask();
				//tree.root.expand(true, true);
		}, 800);
	}
	
//---------------------------
	function usersendurl(to_id,to_user,to_type){
			var mainPanel=Ext.getCmp('doc-body');
			
			var sendmsg = Ext.getCmp('docs-发送信息');
			var sendmail = Ext.getCmp('docs-写邮件');			
			
			var userid=to_id.replace('user','')+",";
			var username=to_user+"/"+userid;

			var actId="";
			var ifrm="";

				//发送短信息
				if(sendmsg && to_type=="msg"){
					actId="docs-发送信息";
					ifrm="iframe-发送信息";
					
				//发送邮件
				}else if(sendmail && to_type=="mail"){
					actId="docs-写邮件";
					ifrm="iframe-写邮件";

				//第一次打开
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
						msglink=encodeURI(msglink,'utf-8');	//解决传过去的值变成乱码的
						mainPanel.loadClass(msglink,'发送信息','','');
					}else{
						var msglink='isprit/mail/mail_write.aspx' + data;
						msglink=encodeURI(msglink,'utf-8');	//解决传过去的值变成乱码的
						mainPanel.loadClass(msglink,'写邮件','','');
					}
				}
				//追加内容
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
							//无此收信人则添加
								if(TO_ID.value.indexOf(","+ids[i].replace('user',''))<0 && TO_ID.value.indexOf(ids[i].replace('user',''))!=0){
									TO_ID.value   += ids[i].replace('user','')+",";
									TO_NAME.value += names[i]+"/"+ids[i].replace('user','')+",";
									
							//有此收信人则移除
								}else{
									TO_ID.value   = TO_ID.value.replace(ids[i].replace('user',''),'')+",";
									TO_NAME.value = TO_NAME.value.replace(names[i]+"/"+ids[i].replace('user','')+",",'');
								}
						}
					}else{

					//无此收信人则添加
						if(TO_ID.value.indexOf(","+userid)<0 && TO_ID.value.indexOf(userid)!=0){
							TO_ID.value   += userid;
							TO_NAME.value += username;
							
					//有此收信人则移除
						}else{
							//TO_NAME.setValue(names.replace(username,''));
							//TO_ID.setValue(toid.replace(userid,''));
							TO_ID.value   = TO_ID.value.replace(userid,'');
							TO_NAME.value = TO_NAME.value.replace(username,'');
						}
					}


				}
	};
	
	