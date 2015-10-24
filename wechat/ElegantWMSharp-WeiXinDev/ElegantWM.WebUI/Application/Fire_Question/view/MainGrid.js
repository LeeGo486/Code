Ext.define('WMC.view.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.maingrid',
    requires: ['Ext.ux.grid.feature.Searching'],
    store: 'Fire_Question',
    region: 'center',
    border: false,
    columns: [
        {
            xtype: 'rownumberer'
            //, sortable: false
        },
		
		{
			text: 'Question',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'Question',
			editor: {
				xtype: 'textfield',
				maxLength: 100,
				emptyText: '',
				allowBlank: false
			}
		},
		{
			text: 'QImage',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'QImage',
			editor: {
				xtype: 'textfield',
				maxLength: 100,
				emptyText: '',
				allowBlank: true
			}
		},
		{
			text: 'TntId',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'TntId',
			editor: {
				xtype: 'textfield',
				maxLength: 16,
				emptyText: '',
				allowBlank: false
			}
		},
		{
			text: 'CreateUser',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'CreateUser'
		},
		{
			text: 'CreateTime',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'CreateTime'
		},
		{
			text: 'ModifyUser',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'ModifyUser'
		},
		{
			text: 'ModifyTime',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'ModifyTime'
		}
	],
    selModel: Ext.create('Ext.selection.CheckboxModel'),
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
        '->',
        {
            action: 'btnDelete',
            text: '删除',
            iconCls: 'Delete'
        }
    ],
    features: [
        {
            ftype: 'searching',
            minChars: 2,
            width: 150,
            mode: 'remote',
            showSelectAll: true,   		//是否显示全选按钮
            checkIndexes: [],			//默认是否选择所有的列
            disableIndexes: []          //那些列需要参与查询
        }
    ],
    dockedItems: [{
        xtype: 'pagingtoolbar',
        store: 'Fire_Question',
        emptyMsg: '没有数据',
        dock: 'bottom',
        displayInfo: true,
        displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
        beforePageText: '第',
        afterPageText: '页/共{0}页'
    }]
});