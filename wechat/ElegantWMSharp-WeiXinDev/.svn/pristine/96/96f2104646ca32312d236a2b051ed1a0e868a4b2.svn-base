Ext.define('WMS.view.ReflectedModuleWin', {
    extend: 'Ext.window.Window',
    alias: 'widget.reflectedmodulewin',
    title: '反射Controller',
    modal: true,
    width: 700,
    requires: ['Ext.ux.grid.feature.Searching'],
    iconCls: 'BulletLightning',
    closeAction: 'hide',
    items: [{
        xtype: 'grid',
        height: 300,
        store: Ext.create('Ext.data.Store', {
            fields: ['Id', 'ModuleName', 'ModuleUrl',
            'ModuleKey', 'ModuleController', 'ModuleAction', 'ModuleMethod',
            'ModuleParam', 'ModuleIndex', 'ModuleDesc', 'ModuleType', 'ModuleIcon', 'SysId'],
            autoLoad: false,
            autoSync: false,
            groupField: 'ModuleController',
            proxy: {
                type: 'ajax',
                url: '/Admin/Main/GetRefModules',
                reader: {
                    type: 'json'
                },
                listeners: {
                    exception: function (proxy, response, operation, eOpts) {
                        rst = Ext.JSON.decode(response.responseText);
                        Ext.Tools.Msg(rst.msg, rst.result);
                    }
                }
            },
            sorters: [{
                property: 'ModuleController',
                direction: 'ASC'
            }]
        }),
        border: 0,
        columns: [
            {
                xtype: 'rownumberer',
                width: 30,
                sortable: false
            },
            {
                text: 'ID',
                hidden: true,
                menuDisabled: true,
                dataIndex: 'Id'
            }, {
                text: '功能节点',
                width: 160,
                dataIndex: 'ModuleName'
            }, {
                text: '类型',
                width: 50,
                dataIndex: 'ModuleType'
            }, {
                text: 'URL',
                dataIndex: 'ModuleUrl',
                flex: 1
            }, {
                text: 'Controller',
                dataIndex: 'ModuleController'
            }, {
                text: 'Action',
                dataIndex: 'ModuleAction'
            }, {
                text: 'Method',
                dataIndex: 'ModuleMethod',
                width: 60
            }, {
                text: 'Params',
                dataIndex: 'ModuleParam',
                width: 60
            }],
        selModel: Ext.create('Ext.selection.CheckboxModel'),
        emptyText: '没有找到任何数据',
        features: [{
            ftype: 'grouping',
            groupByText: '该列分组',
            showGroupsText: '显示分组',
            hideGroupedHeader: true,
            groupHeaderTpl: 'Controller: {name} ({rows.length} Item{[values.rows.length > 1 ? "s" : ""]})'
        }, {
            ftype: 'searching',
            minChars: 2,
            width: 150,
            mode: 'local',
            showSelectAll: true          //那些列需要参与查询
        }],
        tbar: [{
            name: 'assmblyName',
            xtype: 'textfield',
            emptyText: '程序集名称',
            value: 'ElegantWM.WebUI'
        }, {
            name: 'urlPrefix',
            xtype: 'textfield',
            emptyText: 'url前缀',
            value: '/Admin/'
        }, {
            action: 'btnLoadModules',
            text: '加载',
            iconCls: 'Reload',
            handler: function () {
                assm = this.up("grid").down("textfield[name=assmblyName]").getValue();
                upx = this.up("grid").down("textfield[name=urlPrefix]").getValue();
                store = this.up("grid").getStore();
                store.getProxy().setExtraParam("assmblyName", assm);
                store.getProxy().setExtraParam("urlPrefix", upx);
                store.load();
            }
        }, '->']
    }],
    buttons: [{
        text: '取消',
        handler: function () {
            this.up('window').close();
        }
    },
    {
        text: '同步',
        iconCls: 'ServerGo',
        action: 'addReflectedMToM',
        handler: function () {
            //修改用户信息
            var mask = new Ext.LoadMask(this.up("window"), { msg: '正在同步到WMC系统...' });
            mask.show();
            Ext.Ajax.request({
                url: '/Admin/Main/SynRefModule',
                method: 'POST',
                success: function (response) {
                    mask.hide();
                    rst = Ext.JSON.decode(response.responseText);
                    Ext.Tools.Msg(rst.msg, rst.result);
                },
                failure: function (response) {
                    mask.hide();
                    Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
                }
            });
        }
    }]
});