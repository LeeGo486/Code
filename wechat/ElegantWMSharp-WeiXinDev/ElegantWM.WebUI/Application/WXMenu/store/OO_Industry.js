Ext.define("WMC.store.OO_Industry", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.OO_Industry',
    autoLoad: false,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET'
        },
        api: {
            read: '/Admin/OO_Industry/Get'
        },
        reader: {
            type: 'json',
            root: 'data'
        },
        writer: {
            type: 'json'
        }
    }
});