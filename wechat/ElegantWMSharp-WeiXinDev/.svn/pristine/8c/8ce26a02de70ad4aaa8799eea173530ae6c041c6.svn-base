Ext.define('WMC.view.SignRstGridWin', {
    extend: 'Ext.window.Window',
    alias: 'widget.signrstgridwin',
    title: '签到记录',
    modal: true,
    width: 800,
    iconCls: 'StatusAway',
    //closeAction: 'hide',
    items: [{
        xtype: 'grid',
        height: 400,
        border: false,
        store: 'HRSignRst',
        columns: [
            {
                xtype: 'rownumberer'
            },
		    {
		        text: '姓名',
		        menuDisabled: true,
		        sortable: true,
		        dataIndex: 'UserName'
		    },
		    {
		        text: '签到时间',
		        menuDisabled: true,
                width:130,
		        sortable: true,
		        dataIndex: 'CreateTime'
		    },
		    {
		        text: '结果',
		        menuDisabled: true,
		        sortable: true,
		        dataIndex: 'SignRst',
		        editor: {
		            xtype: 'combo',
		            allowBlank: false,
		            editable: false,
		            valueField: 'Value',
		            displayField: 'Value',
		            typeAhead: true,
		            queryMode: 'local',
		            value: 0,
		            store: Ext.create('Ext.data.ArrayStore', {
		                fields: ['Value'],
		                data: [['正常'], ['迟到'], ['早退'], ['缺勤'], ['请假'], ['其他']]
		            })
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
        ]
    }]
});