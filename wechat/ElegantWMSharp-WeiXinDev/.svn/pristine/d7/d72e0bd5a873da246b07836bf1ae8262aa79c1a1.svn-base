Ext.define("WMC.store.HRCourseUser", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.HRCourseUser',
    autoLoad: false,
    autoSync: false,
    pageSize: 30,
    proxy: {
        type: 'rest',
        actionMethods: {
            read: 'GET'
        },
        api: {
            read: '/Admin/HRLKCourseUser/Get'
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