Ext.define('WMC.view.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.maingrid',
    requires: ['Ext.ux.grid.feature.Searching'],
    store: 'Jobs',
    region: 'center',
    border: false,
    columns: [
        {
            xtype: 'rownumberer'
            //, sortable: false
        },		
		{
			text: '职位名称',
			menuDisabled: true,
			sortable: true,
            width:250,
			dataIndex: 'JobName'
		},
		{
			text: '招聘人数',
			menuDisabled: true,
			sortable: true,
			width: 70,
			dataIndex: 'NeedNum'
		},
        {
            text: '应聘人数',
            menuDisabled: true,
            sortable: true,
            width: 70,
            dataIndex: 'JobSeekers',
            renderer: function (value) {
                return "<u style='color:red;cursor:pointer;'>(" + value + ")</u>";
            }
        },
		{
		    text: '置顶',
		    menuDisabled: true,
		    sortable: true,
		    width: 50,
		    dataIndex: 'IsTop',
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
			text: '显隐',
			menuDisabled: true,
			sortable: false,
			width: 50,
			dataIndex: 'IsShow',
			renderer: function (value,meta) {
			    if (value==0) {
			        meta.tdCls = 'BulletGreen';
			    }
			    else {
			        meta.tdCls = 'BulletStopAlt';
			    }
			    return '&nbsp;';
			}
		},
		{
			text: '创建人',
			menuDisabled: true,
			sortable: false,
			width: 60,
			dataIndex: 'CreateUser'
		},
		{
			text: '创建时间',
			menuDisabled: true,
			sortable: false,
			width: 140,
			dataIndex: 'CreateTime'
		},
		{
			text: '修改人',
			menuDisabled: true,
			sortable: false,
			width: 60,
			dataIndex: 'ModifyUser'
		},
		{
			text: '修改时间',
			menuDisabled: true,
			sortable: false,
			width: 140,
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
            checkIndexes: ['JobName'],       //默认是否选择所有的列
            disableIndexes: ['IsShow','IsTop','NeedNum','CreateTime','ModifyTime']      //那些列需要参与查询
        }
    ],
    dockedItems: [{
            xtype: 'pagingtoolbar',
            store: 'Jobs',
            emptyMsg: '没有数据',
            dock: 'bottom',
            displayInfo: true,
            displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
            beforePageText: '第',
            afterPageText: '页/共{0}页'
    }]
});