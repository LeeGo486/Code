Ext.define("WMC.store.Jobs", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.Jobs',
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
            read: '/Admin/HRJobs/Get',
            update: '/Admin/HRJobs/Put',
            create: '/Admin/HRJobs/Post',
            destroy: '/Admin/HRJobs/Delete'
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