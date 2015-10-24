/// <reference path="../../ext/ext-all-debug-w-comments.js" />
Ext.define("WMC.view.EditWin", {
    extend: 'Ext.window.Window',
    alias: 'widget.editwin',
    title: '联系人明细',
    iconCls: 'ApplicationFormEdit',
    modal: true,
    width: 300,
    border: false,
    items: [{
        xtype: 'form',
        labelAlign: 'right',
        bodyPadding: 10,
        height: 250,
        border: false,
        closeAction: 'hide',
        fieldDefaults: {
            labelAlign: 'right',
            labelWidth: 60,
            anchor: '100%'
        },
        html: '',
        dockedItems: [
            {
                xtype: 'toolbar',
                dock: 'bottom',
                items: ['->',
                            {
                                text: '关闭',
                                iconCls: 'RecordRed',
                                handler: function () {
                                    this.up('window').close();
                                }
                            }
                ]
            }
        ]
    }]
});