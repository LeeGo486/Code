Ext.define("WMC.store.HRSignRst", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.HRSignRst',
    autoLoad: false,
    autoSync: false,
    pageSize: 30,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET',
            update:'PUT'
        },
        api: {
            read: '/Admin/HRCourseAttend/Get',
            update: '/Admin/HRCourseAttend/Put'
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