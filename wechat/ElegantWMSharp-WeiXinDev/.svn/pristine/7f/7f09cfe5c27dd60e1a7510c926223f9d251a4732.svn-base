Ext.define("WMC.store.Fire_Question", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.Fire_Question',
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
            read: '/Admin/Fire_Question/Get',
            update: '/Admin/Fire_Question/Put',
            create: '/Admin/Fire_Question/Post',
            destroy: '/Admin/Fire_Question/Delete'
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