Ext.define("WMC.store.WX_QR_Code", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.WX_QR_Code',
    autoLoad: false,
    autoSync: false,
    pageSize: 30,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET',
            update: 'PUT',
            create: 'POST',
        },
        api: {
            read: '/Admin/WX_QR_Code/Get',
            update: '/Admin/WX_QR_Code/Put',
            create: '/Admin/WX_QR_Code/Post'
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