Ext.define('WMS.controller.MainFrame', {
    extend: 'Ext.app.Controller',
    models: ['VPTree'],
    stores: ['VPTreeMenu'],
    views: ['TreeFilter', 'Tree','UserInfo','ReflectedModuleWin'],
    requires: ['Ext.ux.IFrame'],
    refs: [{
        ref: 'wmsTree',
        selector: 'wmstree'
    }, {
        ref: 'userInfo',
        selector: 'userinfo',
        autoCreate: true,
        xtype: 'userinfo'
    }],
    init: function () {
        this.control({
            'viewport wmstree': {
                itemclick: this.NodeClick,
                render: this.TreeRender
            },
            'wmstoolbar #WmsCurrentUser': {
                click: function () {
                    //修改用户信息
                    userWin=this.getUserInfo();
                    userWin.show();
                    var mask = new Ext.LoadMask(userWin, { msg: '信息获取中，请稍后...' });
                    mask.show();
                    Ext.Ajax.request({
                        url: '/Admin/Main/GetCurUser',
                        method: 'GET',
                        success: function (response) {
                            mask.hide();
                            userWin.down("form").getForm().setValues(Ext.JSON.decode(response.responseText));
                        },
                        failure: function (response) {
                            mask.hide();
                            Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
                        }
                    });
                }
            },
            'userinfo button[action=saveUserInfo]': {
                click: function () {
                    //保存用户信息
                    userWin = this.getUserInfo();
                    uf = userWin.down("form").getForm();
                    if (!uf.isValid()) {
                        Ext.Tools.Msg("信息不完整，请检查！", 9);
                        return;
                    }
                    var mask = new Ext.LoadMask(userWin, { msg: '信息更新中，请稍后...' });
                    mask.show();
                    Ext.Ajax.request({
                        url: '/Admin/Main/UpdateCurUser',
                        method: 'POST',
                        params:uf.getValues(),
                        success: function (response) {
                            mask.hide();
                            rst = Ext.JSON.decode(response.responseText);
                            Ext.Tools.Msg(rst.msg, rst.result);
                            if (rst.result == 0) {//需要重新登陆
                                window.location.href = "/Login/LogOut";
                            }
                        },
                        failure: function (response) {
                            mask.hide();
                            Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
                        }
                    });
                }
            }
        });
    },
    TreeRender: function (p) {
        p.setLoading({
            store: p.getStore(),
            msg: '功能菜单加载中...'
        }).hide();
    },
    //恢复tab
    /*onLaunch: function () {
        tree = this.getWmsTree();
        tree.getStore().load({
            scope: this,
            callback: function (records, operation, success) {
                tree.getRootNode().expand();
                if (window.location.hash.indexOf("#") < 0) return;
                activeId = window.location.hash.substring(1, 37);
                activeNode = tree.getStore().getNodeById(activeId);
                if (activeNode) {
                    //打开当前节点
                    tree.expandPath(activeNode.getPath('id'), 'id');
                    tree.getSelectionModel().select(activeNode);
                    this.NodeClick("",activeNode);
                }
            }
        });
    },*/
    NodeClick: function (view, record) {
        if (record.data.leaf == true) {
            if (record.data.url == "") {
                Ext.Tools.Msg(record.data.text + '：链接为空，模块打开失败！', 9);
                return;
            }
            var main = Ext.getCmp("ViewPortCoreTab");
            var panel = Ext.getCmp("tab_" + record.data.id);
            if (!panel) {
                panel = main.add(new Ext.ux.IFrame({
                    xtype: 'iframepanel',
                    id: "tab_" + record.data.id,
                    title: record.data.text,
                    iconCls: record.data.iconCls,
                    closable: true,
                    layout: 'fit',
                    loadMask: '页面加载中...',
                    border: false
                }));

                /*
                panel = main.add({
                    //id: record.id,
                    //closable: true,
                    //title: record.data.text,
                    //iconCls: record.data.iconCls,
                    //autoScroll: true,
                    //border: false,
                    //layout: 'fit',
                    //autoLoad: {
                    //    showMask: true,
                    //    scripts: false,
                    //    mode: "iframe",
                    //    url: record.data.url
                    //}
                    //html: '<iframe src="' + record.data.url + '" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>'
                    //autoLoad: {
                    //    url: record.data.url,
                    //    scope: this,
                    //    scripts: true,
                    //    timeout: 9000,
                    //    text: '页面加载中，请稍候....'
                    //}
                });*/

                main.setActiveTab(panel);
                panel.load(record.data.url);
            } else {
                main.setActiveTab(panel);
            }
            window.location.hash = record.data.id;
        }
    }
});
