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
            labelWidth: 80,
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
                                hidden:true,
							    allowBlank: true,
							    maxLength: 100,
							    emptyText: '',
							    value: '',
							    name: 'AccountId',
							    fieldLabel: '公众号'
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
							    name: 'Action_Name',
							    fieldLabel: '二维码类型',
							    forceSelection: true,
							    editable: false,
							    valueField: 'Key',
							    displayField: 'Value',
							    typeAhead: true,
							    queryMode: 'local',
							    store: Ext.create('Ext.data.Store', {
							        fields: ['Key', 'Value'],
							        data: [{ "Key": "QR_LIMIT_SCENE", "Value": "永久" }, { "Key": "QR_SCENE", "Value": "临时" }]
							    })
							}]
					},
					{
					    columnWidth: .5,
					    items: [
							{
							    xtype: 'numberfield',
							    allowBlank: false,
							    value: 100,
							    minValue: 0,
							    maxValue: 1000000,
							    emptyText: 0,
							    name: 'Scene_ID',
							    fieldLabel: '场景号'
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
							    maxLength: 100,
							    emptyText: '',
							    value: '',
							    name: 'Scene_Name',
							    fieldLabel: '场景介绍'
							}]
					}
                    ,
					{
					    columnWidth: .5,
					    items: [
							{
							    xtype: 'combo',
							    allowBlank: false,
							    name: 'Scene_Key',
							    fieldLabel: '场景事件',
							    forceSelection: true,
							    editable: false,
							    valueField: 'IsUsing',
							    displayField: 'show',
							    typeAhead: true,
							    queryMode: 'local',
							    store: Ext.create('Ext.data.Store', {
							        fields: ['IsUsing', 'show'],
							        data: [{ 'IsUsing': 'text', 'show': '文本' }, { 'IsUsing': 'news', 'show': '图文' }, { 'IsUsing': 'svrtext', 'show': '服务文本' }, { 'IsUsing': 'svrnews', 'show': '服务图文' }]
							    })
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