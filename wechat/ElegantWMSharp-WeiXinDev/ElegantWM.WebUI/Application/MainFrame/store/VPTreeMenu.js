/// <reference path="../../Ext.js" />
Ext.define("WMS.store.VPTreeMenu", {
    extend: 'Ext.data.TreeStore',
    autoLoad: true,
    model: 'WMS.model.VPTree',
    root: {
        text: '功能节点',
        id: 'root',
        expanded: true
    },
    proxy: {
        type: 'ajax',
        api: {
            read: '/Admin/Main/GetMenu'
        },
        reader: {
            type: 'json'
        }
    }
});