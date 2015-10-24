Ext.define("WMC.store.WXKeyWord", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.WXKeyWord',
    autoLoad: false,
    autoSync: false,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET',
            update: 'PUT',
            create: 'POST',
            destroy: 'DELETE'
        },
        api: {
            read: '/Admin/WXKeyWord/Get',
            update: '/Admin/WXKeyWord/Put',
            create: '/Admin/WXKeyWord/Post',
            destroy: '/Admin/WXKeyWord/Delete'
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