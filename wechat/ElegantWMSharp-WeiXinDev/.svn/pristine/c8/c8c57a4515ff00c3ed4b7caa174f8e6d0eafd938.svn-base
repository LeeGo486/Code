Ext.define('WMC.view.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.maingrid',
    requires: ['Ext.ux.grid.feature.Searching'],
    store: 'ITSMEvent',
    region: 'center',
    border: false,
    columns: [
        {
            xtype: 'rownumberer'
        },
		{
		    text: '单号',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'Code'
		},
		{
		    text: '提报人',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'ReqMan'
		},
		{
		    text: '提报公司',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'ReqCom'
		},
		{
		    text: '提报部门',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'ReqDept'
		},
		{
		    text: '提报人手机',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'ReqManPhone'
		},
		{
		    text: '提报地点',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'ReqIncident'
		},
		{
		    text: '工程师',
		    menuDisabled: true,
		    sortable: true,
            width:60,
		    dataIndex: 'Engineer'
		},
		{
		    text: '工程师手机',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'EngineerPhone'
		},
		{
		    text: '状态',
		    menuDisabled: true,
		    sortable: true,
            width:60,
		    dataIndex: 'ProcessStatus',
		    renderer: function (value) {
		        if (value == 0)
		            return "<font color='Red'>提报中</font>";
		        else if (value == 1)
		            return "<font color='Blue'>已派工</font>";
		        if (value == 2)
		            return "<font color='Green'>已接受</font>";
		        if (value == 3)
		            return "<font color='Green'>处理中</font>";
		        if (value == 4)
		            return "<font color='Green'>待评价</font>";
		        if (value == 9)
		            return "<font color='Gray'>已取消</font>";
		        if (value == 5)
		            return "已完结";
		        else
		            return value;
		    }
		},
		{
		    text: '事件描述',
		    menuDisabled: true,
		    sortable: true,
		    width: 250,
		    dataIndex: 'EventDesc',
		    editor: {
		        readOnly: true,
		        xtype: 'textareafield'
		    }
		}, {
		    text: '图片附件',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'FileUrl',
		    renderer: function (value) {
		        if (value != null && value != '')
		            return '<a href="/Content/Uploads/Event/' + value + '" target="_blank">点击查看</a>';
		        else
		            return '';
		    }
		},
        {
            text: '解决方案',
            menuDisabled: true,
            sortable: true,
            width: 250,
            dataIndex: 'EventSolution',
            editor: {
                readOnly: true,
                xtype: 'textareafield'
            }
        },
		{
		    text: '设备类型',
		    menuDisabled: true,
		    sortable: true,
            width:100,
		    dataIndex: 'EventEquipment'
		},
		{
		    text: '应用类型',
		    menuDisabled: true,
		    sortable: true,
            width:80,
		    dataIndex: 'EventApp'
		},
		{
		    text: '及时率',
		    menuDisabled: true,
		    sortable: true,
            width:60,
		    dataIndex: 'ElvTime'
		},
		{
		    text: '服务态度',
		    menuDisabled: true,
		    sortable: true,
		    width: 60,
		    dataIndex: 'ElvAtude'
		},
		{
		    text: '服务结果',
		    menuDisabled: true,
		    sortable: true,
		    width: 60,
		    dataIndex: 'ElvRst'
		},
		{
		    text: '评价',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'ElvDesc'
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
		    width: 130,
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
		    width: 130,
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
        }, '-', {
            action: 'btnAss',
            text: '派工',
            iconCls: 'Wrench-Screwdriver'
        },
        '->',
        {
            action: 'btnAutoReflash',
            text: '自动刷新（已开启）',
            iconCls: 'RecordGreen'
        },
        '-',
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
            store: 'ITSMEvent',
            emptyMsg: '没有数据',
            dock: 'bottom',
            displayInfo: true,
            displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
            beforePageText: '第',
            afterPageText: '页/共{0}页'
    }]
});