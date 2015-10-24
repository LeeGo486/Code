Ext.define("WMC.store.WXRespImgTxt", {
    extend: 'WMC.common.store.Base',
    model: 'WMC.model.WXRespImgTxt',
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
            read: '/Admin/WXRespImgTxt/Get',
            update: '/Admin/WXRespImgTxt/Put',
            create: '/Admin/WXRespImgTxt/Post',
            destroy: '/Admin/WXRespImgTxt/Delete'
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