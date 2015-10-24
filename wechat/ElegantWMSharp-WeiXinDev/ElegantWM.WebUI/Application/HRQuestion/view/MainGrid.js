Ext.define('WMC.view.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.maingrid',
    requires: ['Ext.ux.grid.feature.Searching', 'Ext.grid.feature.Grouping'],
    store: 'HRQuestion',
    region: 'center',
    border: false,
    columns: [
        {
            xtype: 'rownumberer'
            //, sortable: false
        },

		{
		    text: '类别',
		    sortable: true,
		    dataIndex: 'QsnCategory'
		},
		{
			text: '问题',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'QsnName'
		},
		{
			text: '类型',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'QsnType'
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
    tbar:[
        {
            action:'btnAdd',
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
            showSelectAll: true,      //是否显示全选按钮
            checkIndexes: [],       //默认是否选择所有的列
            disableIndexes: []      //那些列需要参与查询
        },
        {
            ftype: 'grouping',
            groupHeaderTpl: '{columnName}: {name} ({rows.length} Item{[values.rows.length > 1 ? "s" : ""]})',
            hideGroupedHeader: false,
            startCollapsed: false
        }
    ],
    dockedItems: [{
            xtype: 'pagingtoolbar',
            store: 'HRQuestion',
            emptyMsg: '没有数据',
            dock: 'bottom',
            displayInfo: true,
            displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
            beforePageText: '第',
            afterPageText: '页/共{0}页'
    }]
});