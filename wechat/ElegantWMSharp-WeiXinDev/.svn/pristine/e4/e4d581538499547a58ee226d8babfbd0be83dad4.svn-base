Ext.define("WMC.store.ITSMEngineer", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.ITSMEngineer',
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
            read: '/Admin/ITSMEngineer/Get',
            update: '/Admin/ITSMEngineer/Put',
            create: '/Admin/ITSMEngineer/Post',
            destroy: '/Admin/ITSMEngineer/Delete'
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