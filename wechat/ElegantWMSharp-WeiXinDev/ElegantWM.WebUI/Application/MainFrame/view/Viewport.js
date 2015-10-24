/// <reference path="../../Ext.js" />
//ToolBar
function ChooseTheme(menu, item) {
    if (item.checked) {
        var Css = extLibUrl + "ext/resources/css/";
        cssname = item.id.replace("Skin-", "").toLowerCase();
        Css += "ext-all" + (cssname == "default" ? "" : "-" + cssname) + ".css";
        //Ext.util.CSS.swapStyleSheet(null, Css);
        var exp = new Date();
        exp.setTime(exp.getTime() + 30 * 24 * 60 * 60 * 1000);
        Cookies.set("ThemeCss", Css, exp);
        Cookies.set("ThemeName", item.id, exp);
        window.location.reload();
    }
};
Ext.define('WMS.view.CfgMenu', {
    extend: 'Ext.menu.Menu',
    alias: 'widget.cfgmenu',
    id: 'CfgMenu',
    items: [
           {
               text: '图标集合',
               iconCls: 'ColorSwatch',
               listeners: {
                   click: function () {
                       Ext.create('Ext.window.Window', {
                           id: 'Wms_Icon_Win',
                           title: '图标集合',
                           height: 300,
                           width: 450,
                           html: '<iframe src="' + extLibUrl + 'COMMON/SRC/ICON.HTML" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>'
                       }).show();
                   }
               }
           },
           {
               text: '模块反射',
               iconCls: 'ApplicationViewTile',
               listeners: {
                   click: function () {
                       Ext.widget('reflectedmodulewin').show();
                   }
               }
           },
           '-', {
               text: '主题皮肤',
               iconCls: 'Paint',
               menu: {
                   items: [
                        {
                            id: 'Skin-Default',
                            text: 'Default',
                            checked: false,
                            group: 'theme'
                        }, '-', {
                            id: 'Skin-Neptune',
                            text: 'Neptune',
                            checked: false,
                            group: 'theme'
                        }, '-', {
                            id: 'Skin-Gray',
                            text: 'Gray',
                            checked: false,
                            group: 'theme'
                        }, '-', {
                            id: 'Skin-Access',
                            text: 'Access',
                            checked: false,
                            group: 'theme'
                        }
                   ],
                   listeners: {
                       click: ChooseTheme
                   }
               }
           }
    ]

});

Ext.define('WMS.view.Toolbar', {
    extend: 'Ext.toolbar.Toolbar',
    alias: 'widget.wmstoolbar',
    id: 'cj_wmctoolbar',
    region: 'north',
    border: 0,
    items: ['<b>Matrix 华之毅微信平台</b>',
        '->',
        {
            id: 'WmsCurrentUser',
            text: '...',
            iconCls: 'User'
        }, '-',
        {
            text: '首选项',
            iconCls: 'Cog',
            menu: { xtype: 'cfgmenu' }
        }, '-',
        {
            text: '安全退出',
            iconCls: 'ControlPowerBlue',
            tooltip: 'Completed Tasks',
            handler: function () {
                Ext.MessageBox.confirm('确认', '您确定要退出本系统吗？ 退出前请保存好您的重要信息！ ', function (result) {
                    if (result == 'yes') {
                        window.location = "/Login/Logout";
                    }
                });
            }
        }
    ],
    initComponent: function () {
        me = this;
        Ext.Ajax.request({
            url: '/Admin/Main/GetCurName',
            method: 'GET',
            success: function (response) {
                me.items.items[2].setText(response.responseText.replace(/"/g,''));
            },
            failure: function (response) {
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
        me.callParent(arguments);
    }
});

Ext.define("WMS.view.Main", {
    extend: 'Ext.tab.Panel',
    alias: 'widget.wmsmain',
    id: "ViewPortCoreTab",
    margins: '0 3 0 0',
    width: 400,
    height: 400,
    masked: {
        xtype: 'loadmask',
        message: '加载中...'
    },
    region: "center",
    items: [{
        iconCls: 'House',
        title: ' 桌 面 ',
        border: 0,
        autoLoad: {
            url: '/Content/Welcome.html',
            scope: this,
            scripts: true,
            text: '加载中,请稍候....'
        }
    }],
    plugins: Ext.create('Ext.ux.TabCloseMenu')
});

Ext.define('WMS.view.South', {
    extend: 'Ext.toolbar.Toolbar',
    alias: 'widget.wmssouthtoolbar',
    id:'cj_wmcstatusbar',
    region: 'south',
    border: 0,
    items: ['Powered by Extjs4.2 GPL', '->', "<a href='http://www.chinacloudtech.cn' target='_blank' style='color:#666;'>系统支持</a>"]
});

Ext.define('WMS.view.Viewport', {
    extend: 'Ext.container.Viewport',
    alias: 'widget.wmsviewport',
    layout: 'border',
    items: [
        {xtype: 'wmstoolbar'},
        {xtype: 'wmssouthtoolbar'},
        {xtype: 'wmstree'},
        {xtype: 'wmsmain'}
    ]
    //requires: ['WMS.view.Toolbar', 'WMS.view.Tree', 'WMS.view.Main', 'WMS.view.South'],
});