Ext.define("WMC.store.HRQARst", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.HRQARst',
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
            read: '/Admin/HRQARst/Get',
            update: '/Admin/HRQARst/Put',
            create: '/Admin/HRQARst/Post',
            destroy: '/Admin/HRQARst/Delete'
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