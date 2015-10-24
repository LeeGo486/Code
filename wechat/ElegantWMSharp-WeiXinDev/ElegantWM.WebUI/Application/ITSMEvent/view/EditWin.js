/// <reference path="../../ext/ext-all-debug-w-comments.js" />
Ext.define("WMC.view.EditWin", {
    extend: 'Ext.window.Window',
    alias: 'widget.editwin',
    title: '编辑',
    iconCls: 'ApplicationFormEdit',
    modal: true,
    width: 700,
    border: false,
    items: [{
        xtype: 'form',
        labelAlign: 'right',
        bodyPadding: 10,
        //height: 210,
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
								maxLength: 22,
								emptyText: '',
								value: '',
                                readOnly:true,
								name: 'Code',
								fieldLabel: '单号'
							}]
					},
					{
						columnWidth: .5,
						items: [
							{
							    xtype: 'textfield',
							    allowBlank: false,
								maxLength: 20,
								emptyText: '',
								value: '',
								name: 'ReqMan',
								fieldLabel: '提报人'
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
								maxLength: 50,
								emptyText: '',
								value: '',
								name: 'ReqCom',
								fieldLabel: '提报公司'
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
								name: 'ReqDept',
								fieldLabel: '提报部门'
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
								allowBlank: true,
								maxLength: 15,
								emptyText: '',
								value: '',
								name: 'ReqManPhone',
								fieldLabel: '联系电话'
							}]
					},
					{
						columnWidth: .5,
						items: [
							{
								xtype: 'combo',
								allowBlank: false,
								name: 'ReqIncident',
								fieldLabel: '提报地点',
								forceSelection: true,
								editable: false,
								valueField: 'value',
								displayField: 'text',
								typeAhead: true,
								queryMode: 'local',
								store: Ext.create('Ext.data.Store', {
								    fields: ['value', 'text'],
								    data: [{ "text": '华之毅园区', "value": "华之毅园区" },
									{ "text": '雅莹商业园区', "value": "雅莹商业园区" },
									{ "text": '时尚园区', "value": "时尚园区" },
									{ "text": '店铺终端', "value": "店铺终端" },
									{ "text": '其他', "value": "其他" }]
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
                items: [{
                    columnWidth: 1,
                    items: [
                        {
                            xtype: 'textareafield',
                            allowBlank: false,
                            name: 'EventDesc',
                            bodyPadding: 10,
                            grow: true,
                            fieldLabel: '事件描述'
                        }]
                }]
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
								allowBlank: true,
								name: 'Engineer',
								fieldLabel: '工程师',
								forceSelection: true,
								editable:true,
								valueField: 'EgrAmName',
								displayField: 'EgrName',
								typeAhead: true,
								queryMode: 'local',
								store: 'ITSMEngineer'
							}]
					},
					{
					    columnWidth: .5,
					    items: [
							{
							    xtype: 'textfield',
							    allowBlank: true,
							    maxLength: 50,
							    emptyText: '',
							    value: '',
							    vtype: 'mobilephone',
							    name: 'EngineerPhone',
							    fieldLabel: '电话'
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
							    allowBlank: true,
							    name: 'EventEquipment',
							    fieldLabel: '设备类型',
							    forceSelection: true,
							    editable: false,
							    valueField: 'BIValue',
							    displayField: 'BIValue',
							    typeAhead: true,
							    queryMode: 'local',
							    store: 'ITSMBasicInfoSB'
							}]
					}, {
					    columnWidth: .5,
					    items: [
							{
							    xtype: 'combo',
							    allowBlank: true,
							    name: 'EventApp',
							    fieldLabel: '应用类型',
							    forceSelection: true,
							    editable: false,
							    valueField: 'BIValue',
							    displayField: 'BIValue',
							    typeAhead: true,
							    queryMode: 'local',
							    store: 'ITSMBasicInfoYY'
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
                items: [{
                    columnWidth: 1,
                    items: [
                        {
                            xtype: 'textareafield',
                            allowBlank: true,
                            name: 'EventSolution',
                            bodyPadding: 10,
                            grow: true,
                            fieldLabel: '解决方案'
                        }]
                }]
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
								name: 'ProcessStatus',
								fieldLabel: '状态',
								forceSelection: true,
								editable:false,
								valueField: 'value',
								displayField: 'text',
								typeAhead: true,
								queryMode: 'local',
								value: 0,
								store: Ext.create('Ext.data.Store', {
									fields: ['value','text'],
									data: [{ "text": '提报中', "value": 0 },
									{ "text": '已派工', "value": 1 },
									{ "text": '已接受', "value": 2 },
									{ "text": '处理中', "value": 3 },
									{ "text": '已完成', "value": 4 },
									{ "text": '已评价', "value": 5 },
									{ "text": '已取消', "value": 9 }]
								})
							}]
					},
					{
						columnWidth: .5,
						items: [
							{
								xtype: 'numberfield',
								allowBlank: true,
								value: 0,
								minValue: 0,
								maxValue: 100,
								emptyText: 0,
								name: 'ElvTime',
								fieldLabel: '及时率'
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
								allowBlank: true,
								value: 0,
								minValue: 0,
								maxValue: 100,
								emptyText: 0,
								name: 'ElvAtude',
								fieldLabel: '服务态度'
							}]
					},
					{
						columnWidth: .5,
						items: [
							{
								xtype: 'numberfield',
								allowBlank: true,
								value: 0,
								minValue: 0,
								maxValue: 100,
								emptyText: 0,
								name: 'ElvRst',
								fieldLabel: '服务结果'
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
						columnWidth: 1,
						items: [
							{
								xtype: 'textareafield',
								allowBlank: true,
								name: 'ElvDesc',
								bodyPadding: 10,
								grow: true,
								fieldLabel: '评价'
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
                                text: '取消',
                                iconCls:'RecordRed',
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
    }]
});