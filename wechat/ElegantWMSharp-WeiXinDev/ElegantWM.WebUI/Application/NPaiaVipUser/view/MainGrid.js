Ext.define('WMC.view.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.maingrid',
    requires: ['Ext.ux.grid.feature.Searching'],
    store: 'NPaiaVipUser',
    region: 'center',
    border: false,
    columns: [
        {
            xtype: 'rownumberer'
            //, sortable: false
        },
		
		{
			text: 'VIPID',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'VipId',
			editor: {
				xtype: 'textfield',
				maxLength: 4,
				emptyText: '',
				allowBlank: false
			}
		},
		{
			text: 'vip名称',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'VipName',
			editor: {
				xtype: 'textfield',
				maxLength: 20,
				emptyText: '',
				allowBlank: false
			}
		},
		{
			text: 'vip性别',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'VipSex',
			editor: {
				xtype: 'textfield',
				maxLength: 4,
				emptyText: '',
				allowBlank: true
			}
		},
		{
			text: 'Vip手机',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'Viptel',
			editor: {
				xtype: 'textfield',
				maxLength: 20,
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
		},
		{
			text: '是否同步到DRP',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'ESBState',
			editor: {
				xtype: 'textfield',
				maxLength: 4,
				emptyText: '',
				allowBlank: true
			}
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
        store: 'NPaiaVipUser',
        emptyMsg: '没有数据',
        dock: 'bottom',
        displayInfo: true,
        displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
        beforePageText: '第',
        afterPageText: '页/共{0}页'
    }]
});