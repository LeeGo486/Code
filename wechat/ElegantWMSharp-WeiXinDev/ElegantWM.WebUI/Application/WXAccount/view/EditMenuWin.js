/// <reference path="../../ext/ext-all-debug-w-comments.js" />
Ext.define("WMC.view.EditMenuWin", {
    extend: 'Ext.window.Window',
    alias: 'widget.editmenuwin',
    title: '编辑微信菜单',
    iconCls: 'Outline',
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
						columnWidth: 1,
						items: [
							{
								xtype: 'textareafield',
								allowBlank: false,
								name: 'wxmenu',
								bodyPadding: 10,
								height:400,
								fieldLabel: '菜单JSON'
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
                                text: '关闭',
                                iconCls:'RecordRed',
                                handler: function () {
                                    this.up('window').close();
                                }
                            },
                            {
                                text: '上传菜单',
                                iconCls: 'ArrowUp',
                                action: 'btnUploadMenu'
                            }
                ]
            }
        ]
    }]
});