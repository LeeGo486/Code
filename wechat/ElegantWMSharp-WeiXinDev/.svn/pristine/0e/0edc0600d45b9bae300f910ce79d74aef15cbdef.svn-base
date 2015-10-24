Ext.define('WMC.view.SeekerWinGrid', {
    extend: 'Ext.window.Window',
    alias: 'widget.seekerwingrid',
    requires: ['Ext.ux.grid.feature.Searching'],
    modal: true,
    width: 800,
    iconCls:'FolderUser',
    //closeAction: 'hide',
    items: [{
        xtype: 'grid',
        height: 400,
        border: false,
        store: 'HRJobSeeker',
        columns: [
            {
                xtype: 'rownumberer'
            },
		    {
		        text: '姓名',
		        menuDisabled: true,
		        sortable: true,
                width:100,
		        dataIndex: 'SkrName'
		    },
		    {
		        text: '性别',
		        menuDisabled: true,
		        sortable: true,
		        width: 50,
		        dataIndex: 'SkrSex'
		    }, {
		        text: '推荐人',
		        menuDisabled: true,
		        sortable: true,
		        width: 80,
		        dataIndex: 'EmployeeId'
		    },
		    {
		        text: '联系电话',
		        menuDisabled: true,
		        sortable: true,
		        width: 100,
		        dataIndex: 'Telphone'
		    },
		    {
		        text: '申请理由',
		        menuDisabled: true,
		        sortable: true,
		        width: 200,
		        dataIndex: 'Remark'
		    },
		    {
		        text: '申请时间',
		        menuDisabled: true,
		        sortable: true,
		        width: 140,
		        dataIndex: 'CreateTime'
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
        tbar: ['->',
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
                checkIndexes: ['SkrName'],			//默认是否选择所有的列
                disableIndexes: ['CreateTime']          //那些列需要参与查询
            }
        ],
        dockedItems: [{
            xtype: 'pagingtoolbar',
            store: 'HRJobSeeker',
            emptyMsg: '没有数据',
            dock: 'bottom',
            displayInfo: true,
            displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
            beforePageText: '第',
            afterPageText: '页/共{0}页'
        }]
    }]
});