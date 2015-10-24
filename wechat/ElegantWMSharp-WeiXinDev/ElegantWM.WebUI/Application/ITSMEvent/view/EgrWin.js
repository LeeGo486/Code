/// <reference path="../../ext/ext-all-debug-w-comments.js" />
Ext.define("WMC.view.EgrWin", {
    extend: 'Ext.window.Window',
    alias: 'widget.egrwin',
    title: '派工',
    iconCls: 'Wrench-Screwdriver',
    modal: true,
    width: 300,
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
                                text: '确定派工',
                                iconCls: 'Wrench-Screwdriver',
                                action: 'btnSure'
                            }
                ]
            }
        ]
    }]
});