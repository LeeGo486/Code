Ext.define('WMC.view.menu.MainGrid', {
    extend: 'Ext.tree.Panel',
    alias: 'widget.menumaingrid',
    store: 'OO_MenuTemplate',
    region: 'center',
    useArrows: true,
    rootVisible: false,
    border: false,
    columns: [
		{
		    xtype: 'treecolumn',
		    width: 140,
			text: '菜单名称',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'Name',
			editor: {
				xtype: 'textfield',
				maxLength: 16,
				emptyText: '',
				allowBlank: true
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
            width: 280,
            dataIndex: 'KeyUrl',
            menuDisabled: true,
            editor: {
            }
        },
		{
			text: '排序',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'OrderIndex',
			editor: {
				xtype: 'textfield',
				maxLength: 4,
				emptyText: '',
				allowBlank: true
			}
		}
	],
    emptyText: '没有找到任何数据',
    plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
        clicksToEdit: 2
    })],
    tbar: [
        {
            action: 'btnReflashNode',
            iconCls: 'Reload'
        }, '-', {
            action: 'btnAddNode',
            text: '新增',
            iconCls: 'ChartOrgInverted'
        }, {
            action: 'btnSaveNode',
            text: '保存',
            iconCls: 'Disk'
        }
    ]
});