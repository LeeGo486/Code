/// <reference path="../../ext/ext-all-debug-w-comments.js" />
Ext.define("WMC.view.CourseForm", {
    extend: 'Ext.form.Panel',
    alias: 'widget.courseform',
    title: '课程信息',
    iconCls: 'BookOpen',
    xtype: 'form',
    labelAlign: 'right',
    bodyPadding: 10,
    height: 260,
    border: false,
    closeAction: 'hide',
    fieldDefaults: {
        labelAlign: 'right',
        labelWidth: 60,
        anchor: '100%'
    },
    items: [
        {
            layout: 'column',
            border: false,
            defaults: {
                border: false,
                layout: 'form'
            },
            items: [
                {
                    columnWidth: .5,
                    items: [
                        {
                            xtype: 'textfield',
                            allowBlank: false,
                            maxLength: 40,
                            emptyText: '',
                            value: '',
                            name: 'CourseName',
                            fieldLabel: '课程名称'
                        }]
                },
                {
                    columnWidth: .5,
                    items: [
                        {
                            xtype: 'combo',
                            allowBlank: false,
                            name: 'TeacherType',
                            fieldLabel: '讲师类型',
                            forceSelection: true,
                            editable: false,
                            valueField: 'Key',
                            displayField: 'Value',
                            typeAhead: true,
                            queryMode: 'local',
                            value: 0,
                            store: Ext.create('Ext.data.Store', {
                                fields: ['Key', 'Value'],
                                data: [{ "Key": 0, "Value": "内部讲师" }, { "Key": 1, "Value": "外部讲师" }]
                            })
                        }]
                }
            ]
        },
        {
            layout: 'column',
            border: false,
            defaults: {
                border: false,
                layout: 'form'
            },
            items: [
                {
                    columnWidth: .5,
                    items: [
                        {
                            xtype: 'textfield',
                            allowBlank: false,
                            maxLength: 40,
                            emptyText: '',
                            value: '',
                            name: 'OrgName',
                            fieldLabel: '组织机构'
                        }]
                },
                {
                    columnWidth: .5,
                    items: [
                        {
                            xtype: 'textfield',
                            allowBlank: false,
                            maxLength: 100,
                            emptyText: '',
                            value: '',
                            name: 'Venue',
                            fieldLabel: '上课地点'
                        }]
                }
            ]
        },
        {
            layout: 'column',
            border: false,
            defaults: {
                border: false,
                layout: 'form'
            },
            items: [
                {
                    columnWidth: .5,
                    items: [
                        {
                            xtype: 'numberfield',
                            allowBlank: false,
                            value: 0,
                            minValue: 0,
                            maxValue: 10000000000000,
                            emptyText: 0,
                            name: 'Fee',
                            fieldLabel: '费用预算'
                        }]
                },
                {
                    columnWidth: .5,
                    items: [
                        {
                            xtype: 'numberfield',
                            allowBlank: false,
                            value: 0,
                            minValue: 0,
                            maxValue: 500,
                            emptyText: 0,
                            name: 'TrainingNum',
                            fieldLabel: '参训人数'
                        }]
                }
            ]
        },
        {
            layout: 'column',
            border: false,
            defaults: {
                border: false,
                layout: 'form'
            },
            items: [
                {
                    columnWidth: .5,
                    items: [
                        {
                            id: 'dfcStart',
                            xtype: 'datefield',
                            allowBlank: false,
                            name: 'StartDate',
                            fieldLabel: '开始时间',
                            format: 'Y-m-d',
                            //开始时间不能小于今天
                            minValue: new Date(),
                            vtype: 'daterange',
                            endDateField: 'dfcEnd'
                            //符合alt格式的时间，会被强制转换为format格式
                            //altFormats: 'Y-m-d|m,d,Y|m.d.Y',
                            //submitFormat: 'Y-m-d',
                        }]
                },
                {
                    columnWidth: .5,
                    items: [
                        {
                            id: 'dfcEnd',
                            xtype: 'datefield',
                            allowBlank: false,
                            name: 'EndDate',
                            fieldLabel: '结束时间',
                            format: 'Y-m-d',
                            vtype: 'daterange',
                            minValue: new Date(),
                            startDateField: 'dfcStart'
                            //符合alt格式的时间，会被强制转换为format格式
                            //altFormats: 'Y-m-d|m,d,Y|m.d.Y',
                            //submitFormat: 'Y-m-d',
                        }]
                }
            ]
        },
        {
            layout: 'column',
            border: false,
            defaults: {
                border: false,
                layout: 'form'
            },
            items: [
                {
                    columnWidth: .5,
                    items: [
                        {
                            xtype: 'combo',
                            allowBlank: false,
                            name: 'SignUpType',
                            fieldLabel: '报名类型',
                            forceSelection: true,
                            editable: false,
                            valueField: 'Key',
                            displayField: 'Value',
                            typeAhead: true,
                            queryMode: 'local',
                            value: 0,
                            store: Ext.create('Ext.data.Store', {
                                fields: ['Key', 'Value'],
                                data: [{ "Key": 1, "Value": "需要报名" }, { "Key": 2, "Value": "不需要报名" }, { "Key": 3, "Value": "特定人员" }]
                            })
                        }]
                },
                {
                    columnWidth: .5,
                    items: [
                        {
                            xtype: 'textareafield',
                            allowBlank: true,
                            name: 'CourseDesc',
                            bodyPadding: 10,
                            grow: true,
                            fieldLabel: '课程简介'
                        }]
                }
            ]
        }
    ],
    dockedItems: [
        {
            xtype: 'toolbar',
            dock: 'bottom',
            items: ['->',
                 {
                     text: '人员导入',
                     iconCls: 'RecordRed',
                     action: 'btnExport'
                 },
                {
                    text: '取消',
                    iconCls: 'RecordRed',
                    handler: function () {
                        this.up('window').close();
                    }
                },
                {
                    text: '保存',
                    iconCls: 'Disk',
                    action: 'btnSave'
                }
            ]
        }
    ]
});