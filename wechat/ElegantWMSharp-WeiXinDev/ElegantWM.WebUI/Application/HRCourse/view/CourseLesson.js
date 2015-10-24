Ext.define('WMC.view.CourseLesson', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.courselesson',
    requires: ['Ext.ux.picker.DateTime', 'Ext.ux.form.field.DateTime'],
    store: "HRCourseLesson",
    region: 'center',
    border: false,
    title: '课时',
    iconCls: 'ClockRed',
    height: 260,
    CourseId: '',
    columns: [
        {
            xtype: 'rownumberer'
            //, sortable: false
        },
		{
		    text: '课程ID',
		    menuDisabled: true,
		    sortable: true,
		    dataIndex: 'Cid',
		    hidden: true
		},
		{
		    text: '课时名称',
		    menuDisabled: true,
		    sortable: true,
		    width: 80,
		    dataIndex: 'LessonName',
		    editor: {
		        xtype: 'textfield',
		        maxLength: 50,
		        emptyText: '',
		        minValue: new Date(),
		        allowBlank: false
		    }
		},
        {
            text: '老师名称',
            menuDisabled: true,
            sortable: true,
            width: 80,
            dataIndex: 'Teacher',
            editor: {
                xtype: 'textfield',
                maxLength: 50,
                emptyText: '',
                minValue: new Date(),
                allowBlank: false
            }
        },
        {
            text: '课程积分',
            menuDisabled: true,
            sortable: true,
            width: 80,
            dataIndex: 'Integration',
            editor: {
                xtype: 'textfield',
                maxLength: 50,
                emptyText: '',
                minValue: new Date(),
                allowBlank: false
            }
        },
        {
            text: '课时',
            menuDisabled: true,
            sortable: true,
            width: 80,
            dataIndex: 'ClassHour',
            editor: {
                xtype: 'textfield',
                maxLength: 50,
                emptyText: '',
                minValue: new Date(),
                allowBlank: false
            }
        },
        {
            text: '满意度问卷模版',
            menuDisabled: true,
            sortable: true,
            width: 100,
            dataIndex: 'SatisfactionType',
            editor: {
                xtype: 'textfield',
                maxLength: 10,
                emptyText: '',
                minValue: new Date(),
                allowBlank: false
            }
        },
		{
		    text: '上课时间',
		    menuDisabled: true,
		    sortable: true,
		    width: 100,
		    dataIndex: 'StartTime',
		    editor: {
		        xtype: 'datetimefield',
		        format: 'Y-m-d H:i',
		        minValue: new Date(),
		        allowBlank: false
		        //,
		        //id: 'gcstart',
		        //endDateField: 'gcend',
		        //vtype: 'daterange'
		    }
		},
		{
		    text: '下课时间',
		    menuDisabled: true,
		    sortable: true,
		    width: 100,
		    dataIndex: 'EndTime',
		    editor: {
		        xtype: 'datetimefield',
		        format: 'Y-m-d H:i',
		        minValue: new Date(),
		        allowBlank: false
		        //,
		        //id: 'gcend',
		        //startDateField: 'gcstart',
		        //vtype: 'daterange'
		    }
		},
        {
            xtype: 'actioncolumn',
            width: 50,
            text: '二维码',
            sortable: false,
            menuDisabled: true,
            items: [{
                iconCls: 'QRCodeBar',
                tooltip: '生成二维码',
                scope: this
            }, {
                iconCls: 'StatusAway',
                tooltip: '签到情况',
                scope: this
            }]
        },
        {
            text: '签到人数',
            menuDisabled: true,
            sortable: true,
            width: 80,
            dataIndex: 'Num'
            //editor: {
            //    //xtype: 'textfield',
            //    //maxLength: 50,
            //    //emptyText: '',
            //    //minValue: new Date(),
            //    //allowBlank: false
            //}
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
    tbar: [
        {
            action: 'btnAddLesson',
            text: '新增',
            iconCls: 'Add'
        },
        '->',
        {
            action: 'btnDeleteLesson',
            text: '删除',
            iconCls: 'Delete'
        }
    ]
});