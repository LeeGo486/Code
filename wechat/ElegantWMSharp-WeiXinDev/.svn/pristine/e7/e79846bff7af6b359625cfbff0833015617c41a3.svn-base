Ext.define('WMC.view.industry.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.industrymaingrid',
    store: 'OO_Industry',
    region: 'center',
    border: false,
    columns: [
        {
            xtype: 'rownumberer'
            //, sortable: false
        },
		{
			text: '行业名称',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'IndustryName',
            width:150,
			editor: {
				xtype: 'textfield',
				maxLength: 200,
				emptyText: '',
				allowBlank: false
			}
		},
		{
			text: '排序',
			menuDisabled: true,
			sortable: true,
            width:70,
			dataIndex: 'OrderIndex',
			editor: {
				xtype: 'numberfield',
				maxLength: 4,
				emptyText: 0,
				allowBlank: false
			}
		}
    ],
    selModel: Ext.create('Ext.selection.CheckboxModel', { mode: 'SINGLE' }),
    emptyText: '没有找到任何数据',
    plugins: [
        {
            errorSummary: false,
            pluginId: 'rowEditor',
            xclass: 'Ext.grid.plugin.RowEditing',
            clicksToEdit: 2,
            clicksToMoveEditor: 1,
            autoCancel: false
        }
    ],
    tbar: [
        {
            action: 'btnAdd',
            text: '新增',
            iconCls: 'Add'
        },
        '-', {
            action: 'btnReflash',
            text: '刷新',
            iconCls: 'Reload'
        },
        '->',
        {
            action: 'btnDelete',
            text: '删除',
            iconCls: 'Delete'
        }
    ]
});