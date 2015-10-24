Ext.define("WMC.store.WXContacts", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.WXContacts',
    autoLoad: false,
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
            read: '/Admin/WXContacts/Get',
            update: '/Admin/WXContacts/Put',
            create: '/Admin/WXContacts/Post',
            destroy: '/Admin/WXContacts/Delete'
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