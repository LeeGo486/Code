Ext.define('WMC.view.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.maingrid',
    requires: ['Ext.ux.grid.feature.Searching'],
    store: 'WX_QR_Code',
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
		    text: '微信号',
		    menuDisabled: true,
		    sortable: true,
		    hidden: true,
		    dataIndex: 'AccountId'
		},
		{
		    text: '二维码URL',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'Url',
		    renderer: function (value) {
		        if (value != null && value != '')
		            return "<a href='" + value + "' target='_blank'><img src='" + value + "' width='60'/></a>";
		        else
		            return '';
		    }
		},
		{
		    text: '二维码类型',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'Action_Name'
		},
		{
		    text: '场景号',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'Scene_ID'
		},
		{
		    text: '场景介绍',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'Scene_Name'
		},
		{
		    text: '场景事件',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'Scene_Key'
		},
		{
		    text: '场景参数1',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'Scene_Param1'
		},
		{
		    text: '场景参数2',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'Scene_Param2'
		},
		{
		    text: '是否使用',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'IsUsed'
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
        }, '->',
        {
            action: 'btnAdd',
            text: '新增',
            iconCls: 'Add'
        },
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
        store: 'WX_QR_Code',
        emptyMsg: '没有数据',
        dock: 'bottom',
        displayInfo: true,
        displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
        beforePageText: '第',
        afterPageText: '页/共{0}页'
    }]
});