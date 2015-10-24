Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['OO_Industry', 'OO_MenuTemplate'],
    stores: ['OO_Industry', 'OO_MenuTemplate'],
    views: ['industry.MainGrid','menu.MainGrid'],
    //注意：如果该模块使用了KindEditor富文本框编辑器，详细使用规范请参考博客说明 http://www.cnblogs.com/qidian10/p/3619701.html
    refs: [{
        ref: 'menuMainGrid',
        selector: 'menumaingrid'
    }, {
        ref: 'mainGrid',
        selector:'industrymaingrid',
    }],
    //声明监控事件
    init: function () {
        this.control({
            'industrymaingrid': {
                //编辑
                edit: function (editor, e) {
                    this.getMainGrid().getStore().sync();//保存 
                },
                itemclick: this.loadMenu,
                itemdblclick: this.rowEditorUpdateBtnDisable
            },
            'industrymaingrid button[action=btnAdd]': {
                click: this.addRecord
            },
            'industrymaingrid button[action=btnDelete]': {
                click: this.deleteRecord
            },
            'industrymaingrid button[action=btnReflash]': {
                click:this.reflashIndustry
            },
            //操作菜单
            'menumaingrid button[action=btnAddNode]': {
                click: this.addMenuRecord
            },
            'menumaingrid button[action=btnSaveNode]': {
                click: function () {
                    //保存菜单，同步store
                    this.getMenuMainGrid().getStore().sync();
                }
            },
            'menumaingrid button[action=btnReflashNode]': {
                click: this.loadMenu
            },
            'menumaingrid actioncolumn': {
                click: function (grid, rowIndex, colIndex, actionItem, event, record, row) {
                    //选中
                    grid.getSelectionModel().select(colIndex);
                    //如果禁用则不响应
                    if (event.getTarget().className.indexOf("x-item-disabled") != -1) return;
                    var m = event.getTarget().className.match(/\bBullet(\w+)\b/);
                    if (m) {
                        switch (m[1]) {
                            case "Plus":
                                this.addNewNode();
                                break;
                            case "Minus":
                                this.deleteSelectedNode(record);
                                break;
                        }
                    }
                }
            }
        });
    },
    onLaunch: function () {
        //根据权限控制界面按钮状态
        //Ext.Tools.CtrlButtonsByPermession("OO_MenuTemplate", this.getMainGrid(), false);
    },
    //解决rowEditor插件的按钮bug
    rowEditorUpdateBtnDisable: function (me, record, item, index, e, eOpts) {
        if (this.getMainGrid().getPlugin("rowEditor").editor) {
            this.getMainGrid().getPlugin("rowEditor").editor.floatingButtons.child('#update').setDisabled(false);
        }
    },
    rowEditorUpdateBtnDisable4Menu: function (me, record, item, index, e, eOpts) {
        if (this.getMenuMainGrid().getPlugin("rowEditor").editor) {
            this.getMenuMainGrid().getPlugin("rowEditor").editor.floatingButtons.child('#update').setDisabled(false);
        }
    },
    //新增
    addRecord: function () {
        rowEditing = this.getMainGrid().getPlugin("rowEditor");
        rowEditing.cancelEdit();
        var r = Ext.create('WMC.model.OO_Industry', {
            Id: Ext.data.IdGenerator.get('uuid').generate()
        });
        this.getMainGrid().getStore().insert(0, r);
        rowEditing.startEdit(0, 0);
        rowEditing.enable();
        rowEditing.editor.floatingButtons.child('#update').setDisabled(false);
    },
    //删除
    deleteRecord: function () {
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要操作的行！", 1);
            return;
        }
        var records = selModel.getSelection();
        Ext.MessageBox.confirm("警告", "是否要彻底删除这些信息吗？", function (button, text) {
            if (button == "yes") {
                grid.getStore().remove(records);
                grid.getStore().sync();//保存
            }
        });
    },
    //刷新
    reflashIndustry: function () {
        this.getMainGrid().getStore().reload();
    },
    getSelectedItry: function () {
        var grid = this.getMainGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要操作的行业！", 1);
            return;
        }
        var records = selModel.getSelection();
        return records[0].data.Id;
    },
    //加载菜单
    loadMenu: function () {
        if (this.getSelectedItry() == null) {
            return;
        }
        var grid = this.getMenuMainGrid();
        var store = grid.getStore();
        store.getProxy().setExtraParam("IdtId", this.getSelectedItry());
        store.load({
            scope: this,
            callback: function () {
                grid.getRootNode().expand();
            }
        });
    },
    //模板菜单操作
    addMenuRecord: function () {
        if (this.getSelectedItry() == null) {
            return;
        }

        var rootNode = this.getMenuMainGrid().getRootNode();
        if (rootNode.childNodes.length >= 3) {
            Ext.Tools.Msg("微信仅支持3个主菜单！", 1);
            return;
        }
        var rid = Ext.data.IdGenerator.get('uuid').generate();
        var r = Ext.create('WMC.model.OO_MenuTemplate', {
            Id: rid,
            FatherId: '00000000-0000-0000-0000-000000000000',
            IdtId: this.getSelectedItry(),
            OrderIndex: 100,
            iconCls: 'RecordGreen',
            leaf: true
        });

        rootNode.appendChild(r);
        rootNode.expand();
    },
    //新增节点
    addNewNode: function () {
        if (this.getSelectedItry() == null) {
            return;
        }
        //获取选择的节点
        var grid = this.getMenuMainGrid();
        var selModel = grid.getSelectionModel();
        var records = selModel.getSelection();
        if (records[0].data.depth > 1) {
            Ext.Tools.Msg("微信仅支持2层菜单！", 1);
            return;
        }

        if (records[0].childNodes.length >= 5) {
            Ext.Tools.Msg("微信仅支持5个子菜单！", 1);
            return;
        }

        var pid = records[0].data.Id;

        var r = Ext.create('WMC.model.OO_MenuTemplate', {
            Id: Ext.data.IdGenerator.get('uuid').generate(),
            IdtId:this.getSelectedItry(),
            FatherId: pid,
            OrderIndex: 100,
            iconCls: 'RecordGreen',
            leaf: true
        });
        if (records[0].get("leaf")) {
            records[0].set("leaf", false);
            records[0].set("iconCls", "");
        }
        records[0].appendChild(r);
        records[0].expand();
    },
    //删除
    deleteSelectedNode: function (selNode) {
        var menuStore = this.getMenuMainGrid().getStore();
        if (!selNode.data.leaf) {
            Ext.Tools.Alert("警告", "请先删除其下的叶子节点！", "E");
            return;
        }
        Ext.MessageBox.confirm("警告", "确定要删除“" + selNode.data.Name + "”吗？", function (button, text) {
            if (button == "yes") {
                parentNode = selNode.parentNode;
                nextSibling = selNode.nextSibling;
                selNode.remove();
                menuStore.sync({
                    success: function (batch, options) {
                        rst = Ext.JSON.decode(batch.operations[0].response.responseText);
                        if (parentNode.childNodes.length <= 0) {
                            parentNode.set("leaf", true);
                        }
                    }, failure: function (batch, options) {
                        parentNode.insertBefore(selNode, nextSibling);
                    }
                });
            }
        });
    }
});
