Ext.define('WMC.controller.Main', {
    extend: 'Ext.app.Controller',
    models: ['WXRespImgTxt', 'WXMenu','Account', 'OO_Industry'],
    stores: ['WXRespImgTxt', 'WXMenu', 'Account', 'OO_Industry'],
    views: ['menu.Grid', 'TpltWin', 'resp.MainGrid', 'resp.EditWin', 'WMC.common.view.ExtKindEditor'],
    //注意：如果该模块使用了KindEditor富文本框编辑器，详细使用规范请参考博客说明 http://www.cnblogs.com/qidian10/p/3619701.html
    refs: [{
        ref: 'menuGrid',
        selector: 'menugrid'
    }, {
        ref: 'tpltWin',
        selector: 'tpltwin',
        autoCreate: true,
        xtype:'tpltwin'
    }, {
        ref: 'cRespText',
        selector: 'tabpanel #CRespText'
    }, {
        ref: 'respTab',
        selector: 'tabpanel'
    }, {
        ref: 'respMainGrid',
        selector:'respmaingrid'
    }, {
        ref: 'respWin',
        selector: 'respeditwin',
        autoCreate: true,
        xtype: 'respeditwin'
    }, {
        ref: 'respContent',
        selector:'#RespContent'
    },{
        ref: 'respSrvForm',
        selector:'tabpanel form'
    }],
    //声明监控事件
    init: function () {
        this.control({
            'menugrid combobox[name=cbAccount]': {
                select: this.loadWXMenu
            },
            'menugrid button[action=btnAddNode]': {
                click: this.addRecord
            },
            'menugrid button[action=btnSaveNode]': {
                click: function () {
                    //保存菜单，同步store
                    this.getMenuGrid().getStore().sync();
                }
            },
            'menugrid button[action=btnReflashNode]': {
                click: this.loadWXMenu
            },
            'menugrid button[action=btnUploadNode]': {
                click: this.uploadWXMenu
            },
            'menugrid button[action=btnDelWxMenu]':{
                click:this.delWXMenu
            },
            'menugrid button[action=btnTemplate]': {
                click:this.loadTemplate
            },
            //'menugrid combo': {
            //    change: this.menuItemSelected
            //},
            'tpltwin button[action=btnApplyTplt]': {
                click: this.applyTplt
            },
            'menugrid actioncolumn': {
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
            },
            'menugrid': {
                itemclick:this.menuItemSelected
            },
            'tabpanel button[action=btnSaveTxt]': {
                click:this.saveTxtAction
            },
            'tabpanel form button[action=btnSaveSrv]': {
                click: this.saveSrvAction
            },
            'tabpanel form button[action=btnSrvTest]': {
                click: this.testSrvAction
            },
            //图文页面管理
            'respmaingrid button[action=btnAdd]': {
                click: function () {
                    //var grid = this.getRespMainGrid();
                    //if (grid.getStore().getCount() >= 10) {
                    //    Ext.Tools.Msg("最多支持10条信息！", 1);
                    //    return;
                    //}
                    this.getRespWin().show();
                }
            },
            'respmaingrid': {
                itemdblclick: this.editRecord
            },
            'respeditwin button[action=btnSave]': {
                click: this.saveRecord
            },
            'respeditwin filefield': {
                change: function (f, v) {
                    var form = this.getRespWin().down('form').getForm();
                    var accountId = this.getAccountId();
                    if (accountId == null) {
                        Ext.Tools.Msg("请先选择微信账号！", 1);
                        return;
                    }
                    form.submit({
                        url: '/Admin/WXRespImgTxt/UploadImg?sid=' + accountId,
                        type: 'ajax',
                        waitMsg: '图片上传中...',
                        clientValidation: false,
                        scope:this,
                        success: function (f,o) {
                            var rst = Ext.JSON.decode(o.response.responseText);
                            if (rst.result == 0) {
                                Ext.Tools.Msg("图片上传成功！", rst.result);
                                this.getRespWin().down('[name=ImageUrl]').setValue(rst.msg);
                            } else {
                                Ext.Tools.Msg(rst.msg, rst.result);
                            }
                        },
                        failure: function (f, o) {
                            var rst = Ext.JSON.decode(o.response.responseText);
                            Ext.Tools.Msg(rst.msg, 9);
                        }
                    });
                }
            },
            'respmaingrid button[action=btnDelete]': {
                click: this.deleteRecord
            }
        });
    },
    onLaunch: function () {
        //根据权限控制界面按钮状态
        //Ext.Tools.CtrlButtonsByPermession("WXMenu", this.getMainGrid(), false);
    },
    //新增根节点
    addRecord: function () {
        var accountId=this.getAccountId();
        if (accountId==null) {
            Ext.Tools.Msg("请先选择微信账号！", 1);
            return;
        }
        var rootNode = this.getMenuGrid().getRootNode();
        if (rootNode.childNodes.length >= 3) {
            Ext.Tools.Msg("微信仅支持3个主菜单！", 1);
            return;
        }
        var rid = Ext.data.IdGenerator.get('uuid').generate();
        var r = Ext.create('WMC.model.WXMenu', {
            Id: rid,
            FatherId: '00000000-0000-0000-0000-000000000000',
            AccountId: accountId,
            OrderIndex: 100,
            iconCls: 'RecordGreen',
            leaf:true
        });

        rootNode.appendChild(r);
        rootNode.expand();
    },
    //新增节点
    addNewNode: function () {
        var accountId = this.getAccountId();
        if (accountId == null) {
            Ext.Tools.Msg("请先选择微信账号！", 1);
            return;
        }
        //获取选择的节点
        var grid = this.getMenuGrid();
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

        var pid = records[0].data.Id;;
        //if (pid == undefined)
        //    pid = records[0].data.id;

        var r = Ext.create('WMC.model.WXMenu', {
            Id: Ext.data.IdGenerator.get('uuid').generate(),
            FatherId: pid,
            AccountId: accountId,
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
        var menuStore = this.getMenuGrid().getStore();
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
    },
    getAccountId:function(){
        var accountInfo = this.getMenuGrid().down("combobox[name=cbAccount]"); 
        return accountInfo.getValue();
    },
    loadWXMenu: function () {
        var menuStore = this.getMenuGrid().getStore();
        menuStore.getProxy().setExtraParam("accountId", this.getAccountId());
        menuStore.load({
            scope: this,
            callback: function () {
                this.getMenuGrid().getRootNode().expand();
            }
        });
    },
    //上传微信菜单
    uploadWXMenu: function () {
        var accountId = this.getAccountId();
        if (accountId == null) {
            Ext.Tools.Msg("请先选择微信账号！", 1);
            return;
        }

        var myMask = new Ext.LoadMask(this.getMenuGrid(), { msg: "正在应用到微信，请稍后..." });
        myMask.show();
        Ext.Ajax.request({
            url: '/Admin/WXMenu/UpdateWxMenu',
            method: 'POST',
            params: { accountId: accountId },
            scope: this,
            success: function (response) {
                var rst = Ext.JSON.decode(response.responseText);
                Ext.Tools.Alert("警告", "微信应答：" + rst, "I");
                myMask.hide();
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    },
    delWXMenu: function () {
        var accountId = this.getAccountId();
        if (accountId == null) {
            Ext.Tools.Msg("请先选择微信账号！", 1);
            return;
        }

        var myMask = new Ext.LoadMask(this.getMenuGrid(), { msg: "正在删除微信菜单，请稍后..." });
        myMask.show();
        Ext.Ajax.request({
            url: '/Admin/WXMenu/DeleteWxMenu',
            method: 'POST',
            params: { accountId: accountId },
            scope: this,
            success: function (response) {
                var rst = Ext.JSON.decode(response.responseText);
                Ext.Tools.Alert("警告", "微信应答：" + rst, "I");
                myMask.hide();
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    },
    //加载行业模板
    loadTemplate: function () {
        var accountId = this.getAccountId();
        if (accountId == null) {
            Ext.Tools.Msg("请先选择微信账号！", 1);
            return;
        }

        var win = this.getTpltWin();
        win.down("grid").getStore().load();
        win.show();
    },
    applyTplt: function () {
        var accountId = this.getAccountId();
        if (accountId == null) {
            Ext.Tools.Msg("请先选择微信账号！", 1);
            return;
        }
        //获取选择的模板
        var grid = this.getTpltWin().down("grid");
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先行业模板！", 1);
            return;
        }
        var records = selModel.getSelection();
        var tplId = records[0].data.Id;
        var ts = this;
        Ext.MessageBox.confirm("警告", "是否要应用“" + records[0].data.IndustryName + "”模板到当前微信号，这将会删除原有的菜单？", function (button, text) {
            if (button == "yes") {
                var win = ts.getTpltWin();
                var myMask = new Ext.LoadMask(win, { msg: "菜单获取中..." });
                myMask.show();
                Ext.Ajax.request({
                    url: '/Admin/WXMenu/CopyMenu',
                    method: 'POST',
                    params: {
                        idtId: tplId,
                        wxId:accountId
                    },
                    success: function (response) {
                        myMask.hide();
                        var rst = Ext.JSON.decode(response.responseText);
                        Ext.Tools.Msg(rst.msg, rst.result);
                        if (rst.result == 0) {
                            ts.loadWXMenu();
                            win.hide();
                        }
                    },
                    failure: function (response) {
                        myMask.hide();
                        Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
                    }
                });
            }
        });
    },
    menuItemSelected: function () {
        //获取选中的菜单
        var grid = this.getMenuGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            //Ext.Tools.Msg("请先选择要响应的菜单！", 1);
            return;
        }
        var records = selModel.getSelection();
        var mid = records[0].data.Id;

        this.getRespTab().setDisabled(true);
        if (records[0].data.RespType == "text") {
            this.getRespTab().setDisabled(false);
            this.getRespTab().down("[title=图文]").setDisabled(true);
            this.getRespTab().down("[title=文本]").setDisabled(false);
            this.getRespTab().down("[title=服务]").setDisabled(true);
            this.getRespTab().setActiveTab(0);
            var myMask = new Ext.LoadMask(this.getRespTab(), { msg: "信息获取中..." });
            myMask.show();
            Ext.Ajax.request({
                url: '/Admin/WXRespImgTxt/GetRespList',
                method: 'GET',
                params: {
                    kwId: mid
                },
                scope:this,
                success: function (response) {
                    myMask.hide();
                    this.getCRespText().setValue("");
                    var rst = Ext.JSON.decode(response.responseText);
                    if (rst.length > 0) {
                        this.getCRespText().setValue(rst[0].Content);
                    }
                },
                failure: function (response) {
                    myMask.hide();
                    Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
                }
            });
        } else if (records[0].data.RespType == "news") {
            this.getRespTab().setDisabled(false);
            this.getRespTab().down("[title=图文]").setDisabled(false);
            this.getRespTab().down("[title=文本]").setDisabled(true);
            this.getRespTab().down("[title=服务]").setDisabled(true);
            this.getRespTab().setActiveTab(1);
            //加载图文数据
            var store = this.getRespMainGrid().getStore();
            store.getProxy().setExtraParam("kwId", mid);
            store.load();
        } else if (records[0].data.RespType.indexOf("svr") >= 0) {
            this.getRespTab().setDisabled(false);
            this.getRespTab().down("[title=图文]").setDisabled(true);
            this.getRespTab().down("[title=文本]").setDisabled(true);
            this.getRespTab().down("[title=服务]").setDisabled(false);
            this.getRespTab().setActiveTab(2);

            var myMask = new Ext.LoadMask(this.getRespTab(), { msg: "信息获取中..." });
            myMask.show();
            Ext.Ajax.request({
                url: '/Admin/WXRespImgTxt/GetRespList',
                method: 'GET',
                params: {
                    kwId: mid
                },
                scope: this,
                success: function (response) {
                    myMask.hide();
                    var form = this.getRespSrvForm();
                    form.getForm().reset();
                    var rst = Ext.JSON.decode(response.responseText);
                    if (rst.length > 0) {
                        form.down("[name=CRespSvrUrl]").setValue(rst[0].AbsUrl);
                        form.down("[name=CRespSvrParams]").setValue(rst[0].Content);
                    }
                },
                failure: function (response) {
                    myMask.hide();
                    Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
                }
            });
        }
    },
    //测试响应服务
    testSrvAction: function () {
        var form = this.getRespSrvForm();
        var record = form.getValues();
        if (!form.isValid()) {
            return;
        }
        var myMask = new Ext.LoadMask(this.getRespTab(), { msg: "调用服务中..." });
        myMask.show();
        form.down("[name=CRespSvrRst]").setValue("");
        Ext.Ajax.request({
            url: '/Admin/WXRespImgTxt/TestSrv',
            method: 'POST',
            params: {
                url: record.CRespSvrUrl,
                prms: record.CRespSvrParams
            },
            scope: this,
            success: function (response) {
                myMask.hide();
                form.down("[name=CRespSvrRst]").setValue(Ext.JSON.decode(response.responseText));
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    },
    //保存响应服务
    saveSrvAction: function () {
        //获取选择的菜单
        var grid = this.getMenuGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要响应的菜单！", 1);
            return;
        }
        var records = selModel.getSelection();
        var mid = records[0].data.Id;
        //获取输入的内容
        var form = this.getRespSrvForm();
        var record = form.getValues();
        if (!form.isValid()) {
            return;
        }
        //保存到后台
        var myMask = new Ext.LoadMask(this.getRespTab(), { msg: "保存中..." });
        myMask.show();
        Ext.Ajax.request({
            url: '/Admin/WXRespImgTxt/SaveRespSrv',
            method: 'POST',
            params: {
                KwId: mid,
                AbsUrl: record.CRespSvrUrl,
                Content: record.CRespSvrParams
            },
            success: function (response) {
                myMask.hide();
                var rst = Ext.JSON.decode(response.responseText);
                Ext.Tools.Msg(rst.msg, rst.result);
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    },
    //保存响应文本
    saveTxtAction: function () {
        //获取选择的菜单
        var grid = this.getMenuGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要响应的菜单！", 1);
            return;
        }
        var records = selModel.getSelection();
        var mid = records[0].data.Id;
        //获取标题
        var txt = this.getCRespText().getValue();
        //保存到后台
        var myMask = new Ext.LoadMask(this.getRespTab(),{ msg: "保存中..." });
        myMask.show();
        Ext.Ajax.request({
            url: '/Admin/WXRespImgTxt/SaveRespTxt',
            method: 'POST',
            params: {
                KwId: mid,
                Content:txt
            },
            success: function (response) {
                myMask.hide();
                var rst = Ext.JSON.decode(response.responseText);
                Ext.Tools.Msg(rst.msg, rst.result);
            },
            failure: function (response) {
                myMask.hide();
                Ext.Tools.Msg('请求超时或网络故障,错误编号：' + response.status, 9);
            }
        });
    },
    //图文响应操作
    //编辑
    editRecord: function (view, record, item, index) {
        var win = this.getRespWin();
        var form = win.down("form");
        form.loadRecord(record);
        win.show();
        this.getRespContent().setValue(record.data.Content);
    },
    //保存
    saveRecord: function () {
        //获取选择的菜单
        var grid = this.getMenuGrid();
        var selModel = grid.getSelectionModel();
        if (!selModel.hasSelection()) {
            Ext.Tools.Msg("请先选择要响应的菜单！", 1);
            return;
        }
        var records = selModel.getSelection();
        var mid = records[0].data.Id;
        //处理保存
        var win = this.getRespWin();
        var form = win.down("form");
        var model = form.getValues();
        model.Content = this.getRespContent().getValue();
        model.KwId = mid;
        if (form.isValid()) {
            record = form.getRecord();
            var store = this.getRespMainGrid().getStore();
            if (record) {//如果是修改
                record.set(model);
            }
            else {
                //record = Ext.create('WMC.model.WXRespImgTxt', model);
                //store.add(record);
                //如果没有datefield，可以直接设置为
                model["Id"] = Ext.data.IdGenerator.get('uuid').generate();
                store.add(model);
            }
            //Date类型的需要重新赋值才起作用，很奇怪
            //record.data.Birthday = model.Birthday;
            win.close();
            store.sync();
        }
    },
    //删除
    deleteRecord: function () {
        var grid = this.getRespMainGrid();
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
    }
});
