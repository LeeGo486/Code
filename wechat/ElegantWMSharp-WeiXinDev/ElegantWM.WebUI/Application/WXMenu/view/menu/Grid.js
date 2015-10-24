Ext.define('WMC.view.menu.Grid', {
    extend: 'Ext.tree.Panel',
    alias: 'widget.menugrid',
    useArrows: true,
    rootVisible: false,
    store: 'WXMenu',
    tbar: [{
        xtype: 'combobox',
        name:'cbAccount',
        store: 'Account',
        displayField: 'AccountName',
        valueField: 'Id',
        queryMode: 'local',
        editable: false,
        emptyText: '请选择微信账号',
        width: 140
    }, '->', {
        action: 'btnReflashNode',
        iconCls: 'Reload'
    }, '-', {
        action: 'btnTemplate',
        text: '行业模板',
        iconCls: 'PageWhiteConnect'
    },'-', {
        action: 'btnAddNode',
        text: '新增',
        iconCls: 'SitemapColor'
    }, {
        action: 'btnSaveNode',
        text: '保存',
        iconCls: 'Disk'
    }, '-', {
        action: 'btnUploadNode',
        text: '上传',
        tooltip:'将菜单上传到微信服务器',
        iconCls: 'ArrowUp'
    }, {
        action: 'btnDelWxMenu',
        text: '删除',
        tooltip: '移除微信菜单',
        iconCls: 'Cross'
    }],
    columns: [
        {
            xtype: 'treecolumn',
            text: '菜单名称',
            width: 110,
            menuDisabled: true,
            sortable: false,
            dataIndex: 'Name',
            editor: {
                xtype: 'textfield',
                maxLength: 10,
                allowBlank: false
            }
        },
        {
            text: '编辑',
            width: 40,
            menuDisabled: true,
            xtype: 'actioncolumn',
            align: 'center',
            items: [{
                iconCls: 'BulletPlus',
                tooltip: '新增子节点',
                //如果是button或者是action不允许再创建子节点
                isDisabled: function (view, rowIdx, colIdx, item, record) {
                    return !(record.data.Type != "view" && record.data.Type != "click");
                }
            }, {
                iconCls: 'BulletMinus',
                tooltip: '删除该节点'
            }]
        }, {
            text: '类型',
            width: 50,
            dataIndex: 'Type',
            menuDisabled: true,
            editor: {
                xtype: 'combo',
                allowBlank: true,
                forceSelection: true,
                editable: false,
                valueField: 'Key',
                displayField: 'Value',
                typeAhead: true,
                queryMode: 'local',
                store: Ext.create('Ext.data.Store', {
                    fields: ['Key', 'Value'],
                    data: [{ "Key": "", "Value": "根" }, { "Key": "click", "Value": "click" }, { "Key": "view", "Value": "view" }]
                })
            }
        }, {
            text: '响应类型',
            width: 60,
            dataIndex: 'RespType',
            menuDisabled: true,
            editor: {
                xtype: 'combo',
                allowBlank: true,
                forceSelection: true,
                editable: false,
                valueField: 'Key',
                displayField: 'Value',
                typeAhead: true,
                queryMode: 'local',
                store: Ext.create('Ext.data.Store', {
                    fields: ['Key', 'Value'],
                    data: [{ "Key": "", "Value": "无" }, { "Key": "text", "Value": "文本" }, { "Key": "news", "Value": "图文" }, { "Key": "svrtext", "Value": "服务文本" }, { "Key": "svrnews", "Value": "服务图文" }]
                })
            }
        }, {
            text: 'KeyOrUrl',
            width: 180,
            dataIndex: 'KeyUrl',
            menuDisabled: true,
            editor: {
            }
        }, {
            text: '排序',
            width: 60,
            dataIndex: 'OrderIndex',
            sortable: true,
            editor: {
                xtype: 'numberfield',
                value: 0,
                minValue: 0,
                emptyText: 0,
                allowBlank: false
            }
        }],
    emptyText: '没有找到任何数据',
    plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
        clicksToEdit: 2
    })]
});