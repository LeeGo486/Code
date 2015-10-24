Ext.define('WMC.view.resp.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.respmaingrid',
    store: 'WXRespImgTxt',
    region: 'center',
    border: false,
    columns: [
        {
            xtype: 'rownumberer'
        },
		{
		    text: '图片',
		    menuDisabled: true,
		    sortable: true,
            width:85,
            dataIndex: 'ImageUrl',
            renderer: function (value) {
                if (value != '' && value != null) {
                    return '<img src="/Content/Uploads/' + value + '" width="80px" height="80px" />';
                }
                else
                    return '';
            }
		},
		{
			text: '标题',
			menuDisabled: true,
			sortable: true,
			dataIndex: 'Title'
		}, {
		    text: '链接地址',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'AbsUrl'
		},
        {
            text: '访问量',
            menuDisabled: true,
            sortable: true,
            width:60,
            dataIndex: 'Hits'
        },
        {
            text: '赞',
            menuDisabled: true,
            sortable: true,
            width:40,
            dataIndex: 'Praise'
        },
		{
			text: '显示',
			menuDisabled: true,
			sortable: true,
            width:50,
			dataIndex: 'IsShow',
			renderer: function (value) {
			    if (value == 0)
			        return "<font color=Green>显示</font>";
			    else
			        return "<font color=Gray>隐藏</font>";
			}
		},
		{
			text: '头条',
			menuDisabled: true,
			sortable: true,
			width: 50,
			dataIndex: 'IsMain',
			renderer: function (value) {
			    if (value == 1)
			        return "<font color=Red>是</font>";
			    else
			        return "<font color=Gray>否</font>";
			}
		},
		{
		    text: '排序',
		    menuDisabled: true,
		    sortable: true,
		    width: 50,
		    dataIndex: 'OrderIndex'
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
        '->',
        {
            action: 'btnDelete',
            text: '删除',
            iconCls: 'Delete'
        }
    ]
});