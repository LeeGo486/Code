Ext.define('WMC.view.Viewport', {
    extend: 'Ext.container.Viewport',
    layout: 'fit',
    layout: 'border',
    items: [
        {
            xtype: 'industrymaingrid',
            region: 'west',
            border: false,
            split: true,
            collapsible: false,
            width: 250
        },
        {
            xtype: 'menumaingrid',
            layout: 'fit',
            border: false,
            region: 'center'
        }
    ]
});
