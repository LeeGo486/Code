Ext.define("WMC.store.HRCourse", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.HRCourse',
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
            read: '/Admin/HRCourse/Get',
            update: '/Admin/HRCourse/Put',
            create: '/Admin/HRCourse/Post',
            destroy: '/Admin/HRCourse/Delete'
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