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
            labelWidth: 70,
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
							    maxLength: 50,
							    emptyText: '',
							    value: '',
							    name: 'QsnCategory',
							    fieldLabel: '类别'
							}]
					},
					{
						columnWidth: .5,
						items: [
							{
								xtype: 'textfield',
								allowBlank: false,
								maxLength: 200,
								emptyText: '',
								value: '',
								name: 'QsnName',
								fieldLabel: '问题'
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
								name: 'QsnType',
								fieldLabel: '类型',
								forceSelection: true,
								editable:false,
								valueField: 'QsnType',
								displayField: 'QsnType',
								typeAhead: true,
								queryMode: 'local',
								store: Ext.create('Ext.data.ArrayStore', {
									fields: ['QsnType'],
									data: [['radio'], ['text']]
								})
							}]
					},
                    {
                        columnWidth: .5,
                        items: [
							{
							    xtype: 'textfield',
							    allowBlank: false,
							    maxLength: 10,
							    emptyText: '',
							    value: '',
							    name: 'QsnSatisfactionType',
							    fieldLabel: '满意度模板'
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
							    xtype: 'textfield',
							    allowBlank: false,
							    maxLength: 100,
							    emptyText: '',
							    value: '',
							    name: 'QsnAnswer1',
							    fieldLabel: '答案1'
							}]
					},
					{
					    columnWidth: .2,
					    items: [
							{
							    xtype: 'textfield',
							    allowBlank: false,
							    maxLength: 100,
							    emptyText: '',
							    value: '',
							    name: 'QsnAnswer2',
							    fieldLabel: '答案2'
							}]
					}, {
					    columnWidth: .2,
					    items: [
							{
							    xtype: 'textfield',
							    allowBlank: false,
							    maxLength: 100,
							    emptyText: '',
							    value: '',
							    name: 'QsnAnswer3',
							    fieldLabel: '答案3'
							}]
					}, {
					    columnWidth: .2,
					    items: [
							{
							    xtype: 'textfield',
							    allowBlank: false,
							    maxLength: 100,
							    emptyText: '',
							    value: '',
							    name: 'QsnAnswer4',
							    fieldLabel: '答案4'
							}]
					}, {
					    columnWidth: .2,
					    items: [
							{
							    xtype: 'textfield',
							    allowBlank: false,
							    maxLength: 100,
							    emptyText: '',
							    value: '',
							    name: 'QsnAnswer5',
							    fieldLabel: '答案5'
							}]
					}
                ]
            },
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