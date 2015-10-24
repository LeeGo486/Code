/// <reference path="../../ext/ext-all-debug-w-comments.js" />
Ext.define("WMC.view.resp.EditWin", {
    extend: 'Ext.window.Window',
    alias: 'widget.respeditwin',
    title: '编辑',
    iconCls: 'ApplicationFormEdit',
    modal: true,
    width: 700,
    border: false,
    items: [{
        xtype: 'form',
        labelAlign: 'right',
        bodyPadding: 10,
        height: 550,
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
								allowBlank: true,
								maxLength: 100,
								emptyText: '',
								value: '',
								name: 'Title',
								fieldLabel: '标题'
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
							    xtype: 'textfield',
							    maxLength: 200,
							    emptyText: '默认不需要填写，您也可以自定义跳转地址',
							    value: '',
							    name: 'AbsUrl',
							    fieldLabel: '链接地址'
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
							    xtype: 'filefield',
								allowBlank: true,
								maxLength: 100,
								emptyText: '推荐主图640x320，小图80x80',
								value: '',
								name: 'UploadImageUrl',
								buttonText: '上传图片',
								fieldLabel: '图片'
							}]
					},
                    {
                        columnWidth: .5,
                        items: [
							{
							    xtype: 'textfield',
                                readOnly:true,
							    emptyText: '请在左侧上传图片',
							    name: 'ImageUrl',
							    fieldLabel: '图片路径'
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
							    allowBlank: false,
							    name: 'Description',
							    fieldLabel: '概要描述'
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
							    name: 'Content',
							    height: 300,
							    width: 670,
							    id: 'RespContent',
							    fieldLabel: '内容'
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
						columnWidth: .4,
						items: [
							{
							    xtype: 'combo',
							    name: 'IsShow',
							    fieldLabel: '是否显示',
							    allowBlank: false,
							    forceSelection: true,
							    editable: false,
							    valueField: 'IsShow',
							    displayField: 'Value',
							    typeAhead: true,
							    queryMode: 'local',
                                value:0,
							    store: Ext.create('Ext.data.Store', {
							        fields: ['IsShow', 'Value'],
							        data: [{ "IsShow": 0, "Value": "是" }, { "IsShow": 1, "Value": "否" }]
							    })
							}]
					},
					{
						columnWidth: .4,
						items: [
							{
							    xtype: 'combo',
							    name: 'IsMain',
							    allowBlank: false,
							    forceSelection: true,
							    editable: false,
							    valueField: 'Key',
							    displayField: 'Value',
							    typeAhead: true,
							    fieldLabel: '是否主图',
							    queryMode: 'local',
                                value:0,
							    store: Ext.create('Ext.data.Store', {
							        fields: ['Key', 'Value'],
							        data: [{ "Key":1, "Value": "是" }, { "Key":0, "Value": "否" }]
							    })
							}]
					}, {
					    columnWidth: .2,
					    items: [
							{
							    xtype: 'numberfield',
							    allowBlank: false,
							    name: 'OrderIndex',
                                value:0,
							    fieldLabel: '排序'
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