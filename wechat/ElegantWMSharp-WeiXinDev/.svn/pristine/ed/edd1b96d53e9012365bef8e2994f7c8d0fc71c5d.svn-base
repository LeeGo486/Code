Ext.define('WMC.view.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.maingrid',
    store: 'WXKeyWord',
    region: 'center',
    border: false,
    columns: [
        {
            xtype: 'rownumberer'
            //, sortable: false
        },
		{
			text: '关键词',
			menuDisabled: true,
			sortable: true,
			width: 180,
			dataIndex: 'KwList'
		},
        {
            text: '响应类型',
            menuDisabled: true,
            sortable: true,
            width: 60,
            dataIndex: 'RespType',
            renderer: function (value) {
                if (value == "text")
                    return "文本";
                else if (value == "news") {
                    return "图文";
                } else if (value == "svrtext") {
                    return "服务文本";
                } else if (value == "svrnews") {
                    return "服务图文";
                }
            }
        },
		{
			text: '是否使用',
			menuDisabled: true,
			sortable: true,
            width:60,
			dataIndex: 'IsUsing',
			renderer: function (value) {
			    if (value == 0)
			        return "<font color=Green>使用</font>";
			    else {
			        return "<font color=Gray>停用</font>";
			    }
			}
		}
    ],
    selModel: Ext.create('Ext.selection.CheckboxModel'),
    emptyText: '没有找到任何数据',
    tbar: [{
        xtype: 'combobox',
        name: 'cbAccount',
        store: 'Account',
        displayField: 'AccountName',
        valueField: 'Id',
        queryMode: 'local',
        editable: false,
        emptyText: '请选择微信账号',
        width: 140
    }, '->',
        {
            action:'btnAdd',
            text: '新增',
            iconCls: 'Add'
        },
        '-',
        {
            action: 'btnDelete',
            text: '删除',
            iconCls: 'Delete'
        }
    ]
});