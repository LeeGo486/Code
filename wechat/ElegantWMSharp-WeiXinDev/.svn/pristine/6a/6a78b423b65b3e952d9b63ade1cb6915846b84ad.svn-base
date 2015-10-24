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
							    allowBlank: true,
							    maxLength: 50,
							    emptyText: '',
							    value: '',
							    name: 'AccountName',
							    fieldLabel: '账号名称'
							}]
					},
					{
						columnWidth: .5,
						items: [
							{
								xtype: 'textfield',
								allowBlank: false,
								maxLength: 50,
								emptyText: '',
								value: '',
								name: 'OpenId',
								fieldLabel: '原始ID'
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
							    name: 'LoginEmail',
							    fieldLabel: '登录邮箱'
							}]
					}
                    ,
					{
					    columnWidth: .5,
					    items: [
							{
							    xtype: 'textfield',
							    allowBlank: false,
							    maxLength: 40,
							    emptyText: '',
							    value: '',
							    name: 'LoginPwd',
							    fieldLabel: '登录密码'
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
							    maxLength: 30,
							    emptyText: '',
							    value: '',
							    name: 'AppId',
							    fieldLabel: 'AppId'
							}]
					}
                    ,
					{
						columnWidth: .5,
						items: [
							{
								xtype: 'textfield',
								allowBlank: false,
								maxLength: 40,
								emptyText: '',
								value: '',
								name: 'AppSecret',
								fieldLabel: 'AppSecret'
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
								name: 'IsAccessed',
								fieldLabel: '是否接入',
								forceSelection: true,
								editable:false,
								valueField: 'Key',
								displayField: 'Value',
								typeAhead: true,
								queryMode: 'local',
								store: Ext.create('Ext.data.Store', {
								    fields: ['Key', 'Value'],
								    data: [{ "Key": 0, "Value": "否" }, { "Key": 1, "Value": "是" }]
								})
							}]
					},
					{
					    columnWidth: .5,
					    items: [
							{
							    xtype: 'combo',
							    allowBlank: true,
							    name: 'IsAuthed',
							    fieldLabel: '是否认证',
							    forceSelection: true,
							    editable: false,
							    valueField: 'Key',
							    displayField: 'Value',
							    typeAhead: true,
							    queryMode: 'local',
							    store: Ext.create('Ext.data.Store', {
							        fields: ['Key', 'Value'],
							        data: [{ "Key": 0, "Value": "否" }, { "Key": 1, "Value": "是" }]
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
							    maxLength: 20,
							    emptyText: '',
							    value: '',
							    name: 'Token',
							    fieldLabel: 'Token'
							}]
					}
                    ,
					{
						columnWidth: .5,
						items: [
							{
								xtype: 'textareafield',
								allowBlank: false,
								name: 'WelcomeWord',
								bodyPadding: 10,
								grow: true,
								fieldLabel: '欢迎词'
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