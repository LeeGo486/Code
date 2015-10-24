Ext.define('WMC.view.StudGridWin', {
    extend: 'Ext.window.Window',
    alias: 'widget.studgridwin',
    modal: true,
    width: 800,
    iconCls:'FolderUser',
    //closeAction: 'hide',
    items: [{
        xtype: 'grid',
        height: 400,
        border: false,
        store: 'HRCourseUser',
        columns: [
            {
                xtype: 'rownumberer'
            },
		    {
		        text: '员工姓名',
		        menuDisabled: true,
		        sortable: true,
		        dataIndex: 'UserName'
		    },
		    {
		        text: '员工工号',
		        menuDisabled: true,
		        sortable: true,
		        dataIndex: 'EmployeeID'
		    },
		    {
		        text: '报名时间',
		        menuDisabled: true,
                width:130,
		        sortable: true,
		        dataIndex: 'CreateTime'
		    }
        ],
        selModel: Ext.create('Ext.selection.CheckboxModel'),
        emptyText: '没有找到任何数据',
        dockedItems: [{
            xtype: 'pagingtoolbar',
            store: 'HRCourseUser',
            emptyMsg: '没有数据',
            dock: 'bottom',
            displayInfo: true,
            displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
            beforePageText: '第',
            afterPageText: '页/共{0}页'
        }]
    }]
});