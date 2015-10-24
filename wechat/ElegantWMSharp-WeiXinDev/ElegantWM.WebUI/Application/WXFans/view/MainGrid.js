Ext.define('WMC.view.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.maingrid',
    requires: ['Ext.ux.grid.feature.Searching'],
    store: 'WXFans',
    region: 'center',
    border: false,
    viewConfig: {
        enableTextSelection: true
    },
    columns: [
        {
            xtype: 'rownumberer'
            //, sortable: false
        }, 
		{
		    text: '头像',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'Avatar',
            width:50,
		    renderer: function (value) {
		        if (value != null && value!='') 
		            return "<img src='" + value + "' width='40'/>";
		        else
		            return '';
		    }
		},
		{
			text: '公众账号ID',
			menuDisabled: true,
			sortable: true,
            hidden: true,
			dataIndex: 'AccountId'
		},
		{
			text: 'OpenId',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'OpenId'
		},
		{
			text: '昵称',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'NickName'
		},
		{
			text: '性别',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'Sex'
		},
		{
			text: '城市',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'City'
		},
		{
			text: '省份',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'Province'
		},
		{
			text: '国家',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'Country'
		},
		{
			text: '创建人',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'CreateUser'
		},
		{
			text: '创建时间',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'CreateTime'
		},
		{
			text: '更新人',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'ModifyUser'
		},
		{
			text: '更新时间',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'ModifyTime'
		}
	],
    selModel: Ext.create('Ext.selection.CheckboxModel'),
    emptyText: '没有找到任何数据',
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
        }, '->'
        //{
        //    action: 'btnAdd',
        //    text: '新增',
        //    iconCls: 'Add'
        //},
        //'->',
        //{
        //    action: 'btnDelete',
        //    text: '删除',
        //    iconCls: 'Delete'
        //}
    ],
    features: [
        {
            ftype: 'searching',
            minChars: 2,
            width: 150,
            mode: 'remote',
            showSelectAll: true,   		//是否显示全选按钮
            checkIndexes: [],			//默认是否选择所有的列
            disableIndexes: ['CreateTime','CreateUser','ModifyUser','ModifyTime']          //那些列需要参与查询
        }
    ],
    dockedItems: [{
        xtype: 'pagingtoolbar',
        store: 'WXFans',
        emptyMsg: '没有数据',
        dock: 'bottom',
        displayInfo: true,
        displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
        beforePageText: '第',
        afterPageText: '页/共{0}页'
    }]
});