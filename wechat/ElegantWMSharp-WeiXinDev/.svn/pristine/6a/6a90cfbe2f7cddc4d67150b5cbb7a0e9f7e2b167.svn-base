Ext.define('WMC.view.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.maingrid',
    requires: ['Ext.ux.grid.feature.Searching'],
    store: 'WXContacts',
    region: 'center',
    border: false,
    columns: [
        {
            xtype: 'rownumberer'
        },
		{
			text: 'fake_id',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'fake_id'
		},
		{
			text: '昵称',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'nick_name'
		},
		{
			text: '备注',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'remark_name',
			editor: {
				xtype: 'textfield',
				maxLength: 100,
				emptyText: '',
				allowBlank: true
			}
		},
		{
			text: '签名',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'signature'
		},
		{
			text: '城市',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'city',
			editor: {
				xtype: 'textfield',
				maxLength: 20,
				emptyText: '',
				allowBlank: true
			}
		},
		{
			text: '省份',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'province',
			editor: {
				xtype: 'textfield',
				maxLength: 20,
				emptyText: '',
				allowBlank: true
			}
		},
		{
			text: '国家',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'country',
			editor: {
				xtype: 'textfield',
				maxLength: 100,
				emptyText: '',
				allowBlank: true
			}
		},
		{
			text: '组别',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'groupName',
			editor: {
				xtype: 'textfield',
				maxLength: 20,
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
            xtype: 'combobox',
            name: 'cbAccount',
            store: 'Account',
            displayField: 'AccountName',
            valueField: 'Id',
            queryMode: 'local',
            editable: false,
            emptyText: '请选择微信账号',
            width: 190
        },
        '-',
        {
            action: 'btnSync',
            text: '同步联系人',
            iconCls: 'DatabaseCopy'
        }, {
            action: 'btnShowDetail',
            text: '显示详细',
            iconCls: 'PagePortraitShot'
        }, '-', , {
            action: 'btnSendMsg',
            text: '发送消息',
            iconCls: 'Comment'
        }, '->'
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
        store: 'WXContacts',
        emptyMsg: '没有数据',
        dock: 'bottom',
        displayInfo: true,
        displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
        beforePageText: '第',
        afterPageText: '页/共{0}页'
    }]
});