Ext.define('WMC.view.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.maingrid',
    requires: ['Ext.ux.grid.feature.Searching'],
    store: 'WXAccount',
    region: 'center',
    border: false,
    viewConfig:{  
        enableTextSelection:true  
    },
    columns: [
        {
            xtype: 'rownumberer'
            //, sortable: false
        },
        {
            text: 'GUID',
            menuDisabled: true,
            hidden:true,
            sortable: false,
            dataIndex: 'Id'
        },
		{
		    text: '账号名称',
		    menuDisabled: false,
		    sortable: true,
		    dataIndex: 'AccountName'
		},
        {
            text: '登录邮箱',
            menuDisabled: true,
            sortable: true,
            width:120,
            dataIndex: 'LoginEmail'
        },
        {
            text: '登录密码',
            menuDisabled: true,
            sortable: true,
            dataIndex: 'LoginPwd'
        },
		{
			text: '原始ID',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'OpenId'
		},
		{
			text: 'AppId',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'AppId'
		},
		{
			text: 'AppSecret',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'AppSecret'
		},
		{
		    text: '是否接入',
		    menuDisabled: true,
		    sortable: true,
            width:65,
		    dataIndex: 'IsAccessed',
		    renderer: function (value, meta) {
		        if (value == 1) {
		            meta.tdCls = 'BulletGet';
		        }
		        else {
		            meta.tdCls = 'BulletToggleMinus';
		        }
		        return '&nbsp;';
		    }
		},
		{
			text: '是否认证',
			menuDisabled: true,
			sortable: true,
			width: 65,
			dataIndex: 'IsAuthed',
			renderer: function (value, meta) {
			    if (value == 1) {
			        meta.tdCls = 'BulletGet';
			    }
			    else {
			        meta.tdCls = 'BulletToggleMinus';
			    }
			    return '&nbsp;';
			}
		},
		{
			text: 'Token',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'Token'
		},
		{
			text: '欢迎词',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'WelcomeWord'
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
			text: '修改人',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'ModifyUser'
		},
		{
			text: '修改时间',
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
        {
            action: 'btnMenu',
            text: '微信菜单',
            iconCls: 'Outline'
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
        }
    ],
    dockedItems: [{
            xtype: 'pagingtoolbar',
            store: 'WXAccount',
            emptyMsg: '没有数据',
            dock: 'bottom',
            displayInfo: true,
            displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
            beforePageText: '第',
            afterPageText: '页/共{0}页'
    }]
});