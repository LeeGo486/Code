Ext.define("WMC.store.S3Dictionary", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.S3Dictionary',
    autoLoad: true,
    autoSync: false,
    pageSize: 30,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET',
            update: 'PUT',
            create: 'POST',
            destroy: 'DELETE'
        },
        api: {
            read: '/Admin/S3Dictionary/Get',
            update: '/Admin/S3Dictionary/Put',
            create: '/Admin/S3Dictionary/Post',
            destroy: '/Admin/S3Dictionary/Delete'
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