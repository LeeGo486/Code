Ext.define('WMC.view.MainGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.maingrid',
    requires: ['Ext.ux.grid.feature.Searching'],
    store: 'HRCourse',
    region: 'center',
    border: false,
    columns: [
        {
            xtype: 'rownumberer'
            //, sortable: false
        },

		{
		    text: '课程名称',
		    menuDisabled: true,
		    sortable: true,
		    width: 160,
		    dataIndex: 'CourseName'
		},
		{
		    text: '讲师类型',
		    menuDisabled: true,
		    sortable: true,
		    width: 60,
		    dataIndex: 'TeacherType',
		    renderer: function (value) {
		        if (value == 0)
		            return "内部讲师";
		        else
		            return "外部讲师";
		    }
		},
		{
		    text: '组织机构',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'OrgName'
		},

       {
           text: '报名类型',
           menuDisabled: true,
           sortable: true,
           width: 60,
           dataIndex: 'SignUpType',
           renderer: function (value) {
               if (value == 1)
                   return "需要报名";
               else if (value == 2) {
                   return "不需要报名";
               }
               else if (value == 3) {
                   return "特定人员";
               }

           }
       },
		{
		    text: '费用预算',
		    menuDisabled: true,
		    sortable: true,
		    width: 60,
		    dataIndex: 'Fee'
		},
		{
		    text: '参训人数',
		    menuDisabled: true,
		    sortable: true,
		    width: 60,
		    dataIndex: 'TrainingNum'
		}, {
		    text: '报名人数',
		    menuDisabled: true,
		    sortable: true,
		    width: 60,
		    dataIndex: 'RegisterNum',
		    renderer: function (value) {
		        return "<u style='color:red;cursor:pointer;'>(" + value + ")</u>";
		    }
		},
		{
		    text: '上课地点',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'Venue'
		},
		{
		    text: '开始时间',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'StartDate'
		},
		{
		    text: '结束时间',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'EndDate'
		},
		{
		    text: '课程简介',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'CourseDesc'
		},
		{
		    text: '是否显示',
		    menuDisabled: true,
		    sortable: true,
		    width: 60,
		    dataIndex: 'IsShow',
		    renderer: function (value) {
		        if (value == 0)
		            return '<font color=green>显示</font>';
		        else
		            return '<font color=gray>隐藏</font>';
		    }
		},
		{
		    text: 'CreateUser',
		    menuDisabled: true,
		    sortable: true,
		    hidden: true,
		    dataIndex: 'CreateUser'
		},
		{
		    text: 'CreateTime',
		    menuDisabled: true,
		    sortable: true,
		    hidden: true,
		    dataIndex: 'CreateTime'
		},
		{
		    text: 'ModifyUser',
		    menuDisabled: true,
		    sortable: true,
		    hidden: true,
		    dataIndex: 'ModifyUser'
		},
		{
		    text: 'ModifyTime',
		    menuDisabled: true,
		    sortable: true,
		    hidden: true,
		    dataIndex: 'ModifyTime'
		}
    ],
    selModel: Ext.create('Ext.selection.CheckboxModel'),
    emptyText: '没有找到任何数据',
    tbar: [
        {
            action: 'btnAdd',
            text: '新增',
            iconCls: 'Add'
        }, '-', {
            action: 'btnDisplay',
            text: '隐藏/显示',
            iconCls: 'RecordRed'
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
        store: 'HRCourse',
        emptyMsg: '没有数据',
        dock: 'bottom',
        displayInfo: true,
        displayMsg: '当前显示{0}-{1}条记录 / 共{2}条记录 ',
        beforePageText: '第',
        afterPageText: '页/共{0}页'
    }]
});