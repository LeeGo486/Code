Ext.define('WMC.view.Viewport', {
    extend: 'Ext.container.Viewport',
    layout: 'border',
    items: [
        {
            xtype: 'maingrid',
            border: false,
            region: 'west',
            split: true,
            collapsible: false,
            width: 350
        },
        {
            xtype: 'tabpanel',
            layout: 'fit',
            region: 'center',
            activeTab: 0,
            disabled: true,
            items: [{
                title: '文本',
                iconCls: 'PageWhite',
                padding: 10,
                border: false,
                items: [{
                    id: 'CRespText',
                    xtype: 'textareafield',
                    maxLength: 1024,
                    width: '100%'
                }, {
                    xtype: 'button',
                    text: '保存',
                    iconCls: 'Disk',
                    action: 'btnSaveTxt'
                }]
            },
            {
                title: '图文',
                iconCls: 'PageWhitePicture',
                xtype: 'respmaingrid'
            },
            {
                title: '服务',
                iconCls: 'ServerConnect',
                padding: 10,
                border: false,
                xtype: 'form',
                labelAlign: 'right',
                fieldDefaults: {
                    labelAlign: 'right',
                    labelWidth: 60,
                    anchor: '100%'
                },
                items: [{
                    name: 'CRespSvrUrl',
                    xtype: 'textfield',
                    allowBlank: false,
                    vtype: 'url',
                    emptyText: 'Url地址，建议采用POST方式，utf-8格式',
                    fieldLabel: '服务地址'
                }, {
                    name: 'CRespSvrParams',
                    xtype: 'textareafield',
                    maxLength: 500,
                    emptyText: '请输入JSON参数，形如：{aaa:1,bbb:2}，其中程序将自动传递sid（微信服务号唯一Id）和oid（当前用户OpenId）到您的服务地址中，如需要请用Request接收。',
                    fieldLabel: '服务参数'
                }, {
                    xtype: 'button',
                    text: '测试',
                    iconCls: 'ApplicationOsxTerminal',
                    action: 'btnSrvTest'
                }, {
                    xtype: 'button',
                    text: '保存',
                    margin: '0 0 0 10',
                    iconCls: 'Disk',
                    action: 'btnSaveSrv'
                }, {
                    name: 'CRespSvrRst',
                    margin: '20 0 0 0',
                    xtype: 'textareafield',
                    height: 250,
                    fieldLabel: '测试结果'
                }]
            }]
        }
    ]
});
