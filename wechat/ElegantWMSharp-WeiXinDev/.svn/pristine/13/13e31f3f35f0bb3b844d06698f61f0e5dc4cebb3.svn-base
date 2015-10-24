/// <reference path="../../ext/ext-all-debug-w-comments.js" />
var htmlEditorRsb;
var htmlEditorSkills;
Ext.define("WMC.view.EditWin", {
    extend: 'Ext.window.Window',
    alias: 'widget.editwin',
    title: '编辑',
    iconCls: 'ApplicationFormEdit',
    modal: true,
    width: 750,
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
					    columnWidth: 1,
					    items: [
							{
							    xtype: 'textfield',
							    allowBlank: false,
							    //vtype: 'number|alpha|alphanum|url|email|',
							    name: 'JobName',
							    fieldLabel: '职位名称'
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
                         columnWidth: .2,
                         items: [
                             {
                                 xtype: 'numberfield',
                                 allowBlank: false,
                                 name: 'NeedNum',
                                 width: 50,
                                 minValue: 1,
                                 emptyText: 1,
                                 blankText: 1,
                                 value: 1,
                                 fieldLabel: '招聘人数'
                             }]
                     },
					{
					    columnWidth: .2,
					    items: [
							{
							    name: 'IsTop',
							    fieldLabel: '置顶',
							    xtype: 'combo',
							    allowBlank: false,
							    forceSelection: true,
							    editable: false,
							    valueField: 'Key',
							    displayField: 'Value',
							    typeAhead: true,
							    queryMode: 'local',
							    value:0,
							    store: Ext.create('Ext.data.Store', {
							        fields: ['Key', 'Value'],
							        data: [{ "Key": 0, "Value": "否" }, { "Key": 1, "Value": "是" }]
							    })
							}]
					}, {
					    columnWidth: .2,
					    items: [
							{
							    name: 'IsShow',
							    fieldLabel: '显隐',
							    xtype: 'combo',
							    allowBlank: false,
							    forceSelection: true,
							    editable: false,
							    valueField: 'Key',
							    displayField: 'Value',
							    typeAhead: true,
							    queryMode: 'local',
							    value: 0,
							    store: Ext.create('Ext.data.Store', {
							        fields: ['Key', 'Value'],
							        data: [{ "Key": 0, "Value": "显示" }, { "Key": 1, "Value": "隐藏" }]
							    })
							}]
					}, {
					    columnWidth: .4,
					    items: [
							{
							    xtype: 'textfield',
							    allowBlank: false,
							    vtype: 'email',
							    name: 'Email',
							    value: 'hujiageng@elegant-prosper.com.cn',
							    fieldLabel: '应聘邮箱'
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
							    xtype: 'extkindeditor',
							    allowBlank: false,
							    //vtype: 'number|alpha|alphanum|url|email|',
							    name: 'Responsibilities',
							    height: 180,
                                //width:670,
							    id: 'Responsibilities',
							    fieldLabel: '岗位职责'
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
							    xtype: 'extkindeditor',
							    allowBlank: false,
							    //vtype: 'number|alpha|alphanum|url|email|',
							    name: 'Skills',
							    id: 'Skills',
							    //width: 670,
                                height:180,
							    fieldLabel: '任职要求'
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
    }]
});