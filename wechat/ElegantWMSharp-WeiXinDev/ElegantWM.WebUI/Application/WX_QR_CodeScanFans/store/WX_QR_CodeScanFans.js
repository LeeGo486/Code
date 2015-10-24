Ext.define("WMC.store.WX_QR_CodeScanFans", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.WX_QR_CodeScanFans',
    autoLoad: false,
    autoSync: false,
    pageSize: 30,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET'
        },
        api: {
            read: '/Admin/WX_QR_CodeScanFans/Get',
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'total'
        },
        writer: {
            type: 'json'
        }
    }
});