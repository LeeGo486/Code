Ext.define("WMC.store.OO_Industry", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.OO_Industry',
    autoLoad: true,
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
            read: '/Admin/OO_Industry/Get',
            update: '/Admin/OO_Industry/Put',
            create: '/Admin/OO_Industry/Post',
            destroy: '/Admin/OO_Industry/Delete'
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