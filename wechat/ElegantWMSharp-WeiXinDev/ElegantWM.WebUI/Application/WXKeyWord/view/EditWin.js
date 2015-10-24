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
					    items: [{
					        columnWidth: 1,
					        items: [
                                {
                                    xtype: 'textareafield',
                                    allowBlank: false,
                                    name: 'KwList',
                                    bodyPadding: 10,
                                    grow: true,
                                    emptyText:'关键词列表，多个请用英文“,”分割开',
                                    fieldLabel: '关键词'
                                }]
					    }]
					}
                    ,
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
                                    xtype: 'combo',
                                    allowBlank: false,
                                    name: 'RespType',
                                    fieldLabel: '响应类型',
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
					    }]
					}
			        ,
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
                                    xtype: 'combo',
                                    allowBlank: false,
                                    name: 'IsUsing',
                                    fieldLabel: '是否使用',
                                    forceSelection: true,
                                    editable: false,
                                    valueField: 'IsUsing',
                                    displayField: 'show',
                                    typeAhead: true,
                                    queryMode: 'local',
                                    store: Ext.create('Ext.data.Store', {
                                        fields: ['IsUsing','show'],
                                        data: [{ 'IsUsing': 0, 'show': '使用' }, { 'IsUsing': 1, 'show': '停用' }]//[['男'], ['女']]
                                    })
                                }]
					    }]
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