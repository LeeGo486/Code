Ext.define("WMS.view.Tree", {
    extend: 'Ext.tree.Panel',
    alias: 'widget.wmstree',
    id: 'wmsMenuTreePanel',
    title: "功能导航",
    margins: '0 0 0 3',
    width: 200,
    region: 'west',
    animate: true,
    store: 'VPTreeMenu',
    autoScroll: true,
    rootVisible: false,
    loadMsg: true,
    collapsible: true,//是否可以折叠
    split: true,
    tools: [{
        type: 'expand',
        handler: function () { Ext.getCmp("wmsMenuTreePanel").expandAll(); }
    }, {
        type: 'collapse',
        handler: function () { Ext.getCmp("wmsMenuTreePanel").collapseAll(); }
    }],
    mixins: {
        treeFilter: 'WMS.view.TreeFilter'
    },
    tbar: [{
        xtype: 'trigger',
        triggerCls: 'x-form-clear-trigger',
        onTriggerClick: function () {
            this.setValue('');
            Ext.getCmp("wmsMenuTreePanel").clearFilter();
        },
        width:'100%',
        emptyText:'快速检索功能',
        enableKeyEvents: true,
        listeners: {
            keyup: {
                fn: function (field, e) {
                    if (Ext.EventObject.ESC == e.getKey()) {
                        field.onTriggerClick();
                    } else {
                        Ext.getCmp("wmsMenuTreePanel").filterByText(this.getRawValue());
                    }
                }
            }
        }
    }]
});