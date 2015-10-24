Ext.define("WMC.store.HRJobSeeker", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.HRJobSeeker',
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
            read: '/Admin/HRJobSeeker/Get',
            update: '/Admin/HRJobSeeker/Put',
            create: '/Admin/HRJobSeeker/Post',
            destroy: '/Admin/HRJobSeeker/Delete'
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