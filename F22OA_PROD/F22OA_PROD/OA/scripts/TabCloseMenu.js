// Very simple plugin for adding a close context menu to tabs
Ext.ux.TabCloseMenu = function(){
    var tabs, menu, ctxItem;
    this.init = function(tp){
        tabs = tp;
        tabs.on('contextmenu', onContextMenu);
    }
    function onContextMenu(ts, item, e){
        if(!menu){ // create context menu on first right click
            menu = new Ext.menu.Menu([{
                id: tabs.id + '-desktop',
                text: '桌面',
				iconCls:'icon-home',
                handler : function(){
                    tabs.setActiveTab(0);
                }
            },'-',{
                id: tabs.id + '-close',
                text: '关闭',
                handler : function(){
                    tabs.remove(ctxItem);
                }
            },{
                id: tabs.id + '-close-others',
                text: '关闭其它',
                handler : function(){
                    tabs.items.each(function(item){
                        if(item.closable && item != ctxItem){
                            tabs.remove(item);
                        }
                    });
                }
            },'-',{
                id: tabs.id + '-reload',
                text: '重新加载',
                handler : function(){
					refreshTab(ctxItem.id)
				}
            },'-',{
                text: '查看帮助',
				iconCls:'icon-question'
            }]);
        }
        ctxItem = item;
        var items = menu.items;
        items.get(tabs.id + '-close').setDisabled(!item.closable);
        items.get(tabs.id + '-reload').setDisabled(!item.closable);
        items.get(tabs.id + '-desktop').setDisabled(!item.closable);
        var disableOthers = true;
        tabs.items.each(function(){
            if(this != item && this.closable){
                disableOthers = false;
                return false;
            }
        });
        items.get(tabs.id + '-close-others').setDisabled(disableOthers);
        menu.showAt(e.getPoint());
    }
};

function refreshTab(id){//刷新当前标签
	var mainPanel = Ext.getCmp("doc-body");
	var fid = id.replace("docs-","iframe-");
	var frm = top.frames[fid];
	var title = id.replace("docs-","");
	
	//方法一:关闭当前标签,再生成一个
	//mainPanel.remove(id);
	//mainPanel.loadClass(href,title)
	
	//方法二:直接当前标签内的框架
	if(frm){
		var subFrm = top.frames[fid].frames["main"];
		if(subFrm){
		subFrm.location.reload();
		}else{
		frm.location.reload();
		}
	}
	
}