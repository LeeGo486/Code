Ext.define("WMC.store.HRCourseLesson", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.HRCourseLesson',
    autoLoad: false,
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
            read: '/Admin/HRCourseLesson/Get',
            update: '/Admin/HRCourseLesson/Put',
            create: '/Admin/HRCourseLesson/Post',
            destroy: '/Admin/HRCourseLesson/Delete'
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